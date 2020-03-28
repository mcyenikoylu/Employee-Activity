<%@ Control Language="C#" ClassName="CurrencyRatesTableRow" %>
<script runat="server">
    string currency;
    float value;
    float growth;
    public string Currency {
        get { return currency; }
        set { currency = value; }
    }
    public float Value {
        get { return value; }
        set { this.value = value; }
    }
    public float Growth {
        get { return growth; }
        set { growth = value; }
    }
    protected void Page_Init(object sender, EventArgs e) {
        CurrencyHyperLink.Text = Currency;
        ValueLabel.Text = Value.ToString();
        GrowthLabel.Text = Growth.ToString();
        if(Growth >= 0)
            GrowthLabel.ForeColor = System.Drawing.Color.Green;
        else
            GrowthLabel.ForeColor = System.Drawing.Color.Red;
    }
</script>
<tr>
    <td style="width: 30%"><dx:ASPxHyperLink runat="server" ID="CurrencyHyperLink" NavigateUrl="javascript:void(0)" /></td>
    <td style="width: 30%"><dx:ASPxLabel runat="server" ID="ValueLabel" /></td>
    <td style="width: 30%"><dx:ASPxLabel runat="server" ID="GrowthLabel"/></td>
</tr>
