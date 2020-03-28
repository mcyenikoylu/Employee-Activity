<%@ Control Language="C#" ClassName="Trading" %>
<%@ Register Src="~/Widgets/TradingWidget/MarketLeadersTableRow.ascx" TagName="MarketLeadersTableRow" TagPrefix="uc" %>
<%@ Register Src="~/Widgets/TradingWidget/CurrencyRatesTableRow.ascx" TagName="CurrencyRatesTableRow" TagPrefix="uc" %>
<script runat="server">
</script>
<dx:ASPxLabel runat="server" ID="IndexesLabel" Text="Market leaders" Font-Bold="true">
</dx:ASPxLabel>
<table width="100%" style="text-align: center;">
    <uc:MarketLeadersTableRow runat="server" Index="APDSP" Value="41.56" Growth="14.61%"/>
    <uc:MarketLeadersTableRow runat="server" Index="MGNZ" Value="53.91" Growth="10.63%"/>
    <uc:MarketLeadersTableRow runat="server" Index="APDS" Value="87.55" Growth="9.54%"/>
    <uc:MarketLeadersTableRow runat="server" Index="MAGE" Value="0.09" Growth="7.92%"/>
    <uc:MarketLeadersTableRow runat="server" Index="VOSB" Value="0.90" Growth="7.87%"/>
    <uc:MarketLeadersTableRow runat="server" Index="DASPA" Value="20.96" Growth="4.2%"/>
    <uc:MarketLeadersTableRow runat="server" Index="HASO" Value="42.11" Growth="12.1%"/>
    <uc:MarketLeadersTableRow runat="server" Index="VIGE" Value="12.23" Growth="8.2%"/>
    <uc:MarketLeadersTableRow runat="server" Index="MERG" Value="10.1" Growth="1.9%"/>
    <uc:MarketLeadersTableRow runat="server" Index="TROM" Value="12.2" Growth="12.14%"/>
</table>
<dx:ASPxLabel runat="server" ID="currencyLalbel" Text="Currency rates" Font-Bold="true">
</dx:ASPxLabel>
<table width="100%" style="text-align: center;">
    <uc:CurrencyRatesTableRow runat="server" Currency="EUR" Value="1.3932" Growth="-0.0014" />
    <uc:CurrencyRatesTableRow runat="server" Currency="RUR" Value="0.0348" Growth="-0.0001" />
</table>
