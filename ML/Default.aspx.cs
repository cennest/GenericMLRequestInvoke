using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.Web.Script.Serialization;
using System.ComponentModel;
using System.Drawing;
using System.Collections;
using ML.Helper;
using SendGrid;
using System.Net.Mail;


namespace ML
{

    public partial class _Default : Page
    {
        ScoreData scoreData = new ScoreData();
        UIHelper helper = new UIHelper();
        private int numOfRows = 1;
        const int colsCount = 2;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rbtLst.SelectedIndex = 1;
                UpdatePanel1.Visible = true;
                GenerateTable(numOfRows, ML.Enums.TableFunction.Refresh.ToString());
                JSONPanel.Visible = false;
                LoadFromCookie();
            }
        }

        protected void YourExperimentPostButton_Click(object sender, EventArgs e)
        {
            ResponseOutputLbl.Visible = true;
            string endPointUrl = this.EndPointTxtBox.Text;
            string apiKey = this.APIKeyTxtBox.Text;
            if (cacheCheckBox.Checked)
            {
                SaveCookie();
            }
            if (UpdatePanel1.Visible)
            {
                if (ViewState["RowsCount"] != null)
                {
                    numOfRows = Convert.ToInt32(ViewState["RowsCount"].ToString());
                    GenerateTable(numOfRows, ML.Enums.TableFunction.Refresh.ToString());
                }

                scoreData.FeatureVector = helper.ExtractParameterValue(panelTable);
                ResponseOutputLbl.Text = helper.GetAndPostData(endPointUrl, apiKey, scoreData.FeatureVector);
                SendEmail("Response Recieved from Your Experiment", "Url " + endPointUrl + " recieved response :- " + ResponseOutputLbl.Text);

            }
            else
            {
                string json = TextArea.Text;
                json = json.Trim();

                ScoreRequest scoreRequest = new JavaScriptSerializer().Deserialize<ScoreRequest>(json);
                int inputParameterCount = 0;
                if (scoreRequest != null)
                {
                    inputParameterCount = scoreRequest.Instance.FeatureVector.Count;
                }

                string outputString = HttpHelper.HttpPost(endPointUrl, apiKey, json.ToString());
                ResponseOutputLbl.Text = helper.ExtractOutputFromResponse(inputParameterCount, outputString);
                SendEmail("Response Recieved from Your Experiment", "Url" + endPointUrl + " recieved response :-" + outputString);
            }

        }

        private void LoadFromCookie()
        {
            HttpCookie azureMLCookies = Request.Cookies["AzureMLExperiment"];
            if (azureMLCookies != null)
            {
                this.EndPointTxtBox.Text = azureMLCookies["url"];
                this.APIKeyTxtBox.Text = azureMLCookies["api"];
            }
        }

        protected void NotUsefulFeedback(object sender, EventArgs e)
        {
            SendEmail("Feedback" ,"User said Umm");
        }
         protected void UsefulFeedback(object sender, EventArgs e)
        {
            SendEmail("Feedback", "User said Loved it");
        }
        private void SendEmail(string subject, string text)
        {
            try
            {
                // Create network credentials to access your SendGrid account.
                var username = "daksh";
                var pswd = "Anshulee25*";

                var credentials = new NetworkCredential(username, pswd);

                // Create the email object first, then add the properties.
                SendGridMessage myMessage = new SendGridMessage();
                myMessage.AddTo("anshulee@cennest.com");
                myMessage.From = new MailAddress("anshulee@cennest.com", "Azure ML Experiment");
                myMessage.Subject = subject;
                myMessage.Text = text;


                // Create an Web transport for sending email.
                var transportWeb = new Web(credentials);

                // Send the email.
                transportWeb.Deliver(myMessage);
            }
            catch(Exception ex)
            {

            }
        }

        protected void SaveCookie()
        {
            string endPointUrl = this.EndPointTxtBox.Text;
            string apiKey = this.APIKeyTxtBox.Text;
            HttpCookie userMLExperimentCookie = new HttpCookie("AzureMLExperiment");
            userMLExperimentCookie["url"] = endPointUrl;
            userMLExperimentCookie["api"] = apiKey;
            Response.Cookies.Add(userMLExperimentCookie);

        }
        protected void AddNewRow_Click(object sender, EventArgs e)
        {
            if (ViewState["RowsCount"] != null)
            {
                numOfRows = Convert.ToInt32(ViewState["RowsCount"].ToString());
                numOfRows = numOfRows + 1;
                GenerateTable(numOfRows, ML.Enums.TableFunction.Add.ToString());
               
            }
        }

        protected void DeleteSingleRow_Click(object sender, EventArgs e)
        {
            if (ViewState["RowsCount"] != null)
            {
                numOfRows = Convert.ToInt32(ViewState["RowsCount"].ToString());
                numOfRows = numOfRows - 1;
                GenerateTable(numOfRows, ML.Enums.TableFunction.Delete.ToString());              
            }
        }

        private void SetPreviousData()
        {
            try
            {
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
                                    (ctrc as TextBox).Text = Request.Form["ctl00$MainContent$Parameter" + i];
                                }
                                else if (ctrc.ID == "Value" + i)
                                {
                                    (ctrc as TextBox).Text = Request.Form["ctl00$MainContent$Value" + i];
                                }
                            }
                        }

                        i++;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;

            }

        }

        //Genrates the table dyanmically for the Table Work Experiance and add the to the page
        private void GenerateTable(int rowsCount,string tableFunction)
        {
            try
            {
                if (rowsCount > 0 && !String.IsNullOrEmpty(tableFunction))
                {
                    if (rowsCount > 1)
                    {
                        DeleteSingleRow.Enabled = true;
                    }
                    else
                    {
                        DeleteSingleRow.Enabled = false;
                    }

                    Table table = new Table();

                    table.ID = "ParameterTable";

                    panelTable.Controls.Add(table);

                    //adding the head Row to the Table
                    TableHeaderRow headRow = new TableHeaderRow();
                    headRow.Height = 33;

                    TableHeaderCell headCell = new TableHeaderCell();
                    headCell.Text = "Parameter";
                    headCell.Width = 10;
                    headRow.Cells.Add(headCell);

                    TableHeaderCell headCell1 = new TableHeaderCell();
                    headCell1.Text = "Value";
                    headRow.Cells.Add(headCell1);

                    table.Rows.Add(headRow);
                    int id = 1;

                    // Now iterate through the table and add your controls
                    for (int i = 0; i < rowsCount; i++)
                    {
                        TableRow row = new TableRow();

                        for (int j = 0; j < colsCount; j++)
                        {
                            TableCell cell = new TableCell();
                            TextBox tb = new TextBox();
                            RequiredFieldValidator rfv = new RequiredFieldValidator(); 

                            // Set a unique ID for each TextBox added

                            if (j == 0)
                            {
                                tb.ID = "Parameter" + id;

                                rfv.ID = "rfvParameter" + id;
                                rfv.ControlToValidate = tb.ID;
                                rfv.ErrorMessage = "Please enter the parameter";
                                rfv.ValidationGroup = "groupValidator";
                                rfv.CssClass = "required-field-validator";
                            }
                            else
                            {
                                tb.ID = "Value" + id;
                                rfv.ID = "rfvValue" + id;
                                rfv.ControlToValidate = tb.ID;
                                rfv.ErrorMessage = "Please enter the value";
                                rfv.ValidationGroup = "groupValidator";
                                rfv.CssClass = "required-field-validator";
                            }

                            // Add the control to the TableCell
                            cell.Controls.Add(tb);
                            cell.Controls.Add(rfv);

                            // Add the TableCell to the TableRow
                            row.Cells.Add(cell);
                        }

                        id++;

                        // And finally, add the TableRow to the Table
                        table.Rows.Add(row);
                    }

                    //Set Previous Data on PostBacks
                    SetPreviousData();

                    if (ML.Enums.TableFunction.Delete.ToString().ToLower() == tableFunction.ToLower())
                    {
                        ViewState["RowsCount"] = rowsCount;
                    }
                    else if (ML.Enums.TableFunction.Add.ToString().ToLower() == tableFunction.ToLower())
                    {
                        ViewState["RowsCount"] = rowsCount;
                    }
                    else
                    {
                        ViewState["RowsCount"] = rowsCount;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
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
                    GenerateTable(numOfRows, ML.Enums.TableFunction.Refresh.ToString());

                }
            }
        }
    }
}