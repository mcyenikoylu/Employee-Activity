<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="TanimlarMusteri.aspx.cs" Inherits="DXAktivite2.TanimlarMusteri" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <%-- MÜŞTERİ --%>
    <dx:ASPxGridView ID="ASPxGridView4" runat="server"
        AutoGenerateColumns="False"
        DataSourceID="MusteriDataSource" KeyFieldName="MusteriID"
        ClientInstanceName="ASPxGridView4"
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
                        <ClientSideEvents Click="function(s,e){ ASPxGridView4.AddNewRow();}" />
                    </dx:ASPxButton>
                </HeaderTemplate>
            </dx:GridViewCommandColumn>
            <dx:GridViewDataColumn FieldName="MusteriID" Visible="false" SortOrder="Descending" />
            <dx:GridViewDataTextColumn FieldName="MusteriAdi" Caption="Aciklama" Width="200">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Sil" Caption="Sil" Visible="false">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsEditing Mode="Inline" />
           <Settings ShowFooter="True"  />
    </dx:ASPxGridView>

    <asp:ObjectDataSource ID="MusteriDataSource" runat="server"
        TypeName="DataProviderTanimlar" SelectMethod="GetMusteriTanimlari"
        InsertMethod="InsertMusteri" UpdateMethod="UpdateMusteri" DeleteMethod="DeleteMusteri">
        <DeleteParameters>
            <asp:Parameter Name="MusteriID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Sil" Type="Boolean"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="MusteriID" Type="Int32" />
            <asp:Parameter Name="MusteriAdi" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="MusteriID" Type="Int32" />
            <asp:Parameter Name="MusteriAdi" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>



</asp:Content>
