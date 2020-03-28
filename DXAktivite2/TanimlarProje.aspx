<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="TanimlarProje.aspx.cs" Inherits="DXAktivite2.TanimlarProje" %>
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
        <dx:ASPxGridView ID="ASPxGridView6" runat="server"
        AutoGenerateColumns="False"
        DataSourceID="ProjelerDataSource" KeyFieldName="ID"
        ClientInstanceName="ASPxGridView6"
        Width="100%"
        OnCellEditorInitialize="ASPxGridView6_CellEditorInitialize" >
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


</asp:Content>
