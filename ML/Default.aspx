<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ML._Default" %>
<asp:Content runat="server" ID="HeadContent" ContentPlaceHolderID="HeadContent">
    <script>
        $(document).ready(function () {
            var interval = null;

            function CheckVisibilityOfResponseLabel() {
                if ($('#ResponseOutputLbl').is(':visible')) {
                    var postedValue = $('#ResponseOutputLbl').text();
                    clearInterval(interval);
                    ga('send', 'event', 'Your Experiment', 'Label Visible', 'Response Label');
                    return true;
                }
            }

            $(document).on('click', '#YourExperimentPostButton', function () {
                ga('send', 'event', 'Your Experiment', 'Button Click', 'Post Button');
                interval = window.setInterval(CheckVisibilityOfResponseLabel, 100);
            });
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
                <asp:RequiredFieldValidator runat="server" CssClass="required-field-validator" ID="rfvEndPointUrl" ControlToValidate="EndPointTxtBox" ErrorMessage="Please enter a end point url." ValidationGroup="groupValidator"></asp:RequiredFieldValidator>
                </div>
                <br />
                <div>
                <asp:Label runat="server" Text="API Key" ID="APIKeyLbl"></asp:Label>
                <asp:TextBox runat="server" ID="APIKeyTxtBox"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" CssClass="required-field-validator" ID="rfvAPIKey" ControlToValidate="APIKeyTxtBox" ErrorMessage="Please enter an api key." ValidationGroup="groupValidator"></asp:RequiredFieldValidator>
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
             <asp:RequiredFieldValidator runat="server" CssClass="required-field-validator" ID="rfvTextArea" ControlToValidate="TextArea" ErrorMessage="Please paste sample request in the textbox." ValidationGroup="groupValidator"></asp:RequiredFieldValidator>
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
            
                <asp:Button ID="YourExperimentPostButton" runat="server" Text="POST" OnClick="YourExperimentPostButton_Click" ValidationGroup="groupValidator" />
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
                    <ProgressTemplate>

                        <img alt="loading..." src="Images/ajax-loader.gif" class="imageLoader" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
                 <asp:CheckBox runat="server" ID="cacheCheckBox" Checked="true" />
                <asp:Label runat="server" Text="Cache Url and Key in my browser"/>
                <div class="response">
                    <asp:Label runat="server" Text="Response:" ID="ResponseLbl"></asp:Label>
                    <asp:Label runat="server" ID="ResponseOutputLbl" Text="" ForeColor="#FF9900"></asp:Label>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
            <br />
      <%--      <asp:Panel runat="server">
                <div class="Q">
                   Feedback: Did you find this tool useful?
                </div>
                <asp:Button ID="btnUseful"  Style="margin-top: 20px" runat="server" Text="Loved it!"  ValidationGroup="groupValidator" />
                               
                 <asp:Button Style="margin-top: 20px;margin-left: 25px" ID="btnNotUseful" runat="server" Text="Umm.." OnClick="YourExperimentPostButton_Click" ValidationGroup="groupValidator" />

            </asp:Panel>--%>
        </asp:Panel>

   <%-- </form>--%>
</asp:Content>
