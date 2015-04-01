using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;

namespace TypingTester.controls
{
    public partial class Thankyou : TypingTester.controls.BaseControl
    {
        public Thankyou(BaseForm reciever)
        {
            InitializeComponent();
            addCommand(@"Finish", new commands.CommandGoToScreen(reciever, Constants.Screen.StartScreen));
        }

        private void Thankyou_Load(object sender, EventArgs e)
        {
            SetHeaderText("Thank You");
            SetEntityProgressVisibility(false);
            SetRoundProgresssVisibility(false);
            FileStream source = new FileStream(@".\documents\thankYou.html", FileMode.Open, FileAccess.Read);
            Session.Instance.CurrentPhase = Constants.Phase.ThankYou;
            Session.Instance.CurrentSubPhase = Constants.SubPhase.Unknown;
            webBrowser1.DocumentStream = source;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            executeCommand(@"Finish");
        }
    }
}
