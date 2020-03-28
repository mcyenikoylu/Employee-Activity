using DevExpress.Web;
using System;
//using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

//using DevExpress.XtraRichEdit;
//using DevExpress.Web.Office;
//using System.IO;
//using System.Text;
//using System.Data;

namespace DXAktivite2
{
    public partial class _Default : System.Web.UI.Page
    {
        AktiviteEntities db = new AktiviteEntities();
        //public static int kacinciHafta = 0;
        //DateTime gununTarihi = new DateTime();
        protected void Page_PreInit(object sender, EventArgs e)
        {
            HttpCookie c = Request.Cookies["theme"];
            if (c == null)
            {
                Guid userId = new Guid(Membership.GetUser().ProviderUserKey.ToString());
                var list = db.S_Ayarlar(userId).ToList();
                Genel.Theme = list.FirstOrDefault().Theme;
                Genel.BirGunKacSaat = Convert.ToInt32(list.FirstOrDefault().BirGunKacSaat);
            }
            ASPxWebControl.GlobalTheme = c == null ? Genel.Theme : c.Value;
        }
        protected void Page_Init(object sender, EventArgs e)
        {
            ContentPlaceHolder mpContentPlaceHolder;
            ASPxNavBar mpNavBar;
            //ASPxSplitter mpSplitter;
            ASPxPanel mpPanel;
            mpContentPlaceHolder = (ContentPlaceHolder)((ASPxPanel)this.Master.Master.FindControl("MainPane")).Controls[1];//.Panes.GetByName("Content").Controls[1];
            if (mpContentPlaceHolder != null)
            {
                mpPanel = (ASPxPanel)mpContentPlaceHolder.FindControl("LeftPane");
                mpNavBar = (ASPxNavBar)mpPanel.FindControl("ASPxNavBar1");
                if (mpNavBar != null)
                {
                    mpNavBar.DataBound += ASPxNavBar1_DataBound1;
                }
            }
            if (!IsPostBack)
            {
                //gununTarihi = DateTime.Now.Date;
                CultureInfo ciCurr = CultureInfo.CurrentCulture;
                //kacinciHafta = ciCurr.Calendar.GetWeekOfYear(gununTarihi, CalendarWeekRule.FirstFourDayWeek, DayOfWeek.Monday);
                Session["GriddeKacinciHafta"] = 0;
                //Session["GriddeKacinciHafta"] = kacinciHafta.ToString();
                Session["GriddeKacinciHafta"] = ciCurr.Calendar.GetWeekOfYear(DateTime.Now.Date, CalendarWeekRule.FirstFourDayWeek, DayOfWeek.Monday);
                Session["GridAktiviteIlkGun"] = "";
                Session["GridAktiviteSonGun"] = "";
                Session["GridPlanIlkGun"] = "";
                Session["GridPlanSonGun"] = "";
            }
        }
        protected void ASPxNavBar1_DataBound1(object sender, EventArgs e)
        {
            ASPxNavBar mpNavBar = (ASPxNavBar)sender;
            var list = db.S_KullaniciYetkileri(Genel.KullaniciGUID).ToList();
            if (list.Count > 0)
            {
                if (list.FirstOrDefault().RoleName == "Admin")
                {
                    //full açýk.
                }
                else if (list.FirstOrDefault().RoleName == "Danýþman")
                {
                    mpNavBar.Groups[1].Visible = false;
                    mpNavBar.Groups[2].Visible = false;
                }
                else if (list.FirstOrDefault().RoleName == "Proje Yöneticisi")
                {
                    mpNavBar.Groups[2].Visible = false;
                }

            }
            else
            {
                //kullanýcýnýn yetki tablosu (roles) boþ.
                mpNavBar.Groups[0].Visible = false;
                mpNavBar.Groups[1].Visible = false;
                mpNavBar.Groups[2].Visible = false;
                mpNavBar.Groups[3].Visible = false;
                mpNavBar.Groups[4].Visible = false;
                mpNavBar.Groups[5].Visible = false;
            }

            //çaðrý sistemi menüleri
            mpNavBar.Groups[3].Visible = false;
            mpNavBar.Groups[4].Visible = false;

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Guid userId = new Guid(Membership.GetUser().ProviderUserKey.ToString());
                Genel.KullaniciGUID = userId;
                Genel.KullaniciIDs = Membership.GetUser().ProviderUserKey.ToString();
                int danismanid = 0;
                var kullaniciJoinDanisman = db.S_Danisman(-1, userId).ToList();
                if (kullaniciJoinDanisman.Count > 0)
                    danismanid = kullaniciJoinDanisman.FirstOrDefault().ID;
                else
                {
                    //bir kullanýcýyý danýþman kaydý ile eþleþtiremediyse login sayfasýna geri atar.
                    FormsAuthentication.SignOut();
                    Session.Abandon();
                    Response.Redirect("~/Account/Login2.aspx");
                    return;
                }

                Genel.DanismanID = danismanid;

                //ASPxGridView1.SettingsPopup.HeaderFilter.Width = 360;
                //ASPxGridView1.SettingsPopup.HeaderFilter.Height = 450;
                ASPxGridView2.SettingsPopup.HeaderFilter.Width = 360;
                ASPxGridView2.SettingsPopup.HeaderFilter.Height = 450;

                DateTime i = Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, Convert.ToInt32(Session["GriddeKacinciHafta"]));
                DateTime s = Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, Convert.ToInt32(Session["GriddeKacinciHafta"])).AddDays(6);
                Session["GridAktiviteIlkGun"] = i;
                Session["GridAktiviteSonGun"] = s;
                Session["GridPlanIlkGun"] = i;
                Session["GridPlanSonGun"] = s;
                deStart.Value = i;
                deEnd.Value = s;
                Session["GridAktiviteGetirBtn"] = false;
                Session["GridPlanGetirBtn"] = false;


            }

            string a = "";
            if (Request.QueryString["Mod"] != null)
                a = Request.QueryString["Mod"].ToString();
            else
                Response.Redirect("/Default.aspx?Mod=P");

            if (Request.QueryString["Mod"] == "P")
            {
                //Planlarým
                flDateRangePicker.Visible = true;
               // ASPxGridView1.Visible = false;
                ASPxGridView2.Visible = true;
                DockPage.Visible = false;
                ASPxRichEdit1.Visible = false;
            }
            else if (Request.QueryString["Mod"] == "A")
            {
                //Aktivitelerim
                flDateRangePicker.Visible = true;
              //  ASPxGridView1.Visible = true;
                ASPxGridView2.Visible = false;
                DockPage.Visible = false;
                ASPxRichEdit1.Visible = false;

            }
            else if (Request.QueryString["Mod"] == "B")
            {
                //Belgelerim
             //   ASPxGridView1.Visible = false;
                ASPxGridView2.Visible = false;
                flDateRangePicker.Visible = false;
                DockPage.Visible = false;
                ASPxRichEdit1.Visible = true;

            }
            else if (Request.QueryString["Mod"] == "ProjeRaporum")
            {
                //Proje Raporum
             //   ASPxGridView1.Visible = false;
                ASPxGridView2.Visible = false;
                flDateRangePicker.Visible = false;
                DockPage.Visible = false;
                ASPxRichEdit1.Visible = false;

            }
            else if (Request.QueryString["Mod"] == "ModulRaporum")
            {
                //Modul Raporum
             //   ASPxGridView1.Visible = false;
                ASPxGridView2.Visible = false;
                flDateRangePicker.Visible = false;
                DockPage.Visible = false;
                ASPxRichEdit1.Visible = false;

            }
            //deEnd.DateRangeSettings.MinDayCount = Convert.ToInt32(seMinDayCount.Value);
            //int maxDayCount = Convert.ToInt32(seMaxDayCount.Value);
            //if (maxDayCount > 0 && maxDayCount < deEnd.DateRangeSettings.MinDayCount)
            //    maxDayCount = deEnd.DateRangeSettings.MinDayCount;
            //deEnd.DateRangeSettings.MaxDayCount = maxDayCount;
            //seMaxDayCount.Value = deEnd.DateRangeSettings.MaxDayCount;
            else if (Request.QueryString["Mod"] == "D")
            {
                //dashboard
             //   ASPxGridView1.Visible = false;
                ASPxGridView2.Visible = false;
                flDateRangePicker.Visible = false;

                string[] widgetNames = { "DateTime", "Mail", "News", "Trading", "Weather", "Calendar" };
                repeater.DataSource = widgetNames;
                repeater.DataBind();

                DockPage.Visible = true;
                ASPxRichEdit1.Visible = false;

            }

            
        }
        protected string GetClientButtonClickHandler(RepeaterItem container)
        {
            return string.Format("function(s, e) {{ ShowWidgetPanel('{0}') }}", container.DataItem);
        }
        //protected void ASPxGridView1_CellEditorInitialize(object sender, DevExpress.Web.ASPxGridViewEditorEventArgs e)
        //{
        //    //if (0 == (sender as ASPxGridView).VisibleRowCount)
        //    //{
        //    //    e.Editor.ReadOnly = false;//gridde hiç data olmadýðýnda yeni satýr eklemek istediðimde combobox içerisindeki deðerleri seçmiyor. tarih veya proje gibi. onun için bunu ekledim.
        //    //    if (e.Column.FieldName == "Tarih")
        //    //    {
        //    //        ((ASPxDateEdit)e.Editor).DisplayFormatString = "d";
        //    //        ((ASPxDateEdit)e.Editor).EditFormatString = "d";
        //    //    }
        //    //}

        //    if (e.Column.FieldName == "ModulID")
        //    {
        //        var combo = (ASPxComboBox)e.Editor;
        //        combo.Callback += new CallbackEventHandlerBase(combo_Callback);

        //        var grid = e.Column.Grid;
        //        if (!combo.IsCallback)
        //        {
        //            var countryID = -1;
        //            if (!grid.IsNewRowEditing)
        //                countryID = (int)grid.GetRowValues(e.VisibleIndex, "ProjeID");
        //            FillCitiesComboBox(combo, countryID);
        //        }
        //    }
        //}
        //private void combo_Callback(object sender, CallbackEventArgsBase e)
        //{
        //    var projeID = -1;
        //    Int32.TryParse(e.Parameter, out projeID);
        //    FillCitiesComboBox(sender as ASPxComboBox, projeID);
        //}
        //protected void FillCitiesComboBox(ASPxComboBox combo, int projeID)
        //{
        //    try
        //    {
        //        combo.DataSourceID = "ModullerData";
        //        ModullerData.SelectParameters["ProjeID"].DefaultValue = projeID.ToString();
        //        combo.DataBindItems();
        //        combo.Items.Insert(0, new ListEditItem("", null)); // Null Item
        //    }
        //    catch (Exception hata)
        //    {

        //    }
        //}
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (IsPostBack && ASPxEdit.ValidateEditorsInContainer(this))
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        @"<script type=""text/javascript"">alert('The form has been submitted successfully.');</script>");
        }
        protected void ASPxGridView2_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            //string hareketYonu = e.Parameters;

            //DateTime i = new DateTime();
            //DateTime s = new DateTime();

            //if (hareketYonu == "getir")
            //{
            //    i = Convert.ToDateTime(deStart.Value);
            //    s = Convert.ToDateTime(deEnd.Value);
            //}
            //else
            //{
            //    i = Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, kacinciHafta);
            //    s = Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, kacinciHafta).AddDays(6);
            //}

            (sender as ASPxGridView).DataSource = DataProvider.GetPlanlamalar();// (i, s);
            ASPxGridView2.DataSourceID = String.Empty;
            ASPxGridView2.DataBind();
        }
        protected void ASPxCallback1_Callback(object source, CallbackEventArgs e)
        {
            try
            {
                string hareketYonu = e.Parameter.ToString();
                if (hareketYonu == "" || hareketYonu == null)
                    return;

                DateTime i = new DateTime();
                DateTime s = new DateTime();

                //kacinciHafta = Convert.ToInt32(Session["GriddeKacinciHafta"]);
                int haftaninNumarasi = Convert.ToInt32(Session["GriddeKacinciHafta"]);
                if (hareketYonu == "sonraki")
                {
                    haftaninNumarasi++;
                    i = Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, haftaninNumarasi);
                    s = Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, haftaninNumarasi).AddDays(6);
                    Session["GridPlanIlkGun"] = i;
                    Session["GridPlanSonGun"] = s;
                }
                else if (hareketYonu == "onceki")
                {
                    haftaninNumarasi--;
                    i = Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, haftaninNumarasi);
                    s = Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, haftaninNumarasi).AddDays(6);
                    Session["GridPlanIlkGun"] = i;
                    Session["GridPlanSonGun"] = s;
                }
                else if (hareketYonu == "getir")
                {
                    i = Convert.ToDateTime(deStart.Value);
                    s = Convert.ToDateTime(deEnd.Value);
                    Session["GridPlanIlkGun"] = i;
                    Session["GridPlanSonGun"] = s;
                }
                Session["GriddeKacinciHafta"] = haftaninNumarasi;

                ASPxCallback1.JSProperties["cpBaslangicTarihi"] = string.Empty;
                ASPxCallback1.JSProperties["cpBitisTarihi"] = string.Empty;

                ASPxCallback1.JSProperties["cpBaslangicTarihi"] = i;
                ASPxCallback1.JSProperties["cpBitisTarihi"] = s;
            }
            catch (Exception)
            {

            }
        }
        //protected void ASPxGridView1_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        //{
        //    //string hareketYonu = e.Parameters;

        //    //DateTime i = new DateTime();
        //    //DateTime s = new DateTime();

        //    //if (hareketYonu == "getir")
        //    //{
        //    //    i = Convert.ToDateTime(deStart.Value);
        //    //    s = Convert.ToDateTime(deEnd.Value);
        //    //}
        //    //else
        //    //{
        //    //    i = Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, kacinciHafta);
        //    //    s = Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, kacinciHafta).AddDays(6);
        //    //}

        //    ////(sender as ASPxGridView).DataSource = DataProvider.GetAktiviteler(i, s);
        //    (sender as ASPxGridView).DataSource = DataProvider.GetAktiviteler();
        //    ASPxGridView1.DataSourceID = String.Empty;
        //    ASPxGridView1.DataBind();

        //    //int a = (sender as ASPxGridView).VisibleRowCount;
        //    //if(0 < (sender as ASPxGridView).VisibleRowCount)
        //    //{
        //    //    DataTable dt = new DataTable();
        //    //    foreach (GridViewColumn col in (sender as ASPxGridView).VisibleColumns)
        //    //    {
        //    //        GridViewDataColumn dataColumn = col as GridViewDataColumn;
        //    //        if (dataColumn == null) continue;
        //    //        dt.Columns.Add(dataColumn.FieldName);
        //    //    }
        //    //    for (int z = 0; z < (sender as ASPxGridView).VisibleRowCount; z++)
        //    //    {
        //    //        DataRow row = dt.Rows.Add();
        //    //        foreach (DataColumn col in dt.Columns)
        //    //            row[col.ColumnName] = (sender as ASPxGridView).GetRowValues(z, col.ColumnName);
        //    //    }

        //    //    int deger = Convert.ToInt32(dt.Rows[0].ItemArray[1]);
        //    //    if (deger != -1)
        //    //    {
        //    //        (sender as ASPxGridView).DataSource = DataProvider.GetAktiviteler();
        //    //        ASPxGridView1.DataSourceID = String.Empty;
        //    //        ASPxGridView1.DataBind();
        //    //    }
        //    //    else
        //    //    {
        //    //        (sender as ASPxGridView).DataSource = null;
        //    //        ASPxGridView1.DataSourceID = String.Empty;
        //    //        ASPxGridView1.DataBind();
        //    //    }
        //    //}
        //}


    }
}