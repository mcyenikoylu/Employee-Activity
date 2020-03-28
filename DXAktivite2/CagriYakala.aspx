<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="CagriYakala.aspx.cs" Inherits="DXAktivite2.CagriYakala" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
            <script type="text/javascript">
            function ASPxGridView2_OnCustomButtonClick(s, e) {
                if (e.buttonID == 'btnDetay_Canli')
              {
                    s.GetRowValues(e.visibleIndex, "ID;ExternalTicketNumber;AlternativeTicketNumber;IstekSirketAdi;IstekSahibiAdiSoyadi;IstekTarihiSaati;IstekAciklama", OnGetRowValues);
              }
              function OnGetRowValues(Value) {

                  txtExternalTicketNumber.SetText(Value[1]);
                  txtAlternativeTicketNumber.SetText(Value[2]);
                  txtSirketAdi.SetText(Value[3]);
                  txtIlgiliKisi.SetText(Value[4]);
                  txtIstekTarihi.SetText(Value[5]);
                  txtAciklama.SetText(Value[6]);
                  ASPxPopupControl1.Show();
              }
              if (e.buttonID == 'btnCagriyiYakala') {
                  s.GetRowValues(e.visibleIndex, "ID;ExternalTicketNumber", OnGetRowValues_CagriyiYakala);
              }
              function OnGetRowValues_CagriyiYakala(Value) {
                 
                      ASPxCallback7.PerformCallback(Value[0]);
                      ASPxGridView1.Refresh();
              }
          }
    </script>

        <dx:ASPxCallback ID="ASPxCallback7"
        ClientInstanceName="ASPxCallback7"
        OnCallback="ASPxCallback7_Callback" runat="server">
    </dx:ASPxCallback>

        <dx:ASPxCallback ID="ASPxCallback2"
        ClientInstanceName="ASPxCallback2"
        OnCallback="ASPxCallback2_Callback" runat="server">
    </dx:ASPxCallback>

     <dx:ASPxCallback ID="ASPxCallback1"
        ClientInstanceName="ASPxCallback1"
        OnCallback="ASPxCallback1_Callback" runat="server">
    </dx:ASPxCallback>

     <style>
        .InlineButton {
            display: inline;
        }
    </style>


        <dx:ASPxFormLayout ID="flDateRangePicker" runat="server" ColCount="3"
        RequiredMarkDisplayMode="None" Visible="true">
        <SettingsItemCaptions Location="Top"></SettingsItemCaptions>
        <Items>

            <dx:LayoutGroup Caption="İstek İşlemleri" ColCount="2" GroupBoxDecoration="HeadingLine">
                <Items>
                    <dx:LayoutItem Caption="&nbsp;">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="btnYonlendir" runat="server" Text="+ Yeni Çağrı İsteği" AutoPostBack="false" EnableViewState="false">
                                    <ClientSideEvents Click="function(s, e) {
                                        
                                         ASPxPopupControl2.Show();
                                        
                                        }" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>

        </Items>
    </dx:ASPxFormLayout>




                        <%--AÇIK ÇAĞRILARIM--%>
                        <dx:ASPxGridView ID="ASPxGridView1" runat="server" 
                            AutoGenerateColumns="False" 
                            DataSourceID="CagriIstekleriData" KeyFieldName="ID"
                            ClientInstanceName="ASPxGridView1"
                            Width="100%"  
                            SettingsText-Title="ÇAĞRI İSTEKLERİ"
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

                                        <dx:GridViewCommandColumnCustomButton ID="btnCagriyiYakala">
                                            <Styles>
                                                <Style CssClass="InlineButton"></Style>
                                            </Styles>
                                            <Image ToolTip="Çağrıyı Yakala" Url="images/Backward_16x16.png" Height="16px" Width="16px" />
                                        </dx:GridViewCommandColumnCustomButton>

                                        <dx:GridViewCommandColumnCustomButton ID="btnDetay_Canli">
                                            <Styles>
                                                <Style CssClass="InlineButton"></Style>
                                            </Styles>
                                            <Image ToolTip="Detayları Aç" Url="images/Preview_16x16.png" Height="16px" Width="16px" />
                                        </dx:GridViewCommandColumnCustomButton>

                                        

                                    </CustomButtons>
                                </dx:GridViewCommandColumn>

                                <dx:GridViewDataColumn FieldName="ID" Visible="false" SortOrder="Descending" />

                                <dx:GridViewDataTextColumn FieldName="ExternalTicketNumber" Caption="External Ticket Number" Width="150" VisibleIndex="0">
                                </dx:GridViewDataTextColumn>

                                
                                <dx:GridViewDataTextColumn FieldName="AlternativeTicketNumber" Caption="External Ticket Number" Width="150" VisibleIndex="0" Visible="false">
                                </dx:GridViewDataTextColumn>

                                <dx:GridViewDataDateColumn FieldName="IstekTarihiSaati" Caption="İstek Tarihi" VisibleIndex="1" Width="100" Settings-AllowHeaderFilter="True">
                                    <PropertiesDateEdit  AllowUserInput="false" AllowNull="true" >
                                    </PropertiesDateEdit>
                                </dx:GridViewDataDateColumn>
                                
                                <dx:GridViewDataDateColumn FieldName="SistemKayitTarihiSaati" Caption="Sistem Kayıt Tarihi" VisibleIndex="1" Width="150" Settings-AllowHeaderFilter="True">
                                    <PropertiesDateEdit  AllowUserInput="false" AllowNull="true" DisplayFormatString="g" >
                                    </PropertiesDateEdit>
                                </dx:GridViewDataDateColumn>

                                  <dx:GridViewDataTextColumn FieldName="IstekSirketAdi" Caption="Şirket Adı" Width="150" VisibleIndex="2">
                                </dx:GridViewDataTextColumn>

                                <dx:GridViewDataTextColumn FieldName="IstekSahibiAdiSoyadi" Caption="İstek Sahibi" Width="150" VisibleIndex="3">
                                </dx:GridViewDataTextColumn>

                                <dx:GridViewDataTextColumn FieldName="IstekAciklama" Caption="Aciklama" VisibleIndex="4">
                                </dx:GridViewDataTextColumn>

                            </Columns>

                            <Settings ShowFooter="True" ShowTitlePanel="true" />

                        </dx:ASPxGridView>

                         <asp:ObjectDataSource ID="CagriIstekleriData" runat="server" TypeName="DataProvider" SelectMethod="GetCagriIstekOnaylananlar" />
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
                                        Çağrıyı kendi üzerinize almak üzeresiniz.
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:center; padding:0 0 20px 0;">
                                        <dx:ASPxTokenBox ID="tbModul" runat="server" Width="200px" Caption="Modülleri seçin: "
                                            AllowMouseWheel="True" AllowCustomTokens="False">
                                        </dx:ASPxTokenBox>
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

        <dx:ASPxPopupControl ID="ASPxPopupControl2" runat="server" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="ASPxPopupControl2"
        HeaderText="Yeni İstek Girişi" AllowDragging="True" PopupAnimationType="None" EnableViewState="False">
      
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
                                        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="External Ticket Number:" AssociatedControlID="txtExtTicNo">
                                        </dx:ASPxLabel>
                                    </td>

                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtExtTicNo" runat="server" Width="200px" ClientInstanceName="txtExtTicNo" ReadOnly="false">
                                        </dx:ASPxTextBox>
                                    </td>
                                    <td rowspan="10">
                                        <div class="pcmSideSpacer">
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Alternative Ticket Number:" AssociatedControlID="txtAltTicNo">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtAltTicNo" runat="server" Width="200px" ClientInstanceName="txtAltTicNo" >
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                           
                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="Şirket Adı:" AssociatedControlID="txtSirAdi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtSirAdi" runat="server" Width="200px" ClientInstanceName="txtSirAdi" >
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>

                                  <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="İlgili Kişi Adı:" AssociatedControlID="txtIlgKisi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtIlgKisi" runat="server" Width="200px" ClientInstanceName="txtIlgKisi" >
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>

                                     <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="İstek Tarihi:" AssociatedControlID="dtIstekTar">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                           <dx:ASPxDateEdit ID="dtIstekTar" ClientInstanceName="dtIstekTar" runat="server" AutoPostBack="false" >
                                                <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                                    <RequiredField IsRequired="True" ErrorText="İstek tarihi seçmelisiniz."></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxDateEdit>
                                    </td>
                                </tr>
                         
                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="Açıklama:" AssociatedControlID="txtYeniIstAciklama">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxMemo ID="txtYeniIstAciklama" runat="server" Width="200px" Height="100px" ClientInstanceName="txtYeniIstAciklama"></dx:ASPxMemo>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pcmCellCaption"></td>
                                    <td colspan="2">
                                        <div class="pcmButton">
                                        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Kaydet" Width="80px"
                                            AutoPostBack="False" >
                                            <ClientSideEvents Click="function(s, e) { if(ASPxClientEdit.ValidateGroup('entryGroupIstek')) ASPxPopupControl2.Hide(); 
                                                ASPxCallback1.PerformCallback(); 
                                                ASPxGridView1.Refresh();
                                                
                                                txtYeniIstAciklama.SetText('');
                                                txtIlgKisi.SetText('');
                                                txtSirAdi.SetText('');
                                                txtAltTicNo.SetText('');
                                                txtExtTicNo.SetText('');

                                                 }" />
                                        </dx:ASPxButton>
                                        <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Vazgeç" Width="80px" AutoPostBack="False" >
                                            <ClientSideEvents Click="function(s, e) { ASPxPopupControl2.Hide(); }" />
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
