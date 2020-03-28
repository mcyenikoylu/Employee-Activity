<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="Aktivitelerim.aspx.cs" Inherits="DXAktivite2.Aktivitelerim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <dx:ASPxFormLayout ID="flDateRangePicker" runat="server" ColCount="2" 
        RequiredMarkDisplayMode="None" Visible="true">
        <SettingsItemCaptions Location="Top"></SettingsItemCaptions>
        <Items>
            <dx:LayoutGroup Caption="Tarih Aralığı" ColCount="3" GroupBoxDecoration="HeadingLine">
                <Items>
                    <dx:LayoutItem Caption="Başlangıç tarihi">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="deStart" ClientInstanceName="deStart" runat="server" AutoPostBack="false" >
                                    <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                        <RequiredField IsRequired="True" ErrorText="Start date is required"></RequiredField>
                                    </ValidationSettings>
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Bitiş tarihi">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="deEnd" ClientInstanceName="deEnd" runat="server" >
                                    <DateRangeSettings StartDateEditID="deStart"></DateRangeSettings>
                                    <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                        <RequiredField IsRequired="True" ErrorText="End date is required"></RequiredField>
                                    </ValidationSettings>
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="&nbsp;" ShowCaption="True">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="btnSubmit" runat="server" Text="Getir" AutoPostBack="false" EnableViewState="false">
                                    <ClientSideEvents Click="function(s, e) { ASPxCallback1.PerformCallback('getir'); 
                                      ASPxGridView1.PerformCallback('getir');
                                          }"/>
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
            <dx:LayoutGroup Caption="Hafta Aralığı"  ColCount="2" GroupBoxDecoration="HeadingLine">
                <Items>
                    <dx:LayoutItem Caption="&nbsp;">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="btnOncekiHafta" runat="server" Text="<< Önceki Hafta" AutoPostBack="false" EnableViewState="false" >
                                    <ClientSideEvents Click="function(s, e) {ASPxCallback1.PerformCallback('onceki'); 
                                          ASPxGridView1.PerformCallback('onceki');
                                        }"/>
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="&nbsp;">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="btnSonrakiHafta" runat="server" Text="Sonraki Hafta >>" AutoPostBack="false" EnableViewState="false" >
                                    <ClientSideEvents Click="function(s, e) {ASPxCallback1.PerformCallback('sonraki'); 
                                        ASPxGridView1.PerformCallback('sonraki');
                                        }"/>
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>

       <dx:ASPxCallback ID="ASPxCallback1" 
            ClientInstanceName="ASPxCallback1" 
            OnCallback="ASPxCallback1_Callback" runat="server">
            <ClientSideEvents 
                BeginCallback="function(s, e) {}" 
                CallbackComplete="function(s, e) {}" 
                EndCallback="function(s, e) { deStart.SetValue(s.cpBaslangicTarihi); deEnd.SetValue(s.cpBitisTarihi); }" />
        </dx:ASPxCallback>

       <script type="text/javascript">
        function ProjelerCombo_SelectedIndexChanged(s, e) {
            ASPxGridView1.GetEditor("ModulID").PerformCallback(s.GetValue());
        }
    </script>

        <dx:ASPxGridView ID="ASPxGridView1" runat="server" 
    AutoGenerateColumns="False" 
    DataSourceID="Aktiviteler" KeyFieldName="ID" 
    ClientInstanceName="ASPxGridView1"
    Width="100%"  
    OnCellEditorInitialize="ASPxGridView1_CellEditorInitialize" 
            OnCustomCallback="ASPxGridView1_CustomCallback"
    >
    <SettingsPager PageSize="50" />
    <Paddings Padding="0px" />
    <Border BorderWidth="0px" />
    <BorderBottom BorderWidth="1px" />
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
            <PropertiesDateEdit  AllowUserInput="false" AllowNull="true" >
            </PropertiesDateEdit>
        </dx:GridViewDataDateColumn>

         <dx:GridViewDataComboBoxColumn FieldName="ProjeID" Caption="Proje" Width="300" Settings-AllowHeaderFilter="True">
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

        <dx:GridViewDataComboBoxColumn FieldName="ModulID" Caption="Modül"  Width="100" Settings-AllowHeaderFilter="True">
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

        <dx:GridViewDataTextColumn FieldName="DanismanID" Caption="DanismanID" Width="200" Visible="false" Settings-AllowHeaderFilter="True">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataSpinEditColumn FieldName="Saat" Caption="Saat" Width="50">
            <PropertiesSpinEdit DisplayFormatInEditMode="true"></PropertiesSpinEdit>
        </dx:GridViewDataSpinEditColumn>
        <dx:GridViewDataTextColumn FieldName="Aciklama" Caption="Aciklama">
        </dx:GridViewDataTextColumn>

    </Columns>
    <SettingsEditing Mode="Inline" />
         <Settings ShowFooter="True" />
</dx:ASPxGridView>
    
    <asp:ObjectDataSource ID="Aktiviteler" runat="server" 
    TypeName="DataProvider" 
    SelectMethod="GetAktiviteler"
    InsertMethod="InsertAktivite" 
    UpdateMethod="UpdateAktivite"
    DeleteMethod="DeleteAktivite"
 > 
    <InsertParameters>
        <asp:Parameter Name="ID" Type="Int32" />
        <asp:Parameter Name="Tarih" Type="String" />
        <asp:Parameter Name="ProjeID" Type="Int32" />
        <asp:Parameter Name="ModulID" Type="Int32" />
        <asp:Parameter Name="Aciklama" Type="String" />
        <asp:Parameter Name="Saat" Type="Decimal" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="ID" Type="Int32" />
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

<asp:ObjectDataSource ID="ProjelerData" runat="server" TypeName="DataProvider" SelectMethod="GetAktiviteGirisi" />
<asp:ObjectDataSource ID="AllModullerData" runat="server" TypeName="DataProvider" SelectMethod="GetAktiviteGirisindeYetkiliOlduguProjeninModulleri" />
<asp:ObjectDataSource ID="ModullerData" runat="server" TypeName="DataProvider" SelectMethod="GetAktiviteGirisindeYetkiliOlduguProjeninModulleri">
<SelectParameters>
    <asp:Parameter Name="ProjeID" Type="Int32" />
</SelectParameters>
</asp:ObjectDataSource>
</asp:Content>
