using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace TypingTester.controls
{
    public partial class Verify : TypingTester.controls.BaseControl
    {
        private string currentString;

        public Verify(BaseForm reciever)
        {
            InitializeComponent();
            addCommand(@"Go To Practice", new commands.CommandGoToScreen(reciever, Constants.Screen.ForcedPractice));
            addCommand(@"Go To Entry", new commands.CommandGoToScreen(reciever, Constants.Screen.Entry));
            addCommand(@"Go To Recall", new commands.CommandGoToScreen(reciever, Constants.Screen.Recall));
            addCommand(@"Go To Memorize", new commands.CommandGoToScreen(reciever, Constants.Screen.Memorize));
            addCommand(@"Skip Entity", new commands.NextEntity(reciever));

            currentString = Session.Instance.EntityStrings[Session.Instance.CurrentEntity];
        }

        private void btnBack_Click(object sender, EventArgs e)
        {
            Session.Instance.AddEvent(new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Memorize, Constants.SubPhase.Verify,
                                                    @"Back button pressed"));
            if (Options.Instance.ForcedPracticeRounds > 0)
            {
                executeCommand(@"Go To Practice");
            }
            else
            {
                executeCommand(@"Go To Memorize");
            }
        }

        private void btnNext_Click(object sender, EventArgs e)
        {
            Session.Instance.AddEvent(new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Memorize, Constants.SubPhase.Verify,
                                                    @"Next button pressed"));
            this.btnHidden.Focus();
            // check from quit and skip strings
            if (tbEntry.Text == Options.Instance.QuitString)
            {
                Session.Instance.AddEvent(new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Memorize, 
                                                        Constants.SubPhase.Verify, @"Quit string entered"));
                executeCommand(@"Go to Recall");
                this.tbEntry.Text = string.Empty;
                return;
            }
            else if (tbEntry.Text == Options.Instance.SkipString)
            {
                Session.Instance.AddEvent(new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Memorize,
                                                        Constants.SubPhase.Verify, @"Skip string entered"));
                executeCommand(@"Skip Entity");
                this.tbEntry.Text = string.Empty;
                return;
            }
            else if (tbEntry.Text.Equals(currentString))
            {
                TestEvent te = new TestEvent(Constants.Event.CorrectValueEntered, Constants.Phase.Memorize, Constants.SubPhase.Verify,
                                             @"Correct value entered");
                te.TargetString = currentString;
                Session.Instance.AddEvent(te);
                Session.Instance.CurrentVerifyRound++;
                this.tbEntry.Text = string.Empty;
            }
            else if (!string.IsNullOrEmpty(tbEntry.Text))
            {
                this.lblIncorrect.Visible = true;
                this.imgIncorrect.Visible = true;
            }
            PromptToMoveOn();
            UpdateUi();
        }

        private void PromptToMoveOn()
        {
            if (Session.Instance.CurrentVerifyRound > Options.Instance.VerifyRounds)
            {
                if (MessageBox.Show("Do you want to proceed to the Enter task?", "Verify Completed",
                                        MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    executeCommand(@"Go To Entry");
                }
            }
        }

        private void Verify_Load(object sender, EventArgs e)
        {
            SetHeaderText("Verify");
            Session.Instance.CurrentPhase = Constants.Phase.Memorize;
            Session.Instance.CurrentSubPhase = Constants.SubPhase.Verify;
            tbEntry.TargetString = currentString;
            SetEntityProgressText(string.Format("Password {0} of {1}", Session.Instance.CurrentEntity + 1, Session.Instance.EntityStrings.Length));
            this.btnHidden.Focus();
            UpdateUi();
        }

        private void UpdateUi()
        {            
            if (Session.Instance.CurrentVerifyRound > Options.Instance.VerifyRounds)
            {
                SetRoundProgressText("Complete");
                btnNext.Enabled = true;
            }
            else
            {
                SetRoundProgressText(string.Format("Round {0} of {1}", Session.Instance.CurrentVerifyRound, Options.Instance.VerifyRounds));
            }
            
        }

        public override void ExitControl()
        {
            Session.Instance.CurrentSubPhase = Constants.SubPhase.Unknown;
            return;
        }

        private void tbEntry_TextChanged(object sender, EventArgs e)
        {
            lblIncorrect.Visible = false;
            imgIncorrect.Visible = false;
            if (tbEntry.Text.Length > 0)
            {
                btnNext.Enabled = true;
            }
            else
            {
                btnNext.Enabled = false;
            }
        }

        private void btnQuit_Click(object sender, EventArgs e)
        {
            Session.Instance.AddEvent(new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Memorize,
                                                        Constants.SubPhase.Verify, @"Quit button pressed"));
            executeCommand(@"Go to Recall");
            return;
        }

        private void btnSkip_Click(object sender, EventArgs e)
        {
            Session.Instance.AddEvent(new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Memorize,
                                                        Constants.SubPhase.Verify, @"Skip button pressed"));
            executeCommand(@"Skip Entity");
            return;
        }

        private void imgIncorrect_Click(object sender, EventArgs e)
        {

        }
    }
}
