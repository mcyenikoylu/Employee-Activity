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
    public partial class PlanlamaGiris : System.Web.UI.Page
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

        }
        protected void ASPxGridView1_CellEditorInitialize(object sender, DevExpress.Web.ASPxGridViewEditorEventArgs e)
        {
            try
            {


                if (e.Column.FieldName == "DanismanID")
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
                else if (e.Column.FieldName == "ModulID")
                {
                    var comboModul = (ASPxComboBox)e.Editor;
                    comboModul.Callback += new CallbackEventHandlerBase(Mcombo_Callback);
                    var Mgrid = e.Column.Grid;
                    if (!comboModul.IsCallback)
                    {
                        var projeID = -1;
                        if (!Mgrid.IsNewRowEditing)
                            projeID = (int)Mgrid.GetRowValues(e.VisibleIndex, "DanismanID");
                        MFillCitiesComboBox(comboModul, projeID);
                    }
                }
            }
            catch (Exception hata)
            {


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
                combo.DataSourceID = "DanismanlarData";
                DanismanlarData.SelectParameters["ProjeID"].DefaultValue = projeID.ToString();
                combo.DataBindItems();
                combo.Items.Insert(0, new ListEditItem("", null)); // Null Item
            }
            catch (Exception hata)
            {

            }
        }

        private void Mcombo_Callback(object sender, CallbackEventArgsBase e)
        {
            var projeID = -1;
            Int32.TryParse(e.Parameter, out projeID);
            MFillCitiesComboBox(sender as ASPxComboBox, projeID);
        }

        protected void MFillCitiesComboBox(ASPxComboBox comboModul, int projeID)
        {
            try
            {
                comboModul.DataSourceID = "ModullerData";
                ModullerData.SelectParameters["DanismanID"].DefaultValue = projeID.ToString();
                comboModul.DataBindItems();
                comboModul.Items.Insert(0, new ListEditItem("", null)); // Null Item
            }
            catch (Exception hata)
            {

            }
        }

    }
}