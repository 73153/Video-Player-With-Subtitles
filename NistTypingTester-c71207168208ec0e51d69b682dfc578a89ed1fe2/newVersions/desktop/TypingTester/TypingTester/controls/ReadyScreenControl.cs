using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;

namespace TypingTester.controls
{
    public partial class ReadyScreenControl : BaseControl
    {
        
        public string ParticipantNumber
        {
            get
            {
                return lblParticipantNumber.Text;
            }
            set
            {
                lblParticipantNumber.Text = value;
            }
        }

        public ReadyScreenControl(BaseForm reciever)
        {
            InitializeComponent();
            addCommand(@"Begin Button", new commands.CommandGoToScreen(reciever, Constants.Screen.Proficiency));
            addCommand(@"Back Button", new commands.CommandGoToScreen(reciever, Constants.Screen.StartScreen));
        }

        private void ReadyScreenControl_Load(object sender, EventArgs e)
        {
            SetHeaderText("Ready");
            SetEntityProgressVisibility(false);
            SetRoundProgresssVisibility(false);
            FileStream source = new FileStream(@".\documents\welcome.html", FileMode.Open, FileAccess.Read);
            webBrowser1.DocumentStream = source;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            executeCommand(@"Begin Button");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            executeCommand(@"Back Button");
        }
    }
}
