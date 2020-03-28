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
    public partial class AktiviteRaporu : System.Web.UI.Page
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
            if(!IsPostBack)
            {
                Session["secilenAktiviteID"] = "";

                //popup ekranı
                var listKisi = db.S_Kisi(-1).ToList();
                if (listKisi.Count > 0)
                {
                    foreach (var item in listKisi)
                    {
                        string firmaadi = item.MusteriAdi == null ? item.YukleniciAdi : item.MusteriAdi;
                        tbAliciKisi.Items.Add(firmaadi + ", " + item.AdiSoyadi + " (" + item.MailAdresi + ")", item.ID);
                        //tbCC.Items.Add(firmaadi + ", " + item.AdiSoyadi + " (" + item.MailAdresi + ")", item.ID);
                        //tbBCC.Items.Add(firmaadi + ", " + item.AdiSoyadi + " (" + item.MailAdresi + ")", item.ID);
                    }
                }
                txtGonderen.Value = "TECS Muhasebe"; txtGonderen.Text = "TECS Muhasebe";
                txtGonderenMail.Value = "mutabakat@tecs.com.tr"; txtGonderenMail.Text = "mutabakat@tecs.com.tr";
                txtKonu.Value = "";
            }
        }
        protected string GetCaptionText(GridViewGroupRowTemplateContainer container)
        {
            //gruplanan satırın üzerine gelecek text i gönderiyorum.
            string captionText = !string.IsNullOrEmpty(container.Column.Caption) ? container.Column.Caption : container.Column.FieldName;
            return string.Format("{0} : {1} {2}", captionText, System.Net.WebUtility.HtmlDecode(container.GroupText), container.SummaryText);
        }
        protected void grid_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
        {
            if (e.RowType == GridViewRowType.Group)
            {
                ASPxCheckBox checkBox = grid.FindGroupRowTemplateControl(e.VisibleIndex, "checkBox") as ASPxCheckBox;
                if (checkBox != null)
                {
                    checkBox.ClientSideEvents.CheckedChanged = string.Format("function(s, e){{ grid.PerformCallback('{0};' + s.GetChecked()); }}", e.VisibleIndex);
                    checkBox.Checked = GetChecked(e.VisibleIndex);
                }
            }
        }
        protected bool GetChecked(int visibleIndex)
        {
            for (int i = 0; i < grid.GetChildRowCount(visibleIndex); i++)
            {
                List<DataProvider.AktivitelerTumu> a = new List<DataProvider.AktivitelerTumu>();

                var list = grid.GetChildRow(visibleIndex, i);
                a.Add(list as DataProvider.AktivitelerTumu);

                int RowNumberID = 0;
                foreach (var item in a)
                {
                    RowNumberID = item.ID;
                }
                bool isRowSelected = grid.Selection.IsRowSelectedByKey(RowNumberID); //bu benim kendi çözümüm. devexpress deki örnek null dönüyor.

                if (!isRowSelected)
                    return false;
            }
            return true;
        }

        protected void ASPxCallback1_Callback(object source, CallbackEventArgs e)
        {
            //headerdaki mail gönderimine hazırla buttonuna tıkladığında            
            List<object> list = (List<object>)grid.GetSelectedFieldValues("ID");
            foreach (object obj in list)
                Session["secilenAktiviteID"] = Session["secilenAktiviteID"].ToString() + obj.ToString() + ";";
        }

        protected void grid_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            string[] parameters = e.Parameters.Split(';');
            int index = int.Parse(parameters[0]);
            bool isGroupRowSelected = bool.Parse(parameters[1]);
            for (int i = 0; i < grid.GetChildRowCount(index); i++)
            {
                List<DataProvider.AktivitelerTumu> a = new List<DataProvider.AktivitelerTumu>();

                var list = grid.GetChildRow(index, i);
                a.Add(list as DataProvider.AktivitelerTumu);

                int RowNumberID = 0;
                foreach (var item in a)
                {
                    RowNumberID = item.ID;
                }

                grid.Selection.SetSelectionByKey(RowNumberID, isGroupRowSelected);
            }
        }

        protected void ASPxCallback3_Callback(object source, CallbackEventArgs e)
        {
            if (cmbSoblon.Value.ToString() == "PDF")
            {
                return; //PDF işlemi henüz aktif olmadığı için mail gönderimi yaptırtmıyorum.
            }

            string mesaj = "";
            string secilenAktiviteID = Session["secilenAktiviteID"].ToString();
            //DateTime c = Convert.ToDateTime(deStart.Value);
            //DateTime s = Convert.ToDateTime(deEnd.Value);
            //var list = db.S_GridGroupCheckedDataSource(degerProjeID, degerDanismanID, degerModulID, c, s, Genel.KullaniciGUID).ToList();

            var list = db.S_GridGroupCheckedDataSourceAktiviteRaporu(secilenAktiviteID).OrderBy(c => c.ProjeAdi).ToList();
            if (list.Count == 0)
                return;

            string OlusturmaTarihi = DateTime.Now.ToLongDateString();
            string DonemTarihi = list.Min(q => q.Tarih).ToString().Substring(0, 10) + " - " + list.Max(c => c.Tarih).ToString().Substring(0, 10);

            var alicikisiler = tbAliciKisi.Value;
            string[] alicikisi = alicikisiler.ToString().Split(';');
            string[] kisiBilgileri = alicikisi[0].ToString().Split(',');
            string firmaadi = kisiBilgileri[0].Trim().ToString();
            string kisiadi = kisiBilgileri[1].Trim().Split('(')[0].Trim().ToString();
            //string gonderilenMailAdresi = kisiBilgileri[1].Trim().Split('(')[1].Trim().Replace(")","").ToString();
            string musteriadi = firmaadi;
            string musterisorumluadi = kisiadi;
            string strHTML = File.ReadAllText(HttpContext.Current.Server.MapPath("Mail/HTML/AktiviteRaporu.html"));
            strHTML = strHTML.Replace("{OLUSTURMATARIHI}", OlusturmaTarihi)
                .Replace("{DONEMTARIHI}", DonemTarihi)
                .Replace("{MUSTERIADI}", musteriadi)
                .Replace("{MUSTERISORUMLUADI}", musterisorumluadi);
            string projegrid = "<tr class=\"heading\"><td>{PROJEADI}</td><td>Saat</td></tr> <tr class=\"item\"><td><strong>{DANISMANADI}</strong> {ACIKLAMA}</td><td><strong>{SAAT}</strong></td></tr>";//</tr><tr class=\"total\"><td></td><td>Toplam: {PROJETOPLAMTUTAR}</td>
            string projegridHeader = "<tr class=\"heading\"><td>{PROJEADI}</td><td>Saat</td></tr>";
            string projegridContent = "<tr class=\"item\"><td><strong>{DANISMANADI}</strong> {ACIKLAMA}</td><td><strong>{SAAT}</strong></td></tr>";
            string projegridFooter = "<tr class=\"total\"><td></td><td>Toplam: {PROJETOPLAMTUTAR}</td></tr>";
            int projeCount = 0;
            int projeDongu = 0;
            decimal toplamTutar = 0;
            string hangiProjeyiDonuyor = "";
            decimal projeToplamSaat = 0;
            foreach (var item in list)
            {
                if (hangiProjeyiDonuyor != item.ProjeAdi)
                {
                    projeCount = 0;
                    projeDongu = 0;
                    projeToplamSaat = 0;
                }

                if (list.Where(x => x.ProjeAdi == item.ProjeAdi).ToList().Count > 1)
                {
                    hangiProjeyiDonuyor = item.ProjeAdi;

                    if (projeCount == 0)
                        projeCount = list.Where(x => x.ProjeAdi == item.ProjeAdi).ToList().Count;

                    projeDongu++;

                    if (projeDongu == 1)
                        strHTML += projegridHeader.Replace("{PROJEADI}", item.ProjeAdi);

                    strHTML += projegridContent.Replace("{DANISMANADI}", item.DanismanAdi + ", " + item.ModulAdi + ", " + item.Tarih.ToString().Substring(0,10)) 
                    .Replace("{ACIKLAMA}", item.Aciklama)
                    .Replace("{SAAT}", item.Saat.ToString());

                    projeToplamSaat += Convert.ToDecimal(item.Saat);
                    if (projeDongu == projeCount)
                    {
                        strHTML += projegridFooter.Replace("{PROJETOPLAMTUTAR}", projeToplamSaat.ToString());
                        toplamTutar = toplamTutar + Convert.ToDecimal(projeToplamSaat);
                    }
                }
                else
                {
                    projeToplamSaat += Convert.ToDecimal(item.Saat);

                    strHTML += projegrid.Replace("{PROJEADI}", item.ProjeAdi)
                .Replace("{DANISMANADI}", item.DanismanAdi + ", " + item.ModulAdi + ", " + item.Tarih.ToString().Substring(0, 10))
                .Replace("{ACIKLAMA}", item.Aciklama)
                .Replace("{SAAT}", item.Saat.ToString()) 
                .Replace("{PROJETOPLAMTUTAR}", projeToplamSaat.ToString());

                    toplamTutar = toplamTutar + Convert.ToDecimal(projeToplamSaat);
                }
            }

            string projeGridToplamTutar = "<tr class=\"heading\"><td></td><td>Toplam Saat #</td></tr><tr class=\"details\"><td></td><td>{TOPLAMTUTAR}</td></tr>";
            projeGridToplamTutar = projeGridToplamTutar.Replace("{TOPLAMTUTAR}", toplamTutar.ToString());
            string htmlbitis = "</table></div></body></html>";
            strHTML += projeGridToplamTutar;
            strHTML += htmlbitis;

            string konu = txtKonu.Value.ToString();
            string gonderenmailadresi = txtGonderen.Value.ToString() + " <" + txtGonderenMail.Value.ToString() + ">";
            string gonderenkisiadi = txtGonderen.Value.ToString();

            string mailadresleri = "";
            foreach (var item in alicikisi)
            {
                mailadresleri = item.Split('(')[1].Trim().Replace(")", "").ToString();
                db.IUD_Mail(Genel.DanismanID, mailadresleri, strHTML, false, null, gonderenmailadresi, konu, "AktiviteRaporu", false, "");
            }

            Session["secilenAktiviteID"] = "";

        }
    }
}