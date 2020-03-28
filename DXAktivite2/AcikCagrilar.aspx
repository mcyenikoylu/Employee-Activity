<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="AcikCagrilar.aspx.cs" Inherits="DXAktivite2.AcikCagrilar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">
          function ASPxGridView1_OnCustomButtonClick(s, e) {
              if (e.buttonID == 'btnDetay_Canli')
              {
                  s.GetRowValues(e.visibleIndex, "ID;InternalTicketNumber;ExternalTicketNumber;AlternativeTicketNumber;IstekSirketAdi;IstekSahibiAdiSoyadi;IstekTarihiSaati;SistemKayitTarihiSaati;IstekAciklama", OnGetRowValues);
              }
              function OnGetRowValues(Value) {
                  txtInternalTicketNumber.SetText(Value[1]);
                  txtExternalTicketNumber.SetText(Value[2]);
                  txtAlternativeTicketNumber.SetText(Value[3]);
                  txtSirketAdi.SetText(Value[4]);
                  txtIlgiliKisi.SetText(Value[5]);
                  txtIstekTarihi.SetText(Value[6]);
                  txtCagriTarihi.SetText(Value[7]);
                  txtAciklama.SetText(Value[8]);
                  ASPxPopupControl1.Show();
              }
              if (e.buttonID == 'btnYonlendir_Canli')
              {
                  s.GetRowValues(e.visibleIndex, "ID;InternalTicketNumber", OnGetRowValuesYonlendir);
              }
              function OnGetRowValuesYonlendir(Value) {
                  ASPxCallback1.PerformCallback(Value[0]); 
                  ASPxPopupControl2.Show();
                  //location.reload();
              }
              
              if (e.buttonID == 'btnOnayaGonder') {
                  s.GetRowValues(e.visibleIndex, "ID;InternalTicketNumber;ExternalTicketNumber;AlternativeTicketNumber;IstekSirketAdi;IstekSahibiAdiSoyadi;IstekTarihiSaati;SistemKayitTarihiSaati;IstekAciklama", OnGetRowValues_OnayaGonder);
              }
              function OnGetRowValues_OnayaGonder(Value) {
                  ASPxCallback6.PerformCallback(Value[0]);
                  OnayTxtInternalTicketNumber.SetText(Value[1]);
                  OnayTxtExternalTicketNumber.SetText(Value[2]);
                  OnayTxtAlternativeTicketNumber.SetText(Value[3]);
                  OnayTxtSirketAdi.SetText(Value[4]);
                  OnayTxtIlgiliKisi.SetText(Value[5]);

                  var istekTarihi = new Date(Value[6]);
                  OnayTxtIstekTarihi.SetDate(istekTarihi);

                  var cagriTarihi = new Date(Value[7])
                  OnayTxtCagriTarihi.SetDate(cagriTarihi);

                  OnayTxtAciklama.SetText(Value[8]);
                  ASPxPopupControl3.Show();
              }
              if (e.buttonID == 'btnElIleOnayla') {
                  s.GetRowValues(e.visibleIndex, "ID;CagriDurumu_TipID1", OnGetRowValues_ElIleOnayla);
              }
              function OnGetRowValues_ElIleOnayla(Value) {
                  //durum tipinin 3 olma şartı var.
                  if (Value[1] == 3)
                  {
                      ASPxCallback7.PerformCallback(Value[0]);
                      ASPxPopupControl4.Show();
                  }
                  else
                      alert("Sadece onay aşamasında olan çağrıları onaylaya bilirsiniz.")
              }
              if (e.buttonID == 'btnAktiviteyeDonustur') {
                  s.GetRowValues(e.visibleIndex, "ID;InternalTicketNumber", OnGetRowValues_AktiviteyeDonustur);
              }
              function OnGetRowValues_AktiviteyeDonustur(Value) {
                  ASPxPopupControl5.Show();
                  ASPxCallback8.PerformCallback(Value[0]);
              }
          }
    </script>

    <dx:ASPxCallback ID="ASPxCallback1"
        ClientInstanceName="ASPxCallback1"
        OnCallback="ASPxCallback1_Callback" runat="server">
    </dx:ASPxCallback>
        <dx:ASPxCallback ID="ASPxCallback6"
        ClientInstanceName="ASPxCallback6"
        OnCallback="ASPxCallback6_Callback" runat="server">
    </dx:ASPxCallback>
    <dx:ASPxCallback ID="ASPxCallback3"
        ClientInstanceName="ASPxCallback3"
        OnCallback="ASPxCallback3_Callback" runat="server">
    </dx:ASPxCallback>
    <dx:ASPxCallback ID="ASPxCallback4"
        ClientInstanceName="ASPxCallback4"
        OnCallback="ASPxCallback4_Callback" runat="server">
    </dx:ASPxCallback>
    <dx:ASPxCallback ID="ASPxCallback5"
        ClientInstanceName="ASPxCallback5"
        OnCallback="ASPxCallback5_Callback" runat="server">
    </dx:ASPxCallback>
    <dx:ASPxCallback ID="ASPxCallback2"
        ClientInstanceName="ASPxCallback2"
        OnCallback="ASPxCallback2_Callback" runat="server">
    </dx:ASPxCallback>
    <dx:ASPxCallback ID="ASPxCallback7"
        ClientInstanceName="ASPxCallback7"
        OnCallback="ASPxCallback7_Callback" runat="server">
    </dx:ASPxCallback>
        <dx:ASPxCallback ID="ASPxCallback8"
        ClientInstanceName="ASPxCallback8"
        OnCallback="ASPxCallback8_Callback" runat="server">
             <ClientSideEvents 
                BeginCallback="function(s, e) {}" 
                CallbackComplete="function(s, e) {}" 
                EndCallback="function(s, e) { 
            dtTarih.SetValue(s.cpAktiviteTarihi); 
            txtAktiviteAciklama.SetValue(s.cptxtAktiviteAciklama);
            txtAktiviteSureSaat.SetValue(s.cptxtAktiviteSureSaat);
            cmbModulAdi.SetValue(s.cpcmbModulAdi);
            }" />
    </dx:ASPxCallback>
        <dx:ASPxCallback ID="ASPxCallback9"
        ClientInstanceName="ASPxCallback9"
        OnCallback="ASPxCallback9_Callback" runat="server">
    </dx:ASPxCallback>

    <style>
        .InlineButton {
            display: inline;
        }
    </style>
    <%--AÇIK ÇAĞRILARIM--%>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" 
        AutoGenerateColumns="False" 
        DataSourceID="AcikCagrilarimData" KeyFieldName="ID"
        ClientInstanceName="ASPxGridView1"
        Width="100%"  
        Caption="AÇIK ÇAĞRILARIM"
        >
        <SettingsPager PageSize="20" />
        <Paddings Padding="0px" />
        <Border BorderWidth="0px" />
        <BorderBottom BorderWidth="1px" />

        <ClientSideEvents CustomButtonClick="ASPxGridView1_OnCustomButtonClick" />
        <Columns>

            <dx:GridViewCommandColumn VisibleIndex="0" Width="70px" MinWidth="60" ButtonType="Image" Caption=" "> 
                <CellStyle VerticalAlign="Middle" />
                <CustomButtons>
                        <dx:GridViewCommandColumnCustomButton ID="btnAktiviteyeDonustur" >
                        <Styles>
                            <Style CssClass="InlineButton"></Style>
                        </Styles>
                        <Image ToolTip="Aktiviteye Dönüştür" Url="images/Convert_16x16.png" Height="16px" Width="16px" />
                    </dx:GridViewCommandColumnCustomButton>

                        <dx:GridViewCommandColumnCustomButton ID="btnElIleOnayla" >
                        <Styles>
                            <Style CssClass="InlineButton"></Style>
                        </Styles>
                        <Image ToolTip="El ile Onayla" Url="images/Status_16x16.png" Height="16px" Width="16px" />
                    </dx:GridViewCommandColumnCustomButton>

                        <dx:GridViewCommandColumnCustomButton ID="btnOnayaGonder" >
                        <Styles>
                            <Style CssClass="InlineButton"></Style>
                        </Styles>
                        <Image ToolTip="Onaya Gönder" Url="images/ChangeView_16x16.png" Height="16px" Width="16px" />
                    </dx:GridViewCommandColumnCustomButton>

                    <dx:GridViewCommandColumnCustomButton ID="btnDetay_Canli">
                        <Styles>
                            <Style CssClass="InlineButton"></Style>
                        </Styles>
                        <Image ToolTip="Detayları Aç" Url="images/Preview_16x16.png" Height="16px" Width="16px" />
                    </dx:GridViewCommandColumnCustomButton>

                    <dx:GridViewCommandColumnCustomButton ID="btnYonlendir_Canli">
                        <Styles>
                            <Style CssClass="InlineButton"></Style>
                        </Styles>
                        <Image ToolTip="Yönlendir" Url="images/Forward_16x16.png" Height="16px" Width="16px" />
                    </dx:GridViewCommandColumnCustomButton>
                </CustomButtons>
            </dx:GridViewCommandColumn>

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

            <dx:GridViewDataTextColumn FieldName="CagriDurumu_TipID1" Visible="false">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataColumn Caption="Durum" VisibleIndex="4">
                <DataItemTemplate>
                    <img id="img" runat="server" alt='Eval("CagriDurumu_TipID1")' src='<%# GetImageName(Eval("CagriDurumu_TipID1")) %>' />
                </DataItemTemplate>
            </dx:GridViewDataColumn>

            <dx:GridViewDataTextColumn FieldName="IstekAciklama" Caption="Aciklama" VisibleIndex="5">
            </dx:GridViewDataTextColumn>

        </Columns>

        <Settings ShowFooter="True" />

    </dx:ASPxGridView>

    <asp:ObjectDataSource ID="AcikCagrilarimData" runat="server" TypeName="DataProvider" SelectMethod="GetAcikCagrilar" />

    <link type="text/css" rel="stylesheet" href="Content/ModalWindow.css" />
    <link type="text/css" rel="stylesheet" href="Content/CodeFormatter.css" />
    <link type="text/css" rel="stylesheet" href="Content/CustomButton.css" />

    <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="ASPxPopupControl1"
        HeaderText="Çağrı Detayı" AllowDragging="True" PopupAnimationType="None" EnableViewState="False">
        <ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('entryGroupDanisman'); }" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

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
                                        <dx:ASPxLabel ID="lblYeniDanismanAdi" runat="server" Text="External Ticket Number:" AssociatedControlID="txtExternalTicketNumber">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtExternalTicketNumber" runat="server" Width="200px" ClientInstanceName="txtExternalTicketNumber" ReadOnly="false">
                                        </dx:ASPxTextBox>
                                    </td>
                                    <td rowspan="10">
                                        <div class="pcmSideSpacer">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="lblAlternativeTicketNumber" runat="server" Text="Alternative Ticket Number:" AssociatedControlID="txtAlternativeTicketNumber">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtAlternativeTicketNumber" runat="server" Width="200px" ClientInstanceName="txtAlternativeTicketNumber" >
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                    <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="lblInternalTicketNumber" runat="server" Text="Internal Ticket Number:" AssociatedControlID="txtInternalTicketNumber">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtInternalTicketNumber" runat="server" Width="200px" ClientInstanceName="txtInternalTicketNumber" >
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Şirket Adı:" AssociatedControlID="txtSirketAdi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtSirketAdi" runat="server" Width="200px" ClientInstanceName="txtSirketAdi" >
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                  <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="İlgili Kişi Adı:" AssociatedControlID="txtIlgiliKisi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtIlgiliKisi" runat="server" Width="200px" ClientInstanceName="txtIlgiliKisi" >
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                     <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="İstek Tarihi:" AssociatedControlID="txtIstekTarihi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtIstekTarihi" runat="server" Width="200px" ClientInstanceName="txtIstekTarihi" >
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                          <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Çağrı Tarihi:" AssociatedControlID="txtCagriTarihi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtCagriTarihi" runat="server" Width="200px" ClientInstanceName="txtCagriTarihi" >
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Açıklama:" AssociatedControlID="txtAciklama">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxMemo ID="txtAciklama" runat="server" Width="200px" Height="100px" ClientInstanceName="txtAciklama"></dx:ASPxMemo>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="pcmCellCaption"></td>
                                    <td colspan="2">
                                        <div class="pcmButton">
                                            <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Kapat" Width="80px" AutoPostBack="False" Style="float: left; margin-right: 8px">
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

    <dx:ASPxPopupControl ID="ASPxPopupControl2" runat="server" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="ASPxPopupControl2"
        HeaderText="Çağrıları Yönlendir" AllowDragging="True" PopupAnimationType="None" EnableViewState="False">
        <ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('entryGroupDanisman'); }" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <dx:ASPxPanel ID="ASPxPanel2" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <table>
                                <tr>
                                    <td rowspan="10">
                                        <div class="pcmSideSpacer">
                                        </div>
                                    </td>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="lblDanismanAdi" runat="server" Text="Danışman Adı:" AssociatedControlID="cmbDanismanAdi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxComboBox ID="cmbDanismanAdi" runat="server" Width="200px"
                                            ClientInstanceName="cmbDanismanAdi" TextField="Aciklama" ValueField="ID">
                                            <ValidationSettings EnableCustomValidation="true" ValidationGroup="entryGroupDanisman" SetFocusOnError="true"
                                                ErrorDisplayMode="Text" ErrorTextPosition="Bottom" CausesValidation="true">
                                                <RequiredField ErrorText="Danışman seçiniz." IsRequired="true" />
                                                <RegularExpression ErrorText="Danışman adı seçiniz." />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                        </dx:ASPxComboBox>
                                    </td>
                                    <td rowspan="10">
                                        <div class="pcmSideSpacer">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pcmCellCaption"></td>
                                    <td colspan="2">
                                        <div class="pcmButton">
                                            <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Kaydet" Width="80px"
                                                AutoPostBack="False" Style="float: left; margin-right: 8px">
                                                <ClientSideEvents Click="function(s, e) { if(ASPxClientEdit.ValidateGroup('entryGroupDanisman')) ASPxPopupControl2.Hide(); ASPxCallback3.PerformCallback(); ASPxGridView1.Refresh(); }" />
                                            </dx:ASPxButton>
                                            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Vazgeç" Width="80px" AutoPostBack="False" Style="float: left; margin-right: 8px">
                                                <ClientSideEvents Click="function(s, e) { ASPxCallback4.PerformCallback(); ASPxPopupControl2.Hide(); }" />
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
    
    <dx:ASPxPopupControl ID="ASPxPopupControl3" runat="server" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="ASPxPopupControl3"
        HeaderText="Çağrıyı Onaya Gönder" AllowDragging="True" PopupAnimationType="None" EnableViewState="False">
        <ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('entryGroupDanisman'); }" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <dx:ASPxPanel ID="ASPxPanel3" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <table>
                                <tr>
                                    <td rowspan="14">
                                        <div class="pcmSideSpacer">
                                        </div>
                                    </td>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="External Ticket Number:" AssociatedControlID="OnayTxtExternalTicketNumber">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="OnayTxtExternalTicketNumber" runat="server" Width="200px" ClientInstanceName="OnayTxtExternalTicketNumber" ReadOnly="false">
                                        </dx:ASPxTextBox>
                                    </td>
                                    <td rowspan="14">
                                        <div class="pcmSideSpacer">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="Alternative Ticket Number:" AssociatedControlID="OnayTxtAlternativeTicketNumber">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="OnayTxtAlternativeTicketNumber" runat="server" Width="200px" ClientInstanceName="OnayTxtAlternativeTicketNumber" >
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                    <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="Internal Ticket Number:" AssociatedControlID="OnayTxtInternalTicketNumber">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="OnayTxtInternalTicketNumber" runat="server" Width="200px" ClientInstanceName="OnayTxtInternalTicketNumber" >
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="Şirket Adı:" AssociatedControlID="OnayTxtSirketAdi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="OnayTxtSirketAdi" runat="server" Width="200px" ClientInstanceName="OnayTxtSirketAdi" >
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                  <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="İlgili Kişi Adı:" AssociatedControlID="OnayTxtIlgiliKisi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="OnayTxtIlgiliKisi" runat="server" Width="200px" ClientInstanceName="OnayTxtIlgiliKisi" >
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                     <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text="İstek Tarihi:" AssociatedControlID="OnayTxtIstekTarihi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                          <dx:ASPxDateEdit ID="OnayTxtIstekTarihi" ClientInstanceName="OnayTxtIstekTarihi" runat="server" AutoPostBack="false" >
                                                <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                                    <RequiredField IsRequired="True" ErrorText="Start date is required"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxDateEdit>
                                    </td>
                                </tr>
                                          <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel12" runat="server" Text="Çağrı Tarihi:" AssociatedControlID="OnayTxtCagriTarihi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                            <dx:ASPxDateEdit ID="OnayTxtCagriTarihi" ClientInstanceName="OnayTxtCagriTarihi" runat="server" AutoPostBack="false" >
                                                <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                                    <RequiredField IsRequired="True" ErrorText="Start date is required"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxDateEdit>
                                    </td>
                                </tr>
                                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel13" runat="server" Text="Açıklama:" AssociatedControlID="OnayTxtAciklama">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxMemo ID="OnayTxtAciklama" runat="server" Width="300px" Height="100px" ClientInstanceName="OnayTxtAciklama"></dx:ASPxMemo>
                                    </td>
                                </tr>
                                                      <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel14" runat="server" Text="Çözüm Açıklama:" AssociatedControlID="OnayTxtCozumAciklama">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxMemo ID="OnayTxtCozumAciklama" runat="server" Width="300px" Height="100px" ClientInstanceName="OnayTxtCozumAciklama"></dx:ASPxMemo>
                                    </td>
                                </tr>

                                          <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel18" runat="server" Text="Başlangıç Tarihi:" AssociatedControlID="deBaslangic">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                            <dx:ASPxDateEdit ID="deBaslangic" ClientInstanceName="deBaslangic" runat="server" AutoPostBack="false" >
                                                <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                                    <RequiredField IsRequired="True" ErrorText="Start date is required"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxDateEdit>
                                    </td>
                                </tr>

                                         <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel17" runat="server" Text="Bitiş Tarihi:" AssociatedControlID="deBitis">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                            <dx:ASPxDateEdit ID="deBitis" ClientInstanceName="deBitis" runat="server" AutoPostBack="false" >
                                    <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                        <RequiredField IsRequired="True" ErrorText="Start date is required"></RequiredField>
                                    </ValidationSettings>
                                </dx:ASPxDateEdit>
                                    </td>
                                </tr>
                                         <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel16" runat="server" Text="Toplam Çözüm Süresi (Saat):" AssociatedControlID="txtToplamCozumSuresi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtToplamCozumSuresi" runat="server" Width="100px" ClientInstanceName="txtToplamCozumSuresi" >
                                        </dx:ASPxTextBox>
                                    </td>
                                  
                                </tr>

                                             <tr runat="server" visible="false">
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel15" runat="server" Text="Alıcı Kişi:">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTokenBox ID="tbAliciKisi" runat="server" Width="300px"
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

                                <tr>
                                    <td class="pcmCellCaption"></td>
                                    <td colspan="2">
                                        <div class="pcmButton">
                                             <dx:ASPxButton ID="ASPxButton5" runat="server" Text="Kaydet" Width="80px"
                                                AutoPostBack="False" Style="float: left; margin-right: 8px">
                                                <ClientSideEvents Click="function(s, e) { if(ASPxClientEdit.ValidateGroup('entryGroupDanisman')) ASPxPopupControl3.Hide(); ASPxCallback5.PerformCallback('OnayaGonder'); ASPxGridView1.Refresh(); }" />
                                            </dx:ASPxButton>
                                             <dx:ASPxButton ID="ASPxButton6" runat="server" Text="Ön İzleme" Width="80px" Visible="false"
                                                AutoPostBack="False" Style="float: left; margin-right: 8px">
                                                <ClientSideEvents Click="function(s, e) { if(ASPxClientEdit.ValidateGroup('entryGroupDanisman')) ASPxPopupControl3.Hide(); ASPxCallback5.PerformCallback('OnIzleme'); }" />
                                            </dx:ASPxButton>
                                            <dx:ASPxButton ID="ASPxButton4" runat="server" Text="Vazgeç" Width="80px" AutoPostBack="False" Style="float: left; margin-right: 8px">
                                                <ClientSideEvents Click="function(s, e) { ASPxPopupControl3.Hide(); }" />
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

    <dx:ASPxPopupControl ID="ASPxPopupControl4" runat="server" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
    PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="ASPxPopupControl4"
    HeaderText="El ile Onay" AllowDragging="True" PopupAnimationType="None" EnableViewState="False">
        <ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('entryGroupDanisman'); }" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <dx:ASPxPanel ID="ASPxPanel4" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <table style="width:300px;" >
                                <tr>
                                    <td style="text-align:center; padding:20px 0 20px 0;" >
                                        Çağrıyı el ile onaylamak üzeresiniz?
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:center" >
                                        <dx:ASPxButton ID="ASPxButton7" runat="server" Text="Evet" Width="80px"
                                            AutoPostBack="False" >
                                            <ClientSideEvents Click="function(s, e) { if(ASPxClientEdit.ValidateGroup('entryGroupDanisman')) ASPxPopupControl4.Hide(); ASPxCallback2.PerformCallback(); ASPxGridView1.Refresh(); }" />
                                        </dx:ASPxButton>
                                        <dx:ASPxButton ID="ASPxButton8" runat="server" Text="Vazgeç" Width="80px" AutoPostBack="False" >
                                            <ClientSideEvents Click="function(s, e) { ASPxPopupControl4.Hide(); }" />
                                        </dx:ASPxButton>
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

    <dx:ASPxPopupControl ID="ASPxPopupControl5" runat="server" 
         CloseAction="CloseButton" 
         CloseOnEscape="true" 
         Modal="True"
        PopupHorizontalAlign="WindowCenter" 
         PopupVerticalAlign="WindowCenter" 
         ClientInstanceName="ASPxPopupControl5"
        HeaderText="Aktiviteye Dönüştür" 
         AllowDragging="True" 
         PopupAnimationType="None" 
         EnableViewState="False">
       
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <dx:ASPxPanel ID="ASPxPanel5" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <table>
                                <tr>
                                    <td rowspan="10">
                                        <div class="pcmSideSpacer">
                                        </div>
                                    </td>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel19" runat="server" Text="Proje Adı:" AssociatedControlID="cmbProjeAdi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxComboBox ID="cmbProjeAdi" runat="server" Width="200px"
                                            ClientInstanceName="cmbProjeAdi" TextField="Aciklama" ValueField="ID">
                                            <ValidationSettings EnableCustomValidation="true" ValidationGroup="" SetFocusOnError="true"
                                                ErrorDisplayMode="Text" ErrorTextPosition="Bottom" CausesValidation="true">
                                                <RequiredField ErrorText="Proje seçiniz." IsRequired="true" />
                                                <RegularExpression ErrorText="Proje adı seçiniz." />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                        </dx:ASPxComboBox>
                                    </td>
                                    <td rowspan="10">
                                        <div class="pcmSideSpacer">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel20" runat="server" Text="Modul Adı:" AssociatedControlID="cmbModulAdi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxComboBox ID="cmbModulAdi" runat="server" Width="200px"
                                            ClientInstanceName="cmbModulAdi" TextField="Aciklama" ValueField="ID">
                                            <ValidationSettings EnableCustomValidation="true" ValidationGroup="" SetFocusOnError="true"
                                                ErrorDisplayMode="Text" ErrorTextPosition="Bottom" CausesValidation="true">
                                                <RequiredField ErrorText="Modül seçiniz." IsRequired="true" />
                                                <RegularExpression ErrorText="Modül adı seçiniz." />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                        </dx:ASPxComboBox>
                                    </td>
                                </tr>
                                          <tr >
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel21" runat="server" Text="Tarih:" AssociatedControlID="dtTarih">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                            <dx:ASPxDateEdit ID="dtTarih" ClientInstanceName="dtTarih" runat="server" AutoPostBack="false" >
                                    <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                        <RequiredField IsRequired="True" ErrorText="Start date is required"></RequiredField>
                                    </ValidationSettings>
                                </dx:ASPxDateEdit>
                                    </td>
                                </tr>
                                         <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel22" runat="server" Text="Saat:" AssociatedControlID="txtAktiviteSureSaat">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtAktiviteSureSaat" runat="server" Width="100px" ClientInstanceName="txtAktiviteSureSaat" >
                                        </dx:ASPxTextBox>
                                    </td>
                                  
                                </tr>
                                           <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel23" runat="server" Text="Açıklama:" AssociatedControlID="txtAktiviteAciklama">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxMemo ID="txtAktiviteAciklama" runat="server" Width="300px" Height="100px" ClientInstanceName="txtAktiviteAciklama"></dx:ASPxMemo>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pcmCellCaption"></td>
                                    <td colspan="2">
                                        <div class="pcmButton">
                                            <dx:ASPxButton ID="ASPxButton9" runat="server" Text="Kaydet" Width="80px"
                                                AutoPostBack="False" Style="float: left; margin-right: 8px">
                                                <ClientSideEvents Click="function(s, e) { 
                                                    if(ASPxClientEdit.ValidateGroup('entryGroupDanisman')) 
                                                    ASPxPopupControl5.Hide(); 
                                                    ASPxCallback9.PerformCallback(); 
                                                    ASPxGridView2.Refresh(); }" />
                                            </dx:ASPxButton>
                                            <dx:ASPxButton ID="ASPxButton10" runat="server" Text="Vazgeç" Width="80px" AutoPostBack="False" Style="float: left; margin-right: 8px">
                                                <ClientSideEvents Click="function(s, e) { ASPxPopupControl5.Hide(); }" />
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
