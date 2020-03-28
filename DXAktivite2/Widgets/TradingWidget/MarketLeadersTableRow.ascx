<%@ Control Language="C#" ClassName="MarketLeadersTableRow" %>
<script runat="server">
    string index;
    string value;
    string growth;
    
    public string Index {
        get { return index; }
        set { index = value; }
    }
    public string Value {
        get { return value; }
        set { this.value = value; }
    }
    public string Growth {
        get { return growth; }
        set { growth = value; }
    }
    protected void Page_Init(object sender, EventArgs e) {
        IndexHyperLink.Text = Index;
        ValueLabel.Text = Value;
        GrowthLabel.Text = Growth;
    }
</script>
<tr>
    <td style="width: 30%"><dx:ASPxHyperLink runat="server" ID="IndexHyperLink" NavigateUrl="javascript:void(0)" /></td>
    <td style="width: 30%"><dx:ASPxLabel runat="server" ID="ValueLabel" /></td>
    <td style="width: 30%"><dx:ASPxLabel runat="server" ID="GrowthLabel" ForeColor="Green"/></td>
</tr>
