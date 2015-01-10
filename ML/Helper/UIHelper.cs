using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

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
                    if(String.IsNullOrEmpty(output))
                    {
                       output= "No Response";
                    }
                    
    
                    return output;
                }
                return "No Response";

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
                    if(String.IsNullOrEmpty(outputString))
                    {
                        outputString = "No Response";
                    }
                    return outputString;
                }

                return null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Dictionary<string, string> ExtractParameterValue(Panel panelTable)
        {
            try
            {
                string parameter = null;
                string value = null;
                scoreData.FeatureVector = new Dictionary<string, string>();

                Table tbl = panelTable.FindControl("ParameterTable") as Table;
                if (tbl != null)
                {
                    var i = 0;
                    foreach (TableRow tr in tbl.Rows)
                    {
                        foreach (TableCell tc in tr.Controls)
                        {
                            foreach (Control ctrc in tc.Controls)
                            {
                                if (ctrc.ID == "Parameter" + i)
                                {
                                    if (!String.IsNullOrEmpty((ctrc as TextBox).Text.Trim()))
                                    {
                                        parameter = (ctrc as TextBox).Text.Trim();
                                    }
                                }
                                else if (ctrc.ID == "Value" + i)
                                {
                                    if (!String.IsNullOrEmpty((ctrc as TextBox).Text.Trim()))
                                    {
                                        value = (ctrc as TextBox).Text.Trim();
                                    }
                                }
                            }
                        }

                        if (!String.IsNullOrEmpty(parameter) && !String.IsNullOrEmpty(value))
                        {
                            scoreData.FeatureVector.Add(parameter, value);
                            parameter = null;
                            value = null;
                        }

                        i++;
                    }

                    return scoreData.FeatureVector;
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