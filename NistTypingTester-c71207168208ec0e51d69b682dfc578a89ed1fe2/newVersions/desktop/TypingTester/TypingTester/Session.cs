using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MouseKeyboardActivityMonitor;
using MouseKeyboardActivityMonitor.WinApi;


namespace TypingTester
{
    public sealed class Session : IDisposable
    {
        #region Properties
        
        private static readonly Session _instance = new Session();
        private bool disposed = false;
        private MouseHookListener _mouseListener;
        private KeyboardHookListener _keyboardListener;

        private StreamWriter rawLog;
        private StreamWriter summaryLog;

        private bool _summaryWritten = false;

        public string ParticipantNumber { get; set; }
        public int CurrentEntity { get; set; }
        public int CurrentProficiencyString { get; set; }
        public int CurrentEntryForEntity { get; set; }
        public int CurrentPracticeRound { get; set; }
        public int CurrentVerifyRound { get; set; }
        public string WorkAreaContents { get; set; }

        private List<string> _proficiencyStrings = new List<string>();
        private List<string> _entityStrings = new List<string>();

        private bool _entityStringNumberError = false;
        private bool _entityFilterError = false;

        public string[] ProficiencyStrings
        {
            get
            {
                return _proficiencyStrings.ToArray();
            }
        }

        public string[] EntityStrings
        {
            get
            {
                return _entityStrings.ToArray();
            }
        }

        public bool InSession { get; private set; }
        private DateTime _sessionStart;
        private DateTime _phaseStart;
        private DateTime _subPhaseStart;
        private DateTime _entityStart;
        private TimeSpan _timeInFreePractice;
        private TimeSpan _timeInForcedPractice;
        private TimeSpan _timeInVerify;
        private int _timesInFreePractice;
        public int TimesInFreePractice
        {
            get
            {
                return _timesInFreePractice;
            }
        }
        private int _timesInForcedPractice;
        public int TimesInForcedPractice
        {
            get
            {
                return _timesInForcedPractice;
            }
        }
        private int _timesInVerify;
        public int TimesInVerify
        {
            get
            {
                return _timesInVerify;
            }
        }
        private Constants.Phase _currentPhase = Constants.Phase.Unknown;
        private Constants.SubPhase _currentSubPhase = Constants.SubPhase.Unknown;

        public Constants.Phase CurrentPhase
        {
            get
            {
                return _currentPhase;
            }

            set 
            {
                DateTime phaseEnd = DateTime.Now;
                if (_currentPhase != value)
                {
                    // if memorize phase is ending output the times in various phases
                    if (_currentPhase == Constants.Phase.Memorize)
                    {
                        summarizeMemorizePhase();
                    }

                    TimeSpan ts = phaseEnd - this._phaseStart;
                    this.AddEvent(new TestEvent(Constants.Event.PhaseEnd, _currentPhase, this.CurrentSubPhase, "Phase End"));
                    WriteToSummaryLog(string.Format("Ending phase {0}, total time in phase {1}", _currentPhase, ts));
                    this.AddEvent(new TestEvent(Constants.Event.PhaseBegin, value, this.CurrentSubPhase, "Phase Start"));
                }
                this._phaseStart = DateTime.Now;
                this._currentPhase = value;
                this._currentSubPhase = Constants.SubPhase.None;
            }
        }

