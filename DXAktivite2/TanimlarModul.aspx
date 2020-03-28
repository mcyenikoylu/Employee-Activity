<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="TanimlarModul.aspx.cs" Inherits="DXAktivite2.TanimlarModul" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <%-- MODÜL --%>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server"
        AutoGenerateColumns="False"
        DataSourceID="ModullerDataSource" KeyFieldName="ModulID"
        ClientInstanceName="ASPxGridView1"
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
                        <ClientSideEvents Click="function(s,e){ASPxGridView1.AddNewRow();}" />
                    </dx:ASPxButton>
                </HeaderTemplate>
            </dx:GridViewCommandColumn>
            <dx:GridViewDataColumn FieldName="ModulID" Visible="false" SortOrder="Descending" />
            <dx:GridViewDataTextColumn FieldName="ModulAdi" Caption="Aciklama" Width="200">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Sil" Caption="Sil" Visible="false">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsEditing Mode="Inline" />
           <Settings ShowFooter="True"  />
    </dx:ASPxGridView>

    <asp:ObjectDataSource ID="ModullerDataSource" runat="server"
        TypeName="DataProviderTanimlar" SelectMethod="GetModuller"
        InsertMethod="InsertModul" UpdateMethod="UpdateModul" DeleteMethod="DeleteModul">
        <DeleteParameters>
            <asp:Parameter Name="ModulID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Sil" Type="Boolean"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ModulID" Type="Int32" />
            <asp:Parameter Name="ModulAdi" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ModulID" Type="Int32" />
            <asp:Parameter Name="ModulAdi" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>


</asp:Content>
