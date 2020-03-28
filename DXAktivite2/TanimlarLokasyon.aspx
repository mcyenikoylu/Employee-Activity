<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="TanimlarLokasyon.aspx.cs" Inherits="DXAktivite2.TanimlarLokasyon" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
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




</asp:Content>
