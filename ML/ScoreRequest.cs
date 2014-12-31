using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ML
{
    public class ScoreRequest
    {
        public string Id { get; set; }
        public ScoreData Instance { get; set; }
    }
}