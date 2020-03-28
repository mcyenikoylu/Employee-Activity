<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Main.master" CodeBehind="Default.aspx.cs" Inherits="DXAktivite2._Default" %>
<%@ Register Assembly="DevExpress.Web.ASPxRichEdit.v18.1, Version=18.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxRichEdit" TagPrefix="dx" %>
<%@ Register Src="~/Widgets/DateTimeWidget.ascx" TagName="DateTime" TagPrefix="widget" %>
<%@ Register Src="~/Widgets/WeatherWidget/WeatherWidget.ascx" TagName="Weather" TagPrefix="widget" %>
<%@ Register Src="~/Widgets/MailWidget.ascx" TagName="Mail" TagPrefix="widget" %>
<%@ Register Src="~/Widgets/CalendarWidget.ascx" TagName="Calendar" TagPrefix="widget" %>
<%@ Register Src="~/Widgets/TradingWidget/TradingWidget.ascx" TagName="Trading" TagPrefix="widget" %>
<%@ Register Src="~/Widgets/NewsWidget.ascx" TagName="News" TagPrefix="widget" %>
<%@ Register Assembly="DevExpress.Web.v18.1, Version=18.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">
    
    <%-- date ranger picker --%>
    <dx:ASPxFormLayout ID="flDateRangePicker" runat="server" ColCount="2" 
        RequiredMarkDisplayMode="None" Visible="true">
        <SettingsItemCaptions Location="Top"></SettingsItemCaptions>
        <Items>
            <dx:LayoutGroup Caption="Tarih Aralýðý" ColCount="3" GroupBoxDecoration="HeadingLine"> 
                <Items>
                    <dx:LayoutItem Caption="Baþlangýç tarihi">
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
                    <dx:LayoutItem Caption="Bitiþ tarihi">
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
                                        if (window.location.search.indexOf('Mod=P') > -1) {
                                                    GridView2.PerformCallback('getir');
                                                } else {
                                                    ASPxGridView1.PerformCallback('getir');
                                                }
                                          }"/>
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
            <dx:LayoutGroup Caption="Hafta Aralýðý"  ColCount="2" GroupBoxDecoration="HeadingLine">
                <Items>
                    <dx:LayoutItem Caption="&nbsp;">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="btnOncekiHafta" runat="server" Text="<< Önceki Hafta" AutoPostBack="false" EnableViewState="false" >
                                    <ClientSideEvents Click="function(s, e) {ASPxCallback1.PerformCallback('onceki'); 
                                           if (window.location.search.indexOf('Mod=P') > -1) {
                                                    GridView2.PerformCallback('onceki');
                                                } else {
                                                    ASPxGridView1.PerformCallback('onceki');
                                                }
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
                                          if (window.location.search.indexOf('Mod=P') > -1) {
                                                    GridView2.PerformCallback('sonraki');
                                                } else {
                                                    ASPxGridView1.PerformCallback('sonraki');
                                                }
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


    <%-- PLANLAMALAR --%>
