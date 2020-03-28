<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="Raporlar.aspx.cs" Inherits="DXAktivite2.Raporlar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <%-- date ranger picker --%>
    <dx:ASPxFormLayout ID="flDateRangePicker" runat="server" ColCount="2"
        RequiredMarkDisplayMode="None" Visible="true">
        <SettingsItemCaptions Location="Top"></SettingsItemCaptions>
        <Items>
            <dx:LayoutGroup Caption="Tarih Aralığı" ColCount="3" GroupBoxDecoration="HeadingLine">
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
            </dx:LayoutGroup>
            <dx:LayoutGroup Caption="İşlemler" ColCount="1" GroupBoxDecoration="HeadingLine">
                <Items>
                    <dx:LayoutItem Caption="Seçilenleri e-Posta ile Gönder" ShowCaption="True">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Göndermeye Hazırla"
                                    AutoPostBack="false" EnableViewState="false">
                                    <ClientSideEvents Click="function(s, e) {ASPxCallback2.PerformCallback('secilenler'); ShowDanismanWindow();}" />
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
        <ClientSideEvents
            BeginCallback="function(s, e) {}"
            CallbackComplete="function(s, e) {}"
            EndCallback="function(s, e) { deStart.SetValue(s.cpBaslangicTarihi); deEnd.SetValue(s.cpBitisTarihi); }" />
    </dx:ASPxCallback>

    <dx:ASPxCallback ID="ASPxCallback2"
        ClientInstanceName="ASPxCallback2"
        OnCallback="ASPxCallback2_Callback" runat="server">
    </dx:ASPxCallback>

    <%--PROJE FİNANS DURUMU--%>

    <dx:ASPxGridView ID="grid"
        ClientInstanceName="grid"
        runat="server"
        DataSourceID="ProjeFinansDurumuData"
        KeyFieldName="RowNumber"
        Width="100%"
        AutoGenerateColumns="False"
        OnCustomCallback="grid_CustomCallback"
        OnCustomUnboundColumnData="grid_CustomUnboundColumnData"
        OnCustomSummaryCalculate="grid_CustomSummaryCalculate"
        OnCustomButtonCallback="grid_CustomButtonCallback"
        OnHtmlRowPrepared="grid_HtmlRowPrepared">
        <SettingsPager PageSize="50" />
        <Paddings Padding="0px" />
        <Border BorderWidth="0px" />
        <BorderBottom BorderWidth="1px" />
        <Columns>
            <dx:GridViewCommandColumn VisibleIndex="0" Width="30px" ButtonType="Image" ShowSelectCheckbox="true">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="MailGonder">
                        <Image ToolTip="e-Posta Gönder" Url="images/glyph-mail-16.png" />
                    </dx:GridViewCommandColumnCustomButton>
                </CustomButtons>
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="RowNumber" ReadOnly="True" VisibleIndex="0" Visible="false" />
            <dx:GridViewDataTextColumn FieldName="ProjeID" VisibleIndex="1" Visible="false" />
            <dx:GridViewDataTextColumn FieldName="ProjeAdi" VisibleIndex="2" GroupIndex="0" />
            <dx:GridViewDataTextColumn FieldName="DanismanID" VisibleIndex="3" Visible="false" />
            <dx:GridViewDataDateColumn FieldName="DanismanAdi" VisibleIndex="4" />
            <dx:GridViewDataTextColumn FieldName="ModulID" VisibleIndex="5" Visible="false" />
            <dx:GridViewDataTextColumn FieldName="ModulAdi" VisibleIndex="6" />
            <dx:GridViewDataTextColumn FieldName="Saat" VisibleIndex="7" />
            <dx:GridViewDataTextColumn FieldName="Gun" Caption="Gün,Saat" VisibleIndex="8" />
            <dx:GridViewDataTextColumn FieldName="BirimFiyatSaat" VisibleIndex="9">
                <PropertiesTextEdit DisplayFormatString="c" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="BirimFiyatGun" VisibleIndex="10">
                <PropertiesTextEdit DisplayFormatString="c" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ToplamFiyat" VisibleIndex="11" UnboundType="Decimal">
                <PropertiesTextEdit DisplayFormatString="c" />
            </dx:GridViewDataTextColumn>
        </Columns>
        <Settings ShowGroupPanel="True" ShowFooter="True" ShowGroupFooter="VisibleIfExpanded" />
        <GroupSummary>
            <dx:ASPxSummaryItem FieldName="DanismanAdi" ShowInGroupFooterColumn="DanismanAdi" SummaryType="Count" />
            <dx:ASPxSummaryItem FieldName="ModulAdi" ShowInGroupFooterColumn="ModulAdi" SummaryType="Count" />
            <dx:ASPxSummaryItem FieldName="Saat" ShowInGroupFooterColumn="Saat" SummaryType="Sum" />
            <dx:ASPxSummaryItem FieldName="Gun" ShowInGroupFooterColumn="Gun" SummaryType="Custom" />
            <dx:ASPxSummaryItem FieldName="ToplamFiyat" ShowInGroupFooterColumn="ToplamFiyat" SummaryType="Sum" />
        </GroupSummary>
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="ProjeAdi" SummaryType="Count" />
            <dx:ASPxSummaryItem FieldName="Saat" SummaryType="Count" />
            <dx:ASPxSummaryItem FieldName="Gun" SummaryType="Count" />
            <dx:ASPxSummaryItem FieldName="ToplamFiyat" SummaryType="Sum" />
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
    </dx:ASPxGridView>

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
