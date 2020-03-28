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
    public partial class KapanmisCagrilarim : System.Web.UI.Page
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
                    //kısıtlı
                    mpNavBar.Groups[4].Visible = false;
                }
                else if (list.FirstOrDefault().RoleName == "Proje Yöneticisi")
                {
                    //kısıtlı
                }
            }
            else
            {
                //kullanıcının yetki tablosu (roles) boş. bütün menüler kapalı.
                mpNavBar.Groups[0].Visible = false;
                mpNavBar.Groups[1].Visible = false;
                mpNavBar.Groups[2].Visible = false;
                mpNavBar.Groups[3].Visible = false;
                mpNavBar.Groups[4].Visible = false;
                mpNavBar.Groups[5].Visible = false;
                //yekti tanımlamız yok diye bir mesaj sayfası gibi bir yere yönlendirilecek.
            }

            //aktivite menüleri kapanıyor.
            mpNavBar.Groups[0].Visible = false;
            mpNavBar.Groups[1].Visible = false;
            mpNavBar.Groups[2].Visible = false;
            mpNavBar.Groups[5].Visible = false;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                Session["KapanmisCagiriyiAktiviteyeDonusturCagriID"] = "";
                var projeList = db.S_DanismaninYetkiliProjeleri(Genel.DanismanID).ToList();
                if(projeList.Count>0)
                {
                    foreach (var item in projeList)
                    {
                        cmbProjeAdi.Items.Add(item.Aciklama, item.ID);
                    }
                }
                var modulList = db.S_DanismaninProjeModulleri(Genel.DanismanID).ToList();
                if(modulList.Count>0)
                {
                    foreach (var item in modulList)
                    {
                        cmbModulAdi.Items.Add(item.Aciklama, item.ID);
                    }
                }
            }
        }
        protected string GetImageName(object dataValue)
        {
            string val = string.Empty;
            try
            {
                val = (string)dataValue.ToString();
            }
            catch { }

            switch (val)
            {
                case "1":
                    return "~/images/LowPriority_16x16.png";
                case "2":
                    return "~/images/NormalPriority_16x16.png";
                case "3":
                    return "~/images/MediumPriority_16x16.png";
                case "4":
                    return "~/images/HighPriority_16x16.png";
                default:
                    return "~/images/LowPriority_16x16.png";
            }
        }

        protected void ASPxCallback3_Callback(object source, CallbackEventArgs e)
        {
            int CagriID = Convert.ToInt32(Session["KapanmisCagiriyiAktiviteyeDonusturCagriID"]);
            db.IUD_Aktivite(-1, Convert.ToDateTime(dtTarih.Value), 
                Convert.ToInt32(cmbProjeAdi.Value), 
                Convert.ToInt32(cmbModulAdi.Value), 
                Genel.DanismanID, 
                OnayTxtAciklama.Value.ToString(), 
                Convert.ToInt32(txtToplamCozumSuresi.Value), false);
            DataProvider.GetAktivitelerYenile();
            Session["KapanmisCagiriyiAktiviteyeDonusturCagriID"] = "";
        }

        protected void ASPxCallback4_Callback(object source, CallbackEventArgs e)
        {
            string CagriID = e.Parameter.ToString();
            Session["KapanmisCagiriyiAktiviteyeDonusturCagriID"] = CagriID;
            var list = db.S_CagriSonuc(Convert.ToInt32(CagriID), Genel.DanismanID).ToList();
            if (list.Count > 0)
            {
                list.OrderByDescending(c => c.ID);

                DateTime tarih = Convert.ToDateTime(list.First().BitisTarihSaat);
                ASPxCallback4.JSProperties["cpAktiviteTarihi"] = string.Empty;
                ASPxCallback4.JSProperties["cpAktiviteTarihi"] = tarih;

                ASPxCallback4.JSProperties["cpOnayTxtAciklama"] = string.Empty;
                ASPxCallback4.JSProperties["cpOnayTxtAciklama"] = list.First().SonucAciklama.ToString();

                ASPxCallback4.JSProperties["cptxtToplamCozumSuresi"] = string.Empty;
                ASPxCallback4.JSProperties["cptxtToplamCozumSuresi"] = list.First().ToplamCozumSuresiSaat.ToString();

                ASPxCallback4.JSProperties["cpcmbModulAdi"] = string.Empty;
                ASPxCallback4.JSProperties["cpcmbModulAdi"] = db.S_CagriModul(Convert.ToInt32(CagriID)).FirstOrDefault().ID;
            }
            else
            {
                ASPxCallback4.JSProperties["cpAktiviteTarihi"] = null;
                ASPxCallback4.JSProperties["cpOnayTxtAciklama"] = string.Empty;
                ASPxCallback4.JSProperties["cptxtToplamCozumSuresi"] = string.Empty;
                ASPxCallback4.JSProperties["cpcmbModulAdi"] = string.Empty;
            }
        }
    }
}