using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TypingTester
{
}

    public class Constants
    {
        public enum Screen {Unknown, StartScreen, ReadyScreen, Proficiency, Instructions, 
                            Memorize, ForcedPractice, Verify, Entry, Recall, ThankYou, Settings };
        public enum Phase { Unknown, Proficiency, Instruction, Memorize, Entry, Recall, ThankYou };
        public enum SubPhase { Unknown, FreePractice, ForcedPractice, Verify, EntityChange, None };
        public enum Event
        {
            Unknown, Input, PhaseBegin, PhaseEnd, SubPhaseChange, ProficiencyStringShown, EntityDisplayed,
            ControlActivated, IncorrectValueEntered, CorrectValueEntered, MouseClick, KeyDown, KeyUp, KeyPress
        };

        
}
