using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace TypingTester.controls
{
    public partial class Entry : TypingTester.controls.BaseControl
    {
        private string currentString;

        public Entry(BaseForm reciever)
        {
            InitializeComponent();
            addCommand(@"Go To Recall", new commands.CommandGoToScreen(reciever, Constants.Screen.Recall));
            addCommand(@"Next Entity", new commands.NextEntity(reciever));
            currentString = Session.Instance.EntityStrings[Session.Instance.CurrentEntity];
        }
        
        private void Entry_Load(object sender, EventArgs e)
        {
            Session.Instance.CurrentPhase = Constants.Phase.Entry;
            Session.Instance.CurrentSubPhase = Constants.SubPhase.None;
            tbEntry.TargetString = currentString;
            SetHeaderText("Enter");
            this.btnHidden.Focus();
            UpdateUi();
        }

        private void UpdateUi()
        {
            SetRoundProgressText(string.Format("Round {0} of {1}", Session.Instance.CurrentEntryForEntity, Options.Instance.RepetitionPerEntity));
            SetEntityProgressText(string.Format("Password {0} of {1}", Session.Instance.CurrentEntity + 1, Session.Instance.EntityStrings.Length));
        }

        private void btnNext_Click(object sender, EventArgs e)
        {
            Session.Instance.AddEvent(new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Entry, Constants.SubPhase.None,
                                                    "Next button pressed"));
            this.btnHidden.Focus();
            if (tbEntry.Text.Equals(Options.Instance.QuitString)) // check for quit phrase
            {
                TestEvent te = new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Entry, Constants.SubPhase.None,
                                             @"Quit phrase entered");
                te.TargetString = currentString;
                Session.Instance.AddEvent(te);
                executeCommand("Go To Recall");
                return;
            }
            else if (tbEntry.Text.Equals(Options.Instance.SkipString)) // check for skip phrase
            {
                TestEvent te = new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Entry, Constants.SubPhase.None,
                                             @"Skip phrase entered");
                te.TargetString = currentString;
                Session.Instance.AddEvent(te);
                executeCommand(@"Next Entity");
                return;
            }
            else if (tbEntry.Text.Equals(currentString)) // check for correct entry
            {
                TestEvent te = new TestEvent(Constants.Event.CorrectValueEntered, Constants.Phase.Entry, Constants.SubPhase.None,
                                             @"Correct value entered");
                te.TargetString = currentString;
                Session.Instance.AddEvent(te);
            }
            else  // incorrect and non special string entered
            {
                TestEvent te = new TestEvent(Constants.Event.IncorrectValueEntered, Constants.Phase.Entry, Constants.SubPhase.None,
                                             @"Incorrect value entered");
                te.TargetString = currentString;
                Session.Instance.AddEvent(te);
            }
            // increment the entry # and determine if another is needed or where to go
            Session.Instance.CurrentEntryForEntity++;
            tbEntry.Text = string.Empty;
            if (Session.Instance.CurrentEntryForEntity > Options.Instance.RepetitionPerEntity)
            {
                if (Session.Instance.CurrentEntity + 1 >= Session.Instance.EntityStrings.Length)
                {
                    executeCommand(@"Go To Recall");
                }
                else
                {
                    executeCommand(@"Next Entity");
                }
            }
            UpdateUi();
        }

        private void tbEntry_TextChanged(object sender, EventArgs e)
        {
            if (tbEntry.Text.Length > 0)
            {
                btnNext.Enabled = true;
            }
            else
            {
                btnNext.Enabled = false;
            }
        }

       
    }
}
