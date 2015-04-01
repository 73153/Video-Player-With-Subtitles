using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace TypingTester.controls
{
    public partial class Memorize : TypingTester.controls.BaseControl
    {
        private string currentString = string.Empty;

        public Memorize(BaseForm reciever)
        {
            InitializeComponent();
            addCommand(@"Go To Practice", new commands.CommandGoToScreen(reciever, Constants.Screen.ForcedPractice));
            addCommand(@"Go To Verify", new commands.CommandGoToScreen(reciever, Constants.Screen.Verify));
            addCommand(@"Go To Entry", new commands.CommandGoToScreen(reciever, Constants.Screen.Entry));
            currentString = Session.Instance.EntityStrings[Session.Instance.CurrentEntity];
        }

        private void btnNext_Click(object sender, EventArgs e)
        {
            Session.Instance.AddEvent(new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Memorize, Constants.SubPhase.FreePractice,
                                                    @"Next button pressed"));
            Session.Instance.WorkAreaContents = this.tbWorkArea.Text;
            if (Options.Instance.ForcedPracticeRounds > 0)
            {
                executeCommand("Go To Practice");
            }
            else if (Options.Instance.VerifyRounds > 0)
            {
                executeCommand(@"Go To Verify");
            }
            else
            {
                PromptToMoveToEntry();
            }
        }

        private void PromptToMoveToEntry()
        {
            if (Session.Instance.CurrentVerifyRound > Options.Instance.VerifyRounds)
            {
                if (MessageBox.Show("Do you want to proceed to the Enter task?", "Memorize Completed",
                                        MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    executeCommand(@"Go To Entry");
                }
            }
        }

        private void Memorize_Load(object sender, EventArgs e)
        {
            Session.Instance.CurrentPhase = Constants.Phase.Memorize;
            Session.Instance.CurrentSubPhase = Constants.SubPhase.FreePractice;
            lblPassword.Text = currentString;
            SetHeaderText("Memorize");
            SetEntityProgressText(string.Format("Password {0} of {1}", Session.Instance.CurrentEntity + 1, Session.Instance.EntityStrings.Length));
            SetRoundProgresssVisibility(false);
            this.tbWorkArea.Text = Session.Instance.WorkAreaContents;
            if (Options.Instance.disableFreePracticeTextBox == true)
            {
                this.tbWorkArea.Visible = false;
            }
        }

        public override void ExitControl()
        {
            Session.Instance.CurrentSubPhase = Constants.SubPhase.Unknown;
            return;
        }
    }
}
