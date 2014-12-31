﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace ML.Helper
{
    public class UIHelper
    {
        ScoreData scoreData = new ScoreData();
        public string GetAndPostData(string endPointUrl, string apiKey, Dictionary<string, string> featureVector)
        {
            try
            {
                if (!String.IsNullOrEmpty(endPointUrl) && !String.IsNullOrEmpty(apiKey) && featureVector != null)
                {
                    scoreData.FeatureVector = featureVector;
                    scoreData.GlobalParameters = new Dictionary<string, string>() { };

                    ScoreRequest scoreRequest = new ScoreRequest()
                    {
                        Id = "score00001",
                        Instance = scoreData
                    };

                    var javaScriptSerializer = new JavaScriptSerializer();
                    string json = javaScriptSerializer.Serialize(scoreRequest);

                    string outputString = HttpHelper.HttpPost(endPointUrl, apiKey, json.ToString());
                    int inputParameterCount = scoreData.FeatureVector.Count;
                    string output = ExtractOutputFromResponse(inputParameterCount, outputString);

                    return output;
                }
                return null;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public string ExtractOutputFromResponse(int inputParameterCount, string outputString)
        {
            try
            {
                if (!String.IsNullOrEmpty(outputString) && inputParameterCount > 0)
                {
                    outputString = outputString.TrimStart('[');
                    outputString = outputString.TrimEnd(']');
                    string[] outputArray = outputString.Split(',');


                    List<string> newArray = outputArray.Skip(inputParameterCount).ToList();

                    outputString = string.Join(",", newArray.ToArray());
                    return outputString;
                }

                return null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}