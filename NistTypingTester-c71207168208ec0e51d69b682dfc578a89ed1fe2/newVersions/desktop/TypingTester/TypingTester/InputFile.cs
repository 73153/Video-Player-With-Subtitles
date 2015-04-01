using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace TypingTester
{
    class InputFile
    {
        private string _filename;

        public string Filename
        {
            get
            {
                return _filename;
            }
        }

        public string[] ProficiencyStrings { get; protected set; }
        public string[] EntityStrings { get; protected set; }

        public bool EntityNumberError { get; protected set; }
        public bool EntityFilterError { get; protected set; }

        public InputFile(string filename)
        {
            this.EntityNumberError = false;
            this.EntityFilterError = false;
            Random rand = new Random();
            XElement root = XElement.Load(filename);
            // load proficiency strings
            IEnumerable<XElement> proficiencyStrings;
            proficiencyStrings = from el in root.Descendants("proficiencyInput") select el;
            List<string> ps = new List<string>();
            foreach (XElement el in proficiencyStrings)
            {
                ps.Add(el.Value);
            }
            this.ProficiencyStrings = ps.ToArray();
            // load strings
            int groupId = -1;
            IEnumerable<XElement> entityElements;
            if (Options.Instance.UseGroupId)
            {
                groupId = Options.Instance.GroupId;
            }
            //load and order the entites, filter by group id if specified
            if (groupId == -1)
            {
                entityElements = from el in root.Descendants("memorizationInput")
                                 orderby(int)el.Attribute("itemId")
                                 select el;
            }
            else
            {
                entityElements = from el in root.Descendants("memorizationInput") 
                                 where (string)el.Attribute("groupId") == groupId.ToString() 
                                 orderby (int)el.Attribute("itemId")
                                 select el;
            }
            // check for no matched filters
            if (entityElements.Count() == 0)
            {
                entityElements = from el in root.Descendants("memorizationInput")
                                 orderby (int)el.Attribute("itemId")
                                 select el;
                this.EntityFilterError = true;
            }
            // get the initial list of filtered and ordered entities
            List<string> entities = new List<string>();
            foreach (XElement element in entityElements)
            {
                IEnumerable<XElement> value = from el in element.Descendants("value") select el;
                foreach (XElement v in value)
                {
                    entities.Add(v.Value);
                }
            }

            // randomize selection from the list
            if (Options.Instance.RandomEntitySelection)
            {
                if (!Options.Instance.UseSelectionSeed) Options.Instance.SelectionSeed = rand.Next();
                entities = RandomizeList(entities, Options.Instance.SelectionSeed);
            }

            // cut the list down to the specified size
            if (entities.Count < Options.Instance.NumberOfEntities)
            {
                this.EntityNumberError = true;
            }
            else
            {
                entities = entities.GetRange(0, Options.Instance.NumberOfEntities);
            }
            // randomize order of the remaining strings
            if (Options.Instance.RandomEntityOrder)
            {
                if (!Options.Instance.UseOrderSeed) Options.Instance.OrderSeed = rand.Next();
                entities = RandomizeList(entities, Options.Instance.OrderSeed);
            }

            this.EntityStrings = entities.ToArray();

        }

        private List<string> RandomizeList(List<string> input, Int32 seed)
        {
            Random rand = new Random(seed);
            List<string> ret = new List<string>(input.Count);
            while (input.Count > 0)
            {
                int i = rand.Next(input.Count - 1);
                ret.Add(input[i]);
                input.RemoveAt(i);
            }
            return ret;
        }

    }
}
