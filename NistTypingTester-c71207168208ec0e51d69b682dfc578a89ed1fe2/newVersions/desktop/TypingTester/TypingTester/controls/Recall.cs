using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace TypingTester.controls
{
    public partial class Recall : BaseControl
    {
        public Recall(BaseForm reciever)
        {
            InitializeComponent();
            addCommand(@"Go To Thank You", new commands.CommandGoToScreen(reciever, Constants.Screen.ThankYou));
        }

        private void btnNext_Click(object sender, EventArgs e)
        {
            StringBuilder enteredValues = new StringBuilder("Recalled Values\n");
            foreach (Control c in flowLayoutPanel1.Controls)
            {
                if (c is CueTextBox)
                {
                    CueTextBox ctb = c as CueTextBox;
                    enteredValues.AppendFormat("{0}:{1}\n",ctb.Id, ctb.Text);
                }
            }
            Session.Instance.WriteToSummaryLog(enteredValues.ToString());
            executeCommand(@"Go To Thank You");
        }

        private void Recall_Load(object sender, EventArgs e)
        {
            SetHeaderText("Recall");
            SetEntityProgressVisibility(false);
            SetRoundProgresssVisibility(false);
            Session.Instance.CurrentPhase = Constants.Phase.Recall;
            Session.Instance.CurrentSubPhase = Constants.SubPhase.None;
            for (int i = 0; i < Session.Instance.EntityStrings.Length; i++ )
            {
                CueTextBox ctb = new CueTextBox(string.Format("Field{0}", i), "Type here ...", string.Empty);
                ctb.UseSystemPasswordChar = true;
                ctb.Width = flowLayoutPanel1.Width - 50;
                ctb.Anchor = AnchorStyles.Left | AnchorStyles.Top | AnchorStyles.Right;
                flowLayoutPanel1.Controls.Add(ctb);
            }

        }

        private void flowLayoutPanel1_Resize(object sender, EventArgs e)
        {
            foreach (Control c in flowLayoutPanel1.Controls)
            {
                if (c is CueTextBox)
                {
                    CueTextBox ctb = c as CueTextBox;
                    ctb.Width = flowLayoutPanel1.Width - 60;

                }
            }
        }

        /*private void flowLayoutPanel1_SizeChanged(object sender, EventArgs e)
        {
            foreach (Control c in flowLayoutPanel1.Controls)
            {
                if (c is CueTextBox)
                {
                    CueTextBox ctb = c as CueTextBox;
                    ctb.Width = flowLayoutPanel1.Width - 60;
                    
                }
            }
        }*/
    }
}