        public Constants.SubPhase CurrentSubPhase
        {
            get
            {
                return _currentSubPhase;
            }
            set
            {
                DateTime subphaseEnd = DateTime.Now;
                if (_currentSubPhase != value)
                {
                    TimeSpan ts = subphaseEnd - _subPhaseStart; 
                    if (_currentSubPhase != Constants.SubPhase.None && _currentSubPhase != Constants.SubPhase.Unknown)
                    { 
                        // log phase sub phase ending
                        WriteToSummaryLog(string.Format("Ending subphase {0}, time in subphase {1}", _currentSubPhase, ts));
                    }
                    // handle reoccuring subphase
                    switch(value)
                    {
                        case Constants.SubPhase.ForcedPractice:
                            _timeInForcedPractice += subphaseEnd - _subPhaseStart;
                            _timesInForcedPractice++;
                            break;

                        case Constants.SubPhase.FreePractice:
                            _timeInFreePractice += subphaseEnd - _subPhaseStart;
                            _timesInFreePractice++;
                            break;

                        case Constants.SubPhase.Verify:
                            _timeInVerify += subphaseEnd - _subPhaseStart;
                            _timesInVerify++;
                            break;
                    }
                    // Log sub phase starting
                    this.AddEvent(new TestEvent(Constants.Event.SubPhaseChange, this.CurrentPhase, value, "Subphase change"));
                    _subPhaseStart = DateTime.Now;
                }
                this._currentSubPhase = value;
            }
        }

        #endregion

        #region constructor, Instance, and IDisposable interface

        private Session()
        {
            // create the keyboard and mouse hooks, for the app only
            Hooker hook = new AppHooker();
            _mouseListener = new MouseHookListener(hook);
            _keyboardListener = new KeyboardHookListener(hook);
            this.InSession = false;
        }

        public static Session Instance
        {
            get
            {
                return _instance;
            }
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        private void Dispose(bool disposing)
        {
            if (!this.disposed)
            {
                if (disposing)
                {
                    closeLogFiles();
                }
                _keyboardListener.Dispose();
                _mouseListener.Dispose();
                this.disposed = true;
                this.InSession = false;
            }
        }

        #endregion

        private void initializeSession(string participant)
        {
            ParticipantNumber = participant;
            initializeLogFiles();
            this.InSession = true;
            this._sessionStart = DateTime.Now;
            this.CurrentEntity = 0;
            this.CurrentEntryForEntity = 1;
            this.CurrentPhase = Constants.Phase.Unknown;
            this.CurrentPracticeRound = 1;
            this.CurrentProficiencyString = 0;
            this.CurrentSubPhase = Constants.SubPhase.Unknown;
            this.CurrentVerifyRound = 1;
            this.WorkAreaContents = string.Empty;
            this._timeInForcedPractice = TimeSpan.Zero;
            this._timeInFreePractice = TimeSpan.Zero;
            this._timeInVerify = TimeSpan.Zero;
            this._timesInForcedPractice = 0;
            this._timesInFreePractice = 0;
            this._timesInVerify = 0;
            this._summaryWritten = false;
            this._entityFilterError = false;
            this._entityStringNumberError = false;
        }

        private void loadData()
        {
            InputFile input = new InputFile(@".\documents\inputStrings.xml");
            this._entityStringNumberError = input.EntityNumberError;
            this._entityFilterError = input.EntityFilterError;
            this._proficiencyStrings = new List<string>(input.ProficiencyStrings);
            this._entityStrings = new List<string>(input.EntityStrings);
        }

        public void start(string particpant)
        {
            loadData();
            initializeSession(particpant);
            this.EnableHooks();
            this.SetMouseDownLogging(true);
        }

        public void end()
        {
            closeLogFiles();
            //this.DisableHooks();
            this.InSession = false;
        }

        private void initializeLogFiles()
        {
            DateTime startingTime = DateTime.Now;
            string filepath = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
            filepath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments), @"NIST_TypingTesterOutput");
            Directory.CreateDirectory(filepath);
            string rawLogFilename = Path.Combine(filepath, string.Format("{0}-{1:yyyy-MM-dd_HH-mm-ss-tt}-desktop-raw.txt", this.ParticipantNumber, startingTime));
            string summaryLogFilename = Path.Combine(filepath, string.Format("{0}-{1:yyyy-MM-dd_HH-mm-ss-tt}-desktop-summary.txt", this.ParticipantNumber, startingTime));
            rawLog = new StreamWriter(rawLogFilename, false);
            rawLog.AutoFlush = true;
            summaryLog = new StreamWriter(summaryLogFilename, false);
            summaryLog.AutoFlush = true;
            rawLog.WriteLine(TestEvent.LogHeader);
            WriteSummaryHeader();
        }

