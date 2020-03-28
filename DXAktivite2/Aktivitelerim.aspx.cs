using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DXAktivite2
{
    public partial class Aktivitelerim : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                DateTime i = Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, Convert.ToInt32(Session["GriddeKacinciHafta"]));
                DateTime s = Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, Convert.ToInt32(Session["GriddeKacinciHafta"])).AddDays(6);
                deStart.Value = i;
                deEnd.Value = s;
            }
        }
        protected void ASPxGridView1_CellEditorInitialize(object sender, DevExpress.Web.ASPxGridViewEditorEventArgs e)
        {
            try
            {
                if (e.Column.FieldName == "ModulID")
                {
                    var combo = (ASPxComboBox)e.Editor;
                    combo.Callback += new CallbackEventHandlerBase(combo_Callback);

                    var grid = e.Column.Grid;
                    if (!combo.IsCallback)
                    {
                        var countryID = -1;
                        if (!grid.IsNewRowEditing)
                            countryID = (int)grid.GetRowValues(e.VisibleIndex, "ProjeID");
                        FillCitiesComboBox(combo, countryID);
                    }
                }
            }
            catch (Exception hata)
            {


            }
        }
        private void combo_Callback(object sender, CallbackEventArgsBase e)
        {
            try
            {
                var projeID = -1;
                Int32.TryParse(e.Parameter, out projeID);
                FillCitiesComboBox(sender as ASPxComboBox, projeID);
            }
            catch (Exception hata)
            {


            }
        }
        protected void FillCitiesComboBox(ASPxComboBox combo, int ProjeID)
        {
            try
            {
                combo.DataSourceID = "ModullerData";
                ModullerData.SelectParameters["ProjeID"].DefaultValue = ProjeID.ToString();
                combo.DataBindItems();
                combo.Items.Insert(0, new ListEditItem("", null)); // Null Item
            }
            catch (Exception hata)
            {

            }
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

                //_Default.kacinciHafta = Convert.ToInt32(Session["GriddeKacinciHafta"]);
                int haftaNumarasi = Convert.ToInt32(Session["GriddeKacinciHafta"]);
                if (hareketYonu == "sonraki")
                {
                    //_Default.kacinciHafta++;
                    haftaNumarasi++;
                    i = Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, haftaNumarasi);
                    s = Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, haftaNumarasi).AddDays(6);
                    Session["GridAktiviteIlkGun"] = i;
                    Session["GridAktiviteSonGun"] = s;
                }
                else if (hareketYonu == "onceki")
                {
                    //_Default.kacinciHafta--;
                    haftaNumarasi--;
                    i = Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, haftaNumarasi);
                    s = Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, haftaNumarasi).AddDays(6);
                    Session["GridAktiviteIlkGun"] = i;
                    Session["GridAktiviteSonGun"] = s;
                }
                else if (hareketYonu == "getir")
                {
                    i = Convert.ToDateTime(deStart.Value);
                    s = Convert.ToDateTime(deEnd.Value);
                    Session["GridAktiviteIlkGun"] = i;
                    Session["GridAktiviteSonGun"] = s;
                }
                //Session["GriddeKacinciHafta"] = _Default.kacinciHafta.ToString();
                Session["GriddeKacinciHafta"] = haftaNumarasi;
                //_Default.kacinciHafta = haftaNumarasi;

                ASPxCallback1.JSProperties["cpBaslangicTarihi"] = string.Empty;
                ASPxCallback1.JSProperties["cpBaslangicTarihi"] = i;

                ASPxCallback1.JSProperties["cpBitisTarihi"] = string.Empty;
                ASPxCallback1.JSProperties["cpBitisTarihi"] = s;
            }
            catch (Exception)
            {

            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (IsPostBack && ASPxEdit.ValidateEditorsInContainer(this))
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        @"<script type=""text/javascript"">alert('The form has been submitted successfully.');</script>");
        }
        protected void ASPxGridView1_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            (sender as ASPxGridView).DataSource = DataProvider.GetAktiviteler();
            ASPxGridView1.DataSourceID = String.Empty;
            ASPxGridView1.DataBind();
        }




    }
}