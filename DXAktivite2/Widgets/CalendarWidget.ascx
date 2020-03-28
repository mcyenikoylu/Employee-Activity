<%@ Control Language="C#" ClassName="CalendarWidget" %>
<script runat="server">
    protected void Page_Init(object sender, EventArgs e) {
        Calendar.SelectedDate = new DateTime(DateTime.Now.Year, 3, 14);
    }
</script>
<dx:ASPxCalendar runat="server" ID="Calendar" ShowClearButton="false" ShowHeader="false"
    ShowTodayButton="false" ShowWeekNumbers="false" HighlightToday="false" Width="100%">
    <Border BorderStyle="None" />
</dx:ASPxCalendar>
