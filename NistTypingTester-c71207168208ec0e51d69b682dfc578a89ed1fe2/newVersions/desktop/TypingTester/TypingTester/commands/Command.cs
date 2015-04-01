using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TypingTester.commands
{
    abstract public class Command : IDisposable
    {
        protected bool disposed = false;

        public abstract void execute();
        public abstract void undo();
        protected abstract void Dispose(bool disposing);
        
        public virtual void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}
