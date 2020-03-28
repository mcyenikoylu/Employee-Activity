<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="TanimlarDanismanWizard.aspx.cs" Inherits="DXAktivite2.TanimlarDanismanWizard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <%-- DANIŞMAN --%>
    <script type="text/javascript">

        function ShowDanismanWindow() {
            ASPxPopupControl1.Show();
        }

    </script>
    <%-- DANIŞMAN WIZARD BUTTONLARI --%>
    <dx:ASPxFormLayout ID="flDanismanWizardPaneli" runat="server" ColCount="2"
        RequiredMarkDisplayMode="None" Visible="true">
        <SettingsItemCaptions Location="Top"></SettingsItemCaptions>
        <Items>
            <dx:LayoutGroup Caption="Danışman Wizard" ColCount="3" GroupBoxDecoration="HeadingLine">
                <Items>

                    <dx:LayoutItem Caption="&nbsp;" ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Yeni Danışman Oluştur" AutoPostBack="false" EnableViewState="false">
                                    <ClientSideEvents Click="function(s, e) {ShowDanismanWindow(); }" />
                                </dx:ASPxButton>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>

    <%-- DANIŞMAN WIZARD ASPxCallback --%>
    <dx:ASPxCallback ID="ASPxCallback2"
        ClientInstanceName="ASPxCallback2"
        OnCallback="ASPxCallback2_Callback" runat="server">
    </dx:ASPxCallback>

    <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="ASPxPopupControl1"
        HeaderText="Yeni Danışman Oluştur" AllowDragging="True" PopupAnimationType="None" EnableViewState="False">
        <ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('entryGroupDanisman'); tbProjeKodu.Focus(); }" />
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
                                        <dx:ASPxLabel ID="lblYeniDanismanAdi" runat="server" Text="Danışman Adı:" AssociatedControlID="tbYeniDanismanAdi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="tbYeniDanismanAdi" runat="server" Width="200px" ClientInstanceName="tbYeniDanismanAdi">
                                            <ValidationSettings EnableCustomValidation="True" ValidationGroup="createAccountGroup"
                                                SetFocusOnError="True" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                <RequiredField IsRequired="True" ErrorText="Danışman adı doldurunuz." />
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
                                        <dx:ASPxLabel ID="lblKullaniciAdi" runat="server" Text="Kullanıcı Adı:" AssociatedControlID="cmbKullaniciAdi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxComboBox ID="cmbKullaniciAdi" runat="server" Width="200px"
                                            ClientInstanceName="cmbKullaniciAdi" TextField="UserName" ValueField="UserId">
                                            <ValidationSettings EnableCustomValidation="true" ValidationGroup="entryGroupDanisman" SetFocusOnError="true"
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
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="lblModul" runat="server" Text="Modül Adı:">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTokenBox ID="tbModul" runat="server" Width="200px"
                                            AllowMouseWheel="True" AllowCustomTokens="False">
                                        </dx:ASPxTokenBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="pcmCellCaption"></td>
                                    <td colspan="2">
                                        <div class="pcmButton">
                                            <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Kaydet" Width="80px"
                                                AutoPostBack="False" Style="float: left; margin-right: 8px">
                                                <ClientSideEvents Click="function(s, e) { if(ASPxClientEdit.ValidateGroup('entryGroupDanisman')) ASPxPopupControl1.Hide(); ASPxCallback2.PerformCallback(); ASPxGridView2.Refresh(); }" />
                                                <%--<ClientSideEvents Click="function(s, e) { if(ASPxClientEdit.ValidateGroup('entryGroup')) pcLogin.Hide(); ASPxCallback1.PerformCallback(); }" />--%>
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

    <dx:ASPxGridView ID="ASPxGridView2" runat="server"
        AutoGenerateColumns="False"
        DataSourceID="DanismanDataSource" KeyFieldName="DanismanID"
        ClientInstanceName="ASPxGridView2"
        Width="100%">
        <SettingsPager PageSize="50" />
        <Paddings Padding="0px" />
        <Border BorderWidth="0px" />
        <BorderBottom BorderWidth="1px" />
        <Columns>
      
            <dx:GridViewDataColumn FieldName="DanismanID" Visible="false" SortOrder="Descending" />

            <dx:GridViewDataTextColumn FieldName="DanismanAdi" Caption="Aciklama" Width="200">
            </dx:GridViewDataTextColumn>
          
            <dx:GridViewDataComboBoxColumn FieldName="UserID" Caption="Kullanıcı Adı" Width="200">
                <PropertiesComboBox
                    DataSourceID="KullaniciData"
                    ValueField="UserID"
                    ValueType="System.String"
                    TextField="UserName"
                    EnableSynchronization="False"
                    IncrementalFilteringMode="StartsWith">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

        </Columns>
        <SettingsEditing Mode="Inline" />
           <Settings ShowFooter="True"  />
    </dx:ASPxGridView>

    <asp:ObjectDataSource ID="DanismanDataSource" runat="server"
        TypeName="DataProviderTanimlar" SelectMethod="GetDanismanTanimlari"
        InsertMethod="InsertDanisman" UpdateMethod="UpdateDanisman" DeleteMethod="DeleteDanisman">
        <DeleteParameters>
            <asp:Parameter Name="DanismanID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Sil" Type="Boolean"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="DanismanID" Type="Int32" />
            <asp:Parameter Name="DanismanAdi" Type="String" />
            <asp:Parameter Name="UserID" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="DanismanID" Type="Int32" />
            <asp:Parameter Name="DanismanAdi" Type="String" />
            <asp:Parameter Name="UserID" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="KullaniciData" runat="server" TypeName="DataProviderTanimlar" SelectMethod="GetKullaniciTanimlari" />



</asp:Content>
