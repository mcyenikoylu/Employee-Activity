﻿using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DXAktivite2
{

    public partial class BekleyenCagrilarim : System.Web.UI.Page
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
                Session["YonlendirilecekDanismanID"] = "";
           
                var list_Kullanici = db.S_Danisman(-1, null).ToList();
                if (list_Kullanici.Count > 0)
                {
                    cmbDanismanAdi.DataSource = list_Kullanici;
                    cmbDanismanAdi.DataBind();
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

        protected void ASPxCallback3_Callback(object source, CallbackEventArgs e)
        {
            string CagriID = Session["YonlendirilecekDanismanID"].ToString();
            var danismanID = cmbDanismanAdi.Value;
            db.I_CagriYonlendir(Convert.ToInt32(CagriID), Convert.ToInt32(danismanID));
            DataProvider.GetAcikCagrilarimYenile();
            DataProvider.GetBekleyenCagrilarYenile();
            Session["YonlendirilecekDanismanID"] = "";
        }

        protected void ASPxCallback4_Callback(object source, CallbackEventArgs e)
        {
            Session["YonlendirilecekDanismanID"] = "";
        }
        protected void ASPxCallback2_Callback(object source, CallbackEventArgs e)
        {
            string CagriID = e.Parameter.ToString();
            db.I_CagriyaBasla(Convert.ToInt32(CagriID));
            DataProvider.GetBekleyenCagrilarYenile();
            DataProvider.GetAcikCagrilarimYenile();
        }

    }
}