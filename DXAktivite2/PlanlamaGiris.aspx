<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="PlanlamaGiris.aspx.cs" Inherits="DXAktivite2.PlanlamaGiris" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function ProjelerCombo_SelectedIndexChanged(s, e) {
            ASPxGridView1.GetEditor("DanismanID").PerformCallback(s.GetValue());
        }
        function DanismanCombo_SelectedIndexChanged(s, e) {
            ASPxGridView1.GetEditor("ModulID").PerformCallback(s.GetValue());
        }
    </script>
    <%-- DXCOMMENT: Configure ASPxGridView control --%>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server"
        AutoGenerateColumns="False"
        DataSourceID="Planlama" KeyFieldName="ID"
        ClientInstanceName="ASPxGridView1"
        Width="100%"
        OnCellEditorInitialize="ASPxGridView1_CellEditorInitialize">
        <SettingsPager PageSize="20" />
        <Paddings Padding="0px" />
        <Border BorderWidth="0px" />
        <BorderBottom BorderWidth="1px" />
        <Toolbars>
            <dx:GridViewToolbar EnableAdaptivity="true">
                <Items>
                    <dx:GridViewToolbarItem Command="Custom" Text="Export To">
                        <Items>
                            <dx:GridViewToolbarItem Command="ExportToPdf" />
                            <dx:GridViewToolbarItem Command="ExportToXls" />
                            <dx:GridViewToolbarItem Command="ExportToXlsx" />
                            <dx:GridViewToolbarItem Command="ExportToDocx" />
                            <dx:GridViewToolbarItem Command="ExportToRtf" />
                            <dx:GridViewToolbarItem Command="ExportToCsv" />
                        </Items>
                    </dx:GridViewToolbarItem>
                    <dx:GridViewToolbarItem Command="ShowCustomizationDialog"></dx:GridViewToolbarItem>
                    <dx:GridViewToolbarItem Command="ShowCustomizationWindow"></dx:GridViewToolbarItem>
                    <dx:GridViewToolbarItem Command="ClearGrouping" />
                    <dx:GridViewToolbarItem Command="ClearSorting" />
                    <dx:GridViewToolbarItem Command="ShowGroupPanel" BeginGroup="true" />
                    <dx:GridViewToolbarItem Command="ShowSearchPanel" />
                    <dx:GridViewToolbarItem Command="Refresh" BeginGroup="true"></dx:GridViewToolbarItem>
                </Items>
            </dx:GridViewToolbar>
        </Toolbars>
        <Columns>

            <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" ShowDeleteButton="true" VisibleIndex="0" Width="6%">
                <HeaderTemplate>
                    <dx:ASPxButton runat="server" Text="Ekle" RenderMode="Link" AutoPostBack="false">
                        <ClientSideEvents Click="function(s,e){ ASPxGridView1.AddNewRow();  }" />
                    </dx:ASPxButton>
                </HeaderTemplate>
            </dx:GridViewCommandColumn>

            <dx:GridViewDataColumn FieldName="ID" Visible="false" SortOrder="Descending" />

            <dx:GridViewDataDateColumn FieldName="Tarih" VisibleIndex="1" Width="100" Settings-AllowHeaderFilter="True">
                <PropertiesDateEdit AllowUserInput="false" AllowNull="true">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>

            <dx:GridViewDataComboBoxColumn FieldName="ProjeID" Caption="Proje" Width="300" Settings-AllowHeaderFilter="True" SettingsHeaderFilter-Mode="CheckedList">
                <PropertiesComboBox
                    DataSourceID="ProjelerData"
                    ValueField="ProjeID"
                    ValueType="System.Int32"
                    TextField="ProjeAdi"
                    EnableSynchronization="False"
                    IncrementalFilteringMode="StartsWith">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                    <ClientSideEvents SelectedIndexChanged="ProjelerCombo_SelectedIndexChanged" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn FieldName="DanismanID" Caption="Danisman" Width="200" Settings-AllowHeaderFilter="True" SettingsHeaderFilter-Mode="CheckedList">
                <PropertiesComboBox
                    DataSourceID="AllDanismanlarData"
                    ValueField="DanismanID"
                    ValueType="System.Int32"
                    TextField="DanismanAdi"
                    EnableSynchronization="False"
                    IncrementalFilteringMode="StartsWith">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                    <ClientSideEvents SelectedIndexChanged="DanismanCombo_SelectedIndexChanged" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn FieldName="ModulID" Caption="Modül" Width="100" Settings-AllowHeaderFilter="True" SettingsHeaderFilter-Mode="CheckedList">
                <PropertiesComboBox
                    DataSourceID="AllModullerData"
                    ValueField="ModulID"
                    ValueType="System.Int32"
                    TextField="ModulAdi"
                    EnableSynchronization="False"
                    IncrementalFilteringMode="StartsWith">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataSpinEditColumn FieldName="Saat" Caption="Saat" Width="50">
                <PropertiesSpinEdit DisplayFormatInEditMode="true"></PropertiesSpinEdit>
            </dx:GridViewDataSpinEditColumn>

            <dx:GridViewDataTextColumn FieldName="Aciklama" Caption="Aciklama">
            </dx:GridViewDataTextColumn>

        </Columns>
        <SettingsEditing Mode="Inline" />
        <Settings ShowGroupPanel="true" ShowFooter="true" ShowHeaderFilterButton="true" ShowGroupFooter="VisibleIfExpanded" />
        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="WYSIWYG" />
    </dx:ASPxGridView>
    <asp:ObjectDataSource ID="Planlama" runat="server"
        TypeName="DataProvider"
        SelectMethod="GetPlanlamalarGiris"
        InsertMethod="InsertPlan"
        UpdateMethod="UpdatePlan"
        DeleteMethod="DeletePlan">

        <InsertParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="DanismanID" Type="Int32" />
            <asp:Parameter Name="Tarih" Type="String" />
            <asp:Parameter Name="ProjeID" Type="Int32" />
            <asp:Parameter Name="ModulID" Type="Int32" />
            <asp:Parameter Name="Aciklama" Type="String" />
            <asp:Parameter Name="Saat" Type="Decimal" />

        </InsertParameters>

        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="DanismanID" Type="Int32" />
            <asp:Parameter Name="Tarih" Type="String" />
            <asp:Parameter Name="ProjeID" Type="Int32" />
            <asp:Parameter Name="ModulID" Type="Int32" />
            <asp:Parameter Name="Aciklama" Type="String" />
            <asp:Parameter Name="Saat" Type="Decimal" />

        </UpdateParameters>

        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="Sil" Type="Boolean"></asp:Parameter>
        </DeleteParameters>

    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="ProjelerData" runat="server" TypeName="DataProvider" SelectMethod="GetProjeler" />

    <asp:ObjectDataSource ID="AllDanismanlarData" runat="server" TypeName="DataProvider" SelectMethod="GetDanismanlar" />
    <asp:ObjectDataSource ID="DanismanlarData" runat="server" TypeName="DataProvider" SelectMethod="GetDanismanlar">
        <SelectParameters>
            <asp:Parameter Name="ProjeID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="AllModullerData" runat="server" TypeName="DataProvider" SelectMethod="GetModullerDanisman" />
    <asp:ObjectDataSource ID="ModullerData" runat="server" TypeName="DataProvider" SelectMethod="GetModullerDanisman">
        <SelectParameters>
            <asp:Parameter Name="DanismanID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

</asp:Content>
