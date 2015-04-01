using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace TypingTester.controls
{
    public partial class ParticipantNumberControl : BaseControl
    {
        public string ParticipantNumber
        {
            get
            {
                return textBox1.Text;
            }
            set
            {
                textBox1.Text = value;
            }
        }

        public ParticipantNumberControl(BaseForm reciever)
        {
            InitializeComponent();
            addCommand(@"Begin Button", new commands.CommandGoToScreen(reciever, Constants.Screen.ReadyScreen));
        }

        private void btnBegin_Click(object sender, EventArgs e)
        {
            executeCommand(@"Begin Button");
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            if (textBox1.Text.Length > 0)
            {
                btnBegin.Enabled = true;
            }
            else
            {
                btnBegin.Enabled = false;
            }
        }

        private void ParticipantNumberControl_Load(object sender, EventArgs e)
        {
            setHeaderVisibility(false);
            SetEntityProgressVisibility(false);
            SetRoundProgresssVisibility(false);
        }
    }
}
