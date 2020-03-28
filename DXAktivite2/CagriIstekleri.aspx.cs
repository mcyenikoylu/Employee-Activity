using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DXAktivite2
{
    public partial class CagriIstekleri : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                Session["CagriIstekleriYonlendirID"] = "";
                Session["CagriIstekleriYonlendirExternalTicketNumber"] = "";
                Session["CagriIstekleriFirmaAdi"] = "";
                Session["CagriIstekleriAdiSoyadi"] = "";
                var list_Kullanici = db.S_Danisman(-1, null).ToList();
                if (list_Kullanici.Count > 0)
                {
                    cmbDanismanAdi.DataSource = list_Kullanici;
                    cmbDanismanAdi.DataBind();
                }

                var list_Modul = db.S_Modul(-1).ToList();
                if (list_Modul.Count > 0)
                {
                    foreach (var item in list_Modul)
                    {
                        //tbModul.Items.Add(item.ModulAdi, item.ModulID);
                        ASPxTokenBox1.Items.Add(item.ModulAdi, item.ModulID);
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
        protected void UploadControl_FilesUploadComplete(object sender, FilesUploadCompleteEventArgs e)
        {
            try
            {
                foreach (UploadedFile file in UploadControl.UploadedFiles)
                {
                    string dosyaAdiUret = DateTime.Now.ToString().Replace(".", "").Replace(":", "").Replace(" ", "");

                    string uploadFolder = Server.MapPath("~/App_Data/UploadDirectory/");
                    string fileName = file.FileName;
                    fileName = dosyaAdiUret + fileName;
                    file.SaveAs(uploadFolder + fileName);
                    e.CallbackData = fileName;

                    db.I_CagriIstekExcelZorlu(uploadFolder + fileName);
                }

                ASPxGridView1.DataSource = DataProvider.GetCagriIstekYenile();
                ASPxGridView1.DataSourceID = String.Empty;
                ASPxGridView1.DataBind();

                e.CallbackData = "success";
            }
            catch (Exception hata)
            {

            }
        }

        protected void ASPxCallback1_Callback(object source, CallbackEventArgs e)
        {
            List<object> list = (List<object>)ASPxGridView1.GetSelectedFieldValues("ID");
            foreach (object obj in list)
                Session["CagriIstekleriYonlendirID"] = Session["CagriIstekleriYonlendirID"].ToString() + obj.ToString() + ";";

            //List<object> listEx = (List<object>)ASPxGridView1.GetSelectedFieldValues("ExternalTicketNumber");
            //foreach (object obj in listEx)
            //    Session["CagriIstekleriYonlendirExternalTicketNumber"] = Session["CagriIstekleriYonlendirExternalTicketNumber"].ToString() + obj.ToString() + ";";


        }

        protected void ASPxCallback2_Callback(object source, CallbackEventArgs e)
        {
            var danismanID = cmbDanismanAdi.Value;
            //var modulAdi = tbModul.Value;
            //string externalTicketNumber = Session["CagriIstekleriYonlendirExternalTicketNumber"].ToString();
            string cagriIstekID = Session["CagriIstekleriYonlendirID"].ToString();
            if (cagriIstekID == "")
                return;

            db.IUD_CagriYonlendir(cagriIstekID, Convert.ToInt32(danismanID), "");//modulAdi.ToString()
            DataProvider.GetBekleyenCagrilarYenile();
            // mail fonksiyonu - başlat
            string firmaadi = Session["CagriIstekleriFirmaAdi"].ToString();
            string kullanıciadi = Session["CagriIstekleriAdiSoyadi"].ToString();
            string strHTML = File.ReadAllText(HttpContext.Current.Server.MapPath("Mail/HTML/DestecCagriBilgilendirmesi.html"));
            string icerik = cagriIstekID + " numaralı çağrı isteğiniz, danışmanımız, " + cmbDanismanAdi.Text + " kullanıcısına aktarılmıştır.<br />Konuyla ilgili olarak en kısa sürede tarafınıza dönüş yapıcaktır.";
            strHTML = strHTML.Replace("{OLUSTURMATARIHI}", DateTime.Now.ToShortDateString())
                .Replace("{CAGRIID}", cagriIstekID.ToString())
                .Replace("{FIRMAADI}", firmaadi)
                .Replace("{KULLANICIADI}", kullanıciadi)
                .Replace("{ICERIK}", icerik);
            var listsirketid = db.S_CagriIstek(Convert.ToInt32(cagriIstekID)).ToList();
            //var sid = db.S_Destec_SirketIDVer(listsirketid.FirstOrDefault().IstekSirketAdi).ToList();
            var sid = db.S_Destec_SirketIDVer(firmaadi).ToList();
            Guid sirketid = sid.FirstOrDefault().SirketId; 
            Guid kullaniciid = db.S_Destec_KullaniciIDVer(kullanıciadi).ToList().First().UserId;
            var alicikisiler = db.S_Destec_GonderilecekMailAdresleri(4, kullaniciid, sirketid, -1).ToList().First().MailAdresleri; //"cenk (cenk.yenikoylu@tecs.com.tr);mcy (mcyenikoylu@gmail.com)";
            string[] alicikisi = alicikisiler.ToString().Split(';');
            string mailadresleri = "";
            foreach (var item in alicikisi)
            {
                mailadresleri = item.Split('(')[1].Trim().Replace(")", "").ToString();
                db.I_Mail(-1, mailadresleri, strHTML, false, null, "DESTEC Ticket Viewer <mailservice@tecs.com.tr>", cagriIstekID + " numaralı çağri isteği", "DestecCagriIstegi", false, "");
            }
            // mail fonksiyonu - bitti
            ASPxGridView1.DataSource = DataProvider.GetCagriIstekYenile();
            ASPxGridView1.DataSourceID = String.Empty;
            ASPxGridView1.DataBind();

            Session["CagriIstekleriYonlendirID"] = "";
            Session["CagriIstekleriFirmaAdi"] = "";
            Session["CagriIstekleriAdiSoyadi"] = "";
        }

        protected void ASPxCallback7_Callback(object source, CallbackEventArgs e)
        {
            string CagriID = e.Parameter.ToString();
            Session["CagriyiYakalaCagriID"] = CagriID;
        }

        protected void ASPxCallback3_Callback(object source, CallbackEventArgs e)
        {
            //çağrı yakala

            //var modulAdi = ASPxTokenBox1.Value;
            //int CagriID = Convert.ToInt32(Session["CagriyiYakalaCagriID"]);

            string CagriID = e.Parameter.ToString();
            db.IU_CagriyiYakala(Convert.ToInt32(CagriID), Genel.DanismanID);
            
            DataProvider.GetBekleyenCagrilarYenile();
            //DataProvider.GetCagriIstekYenile();

            ASPxGridView1.DataSource = DataProvider.GetCagriIstekYenile();
            ASPxGridView1.DataSourceID = String.Empty;
            ASPxGridView1.DataBind();

            Session["CagriyiYakalaCagriID"] = "";


        }

        protected void ASPxCallback4_Callback(object source, CallbackEventArgs e)
        {

            //çağrı yönlendir.
            string parms = e.Parameter.ToString();
            string[] parm = parms.ToString().Split(';');

            Session["CagriIstekleriYonlendirID"] = parm[0].ToString();
            Session["CagriIstekleriFirmaAdi"] = parm[1].ToString();
            Session["CagriIstekleriAdiSoyadi"] = parm[2].ToString();



            //var asd = ASPxGridView1.GetSelectedFieldValues("IstekSirketAdi").ToString();

            //List<object> fieldValues = ASPxGridView1.GetSelectedFieldValues(new string[] { "IstekSirketAdi", "IstekSahibiAdiSoyadi" });
            //foreach (object[] item in fieldValues)
            //{
            //    Session["CagriIstekleriFirmaAdi"] = item[0].ToString();
            //    Session["CagriIstekleriAdiSoyadi"] = item[1].ToString();
            //}
        }

        protected void ASPxGridView1_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
        {
            if (e.RowType != GridViewRowType.Data) return;
            int price = Convert.ToInt32(e.GetValue("KaynakYoneticisiOnayi_TipID4"));
            if (price == 2008)
                e.Row.BackColor = System.Drawing.Color.LightGreen;
            if (price == 2009)
                e.Row.BackColor = System.Drawing.Color.LightPink;
            if (price == 2010)
                e.Row.BackColor = System.Drawing.Color.LightYellow;
        }

        protected void ASPxGridView1_ToolbarItemClick(object source, DevExpress.Web.Data.ASPxGridViewToolbarItemClickEventArgs e)
        {
            if(e.Item.Command.ToString() == "Refresh")
            {
                ASPxGridView1.DataSource = DataProvider.GetCagriIstekYenile();
                ASPxGridView1.DataSourceID = String.Empty;
                ASPxGridView1.DataBind();
            }
        }
    }
}