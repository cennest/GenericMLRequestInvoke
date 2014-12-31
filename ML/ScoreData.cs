using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ML
{
    public class ScoreData
    {
        public Dictionary<string, string> FeatureVector { get; set; }
        public Dictionary<string, string> GlobalParameters { get; set; }
    }
}