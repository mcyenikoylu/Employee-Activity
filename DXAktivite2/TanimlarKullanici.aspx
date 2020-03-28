<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="TanimlarKullanici.aspx.cs" Inherits="DXAktivite2.TanimlarKullanici" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
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
