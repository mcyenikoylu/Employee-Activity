<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="CagriIstekleri.aspx.cs" Inherits="DXAktivite2.CagriIstekleri" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        var fileNumber = 0;
        var fileName = "";
        var startDate = null;
        function UploadControl_OnFileUploadStart() {
            startDate = new Date();
            ClearProgressInfo();
            pcProgress.Show();
        }
        function UploadControl_OnFilesUploadComplete(e) {
            pcProgress.Hide();
            if (e.errorText)
                ShowMessage(e.errorText);
            else if (e.callbackData == "success")
                ShowMessage("Dosya yüklemesi başarıyla tamamlandı.");

            location.reload();
        }
        function ShowMessage(message) {
            window.setTimeout(function () { window.alert(message); }, 0);
        }
        // Progress Dialog
        function UploadControl_OnUploadingProgressChanged(args) {
            if (!pcProgress.IsVisible())
                return;
            if (args.currentFileName != fileName) {
                fileName = args.currentFileName;
                fileNumber++;
            }
            SetCurrentFileUploadingProgress(args.currentFileName, args.currentFileUploadedContentLength, args.currentFileContentLength);
            progress1.SetPosition(args.currentFileProgress);
            SetTotalUploadingProgress(fileNumber, args.fileCount, args.uploadedContentLength, args.totalContentLength);
            progress2.SetPosition(args.progress);
            UpdateProgressStatus(args.uploadedContentLength, args.totalContentLength);
        }
        function SetCurrentFileUploadingProgress(fileName, uploadedLength, fileLength) {
            lblFileName.SetText("Mevcut Dosya İlerlemesi: " + fileName);
            lblFileName.GetMainElement().title = fileName;
            lblCurrentUploadedFileLength.SetText(GetContentLengthString(uploadedLength) + " / " + GetContentLengthString(fileLength));
        }
        function SetTotalUploadingProgress(number, count, uploadedLength, totalLength) {
            lblUploadedFiles.SetText("Toplam İlerleme: " + number + ' den ' + count + " dosya(lar)");
            lblUploadedFileLength.SetText(GetContentLengthString(uploadedLength) + " / " + GetContentLengthString(totalLength));
        }
        function ClearProgressInfo() {
            SetCurrentFileUploadingProgress("", 0, 0);
            progress1.SetPosition(0);
            SetTotalUploadingProgress(0, 0, 0, 0);
            progress2.SetPosition(0);
            lblProgressStatus.SetText('Elapsed time: 00:00:00 &ensp; Estimated time: 00:00:00 &ensp; Speed: ' + GetContentLengthString(0) + '/s');
            fileNumber = 0;
            fileName = "";
        }
        function UpdateProgressStatus(uploadedLength, totalLength) {
            var currentDate = new Date();
            var elapsedDateMilliseconds = currentDate - startDate;
            var speed = uploadedLength / (elapsedDateMilliseconds / 1000);
            var elapsedDate = new Date(elapsedDateMilliseconds);
            var elapsedTime = GetTimeString(elapsedDate);
            var estimatedMilliseconds = Math.floor((totalLength - uploadedLength) / speed) * 1000;
            var estimatedDate = new Date(estimatedMilliseconds);
            var estimatedTime = GetTimeString(estimatedDate);
            var speed = uploadedLength / (elapsedDateMilliseconds / 1000);
            lblProgressStatus.SetText('Geçen zaman: ' + elapsedTime + ' &ensp; Tahmini süre: ' + estimatedTime + ' &ensp; Hız: ' + GetContentLengthString(speed) + '/s');
        }
        function GetContentLengthString(contentLength) {
            var sizeDimensions = ['bytes', 'KB', 'MB', 'GB', 'TB'];
            var index = 0;
            var length = contentLength;
            var postfix = sizeDimensions[index];
            while (length > 1024) {
                length = length / 1024;
                postfix = sizeDimensions[++index];
            }
            var numberRegExpPattern = /[-+]?[0-9]*(?:\.|\,)[0-9]{0,2}|[0-9]{0,2}/;
            var results = numberRegExpPattern.exec(length);
            length = results ? results[0] : Math.floor(length);
            return length.toString() + ' ' + postfix;
        }
        function GetTimeString(date) {
            var timeRegExpPattern = /\d{1,2}:\d{1,2}:\d{1,2}/;
            var results = timeRegExpPattern.exec(date.toUTCString());
            return results ? results[0] : "00:00:00";
        }
    </script>
    <dx:ASPxFormLayout ID="flDateRangePicker" runat="server" ColCount="2"
        RequiredMarkDisplayMode="None" Visible="false">
        <SettingsItemCaptions Location="Top"></SettingsItemCaptions>
        <Items>
            <dx:LayoutGroup Caption="Dosya Aktarım İşlemleri" ColCount="2" GroupBoxDecoration="HeadingLine">
                <Items>
                    <dx:LayoutItem Caption="&nbsp;">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxUploadControl ID="UploadControl" runat="server" ClientInstanceName="UploadControl" Width="330" Height="50"
                                    NullText="Dosyalara göz atmak için buraya tıklayın..." UploadMode="Advanced" AutoStartUpload="True"
                                    OnFilesUploadComplete="UploadControl_FilesUploadComplete">
                                    <AdvancedModeSettings EnableMultiSelect="True" EnableDragAndDrop="True" />
                                    <ValidationSettings MaxFileSize="10000000" ShowErrors="false"></ValidationSettings>
                                    <ClientSideEvents FilesUploadStart="function(s, e) { UploadControl_OnFileUploadStart(); }"
                                        FilesUploadComplete="function(s, e) { UploadControl_OnFilesUploadComplete(e); }"
                                        UploadingProgressChanged="function(s, e) { UploadControl_OnUploadingProgressChanged(e); }" />
                                </dx:ASPxUploadControl>
                                <p class="Note">
                                    <b>Uyarı</b>: Yükleme için seçilen her dosyanın boyutu, 10 MB ile sınırlıdır.
                                </p>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                </Items>
            </dx:LayoutGroup>
            <dx:LayoutGroup Caption="Çağrı İstek İşlemleri" ColCount="2" GroupBoxDecoration="HeadingLine">
                <Items>
                    <dx:LayoutItem Caption="&nbsp;">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxButton ID="btnYonlendir" runat="server" Text="Seçilenleri Yönlendir" AutoPostBack="false" EnableViewState="false">
                                    <ClientSideEvents Click="function(s, e) {
                                        
                                        ASPxGridView1.GetSelectedFieldValues('ID', OnGetSelectedFieldValues);
                                        
                                        }" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <script type="text/javascript">
        function OnGetSelectedFieldValues(selectedValues) {
            if (selectedValues.length == 0)
            {
                alert('Seçili satır yok.');
            }
            else
            {
                ASPxCallback1.PerformCallback('secilenler');
                ASPxPopupControl2.Show();
            }
        }
        function ASPxGridView1_OnCustomButtonClick(s, e) {
            if (e.buttonID == 'btnDetay_Canli') {
                s.GetRowValues(e.visibleIndex, "ID;ExternalTicketNumber;AlternativeTicketNumber;IstekSirketAdi;IstekSahibiAdiSoyadi;IstekTarihiSaati;IstekAciklama", OnGetRowValues);
            }
            function OnGetRowValues(Value) {

                txtExternalTicketNumber.SetText(Value[1]);
                txtAlternativeTicketNumber.SetText(Value[2]);
                txtSirketAdi.SetText(Value[3]);
                txtIlgiliKisi.SetText(Value[4]);
                txtIstekTarihi.SetText(Value[5]);
                txtAciklama.SetText(Value[6]);
                ASPxPopupControl3.Show();
            }
            if (e.buttonID == 'btnCagriyiYakala') {
                s.GetRowValues(e.visibleIndex, "ID;ExternalTicketNumber", OnGetRowValues_CagriyiYakala);
                ASPxGridView1.Refresh();
            }
            function OnGetRowValues_CagriyiYakala(Value) {

                //ASPxCallback7.PerformCallback(Value[0]);
                //ASPxPopupControl4.Show();

                ASPxCallback3.PerformCallback(Value[0]);
            }
            if (e.buttonID == 'btnYonlendir_Canli') {
                s.GetRowValues(e.visibleIndex, "ID;IstekSirketAdi;IstekSahibiAdiSoyadi;", OnGetRowValues_CagriyiYonlendir);
            }
            function OnGetRowValues_CagriyiYonlendir(Value) {
                var deger = Value[0] + ';' + Value[1] + ';' + Value[2]
                ASPxCallback4.PerformCallback(deger);
                ASPxPopupControl2.Show();
                ASPxGridView1.Refresh();
            }
        }
        //function OnToolbarItemClick(s, e) {
        //    if (IsRefreshToolbarCommand(e.item.name)) {
        //        alert('asd');
        //        e.processOnServer = true;
        //        e.usePostBack = true;
        //    }

        //    //if (e.item.name == "Refresh") {
        //    //    //e.processOnServer = true;
        //    //    alert('qwe');
        //    //}
        //}
    </script>

    <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" ClientInstanceName="pcProgress" Modal="True" HeaderText="Dosya Aktarımı"
        PopupAnimationType="None" CloseAction="None" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="460px"
        AllowDragging="true" ShowPageScrollbarWhenModal="True" ShowCloseButton="False" ShowFooter="True">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server" SupportsDisabledAttribute="True">
                <table style="width: 100%;">
                    <tr>
                        <td style="width: 100%;">
                            <div style="overflow: hidden; width: 280px;">
                                <dx:ASPxLabel ID="lblFileName" runat="server" ClientInstanceName="lblFileName" Text=""
                                    Wrap="False">
                                </dx:ASPxLabel>
                            </div>
                        </td>
                        <td class="NoWrap" style="text-align: right">
                            <dx:ASPxLabel ID="lblCurrentUploadedFileLength" runat="server" ClientInstanceName="lblCurrentUploadedFileLength"
                                Text="" Wrap="False">
                            </dx:ASPxLabel>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="TopPadding">
                            <dx:ASPxProgressBar ID="ASPxProgressBar1" runat="server" Height="21px" Width="100%"
                                ClientInstanceName="progress1">
                            </dx:ASPxProgressBar>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="Spacer" style="height: 12px;"></div>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%;">
                            <dx:ASPxLabel ID="lblUploadedFiles" runat="server" ClientInstanceName="lblUploadedFiles" Text=""
                                Wrap="False">
                            </dx:ASPxLabel>
                        </td>
                        <td class="NoWrap" style="text-align: right">
                            <dx:ASPxLabel ID="lblUploadedFileLength" runat="server" ClientInstanceName="lblUploadedFileLength"
                                Text="" Wrap="False">
                            </dx:ASPxLabel>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="TopPadding">
                            <dx:ASPxProgressBar ID="ASPxProgressBar2" runat="server" CssClass="BottomMargin" Height="21px" Width="100%"
                                ClientInstanceName="progress2">
                            </dx:ASPxProgressBar>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="Spacer" style="height: 12px;"></div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <dx:ASPxLabel ID="lblProgressStatus" runat="server" ClientInstanceName="lblProgressStatus" Text=""
                                Wrap="False">
                            </dx:ASPxLabel>
                        </td>
                    </tr>
                </table>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <FooterTemplate>
            <div style="overflow: hidden;">
                <dx:ASPxButton ID="btnCancel" runat="server" AutoPostBack="False" Text="İptal" ClientInstanceName="btnCancel" Width="100px" Style="float: right">
                    <ClientSideEvents Click="function(s, e) { UploadControl.Cancel(); }" />
                </dx:ASPxButton>
            </div>
        </FooterTemplate>
        <FooterStyle>
            <Paddings Padding="5px" PaddingRight="10px" />
        </FooterStyle>
    </dx:ASPxPopupControl>
    
    <dx:ASPxCallback ID="ASPxCallback1"
        ClientInstanceName="ASPxCallback1"
        OnCallback="ASPxCallback1_Callback" runat="server">
    </dx:ASPxCallback>
      <dx:ASPxCallback ID="ASPxCallback7"
        ClientInstanceName="ASPxCallback7"
        OnCallback="ASPxCallback7_Callback" runat="server">
    </dx:ASPxCallback>
      <dx:ASPxCallback ID="ASPxCallback4"
        ClientInstanceName="ASPxCallback4"
        OnCallback="ASPxCallback4_Callback" runat="server">
    </dx:ASPxCallback>

    <style>
        .InlineButton {
            display: inline;
        }
    </style>

    <%-- ÇAĞRI İSTEKLERİM --%>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server"
        AutoGenerateColumns="False"
        DataSourceID="CagriIstekleriData" KeyFieldName="ID"
        ClientInstanceName="ASPxGridView1"
        Width="100%"
        Caption="ÇAĞRI İSTEKLERİ" 
        OnHtmlRowPrepared="ASPxGridView1_HtmlRowPrepared" OnToolbarItemClick="ASPxGridView1_ToolbarItemClick" >
        <SettingsPager PageSize="10" />
        <Paddings Padding="0px" />
        <Border BorderWidth="0px" />
        <BorderBottom BorderWidth="1px" />
        <ClientSideEvents CustomButtonClick="ASPxGridView1_OnCustomButtonClick" />
        <Toolbars>
            <dx:GridViewToolbar>
                <Items>
                    <dx:GridViewToolbarItem Command="Refresh" BeginGroup="true"></dx:GridViewToolbarItem>
                </Items>
            </dx:GridViewToolbar>
        </Toolbars>
        <Columns>
            <dx:GridViewCommandColumn VisibleIndex="0" Width="70px" MinWidth="60" ButtonType="Image" Caption=" ">
                <CellStyle VerticalAlign="Middle" />
                <CustomButtons>

                    <dx:GridViewCommandColumnCustomButton ID="btnCagriyiYakala">
                        <Styles>
                            <Style CssClass="InlineButton"></Style>
                        </Styles>
                        <Image ToolTip="Çağrıyı Yakala" Url="images/Backward_16x16.png" Height="16px" Width="16px" />
                    </dx:GridViewCommandColumnCustomButton>

                    <dx:GridViewCommandColumnCustomButton ID="btnDetay_Canli">
                        <Styles>
                            <Style CssClass="InlineButton"></Style>
                        </Styles>
                        <Image ToolTip="Detayları Aç" Url="images/Preview_16x16.png" Height="16px" Width="16px" />
                    </dx:GridViewCommandColumnCustomButton>

                    <dx:GridViewCommandColumnCustomButton ID="btnYonlendir_Canli">
                        <Styles>
                            <Style CssClass="InlineButton"></Style>
                        </Styles>
                        <Image ToolTip="Yönlendir" Url="images/Forward_16x16.png" Height="16px" Width="16px" />
                    </dx:GridViewCommandColumnCustomButton>

                </CustomButtons>
            </dx:GridViewCommandColumn>

            <dx:GridViewCommandColumn VisibleIndex="0" Width="30px" ShowSelectCheckbox="true" SelectAllCheckboxMode="Page">
            </dx:GridViewCommandColumn>

            <dx:GridViewDataColumn FieldName="ID" Visible="false" SortOrder="Descending" />

            <dx:GridViewDataTextColumn FieldName="ExternalTicketNumber" Caption="External Ticket Number" Width="150" VisibleIndex="0">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataDateColumn FieldName="IstekTarihiSaati" Caption="İstek Tarihi" VisibleIndex="1" Width="100" Settings-AllowHeaderFilter="True">
                <PropertiesDateEdit AllowUserInput="false" AllowNull="true">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>

            <dx:GridViewDataDateColumn FieldName="SistemKayitTarihiSaati" Caption="Sistem Kayıt Tarihi" VisibleIndex="1" Width="150" Settings-AllowHeaderFilter="True">
                <PropertiesDateEdit  AllowUserInput="false" AllowNull="true" DisplayFormatString="g">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>

            <dx:GridViewDataTextColumn FieldName="IstekSirketAdi" Caption="Şirket Adı" Width="150" VisibleIndex="2">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="IstekSahibiAdiSoyadi" Caption="İstek Sahibi" Width="150" VisibleIndex="3">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataComboBoxColumn FieldName="OnemDerecesi" Caption="Önem Derecesi" Width="100" VisibleIndex="4">
                <PropertiesComboBox 
                    DataSourceID="TipData" 
                    ValueField="ID" 
                    ValueType="System.Int32"
                    TextField="Aciklama" 
                    EnableSynchronization="False" 
                    IncrementalFilteringMode="StartsWith">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                    <DropDownButton Visible="False">
                    </DropDownButton>
                    <ClientSideEvents DropDown="function(s, e) {
                    s.HideDropDown();
                    }"
                    />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn FieldName="KaynakYoneticisiOnayi_TipID4" Caption="M.K.Y. Onay Durumu" Width="100" VisibleIndex="4">
                <PropertiesComboBox 
                    DataSourceID="TipData" 
                    ValueField="ID" 
                    ValueType="System.Int32"
                    TextField="Aciklama" 
                    EnableSynchronization="False" 
                    IncrementalFilteringMode="StartsWith">
                    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
                    <DropDownButton Visible="False">
                    </DropDownButton>
                    <ClientSideEvents DropDown="function(s, e) {
                    s.HideDropDown();
                    }"
                    />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataTextColumn FieldName="IstekAciklama" Caption="Aciklama" VisibleIndex="5">
            </dx:GridViewDataTextColumn>

        </Columns>

        <Settings ShowFooter="True" />
        <Settings ShowGroupPanel="true" ShowHeaderFilterButton="true" ShowFilterRowMenu="true" />
    </dx:ASPxGridView>

    <asp:ObjectDataSource ID="CagriIstekleriData" runat="server" TypeName="DataProvider" SelectMethod="GetCagriIstek" />
    <asp:ObjectDataSource ID="TipData" runat="server" TypeName="DataProvider" SelectMethod="GetTipler" />

    <dx:ASPxPopupControl ID="ASPxPopupControl2" runat="server" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="ASPxPopupControl2"
        HeaderText="Çağrıları Yönlendir" AllowDragging="True" PopupAnimationType="None" EnableViewState="False">
        <ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('entryGroupDanisman'); }" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <dx:ASPxPanel ID="ASPxPanel1" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <table>
                                <tr>
                                    <td rowspan="10">
                                        <div class="pcmSideSpacer">
                                        </div>
                                    </td>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="lblKullaniciAdi" runat="server" Text="Danışman Adı:" AssociatedControlID="cmbDanismanAdi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxComboBox ID="cmbDanismanAdi" runat="server" Width="200px"
                                            ClientInstanceName="cmbDanismanAdi" TextField="Aciklama" ValueField="ID">
                                            <ValidationSettings EnableCustomValidation="true" ValidationGroup="entryGroupDanisman" SetFocusOnError="true"
                                                ErrorDisplayMode="Text" ErrorTextPosition="Bottom" CausesValidation="true">
                                                <RequiredField ErrorText="Danışman seçiniz." IsRequired="true" />
                                                <RegularExpression ErrorText="Danışman adı seçiniz." />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                        </dx:ASPxComboBox>
                                    </td>
                                    <td rowspan="10">
                                        <div class="pcmSideSpacer">
                                        </div>
                                    </td>
                                </tr>

