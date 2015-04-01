using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace TypingTester.controls
{
    public partial class ProficiencyControl : TypingTester.controls.BaseControl
    {
        public ProficiencyControl(BaseForm reciever)
        {
            InitializeComponent();
            addCommand(@"Next Proficiency Item", new commands.NextProficiencyItem(this));
            addCommand(@"Go To Instructions", new commands.CommandGoToScreen(reciever, Constants.Screen.Instructions));
        }

        public void UpdateDisplay()
        {
            tbEntry.Text = string.Empty;
            int currentProficiencyItem = Session.Instance.CurrentProficiencyString;
            int totalProficiencyItems = Session.Instance.ProficiencyStrings.Length;
            string currentString = Session.Instance.ProficiencyStrings[currentProficiencyItem];
            SetEntityProgressText(string.Format("Phrase {0} of {1}", currentProficiencyItem + 1, totalProficiencyItems));
            lblProficiencyString.Text = currentString;
        }

        private void btnNext_Click(object sender, EventArgs e)
        {
            Session.Instance.AddEvent(new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Proficiency,
                                      Constants.SubPhase.None, @"Next button pressed"));
            this.btnHidden.Focus();
            if (tbEntry.Text.Equals(lblProficiencyString.Text))
            {
                TestEvent evt = new TestEvent(Constants.Event.CorrectValueEntered, Constants.Phase.Proficiency,
                                            Constants.SubPhase.None, @"Correct value entered");
                evt.TargetString = lblProficiencyString.Text;
                Session.Instance.AddEvent(evt);
            }
            else
            {
                TestEvent evt = new TestEvent(Constants.Event.IncorrectValueEntered, Constants.Phase.Proficiency,
                                            Constants.SubPhase.None, @"Incorrect value entered");
                evt.TargetString = lblProficiencyString.Text;
                Session.Instance.AddEvent(evt);
            }
            if (Session.Instance.CurrentProficiencyString+1 >= Session.Instance.ProficiencyStrings.Length)
            {
                executeCommand(@"Go To Instructions");
            }
            else
            {
                executeCommand(@"Next Proficiency Item");
            }
        }

        private void ProficiencyControl_Load(object sender, EventArgs e)
        {
            Session.Instance.CurrentPhase = Constants.Phase.Proficiency;
            SetHeaderText("Typing Phrases");
            SetRoundProgresssVisibility(false);
            this.btnHidden.Focus();
            UpdateDisplay();
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
