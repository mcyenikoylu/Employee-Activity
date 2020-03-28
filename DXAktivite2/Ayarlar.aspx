<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="Ayarlar.aspx.cs" Inherits="DXAktivite2.Ayarlar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <%-- date ranger picker --%>
    <dx:ASPxFormLayout ID="flDateRangePicker" runat="server" ColCount="2" RequiredMarkDisplayMode="None" Visible="true">
        <SettingsItemCaptions Location="Top">
        </SettingsItemCaptions>
        <Items>
            <dx:LayoutGroup Caption="Görünüm" ColCount="3" GroupBoxDecoration="HeadingLine">
                <Items>
                    <dx:LayoutItem Caption="Başlangıç tarihi">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="ASPxComboBox1" runat="server" DataSourceID="dsThemes" 
                                    TextField="Title" ValueField="Name" ShowImageInEditBox="True" ImageUrlField="ImageUrl">
                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { ASPxClientUtils.SetCookie('theme', s.GetValue());}" />
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Duration" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="tbInfo" ClientInstanceName="tbInfo" runat="server" ReadOnly="True" Width="100">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="&nbsp;" ShowCaption="True">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Uygula">
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="&nbsp;" ShowCaption="True">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Kaydet" OnClick="ASPxButton2_Click">
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem ShowCaption="False" ColSpan="3" Height="10">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxValidationSummary ID="ASPxValidationSummary1" runat="server" ClientInstanceName="validationSummary" ShowErrorsInEditors="True">
                                </dx:ASPxValidationSummary>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <asp:XmlDataSource ID="dsThemes" runat="server" 
            DataFile="~/App_Data/Themes.xml" XPath="Themes/Theme"></asp:XmlDataSource>
    






















</asp:Content>
