using DXAktivite2;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

public static class DataProviderRaporlar
{
    static HttpSessionState Session { get { return HttpContext.Current.Session; } }
    static DemoDataObjectRaporlar DemoDataRaporlar
    {
        get
        {
            const string key = "FB1EB35F-86F5-4FFE-BB23-CBAAF1514C47";
            if (Session[key] == null)
            {
                var obj = new DemoDataObjectRaporlar();
                obj.FillObjTanimlar();
                Session[key] = obj;
            }
            return (DemoDataObjectRaporlar)Session[key];
        }
    }

    public static IEnumerable GetProjeFinansDurumu()
    {
        return DemoDataRaporlar.ProjeFinans;
    }

    public static IEnumerable GetProjeFinansDurumu(DateTime BasTar, DateTime BitTar)
    {
        DemoDataRaporlar.FillObjTanimlar(BasTar, BitTar);
        return DemoDataRaporlar.ProjeFinansTarih;
    }
    
}

public class DemoDataObjectRaporlar
{
    AktiviteEntities db = new AktiviteEntities();
    
    public List<ProjeFinansRaporu> ProjeFinans { get; set; }
    public List<ProjeFinansRaporu> ProjeFinansTarih { get; set; }

    public void FillObjTanimlar()
    {
        ProjeFinans = new List<ProjeFinansRaporu>();
        
        var projeFinansRaporu = db.S_RaporProjeFinansDurumu(null, null,Genel.KullaniciGUID).ToList();
        if (projeFinansRaporu.Count > 0)
        {
            foreach (var item in projeFinansRaporu)
            {
                CreateProjeFinansRaporu(
                    Convert.ToInt32(item.RowNumber),
                    Convert.ToInt32(item.ProjeID),
                    item.ProjeAdi, 
                    Convert.ToInt32(item.DanismanID),
                    item.DanismanAdi, 
                    Convert.ToInt32(item.ModulID),
                    item.ModulAdi, 
                    Convert.ToDecimal(item.Saat), 
                    Convert.ToDecimal(item.Gun),
                    Convert.ToDecimal(item.BirimFiyatSaat),
                    Convert.ToDecimal(item.BirimFiyatGun));
            }
        }
    }

    public void FillObjTanimlar(DateTime i, DateTime s)
    {
        ProjeFinansTarih = new List<ProjeFinansRaporu>();

        var projeFinansRaporu = db.S_RaporProjeFinansDurumu(i, s, Genel.KullaniciGUID).ToList();
        if (projeFinansRaporu.Count > 0)
        {
            ProjeFinansTarih.Clear();
            foreach (var item in projeFinansRaporu)
            {
                CreateProjeFinansRaporuTarih(
                    Convert.ToInt32(item.RowNumber),
                    Convert.ToInt32(item.ProjeID),
                    item.ProjeAdi,
                    Convert.ToInt32(item.DanismanID),
                    item.DanismanAdi,
                    Convert.ToInt32(item.ModulID),
                    item.ModulAdi,
                    Convert.ToInt32(item.Saat),
                    Convert.ToDecimal(item.Gun),
                    Convert.ToDecimal(item.BirimFiyatSaat),
                    Convert.ToDecimal(item.BirimFiyatGun));
            }
        }
    }

    ProjeFinansRaporu CreateProjeFinansRaporu(int _RowNumber, int _ProjeID, string _ProjeAdi, int _DanismanID, string _DanismanAdi,
        int _ModulID, string _ModulAdi, decimal _Saat, decimal _Gun, decimal _BirimFiyatSaat, decimal _BirimFiyatGun)
    {
        var c = new ProjeFinansRaporu()
        {
            RowNumber = _RowNumber,
            ProjeID = _ProjeID,
            ProjeAdi = _ProjeAdi,
            DanismanID = _DanismanID,
            DanismanAdi = _DanismanAdi,
            ModulID = _ModulID,
            ModulAdi = _ModulAdi,
            Saat = _Saat,
            Gun = _Gun,
            BirimFiyatSaat = _BirimFiyatSaat,
            BirimFiyatGun = _BirimFiyatGun
        };
        ProjeFinans.Add(c);
        return c;
    }

    ProjeFinansRaporu CreateProjeFinansRaporuTarih(int _RowNumber, int _ProjeID, string _ProjeAdi, int _DanismanID, string _DanismanAdi,
    int _ModulID, string _ModulAdi, decimal _Saat, decimal _Gun, decimal _BirimFiyatSaat, decimal _BirimFiyatGun)
    {
        var c = new ProjeFinansRaporu()
        {
            RowNumber = _RowNumber,
            ProjeID = _ProjeID,
            ProjeAdi = _ProjeAdi,
            DanismanID = _DanismanID,
            DanismanAdi = _DanismanAdi,
            ModulID = _ModulID,
            ModulAdi = _ModulAdi,
            Saat = _Saat,
            Gun = _Gun,
            BirimFiyatSaat = _BirimFiyatSaat,
            BirimFiyatGun = _BirimFiyatGun
        };
        ProjeFinansTarih.Add(c);
        return c;
    }

    
}

public class ProjeFinansRaporu
{
    public int RowNumber { get; set; }
    public int ProjeID { get; set; }
    public string ProjeAdi { get; set; }
    public int DanismanID { get; set; }
    public string DanismanAdi { get; set; }
    public int ModulID { get; set; }
    public string ModulAdi { get; set; }
    public decimal Saat { get; set; }
    public decimal Gun { get; set; }
    public decimal BirimFiyatSaat { get; set; }
    public decimal BirimFiyatGun { get; set; }
}

