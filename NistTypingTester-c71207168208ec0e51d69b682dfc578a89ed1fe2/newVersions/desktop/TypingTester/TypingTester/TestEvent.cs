using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TypingTester
{
    internal class TestEvent
    {
        public Constants.Event EventType { get; set; }
        public Constants.Phase Phase { get; set; }
        public Constants.SubPhase SubPhase { get; set; }
        public DateTime Time { get; set; }
        public string Notes { get; set; }
        public TimeSpan Interval {get; set;}
        public string ParticipantNumber { get; set; }
        public int X { get; set; }
        public int Y { get; set; }
        public string Key { get; set; }
        public string CurrentValue { get; set;}
        public bool Alt { get; set; }
        public bool Ctrl { get; set; }
        public bool Shift { get; set; }
        public string TargetString { get; set; }
        public int subphaseRepetitionNumber { get; set; }

        public static string LogHeader
        {
            get
            {
                return "Time\tTime Since Session Start\tParticipant Number\tEvent\tPhase\tSubPhase\tSubphase Visit\tTarget String\tX\tY\tKey\tCurrent Value\tNotes";
            }
        }

        public TestEvent(Constants.Event eventType, Constants.Phase phase, Constants.SubPhase subphase, string notes)
        {
            this.EventType = eventType;
            this.Phase = phase;
            this.SubPhase = subphase;
            this.Notes = notes;
            this.Time = DateTime.Now;
            this.X = -1;
            this.Y = -1;
            this.Alt = false;
            this.Ctrl = false;
            this.Shift = false;
            this.TargetString = string.Empty;
            switch(this.SubPhase)
            {
                case Constants.SubPhase.FreePractice:
                    this.subphaseRepetitionNumber = Session.Instance.TimesInFreePractice;
                    break;

                case Constants.SubPhase.ForcedPractice:
                    this.subphaseRepetitionNumber = Session.Instance.TimesInForcedPractice;
                    break;

                case Constants.SubPhase.Verify:
                    this.subphaseRepetitionNumber = Session.Instance.TimesInVerify;
                    break;

                default:
                    this.subphaseRepetitionNumber = 0;
                    break;
            }
        }

        public override string ToString()
        {
            return string.Format("{0}\t{1}\t{2}\t{3}\t{4}\t{5}\t{6}\t{7}\t{8}\t{9}\t{10}\t{11}", this.Time, this.Interval, this.ParticipantNumber,
                this.EventType, this.Phase, this.SubPhase, this.subphaseRepetitionNumber, this.TargetString, this.X, this.Y, this.Key, this.Notes);
        }

        


    }
}
