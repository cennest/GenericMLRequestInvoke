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

        $(document).ready(function () {
            var postButton = document.getElementById('SampleExperimentPostButton');
            addListener(postButton, 'click', function () {
                ga('send', 'event', 'Sample Experiment', 'Button Click', 'Post Button');
            });

            function addListener(element, type, callback) {
                if (element.addEventListener) element.addEventListener(type, callback);
                else if (element.attachEvent) element.attachEvent('on' + type, callback);
            }

        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server" ClientIDMode="Static">
    <asp:Panel runat="server" ID="FormPanel">
        <div class="info">
            <div id="star">
                <p>*</p>
            </div>
            <div id="sampleExperimentInfo">
                <p>
                    Aim of the experiment accessed from this page was to create a sample for how to call the API for your machine learning experiment and not to showcase the power of Machine learning.
                </p>
                <p>
                    The experiment uses demographics to predict whether a person earns over 50K a year.
                It works on a data set called "Adult Census Income Binary Classification dataset” available in the Azure Machine Learning Sample Data Sets.
                </p>
            </div>
        </div>

        <div class="content-wrapper">
            <div>
                <asp:Label runat="server" Text="EndPoint URL" ID="EndPointLbl"></asp:Label>
                <asp:TextBox ID="EndPointTxtBox" runat="server" Text="https://ussouthcentral.services.azureml.net/workspaces/fc2a1659df5d4f5fb16c9fd6aaebf458/services/de1c02358364413f930843019074b247/score" ReadOnly="true"></asp:TextBox>
            </div>
            <br />
            <div>
                <asp:Label runat="server" Text="API Key" ID="APIKeyLbl"></asp:Label>
                <asp:TextBox runat="server" ID="APIKeyTxtBox" Text="4LJiS3e8Z1HRvz2HN84G3j1o/gsGI3S9nF9E5wdSK8zbrqfRgw9x1bWkR4yCP2JvB317gOEpaSN0i3b9yi5X1w==" ReadOnly="true"></asp:TextBox>
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
                <asp:TextBox ID="TextArea" TextMode="MultiLine" Columns="50" Rows="5" runat="server" Text="{
  'Id': 'score00001',
  'Instance': {
    'FeatureVector': {
      'age': '39',
      'workclass': 'State-gov',
      'education': 'Bachelors',
      'marital-status': 'Never-married',
      'occupation': 'Adm-clerical',
      'race': 'White',
      'sex': 'Male',
      'hours-per-week': '80',
      'native-country': 'United-States'
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
                                    <asp:TextBox runat="server" ID="Parameter1" Text="age" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Value1" Text="39" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>

                            <asp:TableRow>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Parameter2" Text="workclass" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Value2" Text="State-gov" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>

                            <asp:TableRow>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Parameter3" Text="education" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Value3" Text="Bachelors" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>

                            <asp:TableRow>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Parameter4" Text="marital-status" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Value4" Text="Never-married" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>

                            <asp:TableRow>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Parameter5" Text="occupation" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Value5" Text="Adm-clerical" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>

                            <asp:TableRow>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Parameter6" Text="race" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Value6" Text="White" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>

                            <asp:TableRow>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Parameter7" Text="sex" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Value7" Text="Male" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>

                            <asp:TableRow>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Parameter8" Text="hours-per-week" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Value8" Text="80" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>

                            <asp:TableRow>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Parameter9" Text="native-country" ReadOnly="true"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell runat="server">
                                    <asp:TextBox runat="server" ID="Value9" Text="United-States" ReadOnly="true"></asp:TextBox>
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

        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:Button ID="SampleExperimentPostButton" runat="server" Text="POST" OnClick="SampleExperimentPostButton_Click" />
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
                    <ProgressTemplate>

                        <img alt="loading..." src="Images/ajax-loader.gif" class="imageLoader" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <div class="response">
                    <asp:Label runat="server" Text="Response:" ID="ResponseLbl"></asp:Label>
                    <asp:Label runat="server" ID="ResponseOutputLbl" Text="" ForeColor="#FF9900"></asp:Label>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>


        <%--<asp:Image runat="server" ImageUrl="~/Images/ajax-loader.gif" AlternateText="loading..." ID="ImageLoader" CssClass="margin-left-10px" />--%>
    </asp:Panel>
</asp:Content>
