using SendGrid;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

namespace ML.Helper
{
    public class SendMailHelper
    {
        public void SendEmail(string subject, string text)
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
            catch (Exception ex)
            {

            }
        }
    }
}