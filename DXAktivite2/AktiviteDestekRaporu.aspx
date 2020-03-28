<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="AktiviteDestekRaporu.aspx.cs" Inherits="DXAktivite2.AktiviteDestekRaporu" %>

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
                            <div class="options-item">
                                <dx:ASPxComboBox runat="server" ID="ddlExportMode" Caption="Details Export Mode">
                                    <RootStyle CssClass="OptionsBottomMargin" />
                                    <CaptionCellStyle>
                                        <Paddings PaddingRight="4px" />
                                    </CaptionCellStyle>
                                </dx:ASPxComboBox>
                            </div>
                        </div>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
        </Items>
    </dx:ASPxFormLayout>
    <dx:ASPxGridView ID="grid" runat="server" EnableRowsCache="false" AutoGenerateColumns="False"
         KeyFieldName="CagriID" Width="100%" OnDataBinding="grid_DataBinding">
        <Toolbars>
            <dx:GridViewToolbar EnableAdaptivity="true">
                <Items>
                    <dx:GridViewToolbarItem Command="ExportToPdf" />
                    <dx:GridViewToolbarItem Command="ExportToXls" />
                    <dx:GridViewToolbarItem Command="ExportToXlsx" />
                    <dx:GridViewToolbarItem Command="ExportToDocx" />
                    <dx:GridViewToolbarItem Command="ExportToRtf" />
                    <dx:GridViewToolbarItem Command="ExportToCsv" />
                </Items>
            </dx:GridViewToolbar>
        </Toolbars>
        <Columns>
            <dx:GridViewDataColumn FieldName="CagriID" Visible="false" />
            <dx:GridViewDataColumn FieldName="AktiviteID" Visible="false" />
            <dx:GridViewDataColumn FieldName="SirketAdi" Width="15%" />
            <dx:GridViewDataColumn FieldName="AktiviteTipi" Width="15%" />
            <dx:GridViewDataColumn FieldName="Aciklama" Width="70%" />
        </Columns>
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="SirketAdi" SummaryType="Count" />
            <dx:ASPxSummaryItem FieldName="AktiviteTipi" SummaryType="Count" />
        </TotalSummary>
        <Templates>
            <DetailRow>
                <dx:ASPxGridView ID="detailGrid" runat="server" KeyFieldName="CagriSonucID" AutoGenerateColumns="False"
                    Width="100%" EnablePagingGestures="False" OnBeforePerformDataSelect="detailGrid_BeforePerformDataSelect">
                    <Columns>
                        <dx:GridViewDataColumn FieldName="CagriSonucID" VisibleIndex="1" Visible="false" />
                        <dx:GridViewDataColumn FieldName="CagriID" VisibleIndex="1" Visible="false" />
                        <dx:GridViewDataColumn FieldName="DanismanAdi" VisibleIndex="2" Width="15%" />
                        <dx:GridViewDataColumn FieldName="Saat" VisibleIndex="2" Width="5%" />
                        <dx:GridViewDataColumn FieldName="BaslangicTarihSaat" VisibleIndex="5" Width="10%" />
                        <dx:GridViewDataColumn FieldName="BitisTarihSaat" VisibleIndex="5" Width="10%" />
                        <dx:GridViewDataColumn FieldName="Modul" VisibleIndex="5" Width="5%" />
                        <dx:GridViewDataColumn FieldName="SonucAciklama" VisibleIndex="5" Width="55%" />
                    </Columns>
                    <Settings ShowFooter="True" />
                    <SettingsPager EnableAdaptivity="true" />
                    <Styles Header-Wrap="True" />
                    <TotalSummary>
                        <dx:ASPxSummaryItem FieldName="Saat" SummaryType="Sum" />
                    </TotalSummary>
                </dx:ASPxGridView>
            </DetailRow>
        </Templates>
        <SettingsDetail ShowDetailRow="true" />
        <Settings ShowGroupPanel="true" ShowFooter="true" />
        <SettingsPager PageSize="30"></SettingsPager>
        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="WYSIWYG" />
    </dx:ASPxGridView>
    <asp:ObjectDataSource ID="AktiviteDestekData" runat="server" TypeName="DataProvider" SelectMethod="GetAktiviteDestek" />
    <asp:ObjectDataSource ID="ProjelerData" runat="server" TypeName="DataProvider" SelectMethod="GetProjelerTumu" />
    <asp:ObjectDataSource ID="ModullerData" runat="server" TypeName="DataProvider" SelectMethod="GetModullerTumu" />
    <asp:ObjectDataSource ID="DanismanlarData" runat="server" TypeName="DataProvider" SelectMethod="GetDanismanlarTumu" />
    <asp:ObjectDataSource ID="detailGridAktiviteDestekData" runat="server" TypeName="DataProvider" SelectMethod="GetDetailGridAktiviteDestek"></asp:ObjectDataSource>
</asp:Content>
