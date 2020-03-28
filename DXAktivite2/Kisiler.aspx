<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="Kisiler.aspx.cs" Inherits="DXAktivite2.Kisiler" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxCardView ID="ASPxCardView1" runat="server"
         DataSourceID="KisilerData" KeyFieldName="ID"
        EnableCardsCache="false" Width="100%">

           <SettingsPager>
            <SettingsTableLayout ColumnCount="2" RowsPerPage="3" />
        </SettingsPager>
        <Columns>
            <dx:CardViewTextColumn FieldName="ID" Visible="false" />
            <dx:CardViewBinaryImageColumn FieldName="Resim">
                <PropertiesBinaryImage ImageHeight="175px">
                    <EditingSettings Enabled="true" UploadSettings-UploadValidationSettings-MaxFileSize="4194304" />
                </PropertiesBinaryImage>
            </dx:CardViewBinaryImageColumn>
            <dx:CardViewTextColumn FieldName="AdiSoyadi" />
            <dx:CardViewTextColumn FieldName="MailAdresi" />
            <dx:CardViewTextColumn FieldName="Unvan" Caption="Ünvanı" />
            <dx:CardViewTextColumn FieldName="Tel" />
            <dx:CardViewComboBoxColumn FieldName="MusteriID" Caption="Müşteri">
                <PropertiesComboBox DataSourceID="MusteriData" ValueType="System.Int32" ValueField="MusteriID" TextField="MusteriAdi" />
            </dx:CardViewComboBoxColumn>
            <dx:CardViewComboBoxColumn FieldName="YukleniciID" Caption="Yüklenici">
                <PropertiesComboBox DataSourceID="YukleniciData" ValueType="System.Int32" ValueField="YukleniciID" TextField="YukleniciAdi" />
            </dx:CardViewComboBoxColumn>
            <dx:CardViewMemoColumn FieldName="NotAciklama" PropertiesMemoEdit-Height="80" />
        </Columns>
        <SettingsSearchPanel Visible="true" />
        <CardLayoutProperties ColCount="3">
            <Items>
                <%--<dx:CardViewCommandLayoutItem ShowEditButton="true" ColSpan="3" HorizontalAlign="Right" ShowNewButton="true" ShowDeleteButton="true" />--%>
                <dx:CardViewColumnLayoutItem ColumnName="Resim" ShowCaption="False" ColSpan="1" RowSpan="4"></dx:CardViewColumnLayoutItem>
                <dx:CardViewColumnLayoutItem ColumnName="AdiSoyadi" />
                <dx:CardViewColumnLayoutItem ColumnName="MailAdresi" />
                <dx:CardViewColumnLayoutItem ColumnName="Unvan" />
                <dx:CardViewColumnLayoutItem ColumnName="Tel" />
                <dx:CardViewColumnLayoutItem ColumnName="MusteriID" />
                <dx:CardViewColumnLayoutItem ColumnName="YukleniciID" />
                <dx:CardViewColumnLayoutItem ColumnName="NotAciklama" CaptionSettings-Location="Top" VerticalAlign="Top" ColSpan="2" />
                <dx:EditModeCommandLayoutItem HorizontalAlign="Right" ColSpan="3" />
            </Items>
        </CardLayoutProperties>
    </dx:ASPxCardView>
     <asp:ObjectDataSource ID="KisilerData" runat="server" TypeName="DataProvider" SelectMethod="GetKisiler" />
    <asp:ObjectDataSource ID="MusteriData" runat="server" TypeName="DataProvider" SelectMethod="GetMusteriKartlari" />
    <asp:ObjectDataSource ID="YukleniciData" runat="server" TypeName="DataProvider" SelectMethod="GetYukleniciKartlari" />

</asp:Content>