<%--                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="lblModul" runat="server" Text="Modül Adı:">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTokenBox ID="tbModul" runat="server" Width="200px"
                                            AllowMouseWheel="True" AllowCustomTokens="False">
                                        </dx:ASPxTokenBox>
                                    </td>
                                </tr>--%>

                                <tr>
                                    <td class="pcmCellCaption"></td>
                                    <td colspan="2">
                                        <div class="pcmButton">
                                            <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Kaydet" Width="80px"
                                                AutoPostBack="False" Style="float: left; margin-right: 8px">
                                                <ClientSideEvents Click="function(s, e) { if(ASPxClientEdit.ValidateGroup('entryGroupDanisman')) ASPxPopupControl2.Hide(); ASPxCallback2.PerformCallback(); ASPxGridView1.Refresh(); }" />
                                            </dx:ASPxButton>
                                            <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Vazgeç" Width="80px" AutoPostBack="False" Style="float: left; margin-right: 8px">
                                                <ClientSideEvents Click="function(s, e) { ASPxPopupControl2.Hide(); }" />
                                            </dx:ASPxButton>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxPanel>

            </dx:PopupControlContentControl>
        </ContentCollection>
        <ContentStyle>
            <Paddings PaddingBottom="5px" />
        </ContentStyle>
    </dx:ASPxPopupControl>
    
    <dx:ASPxCallback ID="ASPxCallback2"
        ClientInstanceName="ASPxCallback2"
        OnCallback="ASPxCallback2_Callback" runat="server">
    </dx:ASPxCallback>

    <dx:ASPxCallback ID="ASPxCallback3"
        ClientInstanceName="ASPxCallback3"
        OnCallback="ASPxCallback3_Callback" runat="server">
    </dx:ASPxCallback>

    <link type="text/css" rel="stylesheet" href="Content/ModalWindow.css" />
    <link type="text/css" rel="stylesheet" href="Content/CodeFormatter.css" />
    <link type="text/css" rel="stylesheet" href="Content/CustomButton.css" />

    <dx:ASPxPopupControl ID="ASPxPopupControl3" runat="server" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="ASPxPopupControl3"
        HeaderText="Çağrı Detayı" AllowDragging="True" PopupAnimationType="None" EnableViewState="False">
        <ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('entryGroupDanisman'); }" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <dx:ASPxPanel ID="ASPxPanel2" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <table>
                                <tr>
                                    <td rowspan="10">
                                        <div class="pcmSideSpacer">
                                        </div>
                                    </td>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="lblYeniDanismanAdi" runat="server" Text="External Ticket Number:" AssociatedControlID="txtExternalTicketNumber">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtExternalTicketNumber" runat="server" Width="200px" ClientInstanceName="txtExternalTicketNumber" ReadOnly="false">
                                        </dx:ASPxTextBox>
                                    </td>
                                    <td rowspan="10">
                                        <div class="pcmSideSpacer">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="lblAlternativeTicketNumber" runat="server" Text="Alternative Ticket Number:" AssociatedControlID="txtAlternativeTicketNumber">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtAlternativeTicketNumber" runat="server" Width="200px" ClientInstanceName="txtAlternativeTicketNumber" >
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                           
                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Şirket Adı:" AssociatedControlID="txtSirketAdi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtSirketAdi" runat="server" Width="200px" ClientInstanceName="txtSirketAdi" >
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                  <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="İlgili Kişi Adı:" AssociatedControlID="txtIlgiliKisi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtIlgiliKisi" runat="server" Width="200px" ClientInstanceName="txtIlgiliKisi" >
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                                     <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="İstek Tarihi:" AssociatedControlID="txtIstekTarihi">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxTextBox ID="txtIstekTarihi" runat="server" Width="200px" ClientInstanceName="txtIstekTarihi" >
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                         
                                                <tr>
                                    <td class="pcmCellCaption">
                                        <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Açıklama:" AssociatedControlID="txtAciklama">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td class="pcmCellText">
                                        <dx:ASPxMemo ID="txtAciklama" runat="server" Width="200px" Height="100px" ClientInstanceName="txtAciklama"></dx:ASPxMemo>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="pcmCellCaption"></td>
                                    <td colspan="2">
                                        <div class="pcmButton">
                                            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Kapat" Width="80px" AutoPostBack="False" Style="float: left; margin-right: 8px">
                                                <ClientSideEvents Click="function(s, e) { ASPxPopupControl3.Hide(); }" />
                                            </dx:ASPxButton>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxPanel>

            </dx:PopupControlContentControl>
        </ContentCollection>
        <ContentStyle>
            <Paddings PaddingBottom="5px" />
        </ContentStyle>
    </dx:ASPxPopupControl>

    <dx:ASPxPopupControl ID="ASPxPopupControl4" runat="server" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
    PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="ASPxPopupControl4"
    HeaderText="El ile Onay" AllowDragging="True" PopupAnimationType="None" EnableViewState="False">
        <ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('entryGroupDanisman'); }" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <dx:ASPxPanel ID="ASPxPanel4" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <table style="width:300px;" >
                                <tr>
                                    <td style="text-align:center; padding:20px 0 20px 0;" >
                                        Çağrıyı kendi üzerinize almak üzeresiniz.
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:center; padding:0 0 20px 0;">
                                        <dx:ASPxTokenBox ID="ASPxTokenBox1" runat="server" Width="200px" Caption="Modülleri seçin: "
                                            AllowMouseWheel="True" AllowCustomTokens="False">
                                        </dx:ASPxTokenBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:center" >
                                        <dx:ASPxButton ID="ASPxButton7" runat="server" Text="Evet" Width="80px"
                                            AutoPostBack="False" >
                                            <ClientSideEvents Click="function(s, e) { if(ASPxClientEdit.ValidateGroup('entryGroupDanisman')) ASPxPopupControl4.Hide(); ASPxCallback3.PerformCallback(); ASPxGridView1.Refresh(); }" />
                                        </dx:ASPxButton>
                                        <dx:ASPxButton ID="ASPxButton8" runat="server" Text="Vazgeç" Width="80px" AutoPostBack="False" >
                                            <ClientSideEvents Click="function(s, e) { ASPxPopupControl4.Hide(); }" />
                                        </dx:ASPxButton>
                                    </td>
                                </tr>
                            </table>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxPanel>

            </dx:PopupControlContentControl>
        </ContentCollection>
        <ContentStyle>
            <Paddings PaddingBottom="5px" />
        </ContentStyle>
    </dx:ASPxPopupControl>


</asp:Content>
