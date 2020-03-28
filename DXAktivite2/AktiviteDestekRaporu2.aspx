<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="AktiviteDestekRaporu2.aspx.cs" Inherits="DXAktivite2.AktiviteDestekRaporu2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .options {
            margin: 0;
            padding: 0;
        }
        .options .options-item {
            display: inline-block;
            vertical-align: top;
            padding: 3px 36px 3px 0;
        }
    </style>
    <dx:ASPxFormLayout ID="HeaderLayout" runat="server">
        <Items>
            <dx:LayoutItem Caption=" ">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <div class="options">
                            <div class="options-item">
                                <dx:ASPxDateEdit ID="dateBaslangic" runat="server" Caption="Başlangıç Tarihi">
                                    <RootStyle CssClass="OptionsBottomMargin" />
                                    <CaptionCellStyle>
                                        <Paddings PaddingRight="4px" />
                                    </CaptionCellStyle>
                                </dx:ASPxDateEdit>
                            </div>
                            <div class="options-item">
                                <dx:ASPxDateEdit ID="dateBitis" runat="server" Caption="Bitiş Tarihi">
                                    <RootStyle CssClass="OptionsBottomMargin" />
                                    <CaptionCellStyle>
                                        <Paddings PaddingRight="4px" />
                                    </CaptionCellStyle>
                                </dx:ASPxDateEdit>
                            </div>
                            <div class="options-item">
                                <dx:ASPxButton ID="btnGetir" runat="server" AutoPostBack="false" Text="Getir" OnClick="btnGetir_Click"></dx:ASPxButton>
                            </div>
                        </div>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
        </Items>
    </dx:ASPxFormLayout>
    <dx:ASPxGridView ID="grid" runat="server" EnableRowsCache="false" AutoGenerateColumns="False"
        KeyFieldName="CagriID" Width="100%" OnDataBinding="grid_DataBinding" OnToolbarItemClick="grid_ToolbarItemClick">
        <Toolbars>
            <dx:GridViewToolbar EnableAdaptivity="true">
                <Items>
                    <dx:GridViewToolbarItem Command="Custom" Text="Export To">
                        <Items>
                            <dx:GridViewToolbarItem Command="ExportToPdf" />
                            <dx:GridViewToolbarItem Command="ExportToXls" />
                            <dx:GridViewToolbarItem Command="ExportToXlsx" />
                            <dx:GridViewToolbarItem Command="ExportToDocx" />
                            <dx:GridViewToolbarItem Command="ExportToRtf" />
                            <dx:GridViewToolbarItem Command="ExportToCsv" />
                        </Items>
                    </dx:GridViewToolbarItem>
                    <dx:GridViewToolbarItem Command="ShowCustomizationDialog"></dx:GridViewToolbarItem>
                    <dx:GridViewToolbarItem Command="ShowCustomizationWindow"></dx:GridViewToolbarItem>
                    <dx:GridViewToolbarItem Command="ClearGrouping" />
                    <dx:GridViewToolbarItem Command="ClearSorting" />
                    <dx:GridViewToolbarItem Command="ShowGroupPanel" BeginGroup="true" />
                    <dx:GridViewToolbarItem Command="ShowSearchPanel" />
                    <dx:GridViewToolbarItem Command="Refresh" BeginGroup="true"></dx:GridViewToolbarItem>
                </Items>
            </dx:GridViewToolbar>
        </Toolbars>
        <Columns>
            <dx:GridViewDataColumn FieldName="CagriSonucID" VisibleIndex="1" Visible="false" Width="5%" />
            <dx:GridViewDataColumn FieldName="CagriID" VisibleIndex="2" Visible="false" Width="5%" />
            <dx:GridViewDataColumn FieldName="InternalTicketNumber" VisibleIndex="3" Width="4%" Caption="Ticket No" />
            <dx:GridViewDataColumn FieldName="SirketAdi" VisibleIndex="4" Width="8%" Caption="Şirket" SettingsHeaderFilter-Mode="CheckedList" />
            <dx:GridViewDataColumn FieldName="LokasyonAdi" VisibleIndex="4" Width="5%" Caption="Lokasyon" SettingsHeaderFilter-Mode="CheckedList" />
            <dx:GridViewDataColumn FieldName="AktiviteTipi" VisibleIndex="5" Width="5%" Caption="Aktivite Tipi" SettingsHeaderFilter-Mode="CheckedList" />
            <dx:GridViewDataColumn FieldName="IstekSahibiAdiSoyadi" VisibleIndex="6" Width="6%" Caption="İstek Sahibi" SettingsHeaderFilter-Mode="CheckedList" />
            <dx:GridViewDataColumn FieldName="DanismanAdi" VisibleIndex="6" Width="6%" Caption="Danışman" SettingsHeaderFilter-Mode="CheckedList" />
            <dx:GridViewDataColumn FieldName="Saat" VisibleIndex="7" Width="3%" Caption="Saat" />
            <dx:GridViewDataColumn FieldName="BaslangicTarihSaat" VisibleIndex="8" Width="6%" Caption="Başlangıç Tarihi" />
            <dx:GridViewDataColumn FieldName="BitisTarihSaat" VisibleIndex="9" Width="6%" Caption="Bitiş Tarihi" />
            <dx:GridViewDataColumn FieldName="ModulAdi" VisibleIndex="10" Width="5%" Caption="Modül" SettingsHeaderFilter-Mode="CheckedList" />
            <dx:GridViewDataColumn FieldName="IstekAciklama" VisibleIndex="11" Width="10%" Caption="Sorun" />
            <dx:GridViewDataColumn FieldName="SonucAciklama" VisibleIndex="12" Width="10%" Caption="Çözüm" />
            <dx:GridViewDataColumn FieldName="CagriDurumu" VisibleIndex="13" Width="5%" Caption="Çağrı Durumu" SettingsHeaderFilter-Mode="CheckedList" />
            <dx:GridViewDataColumn FieldName="YukleniciAdi" VisibleIndex="14" Width="5%" Caption="Yüklenici Adı" SettingsHeaderFilter-Mode="CheckedList" />
            <dx:GridViewDataCheckColumn FieldName="FaturaOnayi" VisibleIndex="15" Width="5%" Caption="Fatura Onayı">
            </dx:GridViewDataCheckColumn>
        </Columns>
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="SirketAdi" SummaryType="Count" DisplayFormat="Toplam {0}" />
            <dx:ASPxSummaryItem FieldName="AktiviteTipi" SummaryType="Count" DisplayFormat="Toplam {0}" />
            <dx:ASPxSummaryItem FieldName="Saat" SummaryType="Sum" DisplayFormat="Toplam {0}" />
        </TotalSummary>
        <GroupSummary>
            <dx:ASPxSummaryItem FieldName="Saat" SummaryType="Sum" ShowInGroupFooterColumn="Saat" DisplayFormat="Toplam {0} Saat" />
        </GroupSummary>
        <SettingsLoadingPanel Mode="ShowOnStatusBar" />
        <SettingsBehavior EnableCustomizationWindow="true" />
        <SettingsResizing ColumnResizeMode="Control" Visualization="Live" />
        <SettingsCustomizationDialog Enabled="true" />
        <Settings ShowGroupPanel="true" ShowFooter="true" ShowHeaderFilterButton="true" ShowGroupFooter="VisibleIfExpanded" />
        <SettingsPager PageSize="15" AlwaysShowPager="true" PageSizeItemSettings-Visible="true">
        </SettingsPager>
        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="WYSIWYG" />
    </dx:ASPxGridView>
    <asp:ObjectDataSource ID="AktiviteDestekData" runat="server" TypeName="DataProvider" SelectMethod="GetAktiviteDestek2" />
    <asp:ObjectDataSource ID="ProjelerData" runat="server" TypeName="DataProvider" SelectMethod="GetProjelerTumu" />
    <asp:ObjectDataSource ID="ModullerData" runat="server" TypeName="DataProvider" SelectMethod="GetModullerTumu" />
    <asp:ObjectDataSource ID="DanismanlarData" runat="server" TypeName="DataProvider" SelectMethod="GetDanismanlarTumu" />
</asp:Content>