        private void closeLogFiles()
        {
            if (rawLog != null)
            {
                rawLog.Flush();
                rawLog.Close();
                rawLog = null;
            }
            if (summaryLog != null)
            {
                summaryLog.Flush();
                summaryLog.Close();
                summaryLog = null;
            }
        }

        public bool nextEntity()
        {
            if (!_summaryWritten) summarizeMemorizePhase();
            if (this.CurrentEntity + 1 < this.EntityStrings.Length)
            {
                this.CurrentEntity++;
                this._timeInForcedPractice = TimeSpan.Zero;
                this._timeInFreePractice = TimeSpan.Zero;
                this._timeInVerify = TimeSpan.Zero;
                this._timesInForcedPractice = 0;
                this._timesInFreePractice = 0;
                this._timesInVerify = 0;
                this.CurrentEntryForEntity = 1;
                this.CurrentPracticeRound = 1;
                this.CurrentVerifyRound = 1;
                this.WorkAreaContents = string.Empty;
                _summaryWritten = false;
                return true;
            }
            return false;
        }

        public void summarizeMemorizePhase()
        {
            WriteToSummaryLog(string.Format("Free Practice {0} times for {1}", _timesInFreePractice, _timeInFreePractice));
            WriteToSummaryLog(string.Format("Forced Practice {0} times for {1}", _timesInForcedPractice, _timeInForcedPractice));
            WriteToSummaryLog(string.Format("Verify {0} times for {1}", _timesInVerify, _timeInVerify));
            this._summaryWritten = true;
        }

        public override string ToString()
        {
            return string.Format("Session for Participant Id: {0}", this.ParticipantNumber);
        }

        private void WriteSummaryHeader()
        {
            string fullname = System.Reflection.Assembly.GetExecutingAssembly().GetName().FullName;
            WriteToSummaryLog(fullname);
            WriteToSummaryLog(string.Format("Participant number: {0}", ParticipantNumber));
            WriteToSummaryLog(Options.Instance.GetSettings());
            if (this._entityStringNumberError)
            {
                WriteToSummaryLog(string.Format("Settings Error: {0} passwords specified in settings, only {1} passwords found matching specified criteria.", Options.Instance.NumberOfEntities, this._entityStrings.Count));
            }
            if (this._entityFilterError)
            {
                WriteToSummaryLog(string.Format("Settings Error: No passwords found matching specified filters, using all passwords as source pool.", Options.Instance.NumberOfEntities, this._entityStrings.Count));
            }
            WriteToSummaryLog("Proficiency Strings");
            foreach(string s in this.ProficiencyStrings)
            {
                WriteToSummaryLog(s);
            }
            WriteToSummaryLog("Entity Strings");
            foreach(string s in this.EntityStrings)
            {
                WriteToSummaryLog(s);
            }
        }

        #region Logging methods

        internal void AddEvent(TestEvent te)
        {
            if (this.InSession)
            {
                te.Interval = te.Time - this._sessionStart;
                Log(te.ToString());
            }
        }

        private void Log(string text)
        {
            rawLog.WriteLine(text);
            Console.WriteLine(text);
        }

        public void WriteToSummaryLog(string text)
        {
            summaryLog.WriteLine(text);
            Console.WriteLine(text);
        }

        #endregion

        #region methods to turn on and off monitoring of mouse and keyboard events

        public void EnableHooks()
        {
            _mouseListener.Enabled = true;
            _keyboardListener.Enabled = true;
        }

        public void DisableHooks()
        {
            _mouseListener.Enabled = true;
            _keyboardListener.Enabled = true;
        }

        public void SetKeyDownLogging(bool log)
        {
            if (log)
            {
                _keyboardListener.KeyDown += HookManager_KeyDown;
            }
            else
            {
                _keyboardListener.KeyDown -= HookManager_KeyDown;
            }
        }

