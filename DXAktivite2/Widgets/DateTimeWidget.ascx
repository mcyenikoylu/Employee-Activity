<%@ Control Language="C#" ClassName="DateTimeWidget" %>
<script runat="server">
    protected void Page_Init(object sender, EventArgs e) {
        DateLabel.Text = new DateTime(DateTime.Now.Year, 3, 14).ToLongDateString();
    }
</script>
<script type="text/javascript" language="javascript">
// <![CDATA[
    function PrepareTimeValue(value) {
        if (value < 10)
            value = "0" + value;
        return value;
    }
    function UpdateTime(s, e) {
        var dateTime = new Date();
        var timeString = PrepareTimeValue(dateTime.getHours()) + ":" + PrepareTimeValue(dateTime.getMinutes()) + ":" +
            PrepareTimeValue(dateTime.getSeconds());
        timeLabel.SetText(timeString);
    }
// ]]> 
</script>
<dx:ASPxTimer runat="server" ID="Timer" ClientInstanceName="timer" Interval="1000">
    <ClientSideEvents Init="UpdateTime" Tick="UpdateTime" />
</dx:ASPxTimer>
<div class="timeContainer">
    <dx:ASPxLabel runat="server" ID="TimeLabel" ClientInstanceName="timeLabel" Font-Bold="true"
        Font-Size="X-Large">
    </dx:ASPxLabel>
</div>
<div class="dateContainer">
    <dx:ASPxLabel runat="server" ID="DateLabel" ClientInstanceName="dateLabel" Font-Size="14px">
    </dx:ASPxLabel>
</div>
