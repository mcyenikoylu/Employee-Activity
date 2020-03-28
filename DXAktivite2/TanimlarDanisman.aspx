<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="TanimlarDanisman.aspx.cs" Inherits="DXAktivite2.TanimlarDanisman" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <%-- DANIŞMAN --%>

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
