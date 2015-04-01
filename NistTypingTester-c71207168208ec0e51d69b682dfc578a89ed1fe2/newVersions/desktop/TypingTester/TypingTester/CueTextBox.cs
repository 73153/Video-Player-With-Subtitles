using System;
using System.ComponentModel;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using System.Text;

namespace TypingTester
{
    class CueTextBox : TextBox
    {
        private static class NativeMethods
        {
            private const uint ECM_FIRST = 0x1500;
            internal const uint EM_SETCUEBANNER = ECM_FIRST + 1;

            [DllImport("user32.dll", EntryPoint = "SendMessageW")]
            public static extern IntPtr SendMessageW(IntPtr hWnd, UInt32 Msg, IntPtr wParam, [MarshalAs(UnmanagedType.LPWStr)] string lParam);
        }

        private string mCue;
        [Localizable(true)]
        public string Cue
        {
            get { return mCue; }
            set { mCue = value; updateCue(); }
        }

        private bool mEscapeCurrentValue;
        public bool EscapeCurrentValue
        {
            get { return mEscapeCurrentValue; }
            set { mEscapeCurrentValue = value; }
        }

        private string mTargetString = string.Empty;
        public string TargetString
        {
            get
            {
                return mTargetString;
            }
            set
            {
                mTargetString = value;
            }
        }

        private string mId;
        public string Id
        {
            get { return mId; }
            set { mId = value; }
        }

        public CueTextBox()
        {
            InitializeComponent();
        }

        public CueTextBox(string id, string cue, string targetString)
        {
            InitializeComponent();
            mId = id;
            mCue = cue;
            mTargetString = targetString;
        }

        private void updateCue()
        {
            if (this.IsHandleCreated && mCue != null)
            {
                NativeMethods.SendMessageW(this.Handle, NativeMethods.EM_SETCUEBANNER, (IntPtr)1, mCue);
            }
        }
        
        protected override void OnHandleCreated(EventArgs e)
        {
            base.OnHandleCreated(e);
            updateCue();
        }

        private void InitializeComponent()
        {
            this.SuspendLayout();
            this.ResumeLayout(false);

        }

        protected override void OnEnter(EventArgs e)
        {
            base.OnEnter(e);
            TestEvent te = new TestEvent(Constants.Event.ControlActivated,
                                         Session.Instance.CurrentPhase,
                                         Session.Instance.CurrentSubPhase,
                                         string.Format("Text Box Got Focus : {0}", this.Id));
            te.TargetString = this.TargetString;
            Session.Instance.AddEvent(te);
        }

        protected override void OnLeave(EventArgs e)
        {
            base.OnLeave(e);
            TestEvent te = new TestEvent(Constants.Event.ControlActivated,
                                         Session.Instance.CurrentPhase,
                                         Session.Instance.CurrentSubPhase,
                                         string.Format("Text Box Lost Focus : {0}", this.Id));
            te.TargetString = this.TargetString;
            Session.Instance.AddEvent(te);
        }

        protected override void OnKeyDown(KeyEventArgs e)
        {
            base.OnKeyDown(e);
            TestEvent te = new TestEvent(Constants.Event.KeyDown,
                                        Session.Instance.CurrentPhase,
                                        Session.Instance.CurrentSubPhase,
                                        string.Format("Key Down"));
            KeysConverter kc = new KeysConverter();
            te.TargetString = this.TargetString;
            te.Key = kc.ConvertToString(e.KeyCode);
            Session.Instance.AddEvent(te);
        }

        protected override void OnKeyUp(KeyEventArgs e)
        {
            base.OnKeyUp(e);
            TestEvent te = new TestEvent(Constants.Event.KeyUp,
                                       Session.Instance.CurrentPhase,
                                       Session.Instance.CurrentSubPhase,
                                       string.Format("Key Up"));
            KeysConverter kc = new KeysConverter();
            te.TargetString = this.TargetString;
            te.Key = kc.ConvertToString(e.KeyCode);
            Session.Instance.AddEvent(te);
        }

        protected override void OnKeyPress(KeyPressEventArgs e)
        {
            base.OnKeyPress(e);
            TestEvent te = new TestEvent(Constants.Event.KeyPress,
                                         Session.Instance.CurrentPhase,
                                         Session.Instance.CurrentSubPhase,
                                         string.Format("{0}", EscapeString(this.Text)));
            te.TargetString = this.TargetString;
            te.Key = this.EscapeString(e.KeyChar.ToString());
            Session.Instance.AddEvent(te);
        }

        private string EscapeString(string original)
        {
            string retVal = original;
            if (this.EscapeCurrentValue == true)
            {
                retVal = retVal.Replace("\n", @"{LF}");
                retVal = retVal.Replace("\r", @"{CR}");
            }
            return retVal;
        }
    }
}
