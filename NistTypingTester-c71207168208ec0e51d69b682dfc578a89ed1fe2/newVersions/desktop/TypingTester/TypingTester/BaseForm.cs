using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TypingTester.controls;
using System.Runtime.InteropServices;

namespace TypingTester
{
    public partial class BaseForm : Form
    {
        [DllImport("Kernel32.dll")]
        static extern Boolean AllocConsole();


        private UserControl currentControl;
        private Constants.Screen _currentScreen = Constants.Screen.Unknown;
        private string participantNumber;

        public Constants.Screen CurrentScreen
        {
            get
            {
                return _currentScreen;
            }

            set
            {
                GoToScreen(value);
            }
        }

        public BaseForm()
        {
            InitializeComponent();

        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        protected void enableOptionsButton(bool state)
        {
            tsbOptions.Enabled = state;
        }

        private void BaseForm_Load(object sender, EventArgs e)
        {
            // load the options file
            Options.Instance.load();
            GoToScreen(Constants.Screen.StartScreen);


            string[] args = Environment.GetCommandLineArgs();
            foreach (string arg in args)
            {
                if (arg == "/d")
                {
                    if (!AllocConsole())
                    {
                        MessageBox.Show("Failed to initialize console", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
            
        }

        private void GoToScreen(Constants.Screen screen)
        {
            UserControl newControl = null;
            switch(screen)
            {
                case Constants.Screen.StartScreen:
                    newControl = new ParticipantNumberControl(this);
                    this.tsbOptions.Enabled = true;
                    break;

                case Constants.Screen.ReadyScreen:
                    this.tsbOptions.Enabled = false;
                    ParticipantNumberControl c = currentControl as ParticipantNumberControl;
                    participantNumber = c.ParticipantNumber;
                    ReadyScreenControl temp = new ReadyScreenControl(this);
                    temp.ParticipantNumber = participantNumber;
                    newControl = temp;
                    break;

                case Constants.Screen.Proficiency:
                    this.tsbOptions.Enabled = false;
                    Session.Instance.start(participantNumber);
                    ProficiencyControl pc = new ProficiencyControl(this);
                    newControl = pc;
                    break;

                case Constants.Screen.Instructions:
                    this.tsbOptions.Enabled = false;
                    newControl = new Instructions(this);
                    break;

                case Constants.Screen.Memorize:
                    this.tsbOptions.Enabled = false;
                    newControl = new Memorize(this);
                    break;

                case Constants.Screen.ForcedPractice:
                    this.tsbOptions.Enabled = false;
                    newControl = new ForcedPractice(this);
                    break;

                case Constants.Screen.Verify:
                    this.tsbOptions.Enabled = false;
                    newControl = new Verify(this);
                    break;

                case Constants.Screen.Entry:
                    this.tsbOptions.Enabled = false;
                    newControl = new Entry(this);
                    break;

                case Constants.Screen.Recall:
                    this.tsbOptions.Enabled = false;
                    newControl = new Recall(this);
                    break;

                case Constants.Screen.ThankYou:
                    this.tsbOptions.Enabled = false;
                    newControl = new Thankyou(this);
                    break;

                case Constants.Screen.Settings:
                    this.tsbOptions.Enabled = false;
                    newControl = new Settings(this);
                    break;

                default:
                    this.tsbOptions.Enabled = false;
                    newControl = null;
                    break;
            }
            if (newControl != null)
            {
                BaseControl bc = currentControl as BaseControl;
                if (bc != null) bc.ExitControl();
                newControl.Dock = DockStyle.Fill;
                if (mainPanel.Controls.Count != 0)
                {
                    mainPanel.Controls.Clear();
                }
                mainPanel.Controls.Add(newControl);
                _currentScreen = screen;
                currentControl = newControl;
            }
            else
            {
                MessageBox.Show("Attempt to add null control to main panel.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void tsbOptions_Click(object sender, EventArgs e)
        {
            GoToScreen(Constants.Screen.Settings);
        }

     }
}
