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
    public partial class Ayarlar : System.Web.UI.Page
    {
        AktiviteEntities db = new AktiviteEntities();

        protected void Page_PreInit(object sender, EventArgs e)
        {
            HttpCookie c = Request.Cookies["theme"];
            ASPxWebControl.GlobalTheme = c == null ? Genel.Theme : c.Value;
            Guid userId = new Guid(Membership.GetUser().ProviderUserKey.ToString());
            Genel.KullaniciGUID = userId;
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
            HttpCookie c = Request.Cookies["theme"];
            if (!IsPostBack && (c != null))
                ASPxComboBox1.Value = c.Value;

            string a = "";
            if (Request.QueryString["Mod"] != null)
                a = Request.QueryString["Mod"].ToString();
            else
                Response.Redirect("/Ayarlar.aspx?Mod=Profil");

            if (Request.QueryString["Mod"] == "Profil")
            {
                //Planlarım
                flDateRangePicker.Visible = false;

            }
            else if (Request.QueryString["Mod"] == "Gorunum")
            {
                //Aktivitelerim
                flDateRangePicker.Visible = true;

            }
        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            AktiviteEntities db = new AktiviteEntities();
            HttpCookie c = Request.Cookies["theme"];
            Genel.Theme = c.Value;
            db.IUD_Ayarlar(Genel.KullaniciGUID, Genel.Theme);
        }
    }
}