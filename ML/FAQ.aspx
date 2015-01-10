<%@ Page Title="" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FAQ.aspx.cs" Inherits="ML.FAQ" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server" ClientIDMode="Static">
            <div class="Q">
              <p>1. What is the aim of this portal?</p>
            </div>
               <div class="ans">
                This portal is an attempt to provide online access to your published Azure Machine learning experiment without writing a single line of code or logging into the portal.
            </div>
       <div class="Q">
              <p>2. Where are you saving my API and Key?</p>
            </div>
               <div class="ans">
                If you have selected "Cache Url/Key&quot; then your Url and API are safely stored in your local browser cache.
            </div>
       <div class="Q">
              <p>3. This portal is useful but i want more features!</p>
            </div>
               <div class="ans">
                 We are aware that this portal is very basic right now and are trying to guage community interest so we can invest more time in it. Please send us your suggestions/questions at <a href="mailto:daksh@cennest.com">Cennest Technologies</a>  and we will definately look to incorporate your suggestions in the next update!
            </div>
                 <br/>
                 <br/>
            <div id="sampleExperimentInfo">
            </div>
      

</asp:Content>