        public void SetKeyUpLogging(bool log)
        {
            if (log)
            {
                _keyboardListener.KeyUp += HookManager_KeyUp;
            }
            else
            {
                _keyboardListener.KeyUp -= HookManager_KeyUp;
            }
        }

        public void SetKeyPressLogging(bool log)
        {
            if (log)
            {
                _keyboardListener.KeyPress += HookManager_KeyPress;
            }
            else
            {
                _keyboardListener.KeyPress -= HookManager_KeyPress;
            }
        }

        public void SetMouseMoveLogging(bool log)
        {
            if (log)
            {
                _mouseListener.MouseMove += HookManager_MouseMove;
            }
            else
            {
                _mouseListener.MouseMove -= HookManager_MouseMove;
            }
        }
        
        public void SetMouseClickLogging(bool log)
        {
            if (log)
            {
                _mouseListener.MouseClick += HookManager_MouseClick;
            }
            else
            {
                _mouseListener.MouseClick -= HookManager_MouseClick;
            }
        }

        public void SetMouseUpLogging(bool log)
        {
            if (log)
            {
                _mouseListener.MouseUp += HookManager_MouseUp;
            }
            else
            {
                _mouseListener.MouseUp -= HookManager_MouseUp;
            }
        }
        
        public void SetMouseDownLogging(bool log)
        {
            if (log)
            {
                _mouseListener.MouseDown += HookManager_MouseDown;
            }
            else
            {
                _mouseListener.MouseDown -= HookManager_MouseDown;
            }
        }

        public void SetMouseDoubleClickLogging(bool log)
        {
            if (log)
            {
                _mouseListener.MouseDoubleClick += HookManager_MouseDoubleClick;
            }
            else
            {
                _mouseListener.MouseDoubleClick -= HookManager_MouseDoubleClick;
            }
        }
        
        public void SetMouseWheelLogging(bool log)
        {
            if (log)
            {
                _mouseListener.MouseWheel += HookManager_MouseWheel;
            }
            else
            {
                _mouseListener.MouseWheel -= HookManager_MouseWheel;
            }
        }

        #endregion


        #region mouse and keyboard monitoring event handlers

        private void HookManager_KeyDown(object sender, KeyEventArgs e)
        {
            Log(string.Format("KeyDown \t\t {0}\n", e.KeyCode));
        }

        private void HookManager_KeyUp(object sender, KeyEventArgs e)
        {
            Log(string.Format("KeyUp  \t\t {0}\n", e.KeyCode));
        }

        private void HookManager_KeyPress(object sender, KeyPressEventArgs e)
        {
            Log(string.Format("KeyPress \t\t {0}\n", e.KeyChar));
        }

        private void HookManager_MouseMove(object sender, MouseEventArgs e)
        {
            Log(string.Format("x={0:0000}; y={1:0000}", e.X, e.Y));
        }

        private void HookManager_MouseClick(object sender, MouseEventArgs e)
        {
            Log(string.Format("MouseClick \t\t {0}\n", e.Button));
        }

        private void HookManager_MouseUp(object sender, MouseEventArgs e)
        {
            Log(string.Format("MouseUp \t\t {0}\n", e.Button));
        }

        private void HookManager_MouseDown(object sender, MouseEventArgs e)
        {
            if (InSession)
            {
                TestEvent te = new TestEvent(Constants.Event.MouseClick, CurrentPhase, CurrentSubPhase, string.Empty);
                te.X = e.X;
                te.Y = e.Y;
                te.Notes = string.Format("{0} button down {1} clicks, Delta {2}", e.Button, e.Clicks, e.Delta);
                AddEvent(te);
            }
        }

        private void HookManager_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            Log(string.Format("MouseDoubleClick \t\t {0}\n", e.Button));
        }

        private void HookManager_MouseWheel(object sender, MouseEventArgs e)
        {
            Log(string.Format("Wheel={0:000}", e.Delta));
        }

        #endregion

    }
}
