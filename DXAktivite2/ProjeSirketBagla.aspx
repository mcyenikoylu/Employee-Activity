<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="ProjeSirketBagla.aspx.cs" Inherits="DXAktivite2.ProjeSirketBagla" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <dx:ASPxGridView ID="ASPxGridView7" runat="server"
        AutoGenerateColumns="False"
        DataSourceID="ProjeSirketDatasource" KeyFieldName="ID"
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

            <dx:GridViewDataColumn FieldName="ID" Visible="false"/>

            <dx:GridViewDataComboBoxColumn FieldName="ProjeID" Caption="Proje Adı" Width="50%">
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

            <dx:GridViewDataComboBoxColumn FieldName="SirketID" Caption="Şirket Adı" Width="50%">
                <PropertiesComboBox
                    DataSourceID="SirketlerDataList"
                    ValueField="SirketId"
                    ValueType="System.Guid"
                    TextField="SirketAdi"
                    EnableSynchronization="False"
                    IncrementalFilteringMode="StartsWith">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

        </Columns>
        <SettingsEditing Mode="Inline" />
           <Settings ShowFooter="True"  />
    </dx:ASPxGridView>
    <asp:ObjectDataSource ID="ProjelerDataList" runat="server" TypeName="DataProviderTanimlar" SelectMethod="GetProjeler" />
    <asp:ObjectDataSource ID="ProjeSirketDatasource" runat="server" TypeName="DataProvider" SelectMethod="GetProjeyeSirketBagla"
        InsertMethod="InsertProjeSirket"
        UpdateMethod="UpdateProjeSirket"
        DeleteMethod="DeleteProjeSirket">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ProjeID" Type="Int32" />
            <asp:Parameter Name="SirketId" Type="Empty" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="ProjeID" Type="Int32" />
            <asp:Parameter Name="SirketId" Type="Empty" />
        </UpdateParameters>
        </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="SirketlerDataList" runat="server" TypeName="DataProviderTanimlar" SelectMethod="GetSirketler" />

</asp:Content>
