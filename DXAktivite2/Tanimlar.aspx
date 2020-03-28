<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="Tanimlar.aspx.cs" Inherits="DXAktivite2.Tanimlar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <%-- MODÜL --%>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server"
        AutoGenerateColumns="False"
        DataSourceID="ModullerDataSource" KeyFieldName="ModulID"
        ClientInstanceName="ASPxGridView1"
        Width="100%">
        <SettingsPager PageSize="50" />
        <Paddings Padding="0px" />
        <Border BorderWidth="0px" />
        <BorderBottom BorderWidth="1px" />
        <Columns>
            <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" ShowDeleteButton="true"
                VisibleIndex="0" Width="6%">
                <HeaderTemplate>
                    <dx:ASPxButton runat="server" Text="Ekle" RenderMode="Link" AutoPostBack="false">
                        <ClientSideEvents Click="function(s,e){ASPxGridView1.AddNewRow();}" />
                    </dx:ASPxButton>
                </HeaderTemplate>
            </dx:GridViewCommandColumn>
            <dx:GridViewDataColumn FieldName="ModulID" Visible="false" SortOrder="Descending" />
            <dx:GridViewDataTextColumn FieldName="ModulAdi" Caption="Aciklama" Width="200">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Sil" Caption="Sil" Visible="false">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsEditing Mode="Inline" />
           <Settings ShowFooter="True"  />
    </dx:ASPxGridView>

    <asp:ObjectDataSource ID="ModullerDataSource" runat="server"
        TypeName="DataProviderTanimlar" SelectMethod="GetModuller"
        InsertMethod="InsertModul" UpdateMethod="UpdateModul" DeleteMethod="DeleteModul">
        <DeleteParameters>
            <asp:Parameter Name="ModulID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Sil" Type="Boolean"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ModulID" Type="Int32" />
            <asp:Parameter Name="ModulAdi" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ModulID" Type="Int32" />
            <asp:Parameter Name="ModulAdi" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>



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
            <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" ShowDeleteButton="true"
                VisibleIndex="0" Width="6%">
                <HeaderTemplate>
                    <dx:ASPxButton runat="server" Text="Ekle" RenderMode="Link" AutoPostBack="false">
                        <ClientSideEvents Click="function(s,e){ASPxGridView2.AddNewRow();}" />
                    </dx:ASPxButton>
                </HeaderTemplate>
            </dx:GridViewCommandColumn>
            <dx:GridViewDataColumn FieldName="DanismanID" Visible="false" SortOrder="Descending" />
            <dx:GridViewDataTextColumn FieldName="DanismanAdi" Caption="Aciklama" Width="200">
            </dx:GridViewDataTextColumn>
            <%--<dx:GridViewDataTextColumn FieldName="Sil" Caption="Sil" Visible="false">
            </dx:GridViewDataTextColumn>--%>
            <dx:GridViewDataComboBoxColumn FieldName="UserID" Caption="Kullanıcı Adı" Width="200">
                <PropertiesComboBox
                    DataSourceID="KullaniciData"
                    ValueField="UserID"
                    ValueType="System.Int32"
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




    <%-- YÜKLENİCİ --%>
    <dx:ASPxGridView ID="ASPxGridView3" runat="server"
        AutoGenerateColumns="False"
        DataSourceID="YukleniciDataSource" KeyFieldName="YukleniciID"
        ClientInstanceName="ASPxGridView3"
        Width="100%">
        <SettingsPager PageSize="50" />
        <Paddings Padding="0px" />
        <Border BorderWidth="0px" />
        <BorderBottom BorderWidth="1px" />
        <Columns>
            <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" ShowDeleteButton="true"
                VisibleIndex="0" Width="6%">
                <HeaderTemplate>
                    <dx:ASPxButton runat="server" Text="Ekle" RenderMode="Link" AutoPostBack="false">
                        <ClientSideEvents Click="function(s,e){ ASPxGridView3.AddNewRow();}" />
                    </dx:ASPxButton>
                </HeaderTemplate>
            </dx:GridViewCommandColumn>
            <dx:GridViewDataColumn FieldName="YukleniciID" Visible="false" SortOrder="Descending" />
            <dx:GridViewDataTextColumn FieldName="YukleniciAdi" Caption="Aciklama" Width="200">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Sil" Caption="Sil" Visible="false">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsEditing Mode="Inline" />
           <Settings ShowFooter="True"  />
    </dx:ASPxGridView>

    <asp:ObjectDataSource ID="YukleniciDataSource" runat="server"
        TypeName="DataProviderTanimlar" SelectMethod="GetYukleniciTanimlari"
        InsertMethod="InsertYuklenici" UpdateMethod="UpdateYuklenici" DeleteMethod="DeleteYuklenici">
        <DeleteParameters>
            <asp:Parameter Name="YukleniciID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Sil" Type="Boolean"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="YukleniciID" Type="Int32" />
            <asp:Parameter Name="YukleniciAdi" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="YukleniciID" Type="Int32" />
            <asp:Parameter Name="YukleniciAdi" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>




    <%-- MÜŞTERİ --%>
    <dx:ASPxGridView ID="ASPxGridView4" runat="server"
        AutoGenerateColumns="False"
        DataSourceID="MusteriDataSource" KeyFieldName="MusteriID"
        ClientInstanceName="ASPxGridView4"
        Width="100%">
        <SettingsPager PageSize="50" />
        <Paddings Padding="0px" />
        <Border BorderWidth="0px" />
        <BorderBottom BorderWidth="1px" />
        <Columns>
            <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" ShowDeleteButton="true"
                VisibleIndex="0" Width="6%">
                <HeaderTemplate>
                    <dx:ASPxButton runat="server" Text="Ekle" RenderMode="Link" AutoPostBack="false">
                        <ClientSideEvents Click="function(s,e){ ASPxGridView4.AddNewRow();}" />
                    </dx:ASPxButton>
                </HeaderTemplate>
            </dx:GridViewCommandColumn>
            <dx:GridViewDataColumn FieldName="MusteriID" Visible="false" SortOrder="Descending" />
            <dx:GridViewDataTextColumn FieldName="MusteriAdi" Caption="Aciklama" Width="200">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Sil" Caption="Sil" Visible="false">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsEditing Mode="Inline" />
           <Settings ShowFooter="True"  />
    </dx:ASPxGridView>

    <asp:ObjectDataSource ID="MusteriDataSource" runat="server"
        TypeName="DataProviderTanimlar" SelectMethod="GetMusteriTanimlari"
        InsertMethod="InsertMusteri" UpdateMethod="UpdateMusteri" DeleteMethod="DeleteMusteri">
        <DeleteParameters>
            <asp:Parameter Name="MusteriID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Sil" Type="Boolean"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="MusteriID" Type="Int32" />
            <asp:Parameter Name="MusteriAdi" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="MusteriID" Type="Int32" />
            <asp:Parameter Name="MusteriAdi" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>





    <%-- MÜŞTERİ LOKASYONLARI --%>
    <dx:ASPxGridView ID="ASPxGridView5" runat="server"
        AutoGenerateColumns="False"
        DataSourceID="MusteriLokasyonDataSource" KeyFieldName="MusteriLokasyonID"
        ClientInstanceName="ASPxGridView5"
        Width="100%">
        <SettingsPager PageSize="50" />
        <Paddings Padding="0px" />
        <Border BorderWidth="0px" />
        <BorderBottom BorderWidth="1px" />

        <Columns>

            <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" ShowDeleteButton="true" VisibleIndex="0" Width="6%">
                <HeaderTemplate>
                    <dx:ASPxButton runat="server" Text="Ekle" RenderMode="Link" AutoPostBack="false">
                        <ClientSideEvents Click="function(s,e){ ASPxGridView5.AddNewRow();  }" />
                    </dx:ASPxButton>
                </HeaderTemplate>
            </dx:GridViewCommandColumn>

            <dx:GridViewDataColumn FieldName="MusteriLokasyonID" Visible="false" SortOrder="Descending" />

            <dx:GridViewDataComboBoxColumn FieldName="MusteriID" Caption="Müşteri Adı" Width="200">
                <PropertiesComboBox
                    DataSourceID="MusteriData"
                    ValueField="MusteriID"
                    ValueType="System.Int32"
                    TextField="MusteriAdi"
                    EnableSynchronization="False"
                    IncrementalFilteringMode="StartsWith">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataTextColumn FieldName="MusteriLokasyonAdi" Caption="Lokasyon Adı">
            </dx:GridViewDataTextColumn>

        </Columns>
        <SettingsEditing Mode="Inline" />
           <Settings ShowFooter="True"  />
    </dx:ASPxGridView>

    <asp:ObjectDataSource ID="MusteriLokasyonDataSource" runat="server"
        TypeName="DataProviderTanimlar" SelectMethod="GetMusteriLokasyonTanimlari"
        InsertMethod="InsertMusteriLokasyon" UpdateMethod="UpdateMusteriLokasyon" DeleteMethod="DeleteMusteriLokasyon">
        <DeleteParameters>
            <asp:Parameter Name="MusteriLokasyonID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Sil" Type="Boolean"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="MusteriLokasyonID" Type="Int32" />
            <asp:Parameter Name="MusteriLokasyonAdi" Type="String" />
            <asp:Parameter Name="MusteriID" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="MusteriLokasyonID" Type="Int32" />
            <asp:Parameter Name="MusteriLokasyonAdi" Type="String" />
            <asp:Parameter Name="MusteriID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>


    <asp:ObjectDataSource ID="MusteriData" runat="server" TypeName="DataProviderTanimlar" SelectMethod="GetMusteriTanimlari" />







    <%-- PROJE --%>
    <script type="text/javascript">
        function MusterilerCombo_SelectedIndexChanged(s, e) {
            ASPxGridView6.GetEditor("LokasyonID").PerformCallback(s.GetValue());
        }
        function ShowLoginWindow() {
            pcLogin.Show();
        }
        function ShowCreateAccountWindow() {
            pcCreateAccount.Show();
            tbUsername.Focus();
        }
    </script>

    <link type="text/css" rel="stylesheet" href="Content/ModalWindow.css" />
    <link type="text/css" rel="stylesheet" href="Content/CodeFormatter.css" />
    <link type="text/css" rel="stylesheet" href="Content/CustomButton.css" />

    <%-- PROJE WIZARD BUTTONLARI --%>
    <dx:ASPxFormLayout ID="flProjeWizardPaneli" runat="server" ColCount="2"
        RequiredMarkDisplayMode="None" Visible="true">
        <SettingsItemCaptions Location="Top"></SettingsItemCaptions>
        <Items>
            <dx:LayoutGroup Caption="Proje Wizard" ColCount="3" GroupBoxDecoration="HeadingLine">
                <Items>

                    <dx:LayoutItem Caption="&nbsp;" ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="btnSubmit" runat="server" Text="Yeni Proje Oluştur" AutoPostBack="false" EnableViewState="false">
                                    <ClientSideEvents Click="function(s, e) {ShowLoginWindow(); }" />
                                </dx:ASPxButton>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>

    <%--SCRIPTLER--%>

    <%--COMBO CHECKBOX İÇİN--%>
    <%--   <script type="text/javascript">
        var textSeparator = ";";
        function OnListBoxSelectionChanged(listBox, args) {
            //if(args.index == 0)
            //    args.isSelected ? listBox.SelectAll() : listBox.UnselectAll();
            //UpdateSelectAllItemState();
            UpdateText();
        }
        function UpdateSelectAllItemState() {
            IsAllSelected() ? checkListBox.SelectIndices([0]) : checkListBox.UnselectIndices([0]);
        }
        function IsAllSelected() {
            var selectedDataItemCount = checkListBox.GetItemCount() - (checkListBox.GetItem(0).selected ? 0 : 1);
            return checkListBox.GetSelectedItems().length == selectedDataItemCount;
        }
        function UpdateText() {
            var selectedItems = checkListBox.GetSelectedItems();
            checkComboBox.SetText(GetSelectedItemsText(selectedItems));
        }
        function SynchronizeListBoxValues(dropDown, args) {
            checkListBox.UnselectAll();
            var texts = dropDown.GetText().split(textSeparator);
            var values = GetValuesByTexts(texts);
            checkListBox.SelectValues(values);
            //UpdateSelectAllItemState();
            UpdateText(); // for remove non-existing texts
        }
        function GetSelectedItemsText(items) {
            var texts = [];
            for(var i = 0; i < items.length; i++)
                //if(items[i].index != 0)
                    texts.push(items[i].text);
            return texts.join(textSeparator);
        }
        function GetValuesByTexts(texts) {
            var actualValues = [];
            var item;
            for(var i = 0; i < texts.length; i++) {
                item = checkListBox.FindItemByText(texts[i]);
                if(item != null)
                    actualValues.push(item.value);
            }
            return actualValues;
        }
    </script>--%>

    <%--COMBOBOX İÇİN --%>
    <script type="text/javascript">
        var lastCountry = null;
        function OnCountryChanged(cmbCountry) {
            if (cmbCity.InCallback())
                lastCountry = cmbCountry.GetValue().toString();
            else
                cmbCity.PerformCallback(cmbCountry.GetValue().toString());
        }
        function OnEndCallback(s, e) {
            if (lastCountry) {
                cmbCity.PerformCallback(lastCountry);
                lastCountry = null;
            }
        }
    </script>

    <%--  <dx:ASPxCallback runat="server" 
            ID="ASPxCallback" 
            ClientInstanceName="ASPxCallback" 
            OnCallback="ASPxCallback_Callback" ></dx:ASPxCallback>--%>

    <%-- PROJE WIZARD ASPxCallback --%>
    <dx:ASPxCallback ID="ASPxCallback1"
        ClientInstanceName="ASPxCallback1"
        OnCallback="ASPxCallback1_Callback" runat="server">
    </dx:ASPxCallback>


    <%-- PROJE WIZARD ASPxPopupControl --%>
    <dx:ASPxPopupControl ID="pcLogin" runat="server" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcLogin"
        HeaderText="Yeni Proje Oluştur" AllowDragging="True" PopupAnimationType="None" EnableViewState="False">
        <ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('entryGroup'); tbProjeKodu.Focus(); }" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <%--<dx:ASPxTokenBox 
                                     runat="server" 
                                     ID="Tokens"
                                     AllowMouseWheel="True" 
                                     AllowCustomTokens="False">      
                                 </dx:ASPxTokenBox>
                                <dx:ASPxButton runat="server" ID="Btn" Text="GetValue" AutoPostBack="False" >
			                        <ClientSideEvents Click="function(s, e) { ASPxCallback.PerformCallback(); }"/>
                                </dx:ASPxButton>--%>
                <dx:ASPxPanel ID="Panel1" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <table>
                                <tr>
                                    <td rowspan="10">
                                        <div class="pcmSideSpacer">
                                        </div>
                                    </td>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Proje Kodu:" AssociatedControlID="tbProjeKodu">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="tbProjeKodu" runat="server" Width="200px" ClientInstanceName="tbProjeKodu">
                                            <ValidationSettings EnableCustomValidation="True" ValidationGroup="createAccountGroup"
                                                SetFocusOnError="True" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                <RequiredField IsRequired="True" ErrorText="Username is required" />
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
                                        <dx:ASPxLabel ID="lblProjeAdi" runat="server" Text="Proje Adı:" AssociatedControlID="tbProjeAdi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="tbProjeAdi" runat="server" Width="200px" ClientInstanceName="tbProjeAdi">
                                            <ValidationSettings EnableCustomValidation="True" ValidationGroup="entryGroup" SetFocusOnError="True"
                                                ErrorDisplayMode="Text" ErrorTextPosition="Bottom" CausesValidation="True">
                                                <RequiredField ErrorText="Username required" IsRequired="True" />
                                                <RegularExpression ErrorText="Login required" />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="lblMusteriAdi" runat="server" Text="Müşteri Adı:" AssociatedControlID="tbMusteriAdi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxComboBox runat="server" ID="CmbCountry" DropDownStyle="DropDownList"
                                            IncrementalFilteringMode="StartsWith"
                                            TextField="MusteriAdi" ValueField="MusteriID"
                                            EnableSynchronization="False" Width="200px">
                                            <ValidationSettings EnableCustomValidation="true" ValidationGroup="entryGroup" SetFocusOnError="true"
                                                ErrorDisplayMode="Text" ErrorTextPosition="Bottom" CausesValidation="true">
                                                <RequiredField ErrorText="Müşteri seçiniz." IsRequired="true" />
                                                <RegularExpression ErrorText="Proje bilgilerinde müşteri alanına seçim yapınız." />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                            <ClientSideEvents SelectedIndexChanged="function(s, e) { OnCountryChanged(s); }" />
                                        </dx:ASPxComboBox>
                                        <%--<dx:ASPxComboBox ID="cmbMusteriAdi" runat="server" Width="200px" ClientInstanceName="cmbMusteriAdi">
                                            <ValidationSettings EnableCustomValidation="true" ValidationGroup="entryGroup" SetFocusOnError="true"
                                                ErrorDisplayMode="Text" ErrorTextPosition="Bottom" CausesValidation="true">
                                                <RequiredField ErrorText="Müşteri seçiniz." IsRequired="true" />
                                                <RegularExpression ErrorText="Proje bilgilerinde müşteri alanına seçim yapınız." />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                        </dx:ASPxComboBox>--%>
                                        <%--<dx:ASPxButton ID="btnBlueBall" runat="server" AutoPostBack="False" AllowFocus="False" 
                                            RenderMode="Link" EnableTheming="False">
                                            <Image>
                                                <SpriteProperties CssClass="blueBall" 
                                                    HottrackedCssClass="blueBallHottracked" 
                                                    PressedCssClass="blueBallPressed" />
                                            </Image> 
                                        </dx:ASPxButton>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="lblLokasyonAdi" runat="server" Text="Lokasyon Adı:" AssociatedControlID="tbLokasyonAdi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxComboBox runat="server" ID="CmbCity" ClientInstanceName="cmbCity"
                                            OnCallback="CmbCity_Callback"
                                            DropDownStyle="DropDown" TextField="Aciklama" Width="200px"
                                            ValueField="ID" IncrementalFilteringMode="StartsWith"
                                            EnableSynchronization="False">
                                            <ValidationSettings EnableCustomValidation="true" ValidationGroup="entryGroup" SetFocusOnError="true"
                                                ErrorDisplayMode="Text" ErrorTextPosition="Bottom" CausesValidation="true">
                                                <RequiredField ErrorText="Müşteri seçiniz." IsRequired="true" />
                                                <RegularExpression ErrorText="Proje bilgilerinde müşteri alanına seçim yapınız." />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                            <ClientSideEvents EndCallback=" OnEndCallback" />
                                        </dx:ASPxComboBox>
                                        <%--<dx:ASPxComboBox ID="tbLokasyonAdi" runat="server" Width="200px" ClientInstanceName="tbLokasyonAdi">
                                            <ValidationSettings EnableCustomValidation="true" ValidationGroup="entryGroup" SetFocusOnError="true"
                                                ErrorDisplayMode="Text" ErrorTextPosition="Bottom" CausesValidation="true">
                                                <RequiredField ErrorText="Müşteri seçiniz." IsRequired="true" />
                                                <RegularExpression ErrorText="Proje bilgilerinde müşteri alanına seçim yapınız." />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                        </dx:ASPxComboBox>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td class="pcmCheckBox">
                                        <dx:ASPxCheckBox ID="chbYuklenici" runat="server" Text="Yüklenici firma var mı?"
                                            ClientInstanceName="chbYuklenici">
                                            <ClientSideEvents ValueChanged="function(s, e) { 
                                                    if(chbYuklenici.GetChecked()) 
                                                        tbYukleniciAdi.SetEnabled(true);
                                                    else
                                                        tbYukleniciAdi.SetEnabled(false);
                                                }" />
                                        </dx:ASPxCheckBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="lblYukleniciAdi" runat="server" Text="Yüklenici Adı:" AssociatedControlID="tbYukleniciAdi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxComboBox ID="tbYukleniciAdi" runat="server" Width="200px"
                                            ClientInstanceName="tbYukleniciAdi" TextField="YukleniciAdi" ValueField="YukleniciID">
                                            <ValidationSettings EnableCustomValidation="true" ValidationGroup="entryGroup" SetFocusOnError="true"
                                                ErrorDisplayMode="Text" ErrorTextPosition="Bottom" CausesValidation="true">
                                                <RequiredField ErrorText="Müşteri seçiniz." IsRequired="true" />
                                                <RegularExpression ErrorText="Proje bilgilerinde müşteri alanına seçim yapınız." />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                        </dx:ASPxComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="lblDanismanAdi" runat="server" Text="Danışman Adı:">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTokenBox ID="tbDanismanAdi" runat="server" Width="200px"
                                            AllowMouseWheel="True" AllowCustomTokens="False">
                                        </dx:ASPxTokenBox>

                                        <%--     <dx:ASPxDropDownEdit ClientInstanceName="checkComboBox" ID="ASPxDropDownEdit1" Width="210px" runat="server" AnimationType="None">
                                            <DropDownWindowStyle BackColor="#EDEDED" />
                                            <DropDownWindowTemplate>
                                                <dx:ASPxListBox Width="100%" ID="listBox" ClientInstanceName="checkListBox" SelectionMode="CheckColumn"
                                                    runat="server" TextField="DanismanModulAdi" ValueField="ID"  >
                                                    <Border BorderStyle="None" />
                                                    <BorderBottom BorderStyle="Solid" BorderWidth="1px" BorderColor="#DCDCDC" />
                                                     
                                                    <ClientSideEvents SelectedIndexChanged="OnListBoxSelectionChanged" />
                                                </dx:ASPxListBox>
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td style="padding: 4px">
                                                            <dx:ASPxButton ID="ASPxButton1" AutoPostBack="False" runat="server" Text="Close" style="float: right">
                                                                <ClientSideEvents Click="function(s, e){ checkComboBox.HideDropDown(); }" />
                                                            </dx:ASPxButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </DropDownWindowTemplate>
                                            <ClientSideEvents TextChanged="SynchronizeListBoxValues" DropDown="SynchronizeListBoxValues" />
                                        </dx:ASPxDropDownEdit>--%>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="pcmCellCaption"></td>
                                    <td colspan="2">
                                        <div class="pcmButton">
                                            <dx:ASPxButton ID="btOK" runat="server" Text="Kaydet" Width="80px"
                                                AutoPostBack="False" Style="float: left; margin-right: 8px">
                                                <ClientSideEvents Click="function(s, e) { if(ASPxClientEdit.ValidateGroup('entryGroup')) pcLogin.Hide(); ASPxCallback1.PerformCallback(); ASPxGridView6.Refresh(); }" />
                                                <%--<ClientSideEvents Click="function(s, e) { if(ASPxClientEdit.ValidateGroup('entryGroup')) pcLogin.Hide(); ASPxCallback1.PerformCallback(); }" />--%>
                                            </dx:ASPxButton>
                                            <dx:ASPxButton ID="btCancel" runat="server" Text="Vazgeç" Width="80px" AutoPostBack="False" Style="float: left; margin-right: 8px">
                                                <ClientSideEvents Click="function(s, e) { pcLogin.Hide(); }" />
                                            </dx:ASPxButton>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxPanel>
                <%--<div>
                    <a href="javascript:ShowCreateAccountWindow();" id="hl1" style="float: right; margin: 14px 0 10px 0;">
                        Create Account</a>
                </div>--%>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ContentStyle>
            <Paddings PaddingBottom="5px" />
        </ContentStyle>
    </dx:ASPxPopupControl>
    <dx:ASPxPopupControl ID="pcCreateAccount" runat="server" CloseAction="CloseButton" CloseOnEscape="true"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="pcCreateAccount"
        HeaderText="Create Account" AllowDragging="True" Modal="True" PopupAnimationType="Fade"
        EnableViewState="False" PopupHorizontalOffset="40" PopupVerticalOffset="40">
        <ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('createAccountGroup'); }" />
        <SizeGripImage Width="11px" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxPanel ID="Panel2" runat="server" DefaultButton="btCreate">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <table>
                                <tr>
                                    <td rowspan="5">
                                        <div class="pcmSideSpacer">
                                        </div>
                                    </td>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="lblUsername2" runat="server" Text="Username:" AssociatedControlID="tbUsername">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="tbUsername" runat="server" Width="150px" ClientInstanceName="tbUsername">
                                            <ValidationSettings EnableCustomValidation="True" ValidationGroup="createAccountGroup"
                                                SetFocusOnError="True" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                <RequiredField IsRequired="True" ErrorText="Username is required" />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </td>
                                    <td rowspan="5">
                                        <div class="pcmSideSpacer">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="lblPass2" runat="server" Text="Password:" AssociatedControlID="tbPass1">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="tbPass1" runat="server" Width="150px" ClientInstanceName="pass1"
                                            Password="True">
                                            <ValidationSettings EnableCustomValidation="True" ValidationGroup="createAccountGroup"
                                                SetFocusOnError="True" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                <RequiredField IsRequired="True" ErrorText="Password is required" />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="lblConfPass2" runat="server" Text="Confirm password:" AssociatedControlID="tbConfPass2">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="tbConfPass2" runat="server" Width="150px" ClientInstanceName="pass2"
                                            Password="True">
                                            <ValidationSettings EnableCustomValidation="True" ValidationGroup="createAccountGroup"
                                                SetFocusOnError="True" ErrorText="Password is incorrect" ErrorDisplayMode="Text"
                                                ErrorTextPosition="Bottom">
                                                <RequiredField IsRequired="True" ErrorText="Please, confirm your password" />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                            <ClientSideEvents Validation="function(s, e) { e.isValid = (pass1.GetText()==pass2.GetText()); }" />
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="lblEmail" runat="server" Text="Email:" AssociatedControlID="tbEmail">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="tbEmail" runat="server" Width="150px">
                                            <ValidationSettings EnableCustomValidation="True" ValidationGroup="createAccountGroup"
                                                SetFocusOnError="True" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                                <RequiredField IsRequired="True" ErrorText="E-mail is required" />
                                                <RegularExpression ErrorText="Invalid e-mail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <div class="pcmButton">
                                            <dx:ASPxButton ID="btCreate" runat="server" Text="OK" Width="80px" AutoPostBack="False" Style="float: left; margin-right: 8px">
                                                <ClientSideEvents Click="function(s, e) {
    if(ASPxClientEdit.ValidateGroup('createAccountGroup')) {
        ASPxClientEdit.ClearGroup('entryGroup');
        tbLogin.SetText(tbUsername.GetText());
        pcCreateAccount.Hide();
    }
}" />
                                            </dx:ASPxButton>
                                            <dx:ASPxButton ID="btCancel2" runat="server" Text="Cancel" Width="80px" AutoPostBack="False" Style="float: left; margin-right: 8px">
                                                <ClientSideEvents Click="function(s, e) { pcCreateAccount.Hide(); }" />
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
    </dx:ASPxPopupControl>


    <dx:ASPxGridView ID="ASPxGridView6" runat="server"
        AutoGenerateColumns="False"
        DataSourceID="ProjelerDataSource" KeyFieldName="ID"
        ClientInstanceName="ASPxGridView6"
        Width="100%"
        OnCellEditorInitialize="ASPxGridView6_CellEditorInitialize"
        OnInit="ASPxGridView6_Init"
        OnDataBound="ASPxGridView6_DataBound">
        <SettingsPager PageSize="50" />
        <Paddings Padding="0px" />
        <Border BorderWidth="0px" />
        <BorderBottom BorderWidth="1px" />
        <Columns>

            <dx:GridViewCommandColumn Name="cmnd" ShowEditButton="True" ShowNewButtonInHeader="True" ShowDeleteButton="true" VisibleIndex="0" Width="6%">
                <HeaderTemplate>
                    <dx:ASPxButton runat="server" Text="Ekle" RenderMode="Link" AutoPostBack="false">
                        <ClientSideEvents Click="function(s,e){ ASPxGridView6.AddNewRow();  }" />
                    </dx:ASPxButton>
                </HeaderTemplate>
            </dx:GridViewCommandColumn>

            <dx:GridViewDataColumn FieldName="ID" Visible="false" SortOrder="Descending" />

            <dx:GridViewDataTextColumn FieldName="Kod" Caption="Proje Kodu" Width="100">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Aciklama" Caption="Proje Adi">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataComboBoxColumn FieldName="MusteriID" Caption="Müşteri Adı" Width="200">
                <PropertiesComboBox
                    DataSourceID="MusterilerData"
                    ValueField="MusteriID"
                    ValueType="System.Int32"
                    TextField="MusteriAdi"
                    EnableSynchronization="False"
                    IncrementalFilteringMode="StartsWith">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                    <ClientSideEvents SelectedIndexChanged="MusterilerCombo_SelectedIndexChanged" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn FieldName="LokasyonID" Caption="Lokasyon Adı" Width="200">
                <PropertiesComboBox
                    DataSourceID="AllLokasyonlarData"
                    ValueField="MusteriLokasyonID"
                    ValueType="System.Int32"
                    TextField="MusteriLokasyonAdi"
                    EnableSynchronization="False"
                    IncrementalFilteringMode="StartsWith">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataCheckColumn FieldName="Yuklenici" Caption="Yüklenici" Width="50">
                <PropertiesCheckEdit DisplayTextChecked="Evet" DisplayTextUnchecked="Hayır"
                    UseDisplayImages="False">
                </PropertiesCheckEdit>
            </dx:GridViewDataCheckColumn>

            <dx:GridViewDataComboBoxColumn FieldName="YukleniciID" Caption="Yüklenici Adı" Width="200">
                <PropertiesComboBox
                    DataSourceID="YuklenicilerData"
                    ValueField="YukleniciID"
                    ValueType="System.Int32"
                    TextField="YukleniciAdi"
                    EnableSynchronization="False"
                    IncrementalFilteringMode="StartsWith">
                    <%--<ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />--%>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
        </Columns>
        <SettingsEditing Mode="Inline" />
           <Settings ShowFooter="True"  />
    </dx:ASPxGridView>

    <asp:ObjectDataSource ID="ProjelerDataSource" runat="server"
        TypeName="DataProviderTanimlar" SelectMethod="GetProjeler"
        InsertMethod="InsertProjeler" UpdateMethod="UpdateProjeler" DeleteMethod="DeleteProjeler">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Sil" Type="Boolean"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="Aciklama" Type="String" />
            <asp:Parameter Name="Kod" Type="String" />
            <asp:Parameter Name="MusteriID" Type="Int32" />
            <asp:Parameter Name="LokasyonID" Type="Int32" />
            <asp:Parameter Name="Yuklenici" Type="Boolean" />
            <asp:Parameter Name="YukleniciID" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="Aciklama" Type="String" />
            <asp:Parameter Name="Kod" Type="String" />
            <asp:Parameter Name="MusteriID" Type="Int32" />
            <asp:Parameter Name="LokasyonID" Type="Int32" />
            <asp:Parameter Name="Yuklenici" Type="Boolean" />
            <asp:Parameter Name="YukleniciID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="ProjelerData" runat="server" TypeName="DataProviderTanimlar" SelectMethod="GetProjeler" />

    <asp:ObjectDataSource ID="MusterilerData" runat="server" TypeName="DataProviderTanimlar" SelectMethod="GetMusteriler" />

    <asp:ObjectDataSource ID="AllLokasyonlarData" runat="server" TypeName="DataProviderTanimlar" SelectMethod="GetLokasyonlar" />
    <asp:ObjectDataSource ID="LokasyonlarData" runat="server" TypeName="DataProviderTanimlar" SelectMethod="GetLokasyonlar">
        <SelectParameters>
            <asp:Parameter Name="MusteriID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="YuklenicilerData" runat="server" TypeName="DataProviderTanimlar" SelectMethod="GetYukleniciler" />



    <%-- PROJE DANIŞMAN TANIMLARI --%>
    <script type="text/javascript">
        function DanismanlarCombo_SelectedIndexChanged(s, e) {
            ASPxGridView7.GetEditor("ModulID").PerformCallback(s.GetValue());
        }
    </script>
    <dx:ASPxGridView ID="ASPxGridView7" runat="server"
        AutoGenerateColumns="False"
        DataSourceID="ProjeDanismanTanimlariDataSource" KeyFieldName="ID"
        ClientInstanceName="ASPxGridView7"
        Width="100%"
        OnCellEditorInitialize="ASPxGridView7_CellEditorInitialize">
        <SettingsPager PageSize="50" />
        <Paddings Padding="0px" />
        <Border BorderWidth="0px" />
        <BorderBottom BorderWidth="1px" />
        <Columns>

            <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" ShowDeleteButton="true" VisibleIndex="0" Width="6%">
                <HeaderTemplate>
                    <dx:ASPxButton runat="server" Text="Ekle" RenderMode="Link" AutoPostBack="false">
                        <ClientSideEvents Click="function(s,e){ ASPxGridView7.AddNewRow();  }" />
                    </dx:ASPxButton>
                </HeaderTemplate>
            </dx:GridViewCommandColumn>

            <dx:GridViewDataColumn FieldName="ID" Visible="false" SortOrder="Descending" />

            <dx:GridViewDataComboBoxColumn FieldName="ProjeID" Caption="Proje Adı">
                <PropertiesComboBox
                    DataSourceID="ProjelerDataList"
                    ValueField="ID"
                    ValueType="System.Int32"
                    TextField="Aciklama"
                    EnableSynchronization="False"
                    IncrementalFilteringMode="StartsWith">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn FieldName="DanismanID" Caption="Danışman Adı" Width="200">
                <PropertiesComboBox
                    DataSourceID="DanismanData"
                    ValueField="DanismanID"
                    ValueType="System.Int32"
                    TextField="DanismanAdi"
                    EnableSynchronization="False"
                    IncrementalFilteringMode="StartsWith">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                    <ClientSideEvents SelectedIndexChanged="DanismanlarCombo_SelectedIndexChanged" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn FieldName="ModulID" Caption="Modül Adı" Width="200">
                <PropertiesComboBox
                    DataSourceID="AllModulData"
                    ValueField="ModulID"
                    ValueType="System.Int32"
                    TextField="ModulAdi"
                    EnableSynchronization="False"
                    IncrementalFilteringMode="StartsWith">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn FieldName="FiyatGun" Caption="Fiyat / Gün" Width="100">
                <PropertiesTextEdit DisplayFormatString="c" />
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsEditing Mode="Inline" />
           <Settings ShowFooter="True"  />
    </dx:ASPxGridView>

    <asp:ObjectDataSource ID="ProjeDanismanTanimlariDataSource" runat="server"
        TypeName="DataProviderTanimlar" SelectMethod="GetProjeDanismanTanimlari"
        InsertMethod="InsertProjeDanismanTanimlari"
        UpdateMethod="UpdateProjeDanismanTanimlari"
        DeleteMethod="DeleteProjeDanismanTanimlari">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Sil" Type="Boolean"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="ProjeID" Type="Int32" />
            <asp:Parameter Name="DanismanID" Type="Int32" />
            <asp:Parameter Name="ModulID" Type="Int32" />
            <asp:Parameter Name="FiyatGun" Type="Decimal" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="ProjeID" Type="Int32" />
            <asp:Parameter Name="DanismanID" Type="Int32" />
            <asp:Parameter Name="ModulID" Type="Int32" />
            <asp:Parameter Name="FiyatGun" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="ProjelerDataList" runat="server" TypeName="DataProviderTanimlar" SelectMethod="GetProjeler" />

    <asp:ObjectDataSource ID="DanismanData" runat="server" TypeName="DataProviderTanimlar" SelectMethod="GetDanismanTanimlari" />

    <asp:ObjectDataSource ID="AllModulData" runat="server" TypeName="DataProviderTanimlar" SelectMethod="GetModuller" />
    <asp:ObjectDataSource ID="ModulData" runat="server" TypeName="DataProviderTanimlar" SelectMethod="GetModullerDanisman">
        <SelectParameters>
            <asp:Parameter Name="DanismanID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>








    <%--  DANIŞMANIN MODÜL TANIMLARI --%>


    <dx:ASPxGridView ID="ASPxGridView8" runat="server"
        AutoGenerateColumns="False"
        DataSourceID="DanismanModulTanimlariDataSource" KeyFieldName="ID"
        ClientInstanceName="ASPxGridView8"
        Width="100%">
        <SettingsPager PageSize="50" />
        <Paddings Padding="0px" />
        <Border BorderWidth="0px" />
        <BorderBottom BorderWidth="1px" />
        <Columns>

            <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" ShowDeleteButton="true" VisibleIndex="0" Width="6%">
                <HeaderTemplate>
                    <dx:ASPxButton runat="server" Text="Ekle" RenderMode="Link" AutoPostBack="false">
                        <ClientSideEvents Click="function(s,e){ ASPxGridView8.AddNewRow();  }" />
                    </dx:ASPxButton>
                </HeaderTemplate>
            </dx:GridViewCommandColumn>

            <dx:GridViewDataColumn FieldName="ID" Visible="false" SortOrder="Descending" />

            <dx:GridViewDataComboBoxColumn FieldName="DanismanID" Caption="Danışman Adı" Width="200">
                <PropertiesComboBox
                    DataSourceID="DanismannData"
                    ValueField="DanismanID"
                    ValueType="System.Int32"
                    TextField="DanismanAdi"
                    EnableSynchronization="False"
                    IncrementalFilteringMode="StartsWith">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn FieldName="ModulID" Caption="Modül Adı" Width="200">
                <PropertiesComboBox
                    DataSourceID="DanismanModulData"
                    ValueField="ModulID"
                    ValueType="System.Int32"
                    TextField="ModulAdi"
                    EnableSynchronization="False"
                    IncrementalFilteringMode="StartsWith">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

        </Columns>
        <SettingsEditing Mode="Inline" />
           <Settings ShowFooter="True" />
    </dx:ASPxGridView>

    <asp:ObjectDataSource ID="DanismanModulTanimlariDataSource" runat="server"
        TypeName="DataProviderTanimlar" SelectMethod="GetDanismanModulTanimlari"
        InsertMethod="InsertDanismanModulTanimlari"
        UpdateMethod="UpdateDanismanModulTanimlari"
        DeleteMethod="DeleteDanismanModulTanimlari">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Sil" Type="Boolean"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="DanismanID" Type="Int32" />
            <asp:Parameter Name="ModulID" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="DanismanID" Type="Int32" />
            <asp:Parameter Name="ModulID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="DanismannData" runat="server" TypeName="DataProviderTanimlar" SelectMethod="GetDanismanTanimlari" />
    <asp:ObjectDataSource ID="DanismanModulData" runat="server" TypeName="DataProviderTanimlar" SelectMethod="GetModuller" />


    <%--  KULLANICI TANIMLARI --%>
    <dx:ASPxGridView ID="ASPxGridView9" runat="server"
        AutoGenerateColumns="False"
        DataSourceID="KullaniciDataSource" KeyFieldName="UserID"
        ClientInstanceName="ASPxGridView9"
        Width="100%">
        <SettingsPager PageSize="50" />
        <Paddings Padding="0px" />
        <Border BorderWidth="0px" />
        <BorderBottom BorderWidth="1px" />
        <Columns>
            <dx:GridViewCommandColumn ShowEditButton="True" 
                ShowNewButtonInHeader="True" 
                VisibleIndex="0" Width="6%"> <%--ShowDeleteButton="true"--%>
                <HeaderTemplate>
                    <dx:ASPxButton runat="server" Text="Ekle" RenderMode="Link" AutoPostBack="false">
                        <ClientSideEvents Click="function(s,e){ ASPxGridView9.AddNewRow(); }" />
                    </dx:ASPxButton>
                </HeaderTemplate>
            </dx:GridViewCommandColumn>
            <dx:GridViewDataColumn FieldName="UserID" Visible="false" VisibleIndex="0" />
            <dx:GridViewDataTextColumn FieldName="UserName" SortOrder="Ascending" Caption="Kullanıcı Adı" Width="200" VisibleIndex="1">
                <PropertiesTextEdit>
                    <ValidationSettings ValidationGroup="RegisterUserValidationGroup">
                        <RequiredField ErrorText="User Name is required." IsRequired="true" />
                    </ValidationSettings>
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Email" Caption="E Posta" Width="200" VisibleIndex="2">
                <PropertiesTextEdit>
                    <ValidationSettings ValidationGroup="RegisterUserValidationGroup">
                        <RequiredField ErrorText="E-mail is required." IsRequired="true" />
                        <RegularExpression ErrorText="Email validation failed" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                    </ValidationSettings>
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
<%--            <dx:GridViewDataTextColumn FieldName="Password" Caption="Parola" Width="200" Visible="false" VisibleIndex="3">
                <EditFormSettings Visible="True" />
                <PropertiesTextEdit>
                    <ValidationSettings ValidationGroup="RegisterUserValidationGroup">
                        <RequiredField ErrorText="Password is required." IsRequired="true" />
                    </ValidationSettings>
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ConfirmPassword" UnboundType="String" Caption="Parola Tekrarı" Width="200" Visible="false" VisibleIndex="4">
                <EditFormSettings Visible="True" />
                <PropertiesTextEdit>
                    <ValidationSettings ValidationGroup="RegisterUserValidationGroup">
                        <RequiredField ErrorText="Confirm Password is required." IsRequired="true" />
                    </ValidationSettings>
                    <ClientSideEvents Validation="function(s, e) {
                var originalPasswd = Password.GetText();
                var currentPasswd = s.GetText();
                e.isValid = (originalPasswd  == currentPasswd );
                e.errorText = 'The Password and Confirmation Password must match.';
            }" />
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>--%>
            <dx:GridViewDataTextColumn FieldName="Password" Caption="Parola" VisibleIndex="3" Visible="false">
				<EditFormSettings Visible="True" />
                <PropertiesTextEdit Password="True" ClientInstanceName="psweditor">
                   
				</PropertiesTextEdit>
				<EditItemTemplate>
					<dx:ASPxTextBox ID="pswtextbox" runat="server" Text='<%# Bind("Password") %>'
						Visible='<%# ASPxGridView9.IsNewRowEditing %>' Password="True">
						<ClientSideEvents Validation="function(s,e){e.isValid = s.GetText()>5;}" />
					</dx:ASPxTextBox>
					<asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="popup.ShowAtElement(this); return false;" 
                        Visible='<%#!ASPxGridView9.IsNewRowEditing%>'>Parolayı değiştir</asp:LinkButton>
				</EditItemTemplate>
			</dx:GridViewDataTextColumn>
        </Columns>
        <SettingsEditing Mode="EditForm" />
           <Settings ShowFooter="True"  />
    </dx:ASPxGridView>

    <dx:ASPxPopupControl ID="ASPxPopupControl2" runat="server" HeaderText="Parola Değiştir" Width="407px" ClientInstanceName="popup">
				<ContentCollection>
					<dx:PopupControlContentControl ID="Popupcontrolcontentcontrol1" runat="server">
						<table>
							<tr>
								<td>Yeni Parola:</td>
								<td style="padding-left:20px;">
									<dx:ASPxTextBox ID="npsw" runat="server" Password="True" ClientInstanceName="npsw">
										<ClientSideEvents Validation="function(s, e) {e.isValid = (s.GetText().length&gt;0)}" />
										<ValidationSettings ErrorDisplayMode="ImageWithTooltip" ErrorText="The password lengt should be more that 6 symbols">
										</ValidationSettings>
									</dx:ASPxTextBox>
								</td>
							</tr>
							<tr>
								<td>Yeni Parolayı Tekrarla:</td>
								<td style="padding-left:20px;">
									<dx:ASPxTextBox ID="cnpsw" runat="server" Password="True" ClientInstanceName="cnpsw">
										<ClientSideEvents Validation="function(s, e) {e.isValid = (s.GetText() == npsw.GetText());}" />
										<ValidationSettings ErrorDisplayMode="ImageWithTooltip" ErrorText="The password is incorrect">
										</ValidationSettings>
									</dx:ASPxTextBox>
								</td>
							</tr>
						</table>
						<dx:ASPxButton ID="confirmButton" runat="server" Text="Güncelle" AutoPostBack="False" OnClick="confirmButton_Click">
						</dx:ASPxButton>

					</dx:PopupControlContentControl>
				</ContentCollection>
			</dx:ASPxPopupControl>

    <asp:ObjectDataSource ID="KullaniciDataSource" runat="server"
        TypeName="DataProviderTanimlar" SelectMethod="GetKullaniciTanimlari"
        InsertMethod="InsertKullanici" UpdateMethod="UpdateKullanici" DeleteMethod="DeleteKullanici">
        <DeleteParameters>
            <asp:Parameter Name="UserID" Type="String"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="Password" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="UserID" Type="String" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>



</asp:Content>
