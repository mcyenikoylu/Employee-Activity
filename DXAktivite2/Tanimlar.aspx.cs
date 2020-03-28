using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DXAktivite2
{
    public partial class Tanimlar : System.Web.UI.Page
    {
        AktiviteEntities db = new AktiviteEntities();
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
            ASPxPanel mpPanel;
            mpContentPlaceHolder = (ContentPlaceHolder)((ASPxPanel)this.Master.Master.FindControl("MainPane")).Controls[1];
            if (mpContentPlaceHolder != null)
            {
                mpPanel = (ASPxPanel)mpContentPlaceHolder.FindControl("LeftPane");
                mpNavBar = (ASPxNavBar)mpPanel.FindControl("ASPxNavBar1");
                if (mpNavBar != null)
                {
                    mpNavBar.DataBound += ASPxNavBar1_DataBound1;
                }
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
                    //full açık.
                }
                else if (list.FirstOrDefault().RoleName == "Danışman")
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
                //kullanıcının yetki tablosu (roles) boş.
                mpNavBar.Groups[0].Visible = false;
                mpNavBar.Groups[1].Visible = false;
                mpNavBar.Groups[2].Visible = false;
                mpNavBar.Groups[3].Visible = false;
                mpNavBar.Groups[4].Visible = false;
                mpNavBar.Groups[5].Visible = false;
            }

            //çağrı sistemi menüleri
            mpNavBar.Groups[3].Visible = false;
            mpNavBar.Groups[4].Visible = false;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            string a = "";
            if (Request.QueryString["Mod"] != null)
                a = Request.QueryString["Mod"].ToString();
            else
                Response.Redirect("/Tanimlar.aspx?Mod=Modul");

            if (Request.QueryString["Mod"] == "Modul")
            {
                //modül
                ASPxGridView1.Visible = true;
                ASPxGridView2.Visible = false;
                ASPxGridView3.Visible = false;
                ASPxGridView4.Visible = false;
                ASPxGridView5.Visible = false;
                ASPxGridView6.Visible = false;
                ASPxGridView7.Visible = false;
                ASPxGridView8.Visible = false;
                flProjeWizardPaneli.Visible = false;
                flDanismanWizardPaneli.Visible = false;
                ASPxGridView9.Visible = false;
            }
            else if (Request.QueryString["Mod"] == "Danisman")
            {
                //danişman
                ASPxGridView1.Visible = false;
                ASPxGridView2.Visible = true;
                ASPxGridView3.Visible = false;
                ASPxGridView4.Visible = false;
                ASPxGridView5.Visible = false;
                ASPxGridView6.Visible = false;
                ASPxGridView7.Visible = false;
                ASPxGridView8.Visible = false;
                flProjeWizardPaneli.Visible = false;
                flDanismanWizardPaneli.Visible = false;
                ASPxGridView9.Visible = false;

            }
            else if (Request.QueryString["Mod"] == "DanismanModul")
            {
                //danişman
                ASPxGridView1.Visible = false;
                ASPxGridView2.Visible = false;
                ASPxGridView3.Visible = false;
                ASPxGridView4.Visible = false;
                ASPxGridView5.Visible = false;
                ASPxGridView6.Visible = false;
                ASPxGridView7.Visible = false;
                ASPxGridView8.Visible = true;
                flProjeWizardPaneli.Visible = false;
                flDanismanWizardPaneli.Visible = false;
                ASPxGridView9.Visible = false;

            }
            else if (Request.QueryString["Mod"] == "Yuklenici")
            {
                //yüklenici
                ASPxGridView1.Visible = false;
                ASPxGridView2.Visible = false;
                ASPxGridView3.Visible = true;
                ASPxGridView4.Visible = false;
                ASPxGridView5.Visible = false;
                ASPxGridView6.Visible = false;
                ASPxGridView7.Visible = false;
                ASPxGridView8.Visible = false;
                flProjeWizardPaneli.Visible = false;
                flDanismanWizardPaneli.Visible = false;
                ASPxGridView9.Visible = false;

            }
            else if (Request.QueryString["Mod"] == "Musteri")
            {
                //müşteri
                ASPxGridView1.Visible = false;
                ASPxGridView2.Visible = false;
                ASPxGridView3.Visible = false;
                ASPxGridView4.Visible = true;
                ASPxGridView5.Visible = false;
                ASPxGridView6.Visible = false;
                ASPxGridView7.Visible = false;
                ASPxGridView8.Visible = false;
                flProjeWizardPaneli.Visible = false;
                flDanismanWizardPaneli.Visible = false;
                ASPxGridView9.Visible = false;

            }
            else if (Request.QueryString["Mod"] == "Lokasyon")
            {
                //lokasyon
                ASPxGridView1.Visible = false;
                ASPxGridView2.Visible = false;
                ASPxGridView3.Visible = false;
                ASPxGridView4.Visible = false;
                ASPxGridView5.Visible = true;
                ASPxGridView6.Visible = false;
                ASPxGridView7.Visible = false;
                ASPxGridView8.Visible = false;
                flProjeWizardPaneli.Visible = false;
                flDanismanWizardPaneli.Visible = false;
                ASPxGridView9.Visible = false;

            }
            else if (Request.QueryString["Mod"] == "Proje")
            {
                //proje
                ASPxGridView1.Visible = false;
                ASPxGridView2.Visible = false;
                ASPxGridView3.Visible = false;
                ASPxGridView4.Visible = false;
                ASPxGridView5.Visible = false;
                ASPxGridView6.Visible = true;
                ASPxGridView7.Visible = false;
                ASPxGridView8.Visible = false;
                flProjeWizardPaneli.Visible = false;
                flDanismanWizardPaneli.Visible = false;
                ASPxGridView9.Visible = false;

            }
            else if (Request.QueryString["Mod"] == "ProjeDanismani")
            {
                //proje danışmanları
                ASPxGridView1.Visible = false;
                ASPxGridView2.Visible = false;
                ASPxGridView3.Visible = false;
                ASPxGridView4.Visible = false;
                ASPxGridView5.Visible = false;
                ASPxGridView6.Visible = false;
                ASPxGridView7.Visible = true;
                ASPxGridView8.Visible = false;
                flProjeWizardPaneli.Visible = false;
                flDanismanWizardPaneli.Visible = false;

                ASPxGridView9.Visible = false;

            }
            else if (Request.QueryString["Mod"] == "ProjeWizard")
            {
                //proje wizard
                ASPxGridView1.Visible = false;
                ASPxGridView2.Visible = false;
                ASPxGridView3.Visible = false;
                ASPxGridView4.Visible = false;
                ASPxGridView5.Visible = false;
                ASPxGridView6.Visible = true;
                ASPxGridView7.Visible = false;
                ASPxGridView8.Visible = false;

                //var column = (GridViewCommandColumn)ASPxGridView6.Columns[0];
                //column.ShowNewButtonInHeader = false;

                //(ASPxGridView6.Columns["CommandColumn"] as GridViewCommandColumn).ShowNewButtonInHeader = false;

                //(ASPxGridView6.Columns[0] as GridViewCommandColumn).ShowNewButtonInHeader = ASPxGridView6.Columns[0].Visible == false;
                flProjeWizardPaneli.Visible = true;
                //Utils.RegisterCssLink(this, "~/Content/ModalWindow.css");
                //Tokens.Items.Add("text1", 1);
                //Tokens.Items.Add("text2", 2);
                var list_danismanModul = db.S_DanismanModulTokenBox(-1).ToList();
                if (list_danismanModul.Count > 0)
                {
                    foreach (var item in list_danismanModul)
                    {
                        tbDanismanAdi.Items.Add(item.DanismanModulAdi, item.ID);
                        //checkListBox.
                    }
                }

                //ASPxListBox list = ((ASPxListBox)ASPxDropDownEdit1.FindControl("listBox"));
                //list.DataSource = list_danismanModul;
                //list.DataBindItems();

                var list_musteri = db.S_MusteriTanimlari(-1).ToList();
                if (list_musteri.Count > 0)
                {
                    CmbCountry.DataSource = list_musteri;
                    CmbCountry.DataBind();
                }

                var list_yuklenici = db.S_YukleniciTanimlari(-1).ToList();
                if (list_musteri.Count > 0)
                {
                    tbYukleniciAdi.DataSource = list_yuklenici;
                    tbYukleniciAdi.DataBind();
                }

                chbYuklenici.Checked = true;

                flDanismanWizardPaneli.Visible = false;
                ASPxGridView9.Visible = false;

            }
            else if (Request.QueryString["Mod"] == "DanismanWizard")
            {
                //danişman
                ASPxGridView1.Visible = false;
                ASPxGridView2.Visible = true;
                ASPxGridView3.Visible = false;
                ASPxGridView4.Visible = false;
                ASPxGridView5.Visible = false;
                ASPxGridView6.Visible = false;
                ASPxGridView7.Visible = false;
                ASPxGridView8.Visible = false;
                flProjeWizardPaneli.Visible = false;
                flDanismanWizardPaneli.Visible = true;

                var list_Kullanici = db.S_Kullanici("").ToList();
                if (list_Kullanici.Count > 0)
                {
                    cmbKullaniciAdi.DataSource = list_Kullanici;
                    cmbKullaniciAdi.DataBind();
                }
                ASPxGridView9.Visible = false;

                var list_Modul = db.S_Modul(-1).ToList();
                if (list_Modul.Count > 0)
                {
                    foreach (var item in list_Modul)
                    {
                        //tbDanismanAdi.Items.Add(item.DanismanModulAdi, item.ID);
                        tbModul.Items.Add(item.ModulAdi, item.ModulID);
                    }
                }
            }
            else if (Request.QueryString["Mod"] == "Kullanici")
            {
                ASPxGridView1.Visible = false;
                ASPxGridView2.Visible = false;
                ASPxGridView3.Visible = false;
                ASPxGridView4.Visible = false;
                ASPxGridView5.Visible = false;
                ASPxGridView6.Visible = false;
                ASPxGridView7.Visible = false;
                ASPxGridView8.Visible = false;
                flProjeWizardPaneli.Visible = false;
                flDanismanWizardPaneli.Visible = false;
                ASPxGridView9.Visible = true;
            }



        }
        protected void CmbCity_Callback(object source, CallbackEventArgsBase e)
        {
            FillCityCombo(e.Parameter);
        }
        protected void FillCityCombo(string countryName)
        {
            if (string.IsNullOrEmpty(countryName)) return;

            //using (var context = new WorldCitiesContext())
            //{
            //var country = context.Countries.SingleOrDefault(c => c.CountryName == countryName);
            var country = db.S_MusteriTanimlari(Convert.ToInt32(countryName)).ToList();
            //CmbCity.DataSource = context.Cities.Where(c => c.Country.CountryName == countryName).OrderBy(c => c.CityName).ToList();
            CmbCity.DataSource = db.S_MusteriLokasyon(Convert.ToInt32(country.FirstOrDefault().MusteriID)).OrderBy(c => c.Aciklama).ToList();
            CmbCity.DataBind();
            //CmbCity.Value = country.City.CityName;
            CmbCity.Value = country.FirstOrDefault().MusteriID;
            //}
        }

        protected void ASPxGridView6_CellEditorInitialize(object sender, DevExpress.Web.ASPxGridViewEditorEventArgs e)
        {
            if (e.Column.FieldName == "LokasyonID")
            {
                var combo = (ASPxComboBox)e.Editor;
                combo.Callback += new CallbackEventHandlerBase(combo_Callback);

                var grid = e.Column.Grid;
                if (!combo.IsCallback)
                {
                    var countryID = -1;
                    if (!grid.IsNewRowEditing)
                        countryID = (int)grid.GetRowValues(e.VisibleIndex, "MusteriID");
                    FillCitiesComboBox(combo, countryID);
                }
            }



        }

        private void combo_Callback(object sender, CallbackEventArgsBase e)
        {
            var projeID = -1;
            Int32.TryParse(e.Parameter, out projeID);
            FillCitiesComboBox(sender as ASPxComboBox, projeID);
        }

        protected void FillCitiesComboBox(ASPxComboBox combo, int projeID)
        {
            try
            {
                combo.DataSourceID = "LokasyonlarData";
                LokasyonlarData.SelectParameters["MusteriID"].DefaultValue = projeID.ToString();
                combo.DataBindItems();
                combo.Items.Insert(0, new ListEditItem("", null)); // Null Item
            }
            catch (Exception hata)
            {

            }
        }
        //PROJE DANIŞMANLARI TANIMLARI
        protected void ASPxGridView7_CellEditorInitialize(object sender, DevExpress.Web.ASPxGridViewEditorEventArgs e)
        {
            if (e.Column.FieldName == "ModulID")
            {
                var combo = (ASPxComboBox)e.Editor;
                combo.Callback += new CallbackEventHandlerBase(combo_Callback7);

                var grid = e.Column.Grid;
                if (!combo.IsCallback)
                {
                    var countryID = -1;
                    if (!grid.IsNewRowEditing)
                        countryID = (int)grid.GetRowValues(e.VisibleIndex, "DanismanID");
                    FillCitiesComboBox7(combo, countryID);
                }
            }
        }
        private void combo_Callback7(object sender, CallbackEventArgsBase e)
        {
            var projeID = -1;
            Int32.TryParse(e.Parameter, out projeID);
            FillCitiesComboBox7(sender as ASPxComboBox, projeID);
        }
        protected void FillCitiesComboBox7(ASPxComboBox combo, int projeID)
        {
            try
            {
                combo.DataSourceID = "ModulData";
                ModulData.SelectParameters["DanismanID"].DefaultValue = projeID.ToString();
                combo.DataBindItems();
                combo.Items.Insert(0, new ListEditItem("", null)); // Null Item
            }
            catch (Exception hata)
            {

            }
        }

        protected void ASPxGridView6_Init(object sender, EventArgs e)
        {
            //ASPxGridView grid = sender as ASPxGridView;
            //foreach (GridViewColumn col in grid.Columns)
            //{
            //    if (col is GridViewCommandColumn) // && !Page.User.IsInRole("manager")
            //    {
            //        (col as GridViewCommandColumn).ShowNewButtonInHeader = false;
            //        //break;
            //    }
            //}

            //(sender as GridViewCommandColumn) col = ASPxGridView6.Columns["CommandColumn"] as GridViewCommandColumn;
            //col.ShowNewButtonInHeader = false;

            //GridViewCommandColumn column = ASPxGridView6.Columns[0] as GridViewCommandColumn;
            //column.ShowNewButtonInHeader = false;
        }

        protected void ASPxGridView6_DataBound(object sender, EventArgs e)
        {
            //ASPxGridView grid = sender as ASPxGridView;
            //(grid.Columns["CommandColumn"] as GridViewCommandColumn).ShowNewButtonInHeader = false;

            //ASPxGridView grid = sender as ASPxGridView;
            //(grid.Columns[0] as GridViewCommandColumn).ShowNewButtonInHeader = false;

            //GridViewCommandColumn col = ASPxGridView6.Columns["cmnd"] as GridViewCommandColumn;
            //col.ShowNewButtonInHeader = !col.ShowNewButtonInHeader;



        }

        protected void ASPxCallback1_Callback(object source, CallbackEventArgs e)
        {
            //proje wizard

            //ASPxListBox list = ((ASPxListBox)ASPxDropDownEdit1.FindControl("listBox"));
            ////var asd = list.Value.ToString();
            //var zxc = ASPxDropDownEdit1.Text;


            var value = tbDanismanAdi.Value;
            //foreach (var item in tbDanismanAdi.Value)
            //{

            //}

            var projekodu = tbProjeKodu.Value;
            var projeadi = tbProjeAdi.Value;
            var musteriadi = CmbCountry.Value;
            var musterilokasyon = CmbCity.Value;
            var yuklenici = chbYuklenici.Value;
            var yukleniciadi = tbYukleniciAdi.Value;

            //var list = db.IUD_ProjelerWizard(-1, projeadi.ToString(),
            //    projekodu.ToString(),
            //    Convert.ToInt32(musteriadi),
            //    Convert.ToInt32(musterilokasyon),
            //    Convert.ToBoolean(yuklenici),
            //    Convert.ToInt32(yukleniciadi),
            //    false,
            //    value.ToString()).ToList();

            //ASPxGridView6.DataSource = DataProviderTanimlar.GetProjeler();
            //ASPxGridView6.DataSourceID = String.Empty;
            //ASPxGridView6.DataBound();
            //DataProviderTanimlar.GetProjeler();

            //(source as ASPxGridView).DataSource = DataProviderTanimlar.GetProjeler();
            //ASPxGridView6.DataSourceID = String.Empty;

            DataProviderTanimlar.InsertProjelerWizard(
                projeadi.ToString(),
                projekodu.ToString(),
               Convert.ToInt32(musteriadi),
              Convert.ToInt32(musterilokasyon),
              Convert.ToBoolean(yuklenici),
                Convert.ToInt32(yukleniciadi),
                value.ToString());

            //ASPxGridView6.DataBind();

        }

        protected void ASPxCallback2_Callback(object source, CallbackEventArgs e)
        {
            //danışman wizard

            var danismanAdi = tbYeniDanismanAdi.Value;
            var kulalniciAdi = cmbKullaniciAdi.Value;
            var modulAdi = tbModul.Value;

            DataProviderTanimlar.InsertDanismanWizard(-1,
                danismanAdi.ToString(),
                kulalniciAdi.ToString(),
                modulAdi.ToString());


        }

        protected void confirmButton_Click(object sender, EventArgs e)
        {
            UpdatePasswordField(cnpsw.Text);
            ASPxPopupControl2.ShowOnPageLoad = false;
        }

        protected void UpdatePasswordField(string newPassword)
        {
            int index = ASPxGridView9.EditingRowVisibleIndex;
            string ad = ASPxGridView9.GetRowValues(index, "UserName").ToString();

            //DataTable dt = Session["data"] as DataTable;
            //dt.Rows[index]["Password"] = newPassword;
            //Session["data"] = dt;


            MembershipUser user = Membership.GetUser(ad);
            var list = db.S_Kullanici("").Where(c => c.UserName == user.UserName & c.Email == user.Email).ToList();
            if (list.Count > 0)
            {

                //if (!Membership.ValidateUser(user.UserName, currentPassword))
                //{
                //    tbCurrentPassword.ErrorText = "Old Password is not valid";
                //    tbCurrentPassword.IsValid = false;
                //}
                //else if (!user.ChangePassword(tbCurrentPassword.Text, tbPassword.Text))
                //{
                //    tbPassword.ErrorText = "Password is not valid";
                //    tbPassword.IsValid = false;
                //}
                //else
                //    Response.Redirect("~/");

                user.ChangePassword(user.ResetPassword(), newPassword);
                Response.Redirect("~/Tanimlar.aspx?Mod=Kullanici");
            }
        }

        //protected void ASPxCallback_Callback(object source, CallbackEventArgs e)
        //{
        //    //var values = Tokens.Value;

        //}


    }
}