<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ML._Default" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
    </section>
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <form class="form" runat="server">
        <asp:Panel runat="server" ID="FormPanel">
            <div class="content-wrapper">
                <asp:Label runat="server" Text="EndPointURL" ID="EndPointLbl"></asp:Label>
                <asp:TextBox ID="EndPointTxtBox" runat="server"></asp:TextBox>
                <asp:Label runat="server" Text="APIKey" ID="APIKeyLbl"></asp:Label>
                <asp:TextBox runat="server" ID="APIKeyTxtBox"></asp:TextBox>
            </div>

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

        <br />

        <asp:Button ID="PostButton" runat="server" Text="POST" OnClick="PostButton_Click" />

        <asp:UpdatePanel runat="server" ID="update">
            <ContentTemplate>
                <asp:Label runat="server" Text="Response:" ID="ResponseLbl"></asp:Label>
                <asp:Label runat="server" ID="ResponseOutputLbl" Text="" ForeColor="#2f96b4"></asp:Label>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="PostButton" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </form>
</asp:Content>
