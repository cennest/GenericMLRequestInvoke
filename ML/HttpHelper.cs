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
        //public delegate string OnHttpSuccessCallback(string response);
        //public delegate string OnHttpErrorCallback(string message);
        //public static string outputString;

//        public static void HttpPost(string url, string apiKey, string jsonData, OnHttpSuccessCallback onSuccessCallback, OnHttpErrorCallback onErrorCallback)
//        {
//            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);

//            request.ContentType = "application/json";
//            request.Method = "POST";
//            request.Headers.Add("Authorization", "Bearer " + apiKey);

//                request.BeginGetRequestStream((IAsyncResult asyncResult) =>
//            {
//                HttpWebRequest req = (HttpWebRequest)asyncResult.AsyncState;

//                try
//                {
//                    Stream postStream = req.EndGetRequestStream(asyncResult);

//                    byte[] byteArray = Encoding.UTF8.GetBytes(jsonData);

//                    postStream.Write(byteArray, 0, byteArray.Length);
//                    postStream.Dispose();

//                    req.BeginGetResponse((IAsyncResult result) =>
//                    {
//                        HttpWebRequest reqs = (HttpWebRequest)result.AsyncState;

//                        HttpWebResponse response = null;
//                        Stream streamResponse = null;
//                        StreamReader reader = null;

//                        string webResponse = string.Empty;

//                        try
//                        {
//                            response = (HttpWebResponse)reqs.EndGetResponse(result);

//                            streamResponse = response.GetResponseStream();
//                            reader = new StreamReader(streamResponse);

//                            outputString =  onSuccessCallback(reader.ReadToEnd());
//                        }
//                        catch (WebException e)
//                        {
//                            var status = e.Status;
//                            onErrorCallback(e.Message);
//                        }
//                        finally
//                        {
//                            if (streamResponse != null)
//                            {
//                                streamResponse.Dispose();
//                            }

//                            if (reader != null)
//                            {
//                                reader.Dispose();
//                            }

//                            if (response != null)
//                            {
//                                response.Dispose();
//                            }
//                        }
//                    }, req);
//                }
//                catch (WebException e)
//                {
//                    onErrorCallback(e.Message);
//                }

//            }, request);
//}
        public static string HttpPost(string url, string apiKey, string jsonData)
        {
            try
            {
                //using (var client = new HttpClient())
                //{
                //    client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", apiKey);

                //    client.BaseAddress = new Uri(url);
                //    HttpResponseMessage response = await client.PutAsJsonAsync("", jsonData);
                //    if (response.IsSuccessStatusCode)
                //    {
                //        string result = await response.Content.ReadAsStringAsync();
                //        return result;
                //    }
                //    else
                //    {
                //        return "Failed with status code: {0}"+ response.StatusCode;
                //    }
                //}

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