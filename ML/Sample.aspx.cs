using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using ML.Helper;

namespace ML
{
    public partial class Sample : System.Web.UI.Page
    {
        ScoreData scoreData = new ScoreData();
        UIHelper helper = new UIHelper();
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
                scoreData.FeatureVector = helper.ExtractParameterValue(panelTable);
                ResponseOutputLbl.Text = helper.GetAndPostData(endPointUrl, apiKey, scoreData.FeatureVector);

            }
            else
            {
                string json = TextArea.Text;
                json = json.Trim();

                ScoreRequest scoreRequest = new JavaScriptSerializer().Deserialize<ScoreRequest>(json);
                int inputParameterCount = scoreRequest.Instance.FeatureVector.Count;

                string outputString = HttpHelper.HttpPost(endPointUrl, apiKey, json.ToString());
                ResponseOutputLbl.Text = helper.ExtractOutputFromResponse(inputParameterCount, outputString);
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
    }
}