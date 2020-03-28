<%@ Control Language="C#" ClassName="DayUserControl" %>
<script runat="server">
    string dayOfWeekHyperLinkText;
    string weatherImageUrl;
    string temperatureHyperLinkText;
    protected void Page_Init(object sender, EventArgs e) {
        DayOfWeekHyperLink.Text = DayOfWeek;
        WeatherImage.ImageUrl = WeatherImageUrl;
        TemperatureHyperLink.Text = Temperature;
    }
    public string DayOfWeek {
        get { return dayOfWeekHyperLinkText; }
        set { dayOfWeekHyperLinkText = value; }
    }
    public string WeatherImageUrl {
        get { return weatherImageUrl; }
        set { weatherImageUrl = value; }
    }
    public string Temperature {
        get { return temperatureHyperLinkText; }
        set { temperatureHyperLinkText = value; }
    }
</script>
<div class="dayUCContainer">
    <div>
        <dx:ASPxHyperLink ID="DayOfWeekHyperLink" runat="server">
        </dx:ASPxHyperLink>
    </div>
    <dx:ASPxImage runat="server" ID="WeatherImage">
    </dx:ASPxImage>
    <div>
        <dx:ASPxHyperLink ID="TemperatureHyperLink" runat="server" Wrap="False">
        </dx:ASPxHyperLink>
    </div>
</div>
