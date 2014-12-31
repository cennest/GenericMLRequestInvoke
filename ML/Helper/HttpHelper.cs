using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace ML
{
    public class HttpHelper
    {
        public static string HttpPost(string url, string apiKey, string jsonData)
        {
            try
            {
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);

                request.ContentType = "application/json";
                request.Method = "POST";
                request.Headers.Add(HttpRequestHeader.Authorization, "Bearer " + apiKey);
                request.ContentType = "application/json";
                byte[] bytedata = Encoding.UTF8.GetBytes(jsonData);
                request.ContentLength = bytedata.Length;

                Stream requestStream = request.GetRequestStream();
                requestStream.Write(bytedata, 0, bytedata.Length);
                requestStream.Close();


                HttpWebResponse httpWebResponse = (HttpWebResponse)request.GetResponse();
                Stream responseStream = httpWebResponse.GetResponseStream();

                StreamReader myStreamReader = new StreamReader(responseStream, Encoding.Default);

                string outputString = myStreamReader.ReadToEnd();

                myStreamReader.Close();
                responseStream.Close();

                httpWebResponse.Close();

                return outputString;

            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
    }
}