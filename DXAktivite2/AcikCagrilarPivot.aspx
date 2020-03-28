﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="AcikCagrilarPivot.aspx.cs" Inherits="DXAktivite2.AcikCagrilarPivot" %>

<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v18.1, Version=18.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPivotGrid" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxPivotGrid ID="ASPxPivotGrid1" runat="server" ClientIDMode="AutoID" DataSourceID="AcikCagrilarimTumuData" OptionsPager-RowsPerPage="50">
        
        <Fields>
            <dx:PivotGridField FieldName="CagriIstekKayitTarihiSaati" ID="fieldCagriIstekKayitTarihiSaati" AreaIndex="0"></dx:PivotGridField>
            <dx:PivotGridField FieldName="IstekSahibiAdiSoyadi" ID="fieldIstekSahibiAdiSoyadi" AreaIndex="1"></dx:PivotGridField>
            <dx:PivotGridField FieldName="IstekTarihiSaati" ID="fieldIstekTarihiSaati" AreaIndex="2"></dx:PivotGridField>
            <dx:PivotGridField FieldName="IstekSirketAdi" ID="fieldIstekSirketAdi" AreaIndex="0" Area="ColumnArea"></dx:PivotGridField>
            <dx:PivotGridField FieldName="ModulAdi" ID="fieldModulAdi" AreaIndex="1" Area="RowArea"></dx:PivotGridField>
            <dx:PivotGridField FieldName="DanismanAdi" ID="fieldDanismanAdi" AreaIndex="1" Area="ColumnArea"></dx:PivotGridField>
            <dx:PivotGridField FieldName="YonlendirilenDanismanAdi" ID="fieldYonlendirilenDanismanAdi" AreaIndex="3"></dx:PivotGridField>
            <dx:PivotGridField FieldName="DurumAdi" ID="fieldDurumAdi" AreaIndex="0" Caption="Durum" Area="RowArea"></dx:PivotGridField>
        </Fields>
    </dx:ASPxPivotGrid>
    <asp:ObjectDataSource ID="AcikCagrilarimTumuData" runat="server" TypeName="DataProvider" SelectMethod="GetAcikCagrilarTumu" />
</asp:Content>
