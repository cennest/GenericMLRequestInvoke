<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ML._Default" %>
<asp:Content runat="server" ID="HeadContent" ContentPlaceHolderID="HeadContent">
    <script>
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),
            m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');


        //ga('create', 'UA-58082288-1', 'none');
        ga('create', 'UA-58082288-1', 'auto');

        $(document).ready(function () {
            var postButton = document.getElementById('YourExperimentPostButton');
            addListener(postButton, 'click', function () {
                ga('send', 'event', 'Your Experiment', 'Button Click', 'Post Button');
            });

            function addListener(element, type, callback) {
                if (element.addEventListener) element.addEventListener(type, callback);
                else if (element.attachEvent) element.attachEvent('on' + type, callback);
            }
        });
         
</script>
</asp:Content>
<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
    </section>
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent" ClientIDMode="Static">
    <%--<div class="text-align-center">
            <h1>Azure Machine Learning Console</h1>
    </div>--%>
   <%-- <form class="form" runat="server">--%>
        <asp:Panel runat="server" ID="FormPanel">
            <div class="content-wrapper">
                <div>
                <asp:Label runat="server" Text="EndPoint URL" ID="EndPointLbl"></asp:Label>
                <asp:TextBox ID="EndPointTxtBox" runat="server"></asp:TextBox>
                </div>
                <br />
                <div>
                <asp:Label runat="server" Text="API Key" ID="APIKeyLbl"></asp:Label>
                <asp:TextBox runat="server" ID="APIKeyTxtBox"></asp:TextBox>
               </div>
                <br />
                <div>
                <asp:RadioButtonList ID="rbtLst" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="rbtLst_SelectedIndexChanged" AutoPostBack="true">
                <asp:ListItem Text="Post JSON" Value="1"></asp:ListItem>
                <asp:ListItem Text="Key-Value" Value="2"></asp:ListItem>
            </asp:RadioButtonList>
                </div>
            </div>
            <div id="radioButtonPanel">
        <asp:Panel ID="JSONPanel" runat="server">
             <asp:TextBox ID="TextArea" TextMode="MultiLine" Columns="50" Rows="5" runat="server"></asp:TextBox>
         </asp:Panel>

        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Panel ID="panelTable" runat="server">
                </asp:Panel>
                <span class="style1">
                    <asp:Button ID="AddNewRow" runat="server" Text="Add" OnClick="AddNewRow_Click" />
                     <asp:Button ID="DeleteSingleRow" runat="server" Text="Delete" Enabled="false" OnClick="DeleteSingleRow_Click" />
            </ContentTemplate>
        </asp:UpdatePanel>
</div>
                    <br />
        <asp:UpdatePanel ID="UpdatePanel2" runat="server" >
            <ContentTemplate>
                <asp:Button ID="YourExperimentPostButton" runat="server" Text="POST" OnClick="YourExperimentPostButton_Click" />
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
                    <ProgressTemplate>

                        <img alt="loading..." src="Images/ajax-loader.gif" class="imageLoader" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <div class="response">
                    <asp:Label runat="server" Text="Response:" ID="ResponseLbl"></asp:Label>
                    <asp:Label runat="server" ID="ResponseOutputLbl" Text="" ForeColor="#2f96b4"></asp:Label>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </asp:Panel>

   <%-- </form>--%>
</asp:Content>
