<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FAQ.aspx.cs" Inherits="ML.FAQ" %>

<%@ Register TagPrefix="uc" TagName="FeedBackUserControl"
    Src="~/UserControls/FeedBackUserControl.ascx" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server" ClientIDMode="Static">
    <div class="text-align-center">
        <uc:FeedBackUserControl ID="feedbackControl" runat="server" />
    </div>

    <div class="Q">
        <p>1. What is the aim of this portal?</p>
    </div>
    <div class="ans">
        This portal is a tool to provide online access to your published Azure Machine learning experiment without writing a single line of code or logging into the Azure portal.
    </div>

    <div class="Q">
        <p>2. So.....what is different from the test web service option within the Azure ML portal??</p>
    </div>
    <div class="ans">
        <ul>
            <li>
                <b><ins>Makes Sharing easier:-</ins></b> Currently there is no way to share and execute the published experiment without logging into Azure unless you write a console app. This is an overhead when one is generally experimenting and wanting to share his output with others( and not necessarily his Experiment which can can do by inviting others via the Azure ML Studio).
                           <ul>
                               <li>Currently in order to share the experiment with mlonazure.cloudapp.net, the user just needs to send his APIKey/Url and parameters to this partner </li>
                               <li>If we get community interest we can create a  "shared key" which the developer can share with his partners where we can auto-fill parameters/Endpoint Url/Key  etc. </li>
                           </ul>
            </li>
            <li>
                <b><ins>Ease of re-use:-</ins></b> The test web service link within Azure gives an option for only the Key/Value pairs which is cumbersome if the user has more number of parameters because he always has to remember the basic values of his test. We have the option of caching the user's EndPoint Url/API Key and JSON request (Caching for Key-Value pairs coming soon) so he can quickly test for various parameter combinations.
            </li>
        </ul>
    </div>

    <div class="Q">
        <p>3. Where are you saving my API and Key?</p>
    </div>
    <div class="ans">
        If you have selected "Caching" then your Url and API are safely stored in your local browser cache.
    </div>

    <div class="Q">
        <p>4. This portal is useful but I want more features!</p>
    </div>
    <div class="ans">
        We are aware that this portal is very basic right now and are trying to gauge community interest so we can invest more time in it. Please send us your suggestions/questions at <a href="mailto:daksh@cennest.com">Cennest Technologies</a>  and we will definately look to incorporate your suggestions in the next update!
    </div>
    <br />
    <br />
    <div id="sampleExperimentInfo">
    </div>

</asp:Content>