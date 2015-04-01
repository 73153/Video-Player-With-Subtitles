using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TypingTester
{
    public sealed class Options
    {
        private static readonly Options _instance = new Options();

        private string _filename = @".\documents\options.xml";

        public int NumberOfEntities { get; set; }
        public int RepetitionPerEntity { get; set; }
        public int ForcedPracticeRounds { get; set; }
        public int VerifyRounds { get; set; }
        public bool RandomEntityOrder { get; set; }
        public bool UseOrderSeed { get; set; }
        public int OrderSeed { get; set; }
        public bool RandomEntitySelection { get; set; }
        public bool UseSelectionSeed { get; set; }
        public int SelectionSeed { get; set; }
        public bool UseGroupId { get; set; }
        public int GroupId { get; set; }
        public string QuitString { get; set; }
        public string SkipString { get; set; }
        public bool ShowSkipButton { get; set; }
        public bool ShowQuitButton { get; set; }
        public bool ShowHideButtonOnPractice { get; set; }
        public bool disableFreePractice { get; set; }
        public bool disableFreePracticeTextBox { get; set; }


        private Options()
        {
            setDefaults();
        }

        public static Options Instance
        {
            get
            {
                return _instance;
            }
        }

        private void setDefaults()
        {
            this.NumberOfEntities = 10;
            this.RepetitionPerEntity = 10;
            this.ForcedPracticeRounds = 3;
            this.RandomEntityOrder = false;
            this.UseOrderSeed = false;
            this.OrderSeed = 1;
            this.RandomEntitySelection = false;
            this.UseSelectionSeed = false;
            this.SelectionSeed = 1;
            this.UseGroupId = false;
            this.GroupId = 1;
            this.QuitString = "I QUIT";
            this.VerifyRounds = 1;
            this.SkipString = "I SKIP";
            this.ShowHideButtonOnPractice = false;
            this.ShowQuitButton = false;
            this.ShowSkipButton = false;
            this.disableFreePractice = false;
            this.disableFreePracticeTextBox = false;
        }

        public void ResetToDefault()
        {
            setDefaults();
            save();
        }

        public void load()
        {
            XElement root = XElement.Load(_filename);
            this.NumberOfEntities = (int)(from el in root.Descendants(OptionTags.numberOfEntities) select el).First();
            this.RepetitionPerEntity = (int)(from el in root.Descendants(OptionTags.repetitionsPerEntity) select el).First();

            this.ForcedPracticeRounds = (int)(from el in root.Descendants(OptionTags.forcedPracticeRounds) select el).First();
            this.VerifyRounds = (int)(from el in root.Descendants(OptionTags.verifyRounds) select el).First();
            this.RandomEntityOrder = (bool)(from el in root.Descendants(OptionTags.randomOrder) select el).First();
            this.UseOrderSeed = (bool)(from el in root.Descendants(OptionTags.useOrderSeed) select el).First();
            this.OrderSeed = (int)(from el in root.Descendants(OptionTags.orderSeed) select el).First();
            this.RandomEntitySelection = (bool)(from el in root.Descendants(OptionTags.randomSelection) select el).First();
            this.UseSelectionSeed = (bool)(from el in root.Descendants(OptionTags.useSelectionSeed) select el).First();
            this.SelectionSeed = (int)(from el in root.Descendants(OptionTags.selectionSeed) select el).First();
            this.UseGroupId = (bool)(from el in root.Descendants(OptionTags.useGroupId) select el).First();
            this.GroupId = (int)(from el in root.Descendants(OptionTags.groupId) select el).First();
            this.QuitString = (string)(from el in root.Descendants(OptionTags.quitString) select el).First();
            this.SkipString = (string)(from el in root.Descendants(OptionTags.skipString) select el).First();
            this.ShowSkipButton = (bool)(from el in root.Descendants(OptionTags.showSkipButton) select el).First();
            this.ShowQuitButton = (bool)(from el in root.Descendants(OptionTags.showQuitButton) select el).First();
            this.ShowHideButtonOnPractice = (bool)(from el in root.Descendants(OptionTags.showHideButton) select el).First();
            this.disableFreePractice = (bool)(from el in root.Descendants(OptionTags.disableFreePractice) select el).First();
            this.disableFreePracticeTextBox = (bool)(from el in root.Descendants(OptionTags.disableFreePracticeTextBox) select el).First();
        }

        public void save()
        {
            XDocument doc = new XDocument();
            XElement root = new XElement("options");
            root.Add(new XElement(OptionTags.numberOfEntities, this.NumberOfEntities));
            root.Add(new XElement(OptionTags.repetitionsPerEntity, this.RepetitionPerEntity));
            root.Add(new XElement(OptionTags.forcedPracticeRounds, this.ForcedPracticeRounds));
            root.Add(new XElement(OptionTags.verifyRounds, this.VerifyRounds));
            root.Add(new XElement(OptionTags.randomOrder, this.RandomEntityOrder));
            root.Add(new XElement(OptionTags.useOrderSeed,this.UseOrderSeed));
            root.Add(new XElement(OptionTags.orderSeed, this.OrderSeed));
            root.Add(new XElement(OptionTags.randomSelection, this.RandomEntitySelection));
            root.Add(new XElement(OptionTags.useSelectionSeed, this.UseSelectionSeed));
            root.Add(new XElement(OptionTags.selectionSeed,this.SelectionSeed));
            root.Add(new XElement(OptionTags.useGroupId, this.UseGroupId));
            root.Add(new XElement(OptionTags.groupId, this.GroupId));
            root.Add(new XElement(OptionTags.quitString, this.QuitString));
            root.Add(new XElement(OptionTags.skipString, this.SkipString));
            root.Add(new XElement(OptionTags.showSkipButton, this.ShowSkipButton));
            root.Add(new XElement(OptionTags.showQuitButton, this.ShowQuitButton));
            root.Add(new XElement(OptionTags.showHideButton, this.ShowHideButtonOnPractice));
            root.Add(new XElement(OptionTags.disableFreePractice, this.disableFreePractice));
            root.Add(new XElement(OptionTags.disableFreePracticeTextBox, this.disableFreePracticeTextBox));
            doc.Add(root);
            doc.Save(_filename);
        }

        public string GetSettings()
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendFormat("Session Settings\n");
            sb.AppendFormat("Number of entities: {0}\n", this.NumberOfEntities);
            sb.AppendFormat("Entries per entity: {0}\n", this.RepetitionPerEntity);
            sb.AppendFormat("Practice rounds : {0}\n", this.ForcedPracticeRounds);
            sb.AppendFormat("Verification rounds : {0}\n", this.VerifyRounds);
            sb.AppendFormat("Random Entity Order : {0}\n", this.RandomEntityOrder);
            sb.AppendFormat("Use Order Seed : {0}\n", this.UseOrderSeed);
            sb.AppendFormat("Order Seed : {0}\n", this.OrderSeed);
            sb.AppendFormat("Random Entity Selection : {0}\n", this.RandomEntitySelection);
            sb.AppendFormat("Use Selection Seed : {0}\n", this.UseSelectionSeed);
            sb.AppendFormat("Selection Seed : {0}\n", this.SelectionSeed);
            sb.AppendFormat("Use Group Id : {0}\n", this.UseGroupId);
            sb.AppendFormat("Group Id : {0}\n", this.GroupId);
            sb.AppendFormat("Quit String : {0}\n", this.QuitString);
            sb.AppendFormat("Skip String : {0}\n", this.SkipString);
            sb.AppendFormat("Show Quit Button : {0}\n", this.ShowQuitButton);
            sb.AppendFormat("Show Skip Button : {0}\n", this.ShowSkipButton);
            sb.AppendFormat("Show Hide Button : {0}\n", this.ShowHideButtonOnPractice);
            return sb.ToString();
        }
    }
}
