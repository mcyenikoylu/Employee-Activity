<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="BekleyenCagrilarim.aspx.cs" Inherits="DXAktivite2.BekleyenCagrilarim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <script type="text/javascript">
          function ASPxGridView2_OnCustomButtonClick(s, e) {
              if (e.buttonID == 'btnDetay')
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
              if (e.buttonID == 'btnYonlendir')
              {
                  s.GetRowValues(e.visibleIndex, "ID;InternalTicketNumber", OnGetRowValuesYonlendir);
              }
              function OnGetRowValuesYonlendir(Value) {
                  ASPxCallback1.PerformCallback(Value[0]); 
                  ASPxPopupControl2.Show();
                  //location.reload();
              }
              if (e.buttonID == 'btnCagriyaBasla') {
                  s.GetRowValues(e.visibleIndex, "ID;InternalTicketNumber", OnGetRowValues_CagriyaBasla);
              }
              function OnGetRowValues_CagriyaBasla(Value) {
                  ASPxCallback2.PerformCallback(Value[0]);
                  location.reload();
              }
           
          }
    </script>

        <dx:ASPxCallback ID="ASPxCallback1"
        ClientInstanceName="ASPxCallback1"
        OnCallback="ASPxCallback1_Callback" runat="server">
    </dx:ASPxCallback>
    <dx:ASPxCallback ID="ASPxCallback3"
        ClientInstanceName="ASPxCallback3"
        OnCallback="ASPxCallback3_Callback" runat="server">
    </dx:ASPxCallback>
    <dx:ASPxCallback ID="ASPxCallback4"
        ClientInstanceName="ASPxCallback4"
        OnCallback="ASPxCallback4_Callback" runat="server">
    </dx:ASPxCallback>
          <dx:ASPxCallback ID="ASPxCallback2"
        ClientInstanceName="ASPxCallback2"
        OnCallback="ASPxCallback2_Callback" runat="server">
    </dx:ASPxCallback>

       <%--BEKLEYEN ÇAĞRILARIM--%>
    <dx:ASPxGridView ID="ASPxGridView2" runat="server" 
        DataSourceID="BekleyenCagrilarimData" KeyFieldName="ID"
        AutoGenerateColumns="False" 
        ClientInstanceName="ASPxGridView2"
        Width="100%"  
        Caption="BEKLEYEN ÇAĞRILARIM"
        >
        <SettingsPager PageSize="20" />
        <Paddings Padding="0px" />
        <Border BorderWidth="0px" />
        <BorderBottom BorderWidth="1px" />

        <ClientSideEvents CustomButtonClick="ASPxGridView2_OnCustomButtonClick" />

        <Columns>

            <dx:GridViewCommandColumn VisibleIndex="0" Width="70px" MinWidth="60" ButtonType="Image" Caption=" "> 
                <CellStyle VerticalAlign="Middle" />
                <CustomButtons>

                    <dx:GridViewCommandColumnCustomButton ID="btnCagriyaBasla">
                        <Styles>
                            <Style CssClass="InlineButton"></Style>
                        </Styles>
                        <Image ToolTip="Çağrıya Başla" Url="images/Apply_16x16.png" Height="16px" Width="16px" />
                    </dx:GridViewCommandColumnCustomButton>

                    <dx:GridViewCommandColumnCustomButton ID="btnDetay">
                        <Styles>
                            <Style CssClass="InlineButton"></Style>
                        </Styles>
                        <Image ToolTip="Detayları Aç" Url="images/Preview_16x16.png" Height="16px" Width="16px" />
                    </dx:GridViewCommandColumnCustomButton>

                    <dx:GridViewCommandColumnCustomButton ID="btnYonlendir">
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
        <SettingsEditing Mode="EditForm" />
        <Settings ShowFooter="True" />

    </dx:ASPxGridView>

    <asp:ObjectDataSource ID="BekleyenCagrilarimData" runat="server" TypeName="DataProvider" SelectMethod="GetBekleyenCagrilar" />


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
                                                <ClientSideEvents Click="function(s, e) { if(ASPxClientEdit.ValidateGroup('entryGroupDanisman')) ASPxPopupControl2.Hide(); ASPxCallback3.PerformCallback(); ASPxGridView2.Refresh(); }" />
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


</asp:Content>
