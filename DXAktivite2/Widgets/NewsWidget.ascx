<%@ Control Language="C#" ClassName="NewsWidget" %>
<script runat="server">
    protected void Page_Init(object sender, EventArgs e) {
        ASPxNewsControl.ItemSettings.DateVerticalPosition = DateVerticalPosition.BelowHeader;
        ASPxNewsControl.ItemSettings.DateHorizontalPosition = DateHorizontalPosition.Right;
        ASPxNewsControl.Paddings.Padding = 10;
        ASPxNewsControl.ContentStyle.Paddings.Padding = 0;
    }
</script>
<dx:ASPxNewsControl ID="ASPxNewsControl" runat="server" NavigateUrlFormatString="javascript:void('{0}');"
    Width="100%">
    <Border BorderStyle="None"/>
    <ItemSettings ImagePosition="Left" MaxLength="120" TailText="Details">
    </ItemSettings>
    <Items>
        <dx:NewsItem Date="4/12/2011" Image-Url="../images/Widgets/News/gagarin.jpg"
            HeaderText="50th Anniversary of Yuri Gagarin's Flight into Space"
            Text="On April 12th of 1961, Yuri Gagarin was the first human to fly into
            outer space. Today is the 50th Anniversary of his journey.">
        </dx:NewsItem>
        <dx:NewsItem Date="3/29/2011" Image-Url="../images/Widgets/News/indices.png"
            HeaderText="U.S. Stocks Advance Tuesday"
            Text="The U.S. stock market indices made strong gains by closing time on
            Tuesday. The European stock market indices were mixed at closing.">
        </dx:NewsItem>
    </Items>
</dx:ASPxNewsControl>
