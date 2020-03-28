<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="BekleyenCagrilar.aspx.cs" Inherits="DXAktivite2.BekleyenCagrilar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
           <%--BEKLEYEN ÇAĞRILARIM--%>
    <dx:ASPxGridView ID="ASPxGridView2" runat="server" 
        DataSourceID="BekleyenCagrilarimData" KeyFieldName="ID"
        AutoGenerateColumns="False" 
        ClientInstanceName="ASPxGridView2"
        Width="100%"  
        Caption="TÜM BEKLEYEN ÇAĞRILAR"
        OnToolbarItemClick="ASPxGridView2_ToolbarItemClick" >
        <SettingsPager PageSize="20" />
        <Paddings Padding="0px" />
        <Border BorderWidth="0px" />
        <BorderBottom BorderWidth="1px" />
        <Toolbars>
            <dx:GridViewToolbar>
                <Items>
                    <dx:GridViewToolbarItem Command="Refresh" BeginGroup="true"></dx:GridViewToolbarItem>
                </Items>
            </dx:GridViewToolbar>
        </Toolbars>
        <Columns>

            <dx:GridViewDataColumn FieldName="ID" Visible="false" SortOrder="Descending" />

            <dx:GridViewDataTextColumn FieldName="InternalTicketNumber" Caption="Internal Ticket Number" Width="150" VisibleIndex="0">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataDateColumn FieldName="IstekTarihiSaati" Caption="İstek Tarihi" VisibleIndex="1" Width="100" Settings-AllowHeaderFilter="True">
                <PropertiesDateEdit  AllowUserInput="false" AllowNull="true" >
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>

            <dx:GridViewDataTextColumn FieldName="IstekSirketAdi" Caption="Şirket Adı" Width="150" VisibleIndex="2">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="IstekSahibiAdiSoyadi" Caption="İstek Sahibi" Width="150" VisibleIndex="3">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="DanismanAdi" Caption="Danışman" Width="150" VisibleIndex="4">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="YonlendirilenDanismanAdi" Width="150" Caption="Yön. Danışman" VisibleIndex="5">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="ModulAdi" Caption="Modül" Width="150" VisibleIndex="6">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="CagriDurumu_TipID1" Visible="false">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataColumn Caption="Durum" VisibleIndex="7">
                <DataItemTemplate>
                    <img id="img" runat="server" alt='Eval("CagriDurumu_TipID1")' src='<%# GetImageName(Eval("CagriDurumu_TipID1")) %>' />
                </DataItemTemplate>
            </dx:GridViewDataColumn>

            <dx:GridViewDataTextColumn FieldName="IstekAciklama" Caption="Aciklama" VisibleIndex="8">
            </dx:GridViewDataTextColumn>

        </Columns>
        <SettingsEditing Mode="EditForm" />
        <Settings ShowFooter="True" ShowGroupPanel="true" ShowGroupFooter="VisibleIfExpanded" />

    </dx:ASPxGridView>

    <asp:ObjectDataSource ID="BekleyenCagrilarimData" runat="server" 
        TypeName="DataProvider" SelectMethod="GetBekleyenCagrilarTumu" />

</asp:Content>
