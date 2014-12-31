using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ML
{
    public class Enums
    {
        public enum SendResponse
        {
           PostJSON = 1,
           KeyValue
        }
        public enum TableFunction
        {
            Add,
            Delete,
            Refresh,
        }
    }
}