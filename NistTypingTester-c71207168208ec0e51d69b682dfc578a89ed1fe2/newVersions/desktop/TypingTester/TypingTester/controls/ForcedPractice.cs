using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace TypingTester.controls
{
    public partial class ForcedPractice : TypingTester.controls.BaseControl
    {
        private string currentString;
        private bool hideString = false;
        private string maskedString;

        public ForcedPractice(BaseForm reciever)
        {
            InitializeComponent();
            addCommand(@"Back To Memorize", new commands.CommandGoToScreen(reciever, Constants.Screen.Memorize));
            addCommand(@"Go To Verify", new commands.CommandGoToScreen(reciever, Constants.Screen.Verify));
            addCommand(@"Go To Recall", new commands.CommandGoToScreen(reciever, Constants.Screen.Recall));
            addCommand(@"Next Entity", new commands.NextEntity(reciever));
            addCommand(@"Go To Entry", new commands.CommandGoToScreen(reciever, Constants.Screen.Entry));
        }

        private void btnBack_Click(object sender, EventArgs e)
        {
            Session.Instance.AddEvent(new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Memorize, Constants.SubPhase.ForcedPractice,
                                                    @"Back button pressed"));
            executeCommand(@"Back To Memorize");
        }

        private void btnNext_Click(object sender, EventArgs e)
        {
            Session.Instance.AddEvent(new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Memorize, Constants.SubPhase.ForcedPractice,
                                                    @"Next button pressed"));
            this.btnHidden.Focus();
            if (tbEntry.Text.Equals(currentString)) // did they get the string correct
            {
                TestEvent te = new TestEvent(Constants.Event.CorrectValueEntered, Constants.Phase.Memorize, Constants.SubPhase.ForcedPractice,
                                              "Correct value entered");
                te.TargetString = currentString;
                Session.Instance.AddEvent(te);
                Session.Instance.CurrentPracticeRound++;
                tbEntry.Text = string.Empty;
            }
            else if (tbEntry.Text.Equals(Options.Instance.QuitString))
            {
                TestEvent te = new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Memorize, Constants.SubPhase.ForcedPractice,
                                             @"Quit string entered");
                te.TargetString = currentString;
                Session.Instance.AddEvent(te);
                executeCommand(@"Go To Recall");
                return;
            }
            else if (tbEntry.Text.Equals(Options.Instance.SkipString))
            {
                TestEvent te = new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Memorize, Constants.SubPhase.ForcedPractice,
                                             @"Skip string entered");
                te.TargetString = currentString;
                Session.Instance.AddEvent(te);
                this.executeCommand(@"Next Entity");
                return;
            }
            else if (!string.IsNullOrEmpty(tbEntry.Text))
            {
                TestEvent te = new TestEvent(Constants.Event.IncorrectValueEntered, Constants.Phase.Memorize, Constants.SubPhase.ForcedPractice,
                                             "Incorrect value entered");
                te.TargetString = currentString;
                Session.Instance.AddEvent(te);
                lblIncorrect.Visible = true;
                imgIncorrect.Visible = true;
            }
            PromptToMoveOn();
            UpdateUi();
        }

        private void PromptToMoveOn()
        {
            if (Session.Instance.CurrentPracticeRound > Options.Instance.ForcedPracticeRounds)
            {
                if (Options.Instance.VerifyRounds > 0)
                {
                    if (MessageBox.Show("Do you want to proceed to the Verify task?", "Practice Completed",
                                        MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                    {
                        executeCommand(@"Go To Verify");
                    }
                }
                else
                {
                    if (MessageBox.Show("Do you want to proceed to the Enter task?", "Practice Completed",
                        MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                    {
                        executeCommand(@"Go to Entry");
                    }
                }
            }
        }

        private void UpdateUi()
        {
            if (Session.Instance.CurrentPracticeRound > Options.Instance.ForcedPracticeRounds)
            {
                SetRoundProgressText("Complete");
                btnNext.Enabled = true;
            }
            else
            {
                SetRoundProgressText(string.Format("Round {0} of {1}", Session.Instance.CurrentPracticeRound, Options.Instance.ForcedPracticeRounds));
            }
        }

        private void ForcedPractice_Load(object sender, EventArgs e)
        {
            Session.Instance.CurrentPhase = Constants.Phase.Memorize;
            Session.Instance.CurrentSubPhase = Constants.SubPhase.ForcedPractice;
            currentString = Session.Instance.EntityStrings[Session.Instance.CurrentEntity];
            maskedString = new string('*', currentString.Length);
            if (hideString == false) lblEntity.Text = currentString;
            else lblEntity.Text = maskedString;
            tbEntry.TargetString = currentString;
            SetEntityProgressText(string.Format("Password {0} of {1}", Session.Instance.CurrentEntity+1, Session.Instance.EntityStrings.Length));
            btnHide.Visible = Options.Instance.ShowHideButtonOnPractice;
            btnQuit.Visible = Options.Instance.ShowQuitButton;
            btnSkip.Visible = Options.Instance.ShowSkipButton;
            SetHeaderText("Practice");
            if (Options.Instance.disableFreePractice == true)
            {
                this.btnBack.Visible = false;
            }
            btnHidden.Focus();
            UpdateUi();
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
            if (tbEntry.Text.Length > 0 || (Session.Instance.CurrentPracticeRound > Options.Instance.ForcedPracticeRounds))
            {
                btnNext.Enabled = true;
            }
            else
            {
                btnNext.Enabled = false;
            }
        }

        private void btnSkip_Click(object sender, EventArgs e)
        {
            TestEvent te = new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Memorize, Constants.SubPhase.ForcedPractice,
                                            @"Skip button pressed");
            te.TargetString = currentString;
            Session.Instance.AddEvent(te);
            this.executeCommand(@"Next Entity");
            return;
        }

        private void btnQuit_Click(object sender, EventArgs e)
        {
            TestEvent te = new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Memorize, Constants.SubPhase.ForcedPractice,
                                             @"Quit button pressed");
            te.TargetString = currentString;
            Session.Instance.AddEvent(te);
            executeCommand(@"Go To Recall");
            return;
        }

        private void btnHide_Click(object sender, EventArgs e)
        {
            hideString = !hideString;
            if (!hideString) lblEntity.Text = currentString;
            else lblEntity.Text = maskedString;
        }
    }
}
