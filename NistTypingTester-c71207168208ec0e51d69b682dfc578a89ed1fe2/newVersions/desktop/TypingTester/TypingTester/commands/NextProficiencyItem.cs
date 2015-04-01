using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TypingTester.commands
{
    class NextProficiencyItem : Command
    {
        private controls.ProficiencyControl _reciever;

        public NextProficiencyItem(controls.ProficiencyControl reciever)
        {
            _reciever = reciever;
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

        public override void execute()
        {
            Session.Instance.CurrentProficiencyString++;
            _reciever.UpdateDisplay();
        }

        public override void undo()
        {
            throw new NotImplementedException();
        }
    }
}
