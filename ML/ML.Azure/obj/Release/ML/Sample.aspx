<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Sample.aspx.cs" Inherits="ML.Sample" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script>
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),
            m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

        //ga('create', 'UA-58082288-1', 'none');
        ga('create', 'UA-58082288-1', 'auto');
        ga('send', 'event', 'PostButton', 'HardcodedValues', 'clicked');

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server" ClientIDMode="Static">
    <asp:Panel runat="server" ID="FormPanel">
        <div class="content-wrapper">
            <div>
                <asp:Label runat="server" Text="EndPoint URL" ID="EndPointLbl"></asp:Label>
                <asp:TextBox ID="EndPointTxtBox" runat="server" Text="https://ussouthcentral.services.azureml.net/workspaces/fc2a1659df5d4f5fb16c9fd6aaebf458/services/c54e29675c0b444083ef6bc655be78f5/score" ReadOnly="true"></asp:TextBox>
            </div>
            <br />
            <div>
                <asp:Label runat="server" Text="API Key" ID="APIKeyLbl"></asp:Label>
                <asp:TextBox runat="server" ID="APIKeyTxtBox" Text="0feHeToqtjZZFTH+2rF17V7C1qo7RVaIs+kT7AkqqI0711KiHBhI8tyFWFT2T4SO1AtSMjZPecBHrmFPCjdOYA==" ReadOnly="true"></asp:TextBox>
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
                <asp:TextBox ID="TextArea" TextMode="MultiLine" Columns="50" Rows="5" runat="server" Text="{ 'Id': 'score00001',
  'Instance': {
    'FeatureVector': {
      'vtCOPBRWheelSpeed': '2',
      'vtCOPBRMassFlow': '5',
      'vtCOPBRRotorDrivePressure': '8',
      'vtCOPBRRotorSpeed': '2',
      'vtCOPBRFuelConsumption': '9',
      'vtCOPBRRotorEfficiency': '0.7'
    },
    'GlobalParameters': {}
  }
} 
"
                    ReadOnly="true"></asp:TextBox>
            </asp:Panel>

            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Panel ID="panelTable" runat="server">
                        <asp:Table ID="ParameterTable" runat="server">
                            <asp:TableHeaderRow runat="server">
                                <asp:TableHeaderCell runat="server" Text="Parameter" Scope="Column"></asp:TableHeaderCell>
                                <asp:TableHeaderCell runat="server" Text="Value" Scope="Column"></asp:TableHeaderCell>
                            </asp:TableHeaderRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Parameter1" Text="vtCOPBRWheelSpeed" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Value1" Text="2" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>

                            <asp:TableRow>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Parameter2" Text="vtCOPBRMassFlow" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Value2" Text="5" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>

                            <asp:TableRow>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Parameter3" Text="vtCOPBRRotorDrivePressure" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Value3" Text="8" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>

                            <asp:TableRow>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Parameter4" Text="vtCOPBRRotorSpeed" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Value4" Text="2" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>

                            <asp:TableRow>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Parameter5" Text="vtCOPBRFuelConsumption" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Value5" Text="9" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>

                            <asp:TableRow>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Parameter6" Text="vtCOPBRRotorEfficiency" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Value6" Text="0.7" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>

                        </asp:Table>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <br />
<%--         <script type="text/javascript">
             var prm = Sys.WebForms.PageRequestManager.getInstance();
             prm.add_initializeRequest(InitializeRequest);
             prm.add_endRequest(EndRequest);
             var postBackElement;
             function InitializeRequest(sender, args) {
                 if (prm.get_isInAsyncPostBack()) {
                     args.set_cancel(true);
                 }
                 postBackElement = args.get_postBackElement();

                 if (postBackElement.id == 'PostButton') {
                     $get('UpdateProgress1').style.display = "inline-block";
                 }
             }
             function EndRequest(sender, args) {
                 if (postBackElement.id == 'PostButton') {
                     $get('UpdateProgress1').style.display = "none";
                 }
             }
    </script>--%>

        <asp:UpdatePanel ID="UpdatePanel2" runat="server" >
            <ContentTemplate>
                <asp:Button ID="PostButton" runat="server" Text="POST" OnClick="PostButton_Click" />
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


        <%--<asp:Image runat="server" ImageUrl="~/Images/ajax-loader.gif" AlternateText="loading..." ID="ImageLoader" CssClass="margin-left-10px" />--%>
    </asp:Panel>
</asp:Content>
