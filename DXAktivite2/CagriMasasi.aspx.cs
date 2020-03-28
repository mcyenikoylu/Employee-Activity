using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DXAktivite2
{
    public partial class CagriMasasi : System.Web.UI.Page
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
                else if (list.FirstOrDefault().RoleName == "Çağrı Masası Takım Lideri")
                {
                    
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
            string a = "";
            if (Request.QueryString["Mod"] != null)
                a = Request.QueryString["Mod"].ToString();
            else
                Response.Redirect("/CagriMasasi.aspx?Mod=M");

            if (!IsPostBack)
            {
                Session["YonlendirilecekDanismanID"] = "";
                Session["OnayaGonderilecekCagriID"] = "";
                var list_Kullanici = db.S_Danisman(-1, null).ToList();
                if (list_Kullanici.Count > 0)
                {
                    cmbDanismanAdi.DataSource = list_Kullanici;
                    cmbDanismanAdi.DataBind();
                }

                var listKisi = db.S_Kisi(-1).ToList();
                if (listKisi.Count > 0)
                {
                    foreach (var item in listKisi)
                    {
                        string firmaadi = item.MusteriAdi == null ? item.YukleniciAdi : item.MusteriAdi;
                        tbAliciKisi.Items.Add(firmaadi + ", " + item.AdiSoyadi + " (" + item.MailAdresi + ")", item.ID);
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
        protected void ASPxCallback1_Callback(object source, CallbackEventArgs e)
        {
            string CagriID = e.Parameter.ToString();
            Session["YonlendirilecekDanismanID"] = CagriID;
        }

        protected void ASPxCallback2_Callback(object source, CallbackEventArgs e)
        {
            string CagriID = e.Parameter.ToString();
            db.I_CagriyaBasla(Convert.ToInt32(CagriID));
            //DataProvider.GetBekleyenCagrilarYenile();
            //DataProvider.GetAcikCagrilarimYenile();
            ASPxGridView1.DataSource = DataProvider.GetAcikCagrilarimYenile();
            ASPxGridView1.DataSourceID = String.Empty;
            ASPxGridView1.DataBind();
            ASPxGridView2.DataSource = DataProvider.GetBekleyenCagrilarYenile();
            ASPxGridView2.DataSourceID = String.Empty;
            ASPxGridView2.DataBind();
        }

        protected void ASPxCallback3_Callback(object source, CallbackEventArgs e)
        {
            string CagriID = Session["YonlendirilecekDanismanID"].ToString();
            var danismanID = cmbDanismanAdi.Value;
            db.I_CagriYonlendir(Convert.ToInt32(CagriID), Convert.ToInt32(danismanID));
            //DataProvider.GetAcikCagrilarimYenile();
            //DataProvider.GetBekleyenCagrilarYenile();
            Session["YonlendirilecekDanismanID"] = "";
            ASPxGridView1.DataSource = DataProvider.GetAcikCagrilarimYenile();
            ASPxGridView1.DataSourceID = String.Empty;
            ASPxGridView1.DataBind();
            ASPxGridView2.DataSource = DataProvider.GetBekleyenCagrilarYenile();
            ASPxGridView2.DataSourceID = String.Empty;
            ASPxGridView2.DataBind();
        }

        protected void ASPxCallback4_Callback(object source, CallbackEventArgs e)
        {
            Session["YonlendirilecekDanismanID"] = "";
        }

        protected void ASPxCallback5_Callback(object source, CallbackEventArgs e)
        {
            //onaya gönder popup
            try
            {
                int CagriID = Convert.ToInt32(Session["OnayaGonderilecekCagriID"]);
                string hareketYonu = e.Parameter.ToString();
                if (hareketYonu == "OnayaGonder")
                {
                    var _OnayTxtExternalTicketNumber = OnayTxtExternalTicketNumber.Value;
                    var _OnayTxtAlternativeTicketNumber = OnayTxtAlternativeTicketNumber.Value;
                    var _OnayTxtInternalTicketNumber = OnayTxtInternalTicketNumber.Value;
                    var _OnayTxtSirketAdi = OnayTxtSirketAdi.Value;
                    var _OnayTxtIlgiliKisi = OnayTxtIlgiliKisi.Value;
                    var _OnayTxtIstekTarihi = OnayTxtIstekTarihi.Value;
                    var _OnayTxtCagriTarihi = OnayTxtCagriTarihi.Value;
                    var _OnayTxtAciklama = OnayTxtAciklama.Value;
                    var _OnayTxtCozumAciklama = OnayTxtCozumAciklama.Value;
                    var _deBaslangic = deBaslangic.Value;
                    var _deBitis = deBitis.Value;
                    var _txtToplamCozumSuresi = txtToplamCozumSuresi.Value;

                    //var alicikisiler = tbAliciKisi.Value;
                    //if (alicikisiler.ToString().Trim() != "")
                    //{
                    //    string[] alicikisi = alicikisiler.ToString().Split(';');
                    //    string[] kisiBilgileri = alicikisi[0].ToString().Split(',');
                    //    string firmaadi = kisiBilgileri[0].Trim().ToString();
                    //    string kisiadi = kisiBilgileri[1].Trim().Split('(')[0].Trim().ToString();
                    //    string gonderilenMailAdresi = kisiBilgileri[1].Trim().Split('(')[1].Trim().Replace(")", "").ToString();
                    //    string musteriadi = firmaadi;
                    //    string musterisorumluadi = kisiadi;

                    //    //string mesaj = "";
                    //    //string strHTML = "";
                    //    //string mailadresleri = "";
                    //    //foreach (var item in alicikisi)
                    //    //{
                    //    //    mailadresleri = item.Split('(')[1].Trim().Replace(")", "").ToString();
                    //    //    MailIslemleri.MailGonder(mailadresleri, "DESTEC Çağrı Masası", "destec@tecs.com.tr", strHTML, "ProjeFinansDurumu", 1, out mesaj);
                    //    //}
                    //}

                    db.IUD_CagriSonucGirOnayaGonder(CagriID, Convert.ToDateTime(_deBaslangic), Convert.ToDateTime(_deBitis), _OnayTxtCozumAciklama.ToString(), Convert.ToInt32(_txtToplamCozumSuresi),Genel.DanismanID);
                    DataProvider.GetAcikCagrilarimYenile();

                    // mail fonksiyonu - başlat
                    string strHTML = File.ReadAllText(HttpContext.Current.Server.MapPath("Mail/HTML/DestecCagriBilgilendirmesi.html"));
                    string icerik = CagriID.ToString() + " numaralı çağrınız için çözüm yapılmış olup tarafınıza test için gönderilmiştir. <br /> Test sonuçlarınız beklenmektedir. Çağrının detayları için 'Test Onayı Bekleyen Çağrılarım' ekranına bakabilirsiniz.";
                    strHTML = strHTML.Replace("{OLUSTURMATARIHI}", DateTime.Now.ToShortDateString())
                        .Replace("{CAGRIID}", CagriID.ToString())
                        .Replace("{FIRMAADI}", _OnayTxtSirketAdi.ToString())
                        .Replace("{KULLANICIADI}", _OnayTxtIlgiliKisi.ToString())
                        .Replace("{ICERIK}", icerik);
                    var sid = db.S_Destec_SirketIDVer(_OnayTxtSirketAdi.ToString()).ToList();
                    Guid sirketid = sid.FirstOrDefault().SirketId;
                    Guid kullaniciid = db.S_Destec_KullaniciIDVer(_OnayTxtIlgiliKisi.ToString()).ToList().First().UserId;
                    var alicikisiler = db.S_Destec_GonderilecekMailAdresleri(5, kullaniciid, sirketid, -1).ToList().First().MailAdresleri; //"cenk (cenk.yenikoylu@tecs.com.tr);mcy (mcyenikoylu@gmail.com)";
                    string[] alicikisi = alicikisiler.ToString().Split(';');
                    string mailadresleri = "";
                    foreach (var item in alicikisi)
                    {
                        mailadresleri = item.Split('(')[1].Trim().Replace(")", "").ToString();
                        db.I_Mail(-1, mailadresleri, strHTML, false, null, "DESTEC Ticket Viewer <mailservice@tecs.com.tr>", CagriID + " numaralı çağri isteği", "DestecCagriIstegi", false, "");
                    }
                    // mail fonksiyonu - bitti
                }
                else if (hareketYonu == "OnIzleme")
                {

                }
                else
                    return;

                //ASPxGridView1.DataSource = DataProvider.GetAcikCagrilarimYenile();
                //ASPxGridView1.DataSourceID = String.Empty;
                //ASPxGridView1.DataBind();
                Session["OnayaGonderilecekCagriID"] = "";
            }
            catch (Exception hata)
            {

                
            }
        }

        protected void ASPxCallback6_Callback(object source, CallbackEventArgs e)
        {
            string CagriID = e.Parameter.ToString();
            Session["OnayaGonderilecekCagriID"] = CagriID;
        }

        protected void ASPxGridView2_ToolbarItemClick(object source, DevExpress.Web.Data.ASPxGridViewToolbarItemClickEventArgs e)
        {
            if (e.Item.Command.ToString() == "Refresh")
            {
                ASPxGridView1.DataSource = DataProvider.GetBekleyenCagrilarYenile(); //DataProvider.GetCagriIstekYenile();
                ASPxGridView1.DataSourceID = String.Empty;
                ASPxGridView1.DataBind();
            }
        }

        protected void ASPxGridView1_ToolbarItemClick(object source, DevExpress.Web.Data.ASPxGridViewToolbarItemClickEventArgs e)
        {
            if (e.Item.Command.ToString() == "Refresh")
            {
                ASPxGridView2.DataSource = DataProvider.GetAcikCagrilarimYenile(); //DataProvider.GetCagriIstekYenile();
                ASPxGridView2.DataSourceID = String.Empty;
                ASPxGridView2.DataBind();
            }
        }
    }
}