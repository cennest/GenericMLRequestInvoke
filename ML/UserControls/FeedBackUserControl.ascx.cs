using ML.Helper;
using SendGrid;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ML.UserControls
{
    public partial class FeedBackUserControl : System.Web.UI.UserControl
    {
        private SendMailHelper mailHelper;
        protected void Page_Load(object sender, EventArgs e)
        {
            mailHelper = new SendMailHelper();
        }

        protected void NotUsefulFeedback(object sender, EventArgs e)
        {
            this.mailHelper.SendEmail("Feedback", "User said Umm");
        }
        protected void UsefulFeedback(object sender, EventArgs e)
        {
            this.mailHelper.SendEmail("Feedback", "User said Loved it");
        }
    }
}