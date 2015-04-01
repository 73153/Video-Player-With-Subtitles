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
    public partial class BaseControl : UserControl
    {
        protected Dictionary<string, commands.Command> _commands = new Dictionary<string, commands.Command>();

        public BaseControl()
        {
            InitializeComponent();
        }

        internal void addCommand(string id, commands.Command newCommand)
        {
            if (_commands.ContainsKey(id))
            {
                _commands[id] = newCommand;
            }
            else
            {
                _commands.Add(id, newCommand);
            }
        }

        public void executeCommand(string id)
        {
            if (_commands.ContainsKey(id))
            {
                _commands[id].execute();
            }
            else
            {
                MessageBox.Show(string.Format("Attempt to execute unknown command:{0}", id), @"Unknown command", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        public virtual void ExitControl()
        {
            Session.Instance.CurrentSubPhase = Constants.SubPhase.Unknown;
            Session.Instance.CurrentPhase = Constants.Phase.Unknown;
        }

        protected override void OnMouseClick(MouseEventArgs e)
        {
            base.OnMouseClick(e);
        }

        protected void SetHeaderText(string text)
        {
            this.lblHeaderBase.Text = text;
        }

        protected void setHeaderVisibility(bool visible)
        {
            this.lblHeaderBase.Visible = visible;
        }

        protected void SetEntityProgressText(string text)
        {
            this.lblEntityProgressBase.Text = text;
        }

        protected void SetEntityProgressVisibility(bool visible)
        {
            this.lblEntityProgressBase.Visible = visible;
        }

        protected void SetRoundProgressText(string text)
        {
            this.lblRoundBase.Text = text;
        }

        protected void SetRoundProgresssVisibility(bool visible)
        {
            this.lblRoundBase.Visible = visible;
        }




    }
}
