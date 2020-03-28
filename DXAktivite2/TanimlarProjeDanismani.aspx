<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="TanimlarProjeDanismani.aspx.cs" Inherits="DXAktivite2.TanimlarProjeDanismani" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
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



</asp:Content>
