<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="TanimlarProjeWizard.aspx.cs" Inherits="DXAktivite2.TanimlarProjeWizard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
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


</asp:Content>
