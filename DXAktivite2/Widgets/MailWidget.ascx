<%@ Control Language="C#" ClassName="MailWidget" %>
<ul class="mailFolders">
    <li>
        <dx:ASPxHyperLink runat="server" NavigateUrl="javascript:void(0)" Text="Inbox (1)" Font-Bold="true">
        </dx:ASPxHyperLink>
    </li>
    <li>
        <dx:ASPxHyperLink ID="ASPxHyperLink1" runat="server" NavigateUrl="javascript:void(0)" Text="Outbox">
        </dx:ASPxHyperLink>
    </li>
    <li>
        <dx:ASPxHyperLink ID="ASPxHyperLink2" runat="server" NavigateUrl="javascript:void(0)" Text="Sent Items">
        </dx:ASPxHyperLink>
    </li>
    <li>
        <dx:ASPxHyperLink ID="ASPxHyperLink3" runat="server" NavigateUrl="javascript:void(0)" Text="Deleted Items">
        </dx:ASPxHyperLink>
    </li>
    <li>
        <dx:ASPxHyperLink ID="ASPxHyperLink4" runat="server" NavigateUrl="javascript:void(0)" Text="Drafts">
        </dx:ASPxHyperLink>
    </li>    
</ul>
