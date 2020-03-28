namespace RouteServer
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.ribbonControl1 = new DevExpress.XtraBars.Ribbon.RibbonControl();
            this.btnBaslat = new DevExpress.XtraBars.BarButtonItem();
            this.btnDurdur = new DevExpress.XtraBars.BarButtonItem();
            this.ribbonPage1 = new DevExpress.XtraBars.Ribbon.RibbonPage();
            this.ribbonPageGroup1 = new DevExpress.XtraBars.Ribbon.RibbonPageGroup();
            this.ribbonStatusBar1 = new DevExpress.XtraBars.Ribbon.RibbonStatusBar();
            this.panelControl1 = new DevExpress.XtraEditors.PanelControl();
            this.marqueeProgressBarControl1 = new DevExpress.XtraEditors.MarqueeProgressBarControl();
            this.gridControl1 = new DevExpress.XtraGrid.GridControl();
            this.sZamanlanmisGorevlerResultBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.gridView1 = new DevExpress.XtraGrid.Views.Grid.GridView();
            this.colID = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colBaslik = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colAciklama = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colGorevTipi_TipID2 = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colSistemKayitTarihiSaati = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colOlusturanDanismanID = new DevExpress.XtraGrid.Columns.GridColumn();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.txtConsole = new DevExpress.XtraEditors.MemoEdit();
            ((System.ComponentModel.ISupportInitialize)(this.ribbonControl1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).BeginInit();
            this.panelControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.marqueeProgressBarControl1.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridControl1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.sZamanlanmisGorevlerResultBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtConsole.Properties)).BeginInit();
            this.SuspendLayout();
            // 
            // ribbonControl1
            // 
            this.ribbonControl1.ExpandCollapseItem.Id = 0;
            this.ribbonControl1.Items.AddRange(new DevExpress.XtraBars.BarItem[] {
            this.ribbonControl1.ExpandCollapseItem,
            this.btnBaslat,
            this.btnDurdur});
            this.ribbonControl1.Location = new System.Drawing.Point(0, 0);
            this.ribbonControl1.MaxItemId = 1;
            this.ribbonControl1.Name = "ribbonControl1";
            this.ribbonControl1.Pages.AddRange(new DevExpress.XtraBars.Ribbon.RibbonPage[] {
            this.ribbonPage1});
            this.ribbonControl1.RibbonStyle = DevExpress.XtraBars.Ribbon.RibbonControlStyle.Office2010;
            this.ribbonControl1.ShowApplicationButton = DevExpress.Utils.DefaultBoolean.False;
            this.ribbonControl1.ShowCategoryInCaption = false;
            this.ribbonControl1.ShowExpandCollapseButton = DevExpress.Utils.DefaultBoolean.False;
            this.ribbonControl1.ShowFullScreenButton = DevExpress.Utils.DefaultBoolean.False;
            this.ribbonControl1.ShowToolbarCustomizeItem = false;
            this.ribbonControl1.Size = new System.Drawing.Size(676, 143);
            this.ribbonControl1.StatusBar = this.ribbonStatusBar1;
            this.ribbonControl1.Toolbar.ShowCustomizeItem = false;
            this.ribbonControl1.Paint += new System.Windows.Forms.PaintEventHandler(this.ribbonControl1_Paint);
            // 
            // btnBaslat
            // 
            this.btnBaslat.Caption = "Başlat";
            this.btnBaslat.Glyph = ((System.Drawing.Image)(resources.GetObject("btnBaslat.Glyph")));
            this.btnBaslat.Id = 1;
            this.btnBaslat.LargeGlyph = ((System.Drawing.Image)(resources.GetObject("btnBaslat.LargeGlyph")));
            this.btnBaslat.Name = "btnBaslat";
            this.btnBaslat.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnBaslat_ItemClick);
            // 
            // btnDurdur
            // 
            this.btnDurdur.Caption = "Durdur";
            this.btnDurdur.Glyph = ((System.Drawing.Image)(resources.GetObject("btnDurdur.Glyph")));
            this.btnDurdur.Id = 2;
            this.btnDurdur.LargeGlyph = ((System.Drawing.Image)(resources.GetObject("btnDurdur.LargeGlyph")));
            this.btnDurdur.Name = "btnDurdur";
            this.btnDurdur.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnDurdur_ItemClick);
            // 
            // ribbonPage1
            // 
            this.ribbonPage1.Groups.AddRange(new DevExpress.XtraBars.Ribbon.RibbonPageGroup[] {
            this.ribbonPageGroup1});
            this.ribbonPage1.Name = "ribbonPage1";
            this.ribbonPage1.Text = "Zamanlanmış Görevler";
            // 
            // ribbonPageGroup1
            // 
            this.ribbonPageGroup1.ItemLinks.Add(this.btnBaslat);
            this.ribbonPageGroup1.ItemLinks.Add(this.btnDurdur);
            this.ribbonPageGroup1.Name = "ribbonPageGroup1";
            this.ribbonPageGroup1.Text = "Temel";
            // 
            // ribbonStatusBar1
            // 
            this.ribbonStatusBar1.Location = new System.Drawing.Point(0, 568);
            this.ribbonStatusBar1.Name = "ribbonStatusBar1";
            this.ribbonStatusBar1.Ribbon = this.ribbonControl1;
            this.ribbonStatusBar1.Size = new System.Drawing.Size(676, 31);
            // 
            // panelControl1
            // 
            this.panelControl1.Controls.Add(this.marqueeProgressBarControl1);
            this.panelControl1.Dock = System.Windows.Forms.DockStyle.Top;
            this.panelControl1.Location = new System.Drawing.Point(0, 143);
            this.panelControl1.Name = "panelControl1";
            this.panelControl1.Size = new System.Drawing.Size(676, 20);
            this.panelControl1.TabIndex = 2;
            // 
            // marqueeProgressBarControl1
            // 
            this.marqueeProgressBarControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.marqueeProgressBarControl1.EditValue = 0;
            this.marqueeProgressBarControl1.Location = new System.Drawing.Point(2, 2);
            this.marqueeProgressBarControl1.MenuManager = this.ribbonControl1;
            this.marqueeProgressBarControl1.Name = "marqueeProgressBarControl1";
            this.marqueeProgressBarControl1.Size = new System.Drawing.Size(672, 16);
            this.marqueeProgressBarControl1.TabIndex = 0;
            // 
            // gridControl1
            // 
            this.gridControl1.DataSource = this.sZamanlanmisGorevlerResultBindingSource;
            this.gridControl1.Dock = System.Windows.Forms.DockStyle.Top;
            this.gridControl1.Location = new System.Drawing.Point(0, 163);
            this.gridControl1.MainView = this.gridView1;
            this.gridControl1.MenuManager = this.ribbonControl1;
            this.gridControl1.Name = "gridControl1";
            this.gridControl1.Size = new System.Drawing.Size(676, 239);
            this.gridControl1.TabIndex = 3;
            this.gridControl1.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.gridView1});
            // 
            // sZamanlanmisGorevlerResultBindingSource
            // 
            this.sZamanlanmisGorevlerResultBindingSource.DataSource = typeof(RouteServer.S_ZamanlanmisGorevler_Result);
            // 
            // gridView1
            // 
            this.gridView1.Columns.AddRange(new DevExpress.XtraGrid.Columns.GridColumn[] {
            this.colID,
            this.colBaslik,
            this.colAciklama,
            this.colGorevTipi_TipID2,
            this.colSistemKayitTarihiSaati,
            this.colOlusturanDanismanID});
            this.gridView1.GridControl = this.gridControl1;
            this.gridView1.Name = "gridView1";
            this.gridView1.OptionsBehavior.Editable = false;
            this.gridView1.OptionsView.ShowGroupPanel = false;
            // 
            // colID
            // 
            this.colID.FieldName = "ID";
            this.colID.Name = "colID";
            this.colID.Visible = true;
            this.colID.VisibleIndex = 0;
            this.colID.Width = 40;
            // 
            // colBaslik
            // 
            this.colBaslik.FieldName = "Baslik";
            this.colBaslik.Name = "colBaslik";
            this.colBaslik.Visible = true;
            this.colBaslik.VisibleIndex = 1;
            this.colBaslik.Width = 136;
            // 
            // colAciklama
            // 
            this.colAciklama.FieldName = "Aciklama";
            this.colAciklama.Name = "colAciklama";
            this.colAciklama.Visible = true;
            this.colAciklama.VisibleIndex = 2;
            this.colAciklama.Width = 136;
            // 
            // colGorevTipi_TipID2
            // 
            this.colGorevTipi_TipID2.FieldName = "GorevTipi_TipID2";
            this.colGorevTipi_TipID2.Name = "colGorevTipi_TipID2";
            this.colGorevTipi_TipID2.Visible = true;
            this.colGorevTipi_TipID2.VisibleIndex = 5;
            this.colGorevTipi_TipID2.Width = 113;
            // 
            // colSistemKayitTarihiSaati
            // 
            this.colSistemKayitTarihiSaati.FieldName = "SistemKayitTarihiSaati";
            this.colSistemKayitTarihiSaati.Name = "colSistemKayitTarihiSaati";
            this.colSistemKayitTarihiSaati.Visible = true;
            this.colSistemKayitTarihiSaati.VisibleIndex = 4;
            this.colSistemKayitTarihiSaati.Width = 103;
            // 
            // colOlusturanDanismanID
            // 
            this.colOlusturanDanismanID.FieldName = "OlusturanDanismanID";
            this.colOlusturanDanismanID.Name = "colOlusturanDanismanID";
            this.colOlusturanDanismanID.Visible = true;
            this.colOlusturanDanismanID.VisibleIndex = 3;
            this.colOlusturanDanismanID.Width = 130;
            // 
            // timer1
            // 
            this.timer1.Interval = 10000;
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // txtConsole
            // 
            this.txtConsole.Dock = System.Windows.Forms.DockStyle.Fill;
            this.txtConsole.Location = new System.Drawing.Point(0, 402);
            this.txtConsole.MenuManager = this.ribbonControl1;
            this.txtConsole.Name = "txtConsole";
            this.txtConsole.Size = new System.Drawing.Size(676, 166);
            this.txtConsole.TabIndex = 6;
            // 
            // Form1
            // 
            this.AllowFormGlass = DevExpress.Utils.DefaultBoolean.False;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(676, 599);
            this.Controls.Add(this.txtConsole);
            this.Controls.Add(this.gridControl1);
            this.Controls.Add(this.panelControl1);
            this.Controls.Add(this.ribbonStatusBar1);
            this.Controls.Add(this.ribbonControl1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "Form1";
            this.Ribbon = this.ribbonControl1;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.StatusBar = this.ribbonStatusBar1;
            this.Text = "Route Server";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.ribbonControl1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).EndInit();
            this.panelControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.marqueeProgressBarControl1.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridControl1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.sZamanlanmisGorevlerResultBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtConsole.Properties)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DevExpress.XtraBars.Ribbon.RibbonControl ribbonControl1;
        private DevExpress.XtraBars.Ribbon.RibbonPage ribbonPage1;
        private DevExpress.XtraBars.Ribbon.RibbonPageGroup ribbonPageGroup1;
        private DevExpress.XtraBars.BarButtonItem btnBaslat;
        private DevExpress.XtraBars.BarButtonItem btnDurdur;
        private DevExpress.XtraBars.Ribbon.RibbonStatusBar ribbonStatusBar1;
        private DevExpress.XtraEditors.PanelControl panelControl1;
        private DevExpress.XtraGrid.GridControl gridControl1;
        private DevExpress.XtraGrid.Views.Grid.GridView gridView1;
        private System.Windows.Forms.Timer timer1;
        private DevExpress.XtraEditors.MarqueeProgressBarControl marqueeProgressBarControl1;
        private System.Windows.Forms.BindingSource sZamanlanmisGorevlerResultBindingSource;
        private DevExpress.XtraGrid.Columns.GridColumn colID;
        private DevExpress.XtraGrid.Columns.GridColumn colBaslik;
        private DevExpress.XtraGrid.Columns.GridColumn colAciklama;
        private DevExpress.XtraGrid.Columns.GridColumn colGorevTipi_TipID2;
        private DevExpress.XtraGrid.Columns.GridColumn colSistemKayitTarihiSaati;
        private DevExpress.XtraGrid.Columns.GridColumn colOlusturanDanismanID;
        public DevExpress.XtraEditors.MemoEdit txtConsole;
    }
}

