<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="TanimlarDanismanModul.aspx.cs" Inherits="DXAktivite2.TanimlarDanismanModul" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
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

</asp:Content>
