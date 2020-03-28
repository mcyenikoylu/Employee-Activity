<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="AcikCagrilarim.aspx.cs" Inherits="DXAktivite2.AcikCagrilarim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <dx:ASPxGridView ID="ASPxGridView2" runat="server" 
        DataSourceID="BekleyenCagrilarimData" KeyFieldName="ID"
        AutoGenerateColumns="False" 
        ClientInstanceName="ASPxGridView2"
        Width="100%"  
        SettingsText-Title="TÜM AÇIK ÇAĞRILAR"
        >
        <SettingsPager PageSize="20" />
        <Paddings Padding="0px" />
        <Border BorderWidth="0px" />
        <BorderBottom BorderWidth="1px" />

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

            <dx:GridViewDataTextColumn FieldName="DanismanAdi" Caption="Danışman" VisibleIndex="4" Width="150">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="YonlendirilenDanismanAdi" Caption="Yön. Danışman" VisibleIndex="5" Width="150">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="ModulAdi" Caption="Modül" VisibleIndex="6" Width="150">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="CagriDurumu_TipID1" Visible="true" VisibleIndex="6" Width="150">
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
        <Settings ShowFooter="True" ShowGroupPanel="true" ShowGroupFooter="VisibleIfExpanded" ShowTitlePanel="true" />

    </dx:ASPxGridView>

    <asp:ObjectDataSource ID="BekleyenCagrilarimData" runat="server" TypeName="DataProvider" SelectMethod="GetAcikCagrilarTumu" />

</asp:Content>
