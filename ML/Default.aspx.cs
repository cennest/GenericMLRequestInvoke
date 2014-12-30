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


namespace ML
{
    public class ScoreData
    {
        public Dictionary<string, string> FeatureVector { get; set; }
        public Dictionary<string, string> GlobalParameters { get; set; }
    }

    public class ScoreRequest
    {
        public string Id { get; set; }
        public ScoreData Instance { get; set; }
    }

    public enum TableFunction
    {
        Add,
        Delete,
        Refresh,
    }

    public partial class _Default : Page
    {
        ScoreData scoreData = new ScoreData();
        private int numOfRows = 1;
        const int colsCount = 2;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rbtLst.SelectedIndex = 1;
                UpdatePanel1.Visible = true;
                GenerateTable(numOfRows, TableFunction.Refresh.ToString());
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
                if (ViewState["RowsCount"] != null)
                {
                    numOfRows = Convert.ToInt32(ViewState["RowsCount"].ToString());
                    GenerateTable(numOfRows, TableFunction.Refresh.ToString());
                }

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

        protected void AddNewRow_Click(object sender, EventArgs e)
        {
            if (ViewState["RowsCount"] != null)
            {
                numOfRows = Convert.ToInt32(ViewState["RowsCount"].ToString());
                numOfRows = numOfRows + 1;
                GenerateTable(numOfRows, TableFunction.Add.ToString());
               
            }
        }

        protected void DeleteSingleRow_Click(object sender, EventArgs e)
        {
            if (ViewState["RowsCount"] != null)
            {
                numOfRows = Convert.ToInt32(ViewState["RowsCount"].ToString());
                numOfRows = numOfRows - 1;
                GenerateTable(numOfRows, TableFunction.Delete.ToString());              
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

            }

        }

        //Genrates the table dyanmically for the Table Work Experiance and add the to the page
        private void GenerateTable(int rowsCount,string tableFunction)
        {
            if(rowsCount > 1)
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

                    // Set a unique ID for each TextBox added

                    if (j == 0)
                    {
                        tb.ID = "Parameter" + id;
                    }
                    else
                    {
                        tb.ID = "Value" + id;
                    }

                    // Add the control to the TableCell
                    cell.Controls.Add(tb);

                    // Add the TableCell to the TableRow
                    row.Cells.Add(cell);
                }

                id++;

                // And finally, add the TableRow to the Table
                table.Rows.Add(row);
            }

            //Set Previous Data on PostBacks
            SetPreviousData();

            if (TableFunction.Delete.ToString().ToLower() == tableFunction.ToLower())
            {
                ViewState["RowsCount"] = rowsCount;
            }
            else if (TableFunction.Add.ToString().ToLower() == tableFunction.ToLower())
            {
                ViewState["RowsCount"] = rowsCount;
            }
            else
            {
                ViewState["RowsCount"] = rowsCount;
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
                    GenerateTable(numOfRows, TableFunction.Refresh.ToString());

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