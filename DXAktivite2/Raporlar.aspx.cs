using DevExpress.Web;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DXAktivite2
{
    public partial class Raporlar : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                Guid userId = new Guid(Membership.GetUser().ProviderUserKey.ToString());
                var list = db.S_Ayarlar(userId).ToList();
                Genel.BirGunKacSaat = Convert.ToInt32(list.FirstOrDefault().BirGunKacSaat);
                Genel.KullaniciGUID = userId;
            }

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
                var today = DateTime.Today;
                int bugun = 0;
                if (today.Month - 1 == 2) //şubat ayına denk geliyorsa
                {
                    if (DateTime.IsLeapYear(today.Year))//bu yıl şubat ayı 29 çekiyor.
                    {
                        if (today.Day > 29) 
                            bugun = 29;
                        else
                            bugun = today.Day;
                    }
                    else //28 çekiyor.
                    {
                        if (today.Day > 28)
                            bugun = 28;
                        else
                            bugun = today.Day;
                    }
                }
                else
                    bugun = today.Day;

                DateTime i = new DateTime(today.Year, today.Month - 1, bugun);
                DateTime s = DateTime.Now;
                grid.DataSource = DataProviderRaporlar.GetProjeFinansDurumu(i, s);
                grid.DataSourceID = String.Empty;
                grid.DataBind();

                grid.ExpandRow(0); 

                deStart.Value = i;
                deEnd.Value = s;

                Session["degerProjeID"] = "";
                Session["degerDanismanID"] = "";
                Session["degerModulID"] = "";

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
            else
            {
                DateTime i = Convert.ToDateTime(deStart.Value);
                DateTime s = Convert.ToDateTime(deEnd.Value);
                grid.DataSource = DataProviderRaporlar.GetProjeFinansDurumu(i, s);
                grid.DataSourceID = String.Empty;
                grid.DataBind();
            }
            
        }

        protected void grid_CustomUnboundColumnData(object sender, ASPxGridViewColumnDataEventArgs e)
        {
            if (e.Column.FieldName == "ToplamFiyat")
            {
                decimal price = (decimal)e.GetListSourceFieldValue("BirimFiyatSaat");
                int quantity = Convert.ToInt32(e.GetListSourceFieldValue("Saat"));
                e.Value = price * quantity;
            }
        }
        protected void ASPxCallback1_Callback(object source, CallbackEventArgs e)
        {
            //tarih aralığındaki getir buttonu
            DateTime i = Convert.ToDateTime(deStart.Value);
            DateTime s = Convert.ToDateTime(deEnd.Value);
            ASPxCallback1.JSProperties["cpBaslangicTarihi"] = string.Empty;
            ASPxCallback1.JSProperties["cpBitisTarihi"] = string.Empty;
            ASPxCallback1.JSProperties["cpBaslangicTarihi"] = i;
            ASPxCallback1.JSProperties["cpBitisTarihi"] = s;
        }

        protected void grid_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            //getir buttonundan sonra grid tekrar yüklensin.
            DateTime c = Convert.ToDateTime(deStart.Value);
            DateTime s = Convert.ToDateTime(deEnd.Value);
            (sender as ASPxGridView).DataSource = DataProviderRaporlar.GetProjeFinansDurumu(c, s);
            grid.DataSourceID = String.Empty;
            grid.DataBind();

            //GetChildDataRow hata veriyor.
            string[] parameters = e.Parameters.Split(';');
            int index = int.Parse(parameters[0]);
            bool isGroupRowSelected = bool.Parse(parameters[1]);
            for (int i = 0; i < grid.GetChildRowCount(index); i++)
            {
                List<ProjeFinansRaporu> a = new List<ProjeFinansRaporu>();

                var list = grid.GetChildRow(index, i);
                a.Add(list as ProjeFinansRaporu);

                int RowNumberID = 0;
                foreach (var item in a)
                {
                    RowNumberID = item.RowNumber;
                }

                grid.Selection.SetSelectionByKey(RowNumberID, isGroupRowSelected);
            }
        }

        protected void grid_CustomSummaryCalculate(object sender, DevExpress.Data.CustomSummaryEventArgs e)
        {
            if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Start)
                dict = new Dictionary<decimal, List<decimal>>();

            if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Calculate)
            {
                decimal customer_No = Convert.ToDecimal(e.GetValue("Gun"));
                List<decimal> list;
                if (!dict.TryGetValue(customer_No, out list))
                {
                    list = new List<decimal>();
                    dict.Add(customer_No, list);
                }
            }

            if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Finalize)
            {
                e.TotalValue = CalculateTotal();
            }

        }
        Dictionary<decimal, List<decimal>> dict;
        private object CalculateTotal()
        {
            decimal result = 0;
            if (dict.Count <= 1)
                result = dict.Keys.First();
            else
            {
                int onluk = 0;
                int birlik = 0;
                int birOncekiBirlik = -1;
                foreach (var item in dict)
                {
                    string cikart = item.Key.ToString();
                    char[] delimiterChars = { ',', '.' };
                    string[] words = cikart.Split(delimiterChars);
                    onluk += Convert.ToInt32(words[0]);

                    if (birOncekiBirlik == -1)
                    {
                        birlik = Convert.ToInt32(words[1]);
                        birOncekiBirlik = Convert.ToInt32(words[1]);
                    }
                    else
                    {
                        int deger = birOncekiBirlik + Convert.ToInt32(words[1]);
                        int index = 0;
                        for (int i = 0; i < deger; i++)
                        {
                            index++;
                            if (index == Genel.BirGunKacSaat)
                            {
                                onluk++;
                                index = 0;
                            }

                        }
                        birlik = index;
                        birOncekiBirlik = birlik;
                    }

                }
                string sonuc = onluk.ToString() + "," + birlik.ToString();
                result = Convert.ToDecimal(sonuc);
            }

            return result;
        }

        protected void grid_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            //satırdaki mail gönder buttonuna tıkladığında
        }

        protected void ASPxCallback2_Callback(object source, CallbackEventArgs e)
        {
            //headerdaki mail gönderimine hazırla buttonuna tıkladığında            
            List<object> list = (List<object>)grid.GetSelectedFieldValues("ProjeID");
            foreach (object obj in list)
                Session["degerProjeID"] = Session["degerProjeID"].ToString() + obj.ToString() + ";";

            List<object> listDanisman = (List<object>)grid.GetSelectedFieldValues("DanismanID");
            foreach (object obj in listDanisman)
                Session["degerDanismanID"] = Session["degerDanismanID"].ToString() + obj.ToString() + ";";

            List<object> listModul = (List<object>)grid.GetSelectedFieldValues("ModulID");
            foreach (object obj in listModul)
                Session["degerModulID"] = Session["degerModulID"].ToString() + obj.ToString() + ";";

        }
        protected void grid_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
        {
            //gruplanan satırın üzerine checkbox ve proje adını basıyorum.
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
        protected string GetCaptionText(GridViewGroupRowTemplateContainer container)
        {
            //gruplanan satırın üzerine gelecek text i gönderiyorum.
            string captionText = !string.IsNullOrEmpty(container.Column.Caption) ? container.Column.Caption : container.Column.FieldName;
            return string.Format("{0} : {1} {2}", captionText, System.Net.WebUtility.HtmlDecode(container.GroupText), container.SummaryText);
        }
        protected bool GetChecked(int visibleIndex)
        {
            for (int i = 0; i < grid.GetChildRowCount(visibleIndex); i++)
            {
                List<ProjeFinansRaporu> a = new List<ProjeFinansRaporu>();

                var list = grid.GetChildRow(visibleIndex, i);
                a.Add(list as ProjeFinansRaporu);

                int RowNumberID = 0;
                foreach (var item in a)
                {
                    RowNumberID = item.RowNumber;
                }
                bool isRowSelected = grid.Selection.IsRowSelectedByKey(RowNumberID); //bu benim kendi çözümüm. devexpress deki örnek null dönüyor.

                if (!isRowSelected)
                    return false;
            }
            return true;
        }
        protected void ASPxCallback3_Callback(object source, CallbackEventArgs e)
        {
            if(cmbSoblon.Value.ToString() == "PDF")
            {
                return; //PDF işlemi henüz aktif olmadığı için mail gönderimi yaptırtmıyorum.
            }

            string mesaj = "";
            string degerProjeID = Session["degerProjeID"].ToString();
            string degerDanismanID = Session["degerDanismanID"].ToString();
            string degerModulID = Session["degerModulID"].ToString();
            DateTime c = Convert.ToDateTime(deStart.Value);
            DateTime s = Convert.ToDateTime(deEnd.Value);
            var list = db.S_GridGroupCheckedDataSource(degerProjeID, degerDanismanID, degerModulID, c, s, Genel.KullaniciGUID).ToList();
            if (list.Count == 0)
                return;

            string OlusturmaTarihi = DateTime.Now.ToLongDateString();
            string DonemTarihi = c.ToShortDateString() + " - " + s.ToShortDateString();
            
            var alicikisiler = tbAliciKisi.Value;
            string[] alicikisi = alicikisiler.ToString().Split(';');
            string[] kisiBilgileri = alicikisi[0].ToString().Split(',');
            string firmaadi = kisiBilgileri[0].Trim().ToString();
            string kisiadi = kisiBilgileri[1].Trim().Split('(')[0].Trim().ToString();
            //string gonderilenMailAdresi = kisiBilgileri[1].Trim().Split('(')[1].Trim().Replace(")","").ToString();
            string musteriadi = firmaadi;
            string musterisorumluadi = kisiadi;
            string strHTML = File.ReadAllText(HttpContext.Current.Server.MapPath("Mail/HTML/ProjeFinansDurumu.html"));
            strHTML = strHTML.Replace("{OLUSTURMATARIHI}", OlusturmaTarihi)
                .Replace("{DONEMTARIHI}", DonemTarihi)
                .Replace("{MUSTERIADI}", musteriadi)
                .Replace("{MUSTERISORUMLUADI}", musterisorumluadi);
            string projegrid = "<tr class=\"heading\"><td>{PROJEADI}</td><td>Tutar</td></tr><tr class=\"item\"><td>{DANISMANADI}</td><td>{DANISMANTUTAR}</td></tr><tr class=\"total\"><td></td><td>Toplam: {PROJETOPLAMTUTAR}</td></tr>";
            string projegridHeader = "<tr class=\"heading\"><td>{PROJEADI}</td><td>Tutar</td></tr>";
            string projegridContent = "<tr class=\"item\"><td>{DANISMANADI}</td><td>{DANISMANTUTAR}</td></tr>";
            string projegridFooter = "<tr class=\"total\"><td></td><td>Toplam: {PROJETOPLAMTUTAR}</td></tr>";
            int projeCount = 0;
            int projeDongu = 0;
            decimal toplamTutar = 0;
            foreach (var item in list)
            {
                if (list.Where(x => x.ProjeID == item.ProjeID).ToList().Count > 1)
                {
                    if(projeCount == 0)
                        projeCount = list.Where(x => x.ProjeID == item.ProjeID).ToList().Count;

                    projeDongu++;

                    if (projeDongu == 1)
                        strHTML += projegridHeader.Replace("{PROJEADI}", item.ProjeAdi);

                    strHTML += projegridContent.Replace("{DANISMANADI}", item.DanismanAdi + ", " + item.ModulAdi + ", " + item.CalisilanSaat.ToString() + " saat")
                    .Replace("{DANISMANTUTAR}", item.ToplamFiyat.ToString());

                    if (projeDongu == projeCount)
                    {
                        strHTML += projegridFooter.Replace("{PROJETOPLAMTUTAR}", item.ProjeToplanFiyat.ToString());
                        toplamTutar = toplamTutar + Convert.ToDecimal(item.ProjeToplanFiyat);
                    }
                }
                else
                {
                        strHTML += projegrid.Replace("{PROJEADI}", item.ProjeAdi)
                    .Replace("{DANISMANADI}", item.DanismanAdi + ", " + item.ModulAdi + ", " + item.CalisilanSaat.ToString() + " saat")
                    .Replace("{DANISMANTUTAR}", item.ToplamFiyat.ToString())
                    .Replace("{PROJETOPLAMTUTAR}", item.ProjeToplanFiyat.ToString());

                    toplamTutar = toplamTutar + Convert.ToDecimal(item.ProjeToplanFiyat);
                }
            }

            string projeGridToplamTutar = "<tr class=\"heading\"><td></td><td>Toplam Tutar #</td></tr><tr class=\"details\"><td></td><td>{TOPLAMTUTAR}</td></tr>";
            projeGridToplamTutar = projeGridToplamTutar.Replace("{TOPLAMTUTAR}", toplamTutar.ToString());
            string htmlbitis = "</table></div></body></html>";
            strHTML += projeGridToplamTutar;
            strHTML += htmlbitis;

            string konu = txtKonu.Value.ToString();
            string gonderenmailadresi = txtGonderen.Value.ToString() + " <" + txtGonderenMail.Value.ToString() + ">";
            string gonderenkisiadi = txtGonderen.Value.ToString();

            //var invNo = db.IUD_Mail(Genel.DanismanID, gonderilenMailAdresi, strHTML).ToList();
            //string invoice = "INV-" + invNo.FirstOrDefault().ID.ToString();

            //strHTML = strHTML.Replace("{INVOICE}", invoice);

            string mailadresleri = "";
            foreach (var item in alicikisi)
            {
                //mailadresleri += item.Split('(')[1].Trim().Replace(")", "").ToString()+"; ";
                mailadresleri = item.Split('(')[1].Trim().Replace(")", "").ToString();
                //MailIslemleri.MailGonder(mailadresleri, konu, gonderenmailadresi, strHTML, "ProjeFinansDurumu", 1, out mesaj);
                db.IUD_Mail(Genel.DanismanID, mailadresleri, strHTML,false,null, gonderenmailadresi, konu, "ProjeFinansDurumu",false,"");
            }
            ////mailadresleri = mailadresleri.Substring(0, mailadresleri.Length - 2);
            ////string konu = txtKonu.Value.ToString();
            ////string gonderenmailadresi = txtGonderen.Value.ToString() + " <" + txtGonderenMail.Value.ToString() + ">";
            ////string gonderenkisiadi = txtGonderen.Value.ToString();
            ////MailIslemleri.MailGonder(mailadresleri, konu, gonderenmailadresi, strHTML, "ProjeFinansDurumu", 1, out mesaj);

            Session["degerProjeID"] = "";
            Session["degerDanismanID"] = "";
            Session["degerModulID"] = "";
        }




    }
}