<dx:ASPxGridView ID="ASPxGridView2" runat="server" 
    AutoGenerateColumns="False" 
    DataSourceID="Planlamalar" KeyFieldName="ID" 
    ClientInstanceName="GridView2"
    Width="100%"
    OnCustomCallback="ASPxGridView2_CustomCallback"
    EnableViewState="false">  
    <SettingsPager PageSize="20" />
    <Paddings Padding="0px" />
    <Border BorderWidth="0px" />
    <BorderBottom BorderWidth="1px" />
    <Columns>
        <dx:GridViewDataColumn FieldName="ID" Visible="false" SortOrder="Descending" VisibleIndex="0" />

        <dx:GridViewDataDateColumn FieldName="Tarih" VisibleIndex="1" Width="100" Settings-AllowHeaderFilter="True" SettingsHeaderFilter-Mode="DateRangePicker">
            <PropertiesDateEdit  >
                <DropDownButton Visible="False">
                </DropDownButton>
                <ClientSideEvents DropDown="function(s, e) {
                    s.HideDropDown();
                }"
                />
            </PropertiesDateEdit>
        </dx:GridViewDataDateColumn>

        <dx:GridViewDataComboBoxColumn FieldName="ProjeID" Caption="Proje" Width="300" VisibleIndex="2" Settings-AllowHeaderFilter="True" SettingsHeaderFilter-Mode="CheckedList">
            <PropertiesComboBox 
                DataSourceID="ProjelerData" 
                ValueField="ProjeID" 
                ValueType="System.Int32"
                TextField="ProjeAdi" 
                EnableSynchronization="False" 
                IncrementalFilteringMode="StartsWith">
                <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
            </PropertiesComboBox>
        </dx:GridViewDataComboBoxColumn>

        <dx:GridViewDataComboBoxColumn FieldName="MusteriLokasyonID" Caption="Lokasyon" Width="200" VisibleIndex="3" Settings-AllowHeaderFilter="True" SettingsHeaderFilter-Mode="CheckedList">
            <PropertiesComboBox 
                DataSourceID="MusteriLokasyonData" 
                ValueField="LokasyonID" 
                ValueType="System.Int32"
                TextField="LokasyonAdi" 
                EnableSynchronization="False" 
                IncrementalFilteringMode="StartsWith">
                <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
            </PropertiesComboBox>
        </dx:GridViewDataComboBoxColumn>

        <dx:GridViewDataTextColumn FieldName="DanismanID" Caption="DanismanID" Width="200" Visible="false" VisibleIndex="3" Settings-AllowHeaderFilter="True" SettingsHeaderFilter-Mode="CheckedList">
        </dx:GridViewDataTextColumn>

        <dx:GridViewDataComboBoxColumn FieldName="ModulID" Caption="Modül"  Width="100" VisibleIndex="4" Settings-AllowHeaderFilter="True" SettingsHeaderFilter-Mode="CheckedList">
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

        <dx:GridViewDataComboBoxColumn FieldName="YukleniciID" Caption="Yüklenici"  Width="100" VisibleIndex="5" Settings-AllowHeaderFilter="True" SettingsHeaderFilter-Mode="CheckedList">
            <PropertiesComboBox 
                DataSourceID="YukleniciData" 
                ValueField="YukleniciID" 
                ValueType="System.Int32"
                TextField="YukleniciAdi" 
                EnableSynchronization="False" 
                IncrementalFilteringMode="StartsWith">
                <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
            </PropertiesComboBox>
        </dx:GridViewDataComboBoxColumn>

        <dx:GridViewDataComboBoxColumn FieldName="MusteriID" Caption="Müþteri"  Width="100" VisibleIndex="6" Settings-AllowHeaderFilter="True" SettingsHeaderFilter-Mode="CheckedList">
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

        <dx:GridViewDataTextColumn FieldName="Saat" Caption="Saat" Width="50" VisibleIndex="7">
        </dx:GridViewDataTextColumn>

        <dx:GridViewDataTextColumn FieldName="Aciklama" Caption="Açýklama" VisibleIndex="8">
        </dx:GridViewDataTextColumn>


    </Columns>
    <SettingsEditing Mode="Inline" />
    <Settings ShowFooter="True"  />

</dx:ASPxGridView>

<asp:ObjectDataSource ID="Planlamalar" runat="server" 
    TypeName="DataProvider" SelectMethod="GetPlanlamalar">  
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="MusteriLokasyonData" runat="server" 
    TypeName="DataProvider" SelectMethod="GetLokasyonlar"> 
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="MusteriData" runat="server" 
    TypeName="DataProvider" SelectMethod="GetMusteriler"> 
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="YukleniciData" runat="server" 
TypeName="DataProvider" SelectMethod="GetYukleniciler"> 
</asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ProjelerData" runat="server" TypeName="DataProvider" SelectMethod="GetProjeler" />
<asp:ObjectDataSource ID="AllModullerData" runat="server" TypeName="DataProvider" SelectMethod="GetModuller" />
<asp:ObjectDataSource ID="ModullerData" runat="server" TypeName="DataProvider" SelectMethod="GetModuller">
<SelectParameters>
    <asp:Parameter Name="ProjeID" Type="Int32" />
