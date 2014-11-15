using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : Page
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

    protected void Page_Load(object sender, EventArgs e)
    {
         InvokeRequestResponseService().Wait();
    }

      static async Task InvokeRequestResponseService()
        {
            using (var client = new HttpClient())
            {
                ScoreData scoreData = new ScoreData()
                {
                    FeatureVector = new Dictionary<string, string>() 
                    {
                        { "vtCOPBRWheelSpeed", "0" },
                        { "vtCOPBRMassFlow", "0" },
                        { "vtCOPBRRotorDrivePressure", "0" },
                        { "vtCOPBRRotorSpeed", "0" },
                        { "vtCOPBRFuelConsumption", "0" },
                        { "vtCOPBRRotorEfficiency", "0" },
                    },
                    GlobalParameters = 
                        new Dictionary<string, string>() 
                        {
                                                }
                };

                ScoreRequest scoreRequest = new ScoreRequest()
                {
                    Id = "score00001",
                    Instance = scoreData
                };

                const string apiKey = "0feHeToqtjZZFTH+2rF17V7C1qo7RVaIs+kT7AkqqI0711KiHBhI8tyFWFT2T4SO1AtSMjZPecBHrmFPCjdOYA=="; // Replace this with the API key for the web service
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue( "Bearer", apiKey);

                client.BaseAddress = new Uri("https://ussouthcentral.services.azureml.net/workspaces/fc2a1659df5d4f5fb16c9fd6aaebf458/services/c54e29675c0b444083ef6bc655be78f5/score");
                HttpResponseMessage response = await client.PostAsJsonAsync("", scoreRequest);
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    Console.WriteLine("Result: {0}", result);
                }
                else
                {
                    Console.WriteLine("Failed with status code: {0}", response.StatusCode);
                }
            }
        }
    }
