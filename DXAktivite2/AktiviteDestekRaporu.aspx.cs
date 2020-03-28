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
    public partial class AktiviteDestekRaporu : System.Web.UI.Page
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
                ddlExportMode.Items.AddRange(Enum.GetNames(typeof(GridViewDetailExportMode)));
                ddlExportMode.Text = GridViewDetailExportMode.Expanded.ToString();
                var firstDayOfMonth = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                var lastDayOfMonth = firstDayOfMonth.AddMonths(1).AddDays(-1);
                dateBaslangic.Date = firstDayOfMonth;
                dateBitis.Date = lastDayOfMonth;
               
                grid.DataBind();
                
            }
            grid.SettingsDetail.ExportMode = (GridViewDetailExportMode)Enum.Parse(typeof(GridViewDetailExportMode), ddlExportMode.Text);
        }

        protected void detailGrid_BeforePerformDataSelect(object sender, EventArgs e)
        {
            Session["CagriID"] = (sender as ASPxGridView).GetMasterRowKeyValue();

            ASPxGridView detailGrid = (ASPxGridView)sender;
            int id = (int)detailGrid.GetMasterRowKeyValue();

            var result = db.R_AktiviteDestekDetail().Where(c => c.CagriID == id).ToList();

            detailGrid.DataSource = result;
        }

        protected void btnGetir_Click(object sender, EventArgs e)
        {
            GridUpdating();
        }

        protected void grid_DataBinding(object sender, EventArgs e)
        {
            grid.DataSource = GridUpdating();
        }
        protected List<R_AktiviteDestek_Result> GridUpdating()
        {
            DateTime bTarih = dateBaslangic.Date;
            List<R_AktiviteDestek_Result> list = new List<R_AktiviteDestek_Result>();
            if (bTarih != null)
                list = DataProvider.GetAktiviteDestek(dateBaslangic.Date, dateBitis.Date);
            else
                list = DataProvider.GetAktiviteDestek();

            if (list.Count > 0)
            {
                return list;
            }
            else
                return null;
        }
    }
}