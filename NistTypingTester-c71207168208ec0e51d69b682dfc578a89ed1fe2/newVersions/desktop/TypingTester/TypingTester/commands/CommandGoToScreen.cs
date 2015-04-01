using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TypingTester.commands
{
    internal class CommandGoToScreen : Command
    {
        private BaseForm _reciever;
        private Constants.Screen _target;
        private Constants.Screen _previousScreen = Constants.Screen.Unknown;

        public CommandGoToScreen(BaseForm reciever, Constants.Screen target)
        {
            _reciever = reciever;
            _target = target;
        }

        public override void execute()
        {
            _previousScreen = _reciever.CurrentScreen;
            _reciever.CurrentScreen = _target;
        }

        public override void undo()
        {
            throw new NotImplementedException();
        }

        protected override void Dispose(bool disposing)
        {
            if (!this.disposed)
            {
                if (disposing)
                {
                    _reciever = null;
                }
                this.disposed = true;
            } 
        }
    }
}
