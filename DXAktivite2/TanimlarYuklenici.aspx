<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="TanimlarYuklenici.aspx.cs" Inherits="DXAktivite2.TanimlarYuklenici" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <%-- YÜKLENİCİ --%>
    <dx:ASPxGridView ID="ASPxGridView3" runat="server"
        AutoGenerateColumns="False"
        DataSourceID="YukleniciDataSource" KeyFieldName="YukleniciID"
        ClientInstanceName="ASPxGridView3"
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
                        <ClientSideEvents Click="function(s,e){ ASPxGridView3.AddNewRow();}" />
                    </dx:ASPxButton>
                </HeaderTemplate>
            </dx:GridViewCommandColumn>
            <dx:GridViewDataColumn FieldName="YukleniciID" Visible="false" SortOrder="Descending" />
            <dx:GridViewDataTextColumn FieldName="YukleniciAdi" Caption="Aciklama" Width="200">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Sil" Caption="Sil" Visible="false">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsEditing Mode="Inline" />
           <Settings ShowFooter="True"  />
    </dx:ASPxGridView>

    <asp:ObjectDataSource ID="YukleniciDataSource" runat="server"
        TypeName="DataProviderTanimlar" SelectMethod="GetYukleniciTanimlari"
        InsertMethod="InsertYuklenici" UpdateMethod="UpdateYuklenici" DeleteMethod="DeleteYuklenici">
        <DeleteParameters>
            <asp:Parameter Name="YukleniciID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Sil" Type="Boolean"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="YukleniciID" Type="Int32" />
            <asp:Parameter Name="YukleniciAdi" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="YukleniciID" Type="Int32" />
            <asp:Parameter Name="YukleniciAdi" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>


</asp:Content>