</SelectParameters>
</asp:ObjectDataSource>


    <%-- DASHBOARD --%>
        <script type="text/javascript">
    // <![CDATA[
        function ShowWidgetPanel(widgetPanelUID) {
            var panel = dockManager.GetPanelByUID(widgetPanelUID);
            panel.Show();
        }
        function SetWidgetButtonVisible(widgetName, visible) {
            var button = ASPxClientControl.GetControlCollection().GetByName('widgetButton_' + widgetName);
            button.GetMainElement().className = visible ? '' : 'disabled';
        }
     // ]]>
    </script>

    <link href="CSS/Widgets.css" rel="Stylesheet" type="text/css" />

        <div id="DockPage" runat="server">
        <dx:ASPxDockManager runat="server" ID="ASPxDockManager" ClientInstanceName="dockManager">
            <ClientSideEvents PanelShown="function(s, e) { SetWidgetButtonVisible(e.panel.panelUID, false) }"
                PanelCloseUp="function(s, e) { SetWidgetButtonVisible(e.panel.panelUID, true) }" />
        </dx:ASPxDockManager>
        <dx:ASPxDockPanel runat="server" ID="DateTimePanel" PanelUID="DateTime" HeaderText="Date & Time"
            Height="120px" Left="820" Top="220" ClientInstanceName="dateTimePanel">
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <widget:DateTime ID="DateTimeWidget" runat="server" />
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxDockPanel>
        <dx:ASPxDockPanel runat="server" ID="WeatherPanel" PanelUID="Weather" HeaderText="Weather"
            Width="275px" Height="200px" OwnerZoneUID="RightZone" VisibleIndex="0" ClientInstanceName="weatherPanel"
            ShowOnPageLoad="false">
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <widget:Weather runat="server" ID="WeatherWidget" />
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxDockPanel>
        <dx:ASPxDockPanel runat="server" ID="MailPanel" PanelUID="Mail" HeaderText="Mail"
            OwnerZoneUID="LeftZone" VisibleIndex="0" ClientInstanceName="mailPanel">
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <widget:Mail runat="server" ID="MailWidget" />
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxDockPanel>
        <dx:ASPxDockPanel runat="server" ID="CalendarPanel" PanelUID="Calendar" HeaderText="Calendar"
            Width="275px" OwnerZoneUID="LeftZone" VisibleIndex="1" ClientInstanceName="calendarPanel">
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <widget:Calendar runat="server" ID="CalendarWidget" />
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxDockPanel>
        <dx:ASPxDockPanel runat="server" ID="TradingPanel" PanelUID="Trading" HeaderText="Trading"
            Width="400px" Height="150px" AllowResize="true" OwnerZoneUID="LeftZone" ClientInstanceName="tradingPanel"
            ShowOnPageLoad="false">
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <widget:Trading runat="server" ID="TradingWidget" />
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxDockPanel>
        <dx:ASPxDockPanel runat="server" ID="NewsPanel" PanelUID="News" HeaderText="News"
            Width="400px" AllowResize="true" OwnerZoneUID="RightZone" VisibleIndex="1" ClientInstanceName="newsPanel"
            ShowOnPageLoad="false">
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <widget:News runat="server" ID="NewsWidget" />
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxDockPanel>
        <div class="widgetPanel">
            <asp:Repeater runat="server" ID="repeater">
                <ItemTemplate>
                    <dx:ASPxImage runat="server" ImageUrl='<%# string.Format("~/images/Widgets/{0}.png", Container.DataItem) %>'
                        Cursor="pointer" ClientInstanceName='<%# "widgetButton_" + Container.DataItem %>'
                        ToolTip='<%# "Show " + Container.DataItem %>' ClientSideEvents-Click='<%# GetClientButtonClickHandler(Container) %>'>
                    </dx:ASPxImage>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <dx:ASPxDockZone runat="server" ID="ASPxDockZone1" ZoneUID="LeftZone" CssClass="leftZone"
            Width="297px" PanelSpacing="3">
        </dx:ASPxDockZone>
        <dx:ASPxDockZone runat="server" ID="ASPxDockZone2" ZoneUID="RightZone" CssClass="rightZone"
            Width="400px" PanelSpacing="3">
        </dx:ASPxDockZone>
    </div>

    <dx:ASPxRichEdit ID="ASPxRichEdit1" runat="server" WorkDirectory="~\App_Data\WorkDirectory" Width="100%" Height="800"></dx:ASPxRichEdit>


</asp:Content>