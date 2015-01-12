<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FeedBackUserControl.ascx.cs" Inherits="ML.UserControls.FeedBackUserControl" %>
<div>
    <div class="Q">
        Feedback: Did you find this tool useful?
    </div>
    <asp:Button ID="btnUseful" Style="margin-top: 20px" runat="server" Text="Loved it!" OnClick="UsefulFeedback" />

    <asp:Button Style="margin-top: 20px; margin-left: 25px" ID="btnNotUseful" runat="server" Text="Umm.." OnClick="NotUsefulFeedback" />
</div>