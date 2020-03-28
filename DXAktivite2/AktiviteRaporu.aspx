<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="AktiviteRaporu.aspx.cs" Inherits="DXAktivite2.AktiviteRaporu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <dx:ASPxFormLayout ID="flDateRangePicker" runat="server" ColCount="2"
        RequiredMarkDisplayMode="None" Visible="true">
        <SettingsItemCaptions Location="Top"></SettingsItemCaptions>
        <Items>
            <%--<dx:LayoutGroup Caption="Tarih Aralığı" ColCount="3" GroupBoxDecoration="HeadingLine">
                <Items>

                    <dx:LayoutItem Caption="Başlangıç tarihi">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxDateEdit ID="deStart" ClientInstanceName="deStart" runat="server" AutoPostBack="false">

                                    <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                        <RequiredField IsRequired="True" ErrorText="Start date is required"></RequiredField>
                                    </ValidationSettings>
                                </dx:ASPxDateEdit>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Bitiş tarihi">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxDateEdit ID="deEnd" ClientInstanceName="deEnd" runat="server">
                                    <DateRangeSettings StartDateEditID="deStart"></DateRangeSettings>

                                    <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                        <RequiredField IsRequired="True" ErrorText="End date is required"></RequiredField>
                                    </ValidationSettings>
                                </dx:ASPxDateEdit>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="&nbsp;" ShowCaption="True">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="btnSubmit" runat="server" Text="Getir" AutoPostBack="false" EnableViewState="false">
                                    <ClientSideEvents Click="function(s, e) {ASPxCallback1.PerformCallback('getir'); grid.PerformCallback('getir');}" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                </Items>
            </dx:LayoutGroup>--%>
            <dx:LayoutGroup Caption="İşlemler" ColCount="1" GroupBoxDecoration="HeadingLine">
                <Items>
                    <dx:LayoutItem Caption="Seçilenleri e-Posta ile Gönder" ShowCaption="True">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Göndermeye Hazırla"
                                    AutoPostBack="false" EnableViewState="false">
                                    <ClientSideEvents Click="function(s, e) {ASPxCallback1.PerformCallback('secilenler'); ShowDanismanWindow();}" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>

    <dx:ASPxCallback ID="ASPxCallback1"
        ClientInstanceName="ASPxCallback1"
        OnCallback="ASPxCallback1_Callback" runat="server">
    </dx:ASPxCallback>

    <dx:ASPxGridView ID="grid" runat="server"
        AutoGenerateColumns="False"
        DataSourceID="AktivitelerData" 
        KeyFieldName="ID"
        ClientInstanceName="grid"
        Width="100%"
        OnHtmlRowPrepared="grid_HtmlRowPrepared"
        OnCustomCallback="grid_CustomCallback"
      
        > 

        <SettingsPager PageSize="50" />
        <Paddings Padding="0px" />
        <Border BorderWidth="0px" />
        <BorderBottom BorderWidth="1px" />

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

            <dx:GridViewCommandColumn VisibleIndex="0" Width="30px" ButtonType="Image" ShowSelectCheckbox="true">
                <%--<CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="MailGonder">
                        <Image ToolTip="e-Posta Gönder" Url="images/glyph-mail-16.png" />
                    </dx:GridViewCommandColumnCustomButton>
                </CustomButtons>--%>
            </dx:GridViewCommandColumn>

            <dx:GridViewDataColumn FieldName="ID" Visible="false" SortOrder="Descending" VisibleIndex="0" />

            <dx:GridViewDataDateColumn FieldName="Tarih" VisibleIndex="1" Width="100" >
                <PropertiesDateEdit  AllowUserInput="false" AllowNull="true">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>

            <dx:GridViewDataComboBoxColumn FieldName="DanismanID" Caption="Danisman" Width="200"
                 VisibleIndex="2" SettingsHeaderFilter-Mode="CheckedList">
                <PropertiesComboBox
                    DataSourceID="DanismanlarData"
                    ValueField="ID"
                    ValueType="System.Int32"
                    TextField="Adi"
                    EnableSynchronization="False"
                    IncrementalFilteringMode="StartsWith">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn FieldName="ProjeID" Caption="Proje" Width="300" 
                VisibleIndex="3" SettingsHeaderFilter-Mode="CheckedList">
                <PropertiesComboBox
                    DataSourceID="ProjelerData"
                    ValueField="ID"
                    ValueType="System.Int32"
                    TextField="Adi"
                    EnableSynchronization="False"
                    IncrementalFilteringMode="StartsWith">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn FieldName="ModulID" Caption="Modül" Width="80" 
                VisibleIndex="4"  SettingsHeaderFilter-Mode="CheckedList">
                <PropertiesComboBox
                    DataSourceID="ModullerData"
                    ValueField="ID"
                    ValueType="System.Int32"
                    TextField="Adi"
                    EnableSynchronization="False"
                    IncrementalFilteringMode="StartsWith">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataTextColumn FieldName="Saat" Caption="Saat" Width="50" VisibleIndex="5">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Aciklama" Caption="Aciklama" VisibleIndex="8">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="YukleniciAdi" Caption="Yüklenici Adı" VisibleIndex="6" Width="60"
                 SettingsHeaderFilter-Mode="CheckedList">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="MusteriAdi" Caption="Müşteri Adı" VisibleIndex="7" Width="80"
                 SettingsHeaderFilter-Mode="CheckedList">
            </dx:GridViewDataTextColumn>

        </Columns>
        <GroupSummary>
            <dx:ASPxSummaryItem FieldName="DanismanID" ShowInGroupFooterColumn="Danisman" SummaryType="Count" />
            <dx:ASPxSummaryItem FieldName="ProjeID" ShowInGroupFooterColumn="Proje" SummaryType="Count" />
            <dx:ASPxSummaryItem FieldName="ModulID" ShowInGroupFooterColumn="Modül" SummaryType="Count" />
            <dx:ASPxSummaryItem FieldName="Saat" ShowInGroupFooterColumn="Saat" SummaryType="Sum" />
        </GroupSummary>
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="DanismanID" SummaryType="Count" />
            <dx:ASPxSummaryItem FieldName="ProjeID" SummaryType="Count" />
            <dx:ASPxSummaryItem FieldName="ModulID" SummaryType="Count" />
            <dx:ASPxSummaryItem FieldName="Saat" SummaryType="Sum" />
        </TotalSummary>
        <Templates>
            <GroupRowContent>
                <table>
                    <tr>
                        <td>
                            <dx:ASPxCheckBox ID="checkBox" runat="server" />
                        </td>
                        <td>
                            <dx:ASPxLabel ID="CaptionText" runat="server" Text='<%# GetCaptionText(Container) %>' />
                        </td>
                    </tr>
                </table>
            </GroupRowContent>
        </Templates>
        
        <SettingsEditing Mode="Inline" />
        <Settings ShowFooter="True" ShowGroupPanel="true" ShowGroupFooter="VisibleIfExpanded" ShowHeaderFilterButton="true" />
        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="WYSIWYG" />
        <SettingsPopup>
            <HeaderFilter Height="200">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="768" MinHeight="300" />
            </HeaderFilter>
        </SettingsPopup>
    </dx:ASPxGridView>

    <asp:ObjectDataSource ID="AktivitelerData" runat="server" TypeName="DataProvider" SelectMethod="GetAktivitelerTumu" />
    <asp:ObjectDataSource ID="ProjelerData" runat="server" TypeName="DataProvider" SelectMethod="GetProjelerTumu" />
    <asp:ObjectDataSource ID="ModullerData" runat="server" TypeName="DataProvider" SelectMethod="GetModullerTumu" />
    <asp:ObjectDataSource ID="DanismanlarData" runat="server" TypeName="DataProvider" SelectMethod="GetDanismanlarTumu" />

    <dx:ASPxCallback ID="ASPxCallback3"
        ClientInstanceName="ASPxCallback3"
        OnCallback="ASPxCallback3_Callback" runat="server">
    </dx:ASPxCallback>

    <script type="text/javascript">

          function ShowDanismanWindow() {
              //txtGonderen.SetText('Tecs Muhasebe');
              //txtGonderenMail.SetText('muhasebe@tecs.com.tr');
            ASPxPopupControl1.Show();
        }

    </script>

    <link type="text/css" rel="stylesheet" href="Content/ModalWindow.css" />
    <link type="text/css" rel="stylesheet" href="Content/CodeFormatter.css" />
    <link type="text/css" rel="stylesheet" href="Content/CustomButton.css" />

    <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" 
            CloseAction="CloseButton" 
            CloseOnEscape="true" 
            Modal="True"
        PopupHorizontalAlign="WindowCenter" 
            PopupVerticalAlign="WindowCenter" 
            ClientInstanceName="ASPxPopupControl1"
        HeaderText="E-Posta Göndermeye Hazırla" 
            AllowDragging="True" 
            PopupAnimationType="None" 
            EnableViewState="False">
        <ClientSideEvents PopUp="function(s, e) { txtKonu.Focus(); }" /> <%--ASPxClientEdit.ClearGroup('entryGroup');--%>
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <div style="padding:15px;" >
                    <%--When a Roman general is betrayed and his family murdered by a corrupt prince, he
                    comes to Rome as a gladiator to seek revenge.--%></div>
                <dx:ASPxPanel ID="ASPxPanel1" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <table>
                                <tr>
                                    <td rowspan="10">
                                        <div class="pcmSideSpacer">
                                        </div>
                                    </td>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="lblGonderen" runat="server" Text="Gönderen Adı:" AssociatedControlID="txtGonderen">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtGonderen" runat="server" Width="200px" ClientInstanceName="txtGonderen">
                                            <ValidationSettings EnableCustomValidation="True" ValidationGroup="entryGroup"
                                                SetFocusOnError="True" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                <RequiredField IsRequired="True" ErrorText="Gönderen kişi adı doldurunuz." />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </td>
                                    <td rowspan="10">
                                        <div class="pcmSideSpacer">
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Gönderen Mail:" AssociatedControlID="txtGonderenMail">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtGonderenMail" runat="server" Width="200px" ClientInstanceName="txtGonderenMail" >
                                            <ValidationSettings EnableCustomValidation="True" ValidationGroup="entryGroup"
                                                SetFocusOnError="True" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                <RequiredField IsRequired="True" ErrorText="Gönderen kişi mail adresini giriniz." />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Alıcı Kişi:">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTokenBox ID="tbAliciKisi" runat="server" Width="200px"
                                            AllowMouseWheel="True" AllowCustomTokens="False" ValueSeparator=";">
                                            <ValidationSettings EnableCustomValidation="True" ValidationGroup="entryGroup"
                                                SetFocusOnError="True" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                <RequiredField IsRequired="True" ErrorText="Alıcı bilgisi giriniz." />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                        </dx:ASPxTokenBox>
                                    </td>
                                </tr>

                                <%--<tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="CC Kişi:">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTokenBox ID="tbCC" runat="server" Width="200px"
                                            AllowMouseWheel="True" AllowCustomTokens="False">
                                            <ValidationSettings EnableCustomValidation="True" ValidationGroup=""
                                                SetFocusOnError="True" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                <RequiredField IsRequired="True" ErrorText="" />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                        </dx:ASPxTokenBox>
                                        <br />
                                    </td>
                                </tr>

                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="BCC Kişi:">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTokenBox ID="tbBCC" runat="server" Width="200px"
                                            AllowMouseWheel="True" AllowCustomTokens="False">
                                     
                                        </dx:ASPxTokenBox>
                                        <br />
                                    </td>
                                </tr>--%>

                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Konu:" AssociatedControlID="txtKonu">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtKonu" runat="server" Width="200px" ClientInstanceName="txtKonu">
                                            <ValidationSettings EnableCustomValidation="True" ValidationGroup="entryGroup"
                                                SetFocusOnError="True" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                <RequiredField IsRequired="True" ErrorText="Konu giriniz." />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="lblKullaniciAdi" runat="server" Text="İçerik Şablon:" AssociatedControlID="cmbSoblon">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxComboBox ID="cmbSoblon" runat="server" Width="200px"
                                            ClientInstanceName="cmbSoblon" TextField="UserName" ValueField="UserId">
                                            <Items>
                                                <dx:ListEditItem Text="HTML" Value="HTML" Selected="true" />
                                                <dx:ListEditItem Text="PDF" Value="PDF"  />
                                            </Items>
                                            <ValidationSettings EnableCustomValidation="true" ValidationGroup="entryGroup" SetFocusOnError="true"
                                                ErrorDisplayMode="Text" ErrorTextPosition="Bottom" CausesValidation="true">
                                                <RequiredField ErrorText="Müşteri seçiniz." IsRequired="true" />
                                                <RegularExpression ErrorText="Kullanıcı adı seçiniz." />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                        </dx:ASPxComboBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="pcmCellCaption"></td>
                                    <td colspan="2">
                                        <div class="pcmButton">
                                            <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Gönder" Width="80px"
                                                AutoPostBack="False" Style="float: left; margin-right: 8px">
                                                <ClientSideEvents Click="function(s, e) { 

                                                    if(ASPxClientEdit.ValidateGroup('entryGroup')) 
                                                    ASPxPopupControl1.Hide(); 

                                                    ASPxCallback3.PerformCallback(); 
                                                    grid.Refresh(); 
                                                    
                                                    }" />

                                            </dx:ASPxButton>
                                            <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Vazgeç" Width="80px" AutoPostBack="False" Style="float: left; margin-right: 8px">
                                                <ClientSideEvents Click="function(s, e) { ASPxPopupControl1.Hide(); }" />
                                            </dx:ASPxButton>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxPanel>

            </dx:PopupControlContentControl>
        </ContentCollection>
        <ContentStyle>
            <Paddings PaddingBottom="5px" />
        </ContentStyle>
    </dx:ASPxPopupControl>

</asp:Content>
