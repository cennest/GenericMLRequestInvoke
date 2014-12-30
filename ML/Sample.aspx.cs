using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ML
{
    public partial class Sample : System.Web.UI.Page
    {
        ScoreData scoreData = new ScoreData();
        protected void Page_Load(object sender, EventArgs e)
        {
           if (!IsPostBack)
            {
                rbtLst.SelectedIndex = 1;
                UpdatePanel1.Visible = true;
                JSONPanel.Visible = false;
            }
        }

        protected void PostButton_Click(object sender, EventArgs e)
        {
            ResponseOutputLbl.Visible = true;
            string endPointUrl = this.EndPointTxtBox.Text;
            string apiKey = this.APIKeyTxtBox.Text;

            if (UpdatePanel1.Visible)
            {
                scoreData.FeatureVector = ExtractParameterValue();
                GetAndPostData(endPointUrl, apiKey, scoreData.FeatureVector);

            }
            else
            {
                string json = TextArea.Text;
                json = json.Trim();

                ScoreRequest scoreRequest = new JavaScriptSerializer().Deserialize<ScoreRequest>(json);
                int inputParameterCount = scoreRequest.Instance.FeatureVector.Count;

                string outputString = HttpHelper.HttpPost(endPointUrl, apiKey, json.ToString());
                ExtractOutputFromResponse(inputParameterCount, outputString);
            }

        }


 
        protected Dictionary<string, string> ExtractParameterValue()
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

        protected void GetAndPostData(string endPointUrl, string apiKey, Dictionary<string, string> featureVector)
        {
            try
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
                ExtractOutputFromResponse(inputParameterCount, outputString);


            }
            catch (Exception ex)
            {

            }
        }

        protected void rbtLst_SelectedIndexChanged(object sender, EventArgs e)
        {
            ResponseOutputLbl.Visible = false;
            if (rbtLst.SelectedItem != null)
            {
                if (Convert.ToInt32(rbtLst.SelectedItem.Value) == (int)Enums.SendResponse.PostJSON)
                {
                    UpdatePanel1.Visible = false;
                    JSONPanel.Visible = true;
                }
                else if (Convert.ToInt32(rbtLst.SelectedItem.Value) == (int)Enums.SendResponse.KeyValue)
                {
                    JSONPanel.Visible = false;
                    UpdatePanel1.Visible = true;

                }
            } 
        }

        private void ExtractOutputFromResponse(int inputParameterCount, string outputString)
        {
            outputString = outputString.TrimStart('[');
            outputString = outputString.TrimEnd(']');
            string[] outputArray = outputString.Split(',');


            List<string> newArray = outputArray.Skip(inputParameterCount).ToList();

            outputString = string.Join(",", newArray.ToArray());
            ResponseOutputLbl.Text = outputString;
        }
    }
}