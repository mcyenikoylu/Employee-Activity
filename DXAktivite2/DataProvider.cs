using DevExpress.Data.Linq;
using DXAktivite2;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

public static class DataProvider
{

    static HttpSessionState Session { get { return HttpContext.Current.Session; } }
    static DemoDataObject DemoData
    {
        get
        {
            const string key = "FB1EB35F-86F5-4FFE-BB23-CBAAF1514C49";
            if (Session[key] == null)
            {
                var obj = new DemoDataObject();
                obj.FillObj();
                Session[key] = obj;
            }
            return (DemoDataObject)Session[key];
        }
    }
    public static List<Aktivite> GetAktiviteler()
    {
        DateTime seciliHaftaninIlkGunu = Convert.ToDateTime(Session["GridAktiviteIlkGun"]); //Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, Convert.ToInt32(Session["GriddeKacinciHafta"]));
        DateTime seciliHaftaninSonGunu = Convert.ToDateTime(Session["GridAktiviteSonGun"]); //Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, Convert.ToInt32(Session["GriddeKacinciHafta"])).AddDays(6);
        return DemoData.Aktiviteler.Where(c => c.Tarih >= seciliHaftaninIlkGunu && c.Tarih <= seciliHaftaninSonGunu).ToList();
    }
    public static List<Aktivite> GetAktivitelerYenile()
    {
        DateTime seciliHaftaninIlkGunu = Convert.ToDateTime(Session["GridAktiviteIlkGun"]); //Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, Convert.ToInt32(Session["GriddeKacinciHafta"]));
        DateTime seciliHaftaninSonGunu = Convert.ToDateTime(Session["GridAktiviteSonGun"]); //Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, Convert.ToInt32(Session["GriddeKacinciHafta"])).AddDays(6);
        AktiviteEntities db = new AktiviteEntities();
        var listAktivite = db.S_Aktivite(-1, Genel.DanismanID).ToList();
        DemoData.Aktiviteler.Clear();
        if (listAktivite.Count > 0)
        {
            foreach (var item in listAktivite)
            {
                var c = new Aktivite()
                {
                    ID = item.ID,
                    Tarih = Convert.ToDateTime(item.Tarih),
                    ProjeID = Convert.ToInt32(item.ProjeID),
                    ModulID = Convert.ToInt32(item.ModulID),
                    DanismanID = Convert.ToInt32(item.DanismanID),
                    Aciklama = item.Aciklama,
                    Saat = Convert.ToDecimal(item.Saat)
                };

                DemoData.Aktiviteler.Add(c);
            }
        }
        return DemoData.Aktiviteler.Where(c => c.Tarih >= seciliHaftaninIlkGunu && c.Tarih <= seciliHaftaninSonGunu).ToList();
    }
    public static IEnumerable GetPlanlamalar()
    {
        DateTime seciliHaftaninIlkGunu = Convert.ToDateTime(Session["GridPlanIlkGun"]);//Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, Convert.ToInt32(Session["GriddeKacinciHafta"]));
        DateTime seciliHaftaninSonGunu = Convert.ToDateTime(Session["GridPlanSonGun"]);//Genel.HaftaninIlkTarihiISO8601(DateTime.Now.Year, Convert.ToInt32(Session["GriddeKacinciHafta"])).AddDays(6);
        return from z in DemoData.Planlamalar.Where(c => c.DanismanID == Genel.DanismanID)
               where z.Tarih >= seciliHaftaninIlkGunu && z.Tarih <= seciliHaftaninSonGunu
               select z;
    }
    public static IEnumerable GetProjeler()
    {
        return DemoData.Projeler;
    }
    public static IEnumerable SetProjeler(int ID, string Aciklama)
    {
        var c = new Proje
        {
            ProjeID = ID,
            ProjeAdi = Aciklama
        };
        DemoData.Projeler.Add(c);
        return DemoData.Projeler;
    }
    public static IEnumerable GetModuller()
    {
        return DemoData.Moduller;
    }
    public static IEnumerable GetModullerYenile()
    {
        AktiviteEntities db = new AktiviteEntities();
        var listDanisman = new List<S_ProjeDanisman_Result>();
        listDanisman = db.S_ProjeDanisman(-1).ToList();
        var listProje = db.S_Proje(-1).ToList();
        if (listProje.Count > 0)
        {
            foreach (var item in listProje)
            {
                //CreateProje(item.ProjeID, item.ProjeAciklama);

                foreach (var item2 in listDanisman.Where(c => c.ProjeID == item.ProjeID).GroupBy(c => c.ModulID))
                {
                    //CreateModul(
                    //    item2.FirstOrDefault().ModulID.Value,
                    //    item2.FirstOrDefault().ModulAciklama,
                    //    item2.FirstOrDefault().ProjeID.Value);
                    var c = new Modul()
                    {
                        ModulID = item2.FirstOrDefault().ModulID.Value,
                        ModulAdi = (item2.FirstOrDefault().ModulAciklama != null) ? item2.FirstOrDefault().ModulAciklama.ToString() : "",
                        ProjeID = item2.FirstOrDefault().ProjeID.Value
                    };

                    DemoData.Moduller.Add(c);

                    //return c;
                }
            }
        }
        return DemoData.Moduller;
    }
    public static IEnumerable GetAktiviteGirisindeYetkiliOlduguProjeninModulleri()
    {
        return DemoData.ModulDanismanProjeIDler;
    }
    public static IEnumerable GetAktiviteGirisindeYetkiliOlduguProjeninModulleri(int ProjeID)
    {
        return from c in DemoData.ModulDanismanProjeIDler
               where c.ProjeID == ProjeID
               select c;
    }
    public static IEnumerable SetAktiviteGirisindeYetkiliOlduguProjeninModulleri(int _ProjeID, int _ModulID)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list_moduladi = db.S_Modul(_ModulID).ToList();
        var x = new ModulDanismanProjeID()
        {
            ModulID = Convert.ToInt32(_ModulID),
            ModulAdi = list_moduladi.First().ModulAdi,
            ProjeID = Convert.ToInt32(_ProjeID)
        };
        DemoData.ModulDanismanProjeIDler.Add(x);
        return DemoData.ModulDanismanProjeIDler;
    }
    public static IEnumerable GetModuller(int projeID)
    {
        return from c in DemoData.Moduller
               where c.ProjeID == projeID
               select c;
    }
    public static IEnumerable GetDanismanlar()
    {
        return DemoData.Danismanlar;
    }
    public static IEnumerable SetDanismanlar(int _DanismanID, int _ProjeID)
    {
        AktiviteEntities db = new AktiviteEntities();
        var danismanList = db.S_Danisman(_DanismanID, null).ToList();
        var c = new Danisman
        {
            DanismanID = _DanismanID,
            DanismanAdi = danismanList.FirstOrDefault().Aciklama,
            ProjeID = _ProjeID
        };
        DemoData.Danismanlar.Add(c);
        DemoData.ModulDanismanlar.Clear();
        var a = db.S_ModulDanisman(-1).ToList();
        foreach (var item3 in a)
        {
            var z = new ModulDanisman()
            {
                ModulID = Convert.ToInt32(item3.ModulID),
                ModulAdi = item3.ModulAciklama,
                DanismanID = Convert.ToInt32(item3.DanismanID)
            };
            DemoData.ModulDanismanlar.Add(z);
        }
        return DemoData.Danismanlar;
    }
    public static IEnumerable GetDanismanlar(int projeID)
    {
        return from c in DemoData.Danismanlar
               where c.ProjeID == projeID
               select c;
    }
    public static IEnumerable GetPlanlamalarGiris()
    {
        return DemoData.PlanlamalarGiris;
    }
    public static IEnumerable GetLokasyonlar()
    {
        return DemoData.MusteriLokasyonlari;
    }
    public static IEnumerable GetMusteriler()
    {
        return DemoData.Musteriler;
    }
    public static IEnumerable GetYukleniciler()
    {
        return DemoData.Yukleniciler;
    }
    public static IEnumerable GetModullerDanisman()
    {
        return DemoData.ModulDanismanlar;
    }
    public static IEnumerable GetModullerDanisman(int danismanID)
    {
        return from c in DemoData.ModulDanismanlar
               where c.DanismanID == danismanID
               select c;
    }
    public static IEnumerable SetModullerDanisman(int _ModulID, int _DanismanID)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.S_Modul(_ModulID).ToList();
        var c = new ModulDanisman
        {
            ModulID = _ModulID,
            ModulAdi = list.FirstOrDefault().ModulAdi,
            DanismanID = _DanismanID
        };
        DemoData.ModulDanismanlar.Add(c);
        return DemoData.ModulDanismanlar;
    }
    //aktivite
    public static void InsertAktivite(int ID, string Tarih, int ProjeID, int ModulID, string Aciklama, decimal Saat)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_Aktivite(-1, Convert.ToDateTime(Tarih), ProjeID, ModulID, Genel.DanismanID, Aciklama, Saat, false).ToList();
        var c = new Aktivite()
        {
            ID = Convert.ToInt32(list.FirstOrDefault().Sonuc),
            Tarih = Convert.ToDateTime(Tarih),
            ProjeID = ProjeID,
            ModulID = ModulID,
            DanismanID = Genel.DanismanID,
            Aciklama = Aciklama,
            Saat = Saat
        };
        DemoData.Aktiviteler.Add(c);
    }
    public static void UpdateAktivite(int ID, string Tarih, int ProjeID, int ModulID, string Aciklama, decimal Saat)
    {
        AktiviteEntities db = new AktiviteEntities();
        db.IUD_Aktivite(ID, Convert.ToDateTime(Tarih), ProjeID, ModulID, Genel.DanismanID, Aciklama, Saat, false);
        var c = DemoData.Aktiviteler.First(i => i.ID == ID);
        c.Tarih = Convert.ToDateTime(Tarih);
        c.ProjeID = ProjeID;
        c.ModulID = ModulID;
        c.DanismanID = Genel.DanismanID;
        c.Aciklama = Aciklama;
        c.Saat = Saat;

    }
    public static void DeleteAktivite(int ID, bool Sil)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_Aktivite(ID, null, -1, -1, -1, "", -1, true);
        DemoData.Aktiviteler.RemoveAll(i => i.ID == ID);
    }
    //plan
    public static void InsertPlan(int ID, int DanismanID, string Tarih, int ProjeID, int ModulID, string Aciklama, decimal Saat)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_Planlama(-1, DanismanID, ModulID, ProjeID,
            -1, -1, Convert.ToDateTime(Tarih), Saat, Aciklama, false).ToList();
        var c = new PlanlamaGiris()
        {
            ID = Convert.ToInt32(list.FirstOrDefault().ID),
            DanismanID = DanismanID,
            Tarih = Convert.ToDateTime(Tarih),
            ProjeID = ProjeID,
            ModulID = ModulID,
            MusteriID = list.FirstOrDefault().MusteriID.Value,
            YukleniciID = list.FirstOrDefault().YukleniciID.Value,
            Saat = Saat,
            Aciklama = Aciklama
        };
        DemoData.PlanlamalarGiris.Add(c);

        //eğer kendi kullanıcısına planlama girdiyse, planlama listinede ekleniyor.
        if (list.FirstOrDefault().DanismanID == Genel.DanismanID)
        {
            var z = new Planlama()
            {
                ID = Convert.ToInt32(list.FirstOrDefault().ID),
                DanismanID = DanismanID,
                Tarih = Convert.ToDateTime(Tarih),
                ProjeID = ProjeID,
                ModulID = ModulID,
                MusteriID = list.FirstOrDefault().MusteriID.Value,
                YukleniciID = list.FirstOrDefault().YukleniciID.Value,
                Saat = Saat,
                Aciklama = Aciklama,
                MusteriLokasyonID = list.FirstOrDefault().LokasyonID.Value
            };
            DemoData.Planlamalar.Add(z);
        }
        GetModullerYenile();
    }
    public static void UpdatePlan(int ID, int DanismanID, string Tarih, int ProjeID, int ModulID, string Aciklama, decimal Saat)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_Planlama(ID, DanismanID, ModulID, ProjeID, -1, -1,
            Convert.ToDateTime(Tarih), Saat, Aciklama, false).ToList();
        var c = DemoData.PlanlamalarGiris.First(i => i.ID == ID);
        c.ID = ID;
        c.DanismanID = DanismanID;
        c.Tarih = Convert.ToDateTime(Tarih);
        c.ProjeID = ProjeID;
        c.ModulID = ModulID;
        c.Aciklama = Aciklama;
        c.Saat = Saat;
        c.YukleniciID = Convert.ToInt32(list.FirstOrDefault().YukleniciID);
        c.MusteriID = Convert.ToInt32(list.FirstOrDefault().MusteriID);

        if (list.FirstOrDefault().DanismanID == Genel.DanismanID)
        {
            var x = DemoData.Planlamalar.First(v => v.ID == ID);
            x.ID = ID;
            x.DanismanID = DanismanID;
            x.Tarih = Convert.ToDateTime(Tarih);
            x.ProjeID = ProjeID;
            x.ModulID = ModulID;
            x.Aciklama = Aciklama;
            x.Saat = Saat;
            x.YukleniciID = Convert.ToInt32(list.FirstOrDefault().YukleniciID);
            x.MusteriID = Convert.ToInt32(list.FirstOrDefault().MusteriID);
        }
    }
    public static void DeletePlan(int ID, bool Sil)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_Planlama(ID, -1, -1, -1, -1, -1, null, -1, "", true);
        DemoData.PlanlamalarGiris.RemoveAll(i => i.ID == ID);

        if (list.FirstOrDefault().DanismanID == Genel.DanismanID)
        {
            DemoData.Planlamalar.RemoveAll(i => i.ID == ID);
        }
    }
    //çağrı
    public static List<CagriIstek> GetCagriIstek()
    {
        return DemoData.CagriIstekleri;
    }
    public static List<CagriIstek> GetCagriIstekOnaylananlar()
    {
        return DemoData.CagriIstekleriOnaylananlar;
    }
    public static List<Tip> GetTipler()
    {
        return DemoData.Tipler;
    }
    public static List<Cagri> GetBekleyenCagrilar()
    {
        return DemoData.BekleyenCagrilar;
    }
    public static List<Cagri> GetBekleyenCagrilarYenile()
    {
        AktiviteEntities db = new AktiviteEntities();
        //var list = db.S_Cagri(-1, Genel.DanismanID, 1).ToList();
        var list = db.S_Cagri(-1, Genel.DanismanID, 1).Skip(0).Take(1000).ToList();
        DemoData.BekleyenCagrilar.Clear();
        foreach (var item in list)
        {
            var c = new Cagri
            {
                ID = item.ID,
                CagriIstekID = item.CagriIstekID,
                CagriIstekKayitTarihiSaati = Convert.ToDateTime(item.CagriIstekKayitTarihiSaati),
                InternalTicketNumber = item.InternalTicketNumber,
                ExternalTicketNumber = item.ExternalTicketNumber,
                AlternativeTicketNumber = item.AlternativeTicketNumber,
                IstekSahibiAdiSoyadi = item.IstekSahibiAdiSoyadi,
                IstekTarihiSaati = Convert.ToDateTime(item.IstekTarihiSaati),
                IstekSirketAdi = item.IstekSirketAdi,
                IstekSirketKodu = item.IstekSirketKodu,
                IstekAciklama = item.IstekAciklama,
                SistemKayitTarihiSaati = item.SistemKayitTarihiSaati,
                AtananDanismanID = item.AtananDanismanID,
                YonlendirilenDanismanID = item.YonlendirilenDanismanID,
                YonlendirilenDanismanTarihSaati = Convert.ToDateTime(item.YonlendirilenDanismanTarihSaati),
                KayitOlusturanKullaniciID = item.KayitOlusturanKullaniciID ?? Guid.Empty,
                KayitDegistirenKullaniciID = item.KayitDegistirenKullaniciID ?? Guid.Empty,
                CagriDurumu_TipID1 = item.CagriDurumu_TipID1
            };
            DemoData.BekleyenCagrilar.Add(c);
        }
        return DemoData.BekleyenCagrilar;
    }
    public static List<CagriTumu> GetBekleyenCagrilarTumu()
    {
        return DemoData.BekleyenCagrilarTumu;
    }
    public static List<CagriTumu> GetBekleyenCagrilarTumuYenile()
    {
        AktiviteEntities db = new AktiviteEntities();
        var listBekleyenCagriTumu = db.S_CagriTumu(1).Skip(0).Take(1000).ToList();
        if (listBekleyenCagriTumu.Count > 0)
        {
            DemoData.BekleyenCagrilarTumu.Clear();
            foreach (var item in listBekleyenCagriTumu)
            {
                DemoData.CreateBekleyenCagrilarTumu(item.ID,
                    item.CagriIstekID,
                    Convert.ToDateTime(item.CagriIstekKayitTarihiSaati),
                    item.InternalTicketNumber,
                    item.ExternalTicketNumber,
                    item.AlternativeTicketNumber,
                    item.IstekSahibiAdiSoyadi,
                    Convert.ToDateTime(item.IstekTarihiSaati),
                    item.IstekSirketAdi,
                    item.IstekSirketKodu,
                    item.IstekAciklama,
                    item.SistemKayitTarihiSaati,
                    item.AtananDanismanID,
                    item.YonlendirilenDanismanID,
                    Convert.ToDateTime(item.YonlendirilenDanismanTarihSaati),
                    item.KayitOlusturanKullaniciID ?? Guid.Empty,
                    item.KayitDegistirenKullaniciID ?? Guid.Empty,
                    item.CagriDurumu_TipID1,
                    item.ModulAdi,
                    item.DanismanAdi,
                    item.YonlendirilenDanismanAdi,
                    item.DurumAdi);
            }
        }
        return DemoData.BekleyenCagrilarTumu;
    }
    public static List<Cagri> GetAcikCagrilar()
    {
        return DemoData.AcikCagrilar;
    }
    public static List<CagriTumu> GetAcikCagrilarTumu()
    {
        return DemoData.AcikCagrilarTumu;
    }
    public static List<Cagri> GetKapaliCagrilarim()
    {
        return DemoData.KapaliCagrilarim;
    }
    public static List<CagriTumu> GetKapaliCagrilarTumu()
    {
        return DemoData.KapaliCagrilarTumu;
    }
    public static List<Cagri> GetKapaliCagrilarimYenile()
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.S_Cagri(-1, Genel.DanismanID, 4).ToList();
        DemoData.KapaliCagrilarim.Clear();
        foreach (var item in list)
        {
            var c = new Cagri
            {
                ID = item.ID,
                CagriIstekID = item.CagriIstekID,
                CagriIstekKayitTarihiSaati = Convert.ToDateTime(item.CagriIstekKayitTarihiSaati),
                InternalTicketNumber = item.InternalTicketNumber,
                ExternalTicketNumber = item.ExternalTicketNumber,
                AlternativeTicketNumber = item.AlternativeTicketNumber,
                IstekSahibiAdiSoyadi = item.IstekSahibiAdiSoyadi,
                IstekTarihiSaati = Convert.ToDateTime(item.IstekTarihiSaati),
                IstekSirketAdi = item.IstekSirketAdi,
                IstekSirketKodu = item.IstekSirketKodu,
                IstekAciklama = item.IstekAciklama,
                SistemKayitTarihiSaati = item.SistemKayitTarihiSaati,
                AtananDanismanID = item.AtananDanismanID,
                YonlendirilenDanismanID = item.YonlendirilenDanismanID,
                YonlendirilenDanismanTarihSaati = Convert.ToDateTime(item.YonlendirilenDanismanTarihSaati),
                KayitOlusturanKullaniciID = item.KayitOlusturanKullaniciID ?? Guid.Empty,
                KayitDegistirenKullaniciID = item.KayitDegistirenKullaniciID ?? Guid.Empty,
                CagriDurumu_TipID1 = item.CagriDurumu_TipID1
            };
            DemoData.KapaliCagrilarim.Add(c);
        }
        return DemoData.KapaliCagrilarim;
    }
    public static List<Cagri> GetAcikCagrilarimYenile()
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.S_Cagri(-1, Genel.DanismanID, 2).ToList();
        //var list = db.S_Cagri(-1, Genel.DanismanID, 2).Skip(0).Take(1000).ToList();
        DemoData.AcikCagrilar.Clear();
        foreach (var item in list)
        {
            var c = new Cagri
            {
                ID = item.ID,
                CagriIstekID = item.CagriIstekID,
                CagriIstekKayitTarihiSaati = Convert.ToDateTime(item.CagriIstekKayitTarihiSaati),
                InternalTicketNumber = item.InternalTicketNumber,
                ExternalTicketNumber = item.ExternalTicketNumber,
                AlternativeTicketNumber = item.AlternativeTicketNumber,
                IstekSahibiAdiSoyadi = item.IstekSahibiAdiSoyadi,
                IstekTarihiSaati = Convert.ToDateTime(item.IstekTarihiSaati),
                IstekSirketAdi = item.IstekSirketAdi,
                IstekSirketKodu = item.IstekSirketKodu,
                IstekAciklama = item.IstekAciklama,
                SistemKayitTarihiSaati = item.SistemKayitTarihiSaati,
                AtananDanismanID = item.AtananDanismanID,
                YonlendirilenDanismanID = item.YonlendirilenDanismanID,
                YonlendirilenDanismanTarihSaati = Convert.ToDateTime(item.YonlendirilenDanismanTarihSaati),
                KayitOlusturanKullaniciID = item.KayitOlusturanKullaniciID ?? Guid.Empty,
                KayitDegistirenKullaniciID = item.KayitDegistirenKullaniciID ?? Guid.Empty,
                CagriDurumu_TipID1 = item.CagriDurumu_TipID1,
                DosyaEkleri = item.DosyaEkleri,
                CagriTestiAciklamasi = item.CagriTestiAciklamasi
                
            };
            DemoData.AcikCagrilar.Add(c);
        }

        return DemoData.AcikCagrilar;
    }
    public static List<CagriIstek> GetCagriIstekYenile()
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.S_CagriIstek(-1).ToList();
        //var list = db.S_CagriIstek(-1).Skip(0).Take(1000).ToList();
        DemoData.CagriIstekleri.Clear();
        foreach (var item in list)
        {
            var c = new CagriIstek()
            {
                ID = Convert.ToInt32(item.ID),
                ExternalTicketNumber = item.ExternalTicketNumber,
                AlternativeTicketNumber = item.AlternativeTicketNumber,
                IstekSahibiAdiSoyadi = item.IstekSahibiAdiSoyadi,
                IstekTarihiSaati = Convert.ToDateTime(item.IstekTarihiSaati),
                IstekSirketAdi = item.IstekSirketAdi,
                IstekSirketKodu = item.IstekSirketKodu,
                IstekAciklama = item.IstekAciklama,
                SistemKayitTarihiSaati = item.SistemKayitTarihiSaati,
                KaynakYoneticisiOnayi_TipID4 = Convert.ToInt32(item.KaynakYoneticisiOnayi_TipID4),
                OnemDerecesi = item.OnemDerecesi
            };
            DemoData.CagriIstekleri.Add(c);
        }
        return DemoData.CagriIstekleri;
    }
    public static List<CagriIstek> GetCagriIstekOnaylananlarYenile()
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.S_CagriIstekOnaylananlar(-1).ToList();
        //var list = db.S_CagriIstek(-1).Skip(0).Take(1000).ToList();
        DemoData.CagriIstekleriOnaylananlar.Clear();
        foreach (var item in list)
        {
            var c = new CagriIstek()
            {
                ID = Convert.ToInt32(item.ID),
                ExternalTicketNumber = item.ExternalTicketNumber,
                AlternativeTicketNumber = item.AlternativeTicketNumber,
                IstekSahibiAdiSoyadi = item.IstekSahibiAdiSoyadi,
                IstekTarihiSaati = Convert.ToDateTime(item.IstekTarihiSaati),
                IstekSirketAdi = item.IstekSirketAdi,
                IstekSirketKodu = item.IstekSirketKodu,
                IstekAciklama = item.IstekAciklama,
                SistemKayitTarihiSaati = item.SistemKayitTarihiSaati,
                KaynakYoneticisiOnayi_TipID4 = Convert.ToInt32(item.KaynakYoneticisiOnayi_TipID4),
                OnemDerecesi = item.OnemDerecesi
            };
            DemoData.CagriIstekleriOnaylananlar.Add(c);
        }
        return DemoData.CagriIstekleriOnaylananlar;
    }
    public static List<AktiviteyeYetkiliDanismanProjeleri> GetAktiviteGirisi()
    {
        return DemoData.AktiviteDanismanProjeleri;
    }
    public static IEnumerable SetAktiviteDanismanProjeleri(int _ProjeID, int _DanismanID, int _ModulID)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list_AciklamaAlanlari = db.S_AktivteGirisBilgileriYenileme(_ProjeID, _DanismanID, _ModulID).ToList();
        var c = new AktiviteyeYetkiliDanismanProjeleri
        {
            ProjeID = _ProjeID,
            ProjeAdi = list_AciklamaAlanlari.First().ProjeAdi,
            ModulID = _ModulID,
            ModulAdi = list_AciklamaAlanlari.First().ModulAdi,
            DanismanID = _DanismanID,
            DanismanAdi = list_AciklamaAlanlari.First().DanismanAdi
        };
        DemoData.AktiviteDanismanProjeleri.Add(c);
        return DemoData.AktiviteDanismanProjeleri;
    }
    public static List<KisiKarti> GetKisiler()
    {
        return DemoData.Kisiler;
    }
    public static List<MusteriKarti> GetMusteriKartlari()
    {
        return DemoData.MusteriKartlari;
    }
    public static List<YukleniciKarti> GetYukleniciKartlari()
    {
        return DemoData.YukleniciKartlari;
    }
    public static List<AktivitelerTumu> GetAktivitelerTumu()
    {
        return DemoData.AktiviteTumu;
    }
    public static List<ProjelerTumu> GetProjelerTumu()
    {
        return DemoData.ProjeTumu;
    }
    public static List<ModullerTumu> GetModullerTumu()
    {
        return DemoData.ModulTumu;
    }
    public static List<DanismanlarTumu> GetDanismanlarTumu()
    {
        return DemoData.DanismanTumu;
    }
    public static List<R_AktiviteDestek_Result> GetAktiviteDestek()
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.R_AktiviteDestek(null,null).ToList();
        return list;
    }
    public static List<R_AktiviteDestek_Result> GetAktiviteDestek(DateTime baslangicTarihi, DateTime bitisTarihi)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.R_AktiviteDestek(baslangicTarihi,bitisTarihi).ToList();
        return list;
    }
    public static List<R_AktiviteDestek2_Result> GetAktiviteDestek2()
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.R_AktiviteDestek2(null, null).ToList();
        return list;
    }
    public static List<R_AktiviteDestek2_Result> GetAktiviteDestek2(DateTime baslangicTarihi, DateTime bitisTarihi)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.R_AktiviteDestek2(baslangicTarihi, bitisTarihi).ToList();
        return list;
    }
    public static List<R_AktiviteDestekDetail_Result> GetDetailGridAktiviteDestek()
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.R_AktiviteDestekDetail().ToList();
        return list;
    }
    public static IEnumerable GetProjeyeSirketBagla()
    {
        return DemoData.ProjeyeSirketBaglamalari;
    }
    //PROJE ŞİRKET BAĞLAMA
    public static void InsertProjeSirket(int ProjeID, Guid SirketId)
    {
        AktiviteEntities db = new AktiviteEntities();
        db.I_ProjeyeSirketBagla(ProjeID, SirketId);//IUD_ProjeDanisman(ID, ProjeID, DanismanID, ModulID, FiyatGun, false);
        var list = db.S_ProjeyeSirketBagla().ToList();
        DemoData.ProjeyeSirketBaglamalari.Clear();
        foreach (var item in list)
        {
            var c = new ProjeSirketBagla
            {
                ID = item.ID,
                ProjeID = (int)item.ProjeID,
                SirketID = (Guid)item.SirketID
            };
            DemoData.ProjeyeSirketBaglamalari.Add(c);
        }
    }
    public static void UpdateProjeSirket(int ID, int ProjeID, Guid SirketId)
    {
        AktiviteEntities db = new AktiviteEntities();
        db.U_ProjeyeSirketBagla(ID, ProjeID, SirketId);
        var list = db.S_ProjeyeSirketBagla().ToList();
        DemoData.ProjeyeSirketBaglamalari.Clear();
        foreach (var item in list)
        {
            var c = new ProjeSirketBagla
            {
                ID = item.ID,
                ProjeID = (int)item.ProjeID,
                SirketID = (Guid)item.SirketID
            };
            DemoData.ProjeyeSirketBaglamalari.Add(c);
        }
    }
    public static void DeleteProjeSirket(int ID)
    {
        AktiviteEntities db = new AktiviteEntities();
        db.D_ProjeyeSirketBagla(ID);
        var list = db.S_ProjeyeSirketBagla().ToList();
        DemoData.ProjeyeSirketBaglamalari.Clear();
        foreach (var item in list)
        {
            var c = new ProjeSirketBagla
            {
                ID = item.ID,
                ProjeID = (int)item.ProjeID,
                SirketID = (Guid)item.SirketID
            };
            DemoData.ProjeyeSirketBaglamalari.Add(c);
        }
    }

    public class DemoDataObject
    {
        AktiviteEntities db = new AktiviteEntities();
        public List<Proje> Projeler { get; set; }
        public List<Modul> Moduller { get; set; }
        public List<Aktivite> Aktiviteler { get; set; }
        public List<Planlama> Planlamalar { get; set; }
        public List<Danisman> Danismanlar { get; set; }
        public List<PlanlamaGiris> PlanlamalarGiris { get; set; }
        public List<MusteriLokasyon> MusteriLokasyonlari { get; set; }
        public List<Musteri> Musteriler { get; set; }
        public List<Yuklenici> Yukleniciler { get; set; }
        public List<ModulDanisman> ModulDanismanlar { get; set; }
        public List<Planlama> PlanlamalarBuHafta { get; set; }
        public List<Aktivite> AktivitelerBuHafta { get; set; }
        public List<CagriIstek> CagriIstekleri { get; set; }
        public List<CagriIstek> CagriIstekleriOnaylananlar { get; set; }
        public List<Cagri> BekleyenCagrilar { get; set; }
        public List<CagriTumu> BekleyenCagrilarTumu { get; set; }
        public List<Cagri> AcikCagrilar { get; set; }
        public List<Cagri> KapaliCagrilarim { get; set; }
        public List<CagriTumu> KapaliCagrilarTumu { get; set; }
        public List<CagriTumu> AcikCagrilarTumu { get; set; }
        public List<AktiviteyeYetkiliDanismanProjeleri> AktiviteDanismanProjeleri { get; set; }
        public List<ModulDanismanProjeID> ModulDanismanProjeIDler { get; set; }
        public List<KisiKarti> Kisiler { get; set; }
        public List<MusteriKarti> MusteriKartlari { get; set; }
        public List<YukleniciKarti> YukleniciKartlari { get; set; }
        public List<ProjelerTumu> ProjeTumu { get; set; }
        public List<DanismanlarTumu> DanismanTumu { get; set; }
        public List<ModullerTumu> ModulTumu { get; set; }
        public List<AktivitelerTumu> AktiviteTumu { get; set; }
        public List<Tip> Tipler { get; set; }
        public List<ProjeSirketBagla> ProjeyeSirketBaglamalari { get; set; }
        public void FillObj()
        {
            Aktiviteler = new List<Aktivite>();
            Projeler = new List<Proje>();
            Moduller = new List<Modul>();
            Planlamalar = new List<Planlama>();
            Danismanlar = new List<Danisman>();
            PlanlamalarGiris = new List<PlanlamaGiris>();
            MusteriLokasyonlari = new List<MusteriLokasyon>();
            Musteriler = new List<Musteri>();
            Yukleniciler = new List<Yuklenici>();
            ModulDanismanlar = new List<ModulDanisman>();
            CagriIstekleri = new List<CagriIstek>();
            CagriIstekleriOnaylananlar = new List<CagriIstek>();
            BekleyenCagrilar = new List<Cagri>();
            AcikCagrilar = new List<Cagri>();
            KapaliCagrilarim = new List<Cagri>();
            BekleyenCagrilarTumu = new List<CagriTumu>();
            KapaliCagrilarTumu = new List<CagriTumu>();
            AcikCagrilarTumu = new List<CagriTumu>();
            AktiviteDanismanProjeleri = new List<AktiviteyeYetkiliDanismanProjeleri>();
            ModulDanismanProjeIDler = new List<ModulDanismanProjeID>();
            Kisiler = new List<KisiKarti>();
            MusteriKartlari = new List<MusteriKarti>();
            YukleniciKartlari = new List<YukleniciKarti>();
            ProjeTumu = new List<ProjelerTumu>();
            DanismanTumu = new List<DanismanlarTumu>();
            ModulTumu = new List<ModullerTumu>();
            AktiviteTumu = new List<AktivitelerTumu>();
            Tipler = new List<Tip>();
            ProjeyeSirketBaglamalari = new List<ProjeSirketBagla>();
            #region aktivite
            var listAktivite = db.S_Aktivite(-1, Genel.DanismanID).ToList();
            if (listAktivite.Count > 0)
            {
                foreach (var item in listAktivite)
                {
                    CreateAktivite(
                        item.ID,
                        item.Tarih.Value,
                        item.ProjeID.Value,
                        item.ModulID.Value,
                        item.DanismanID.Value,
                        item.Aciklama,
                        item.Saat.Value
                        );
                }
            }
            #endregion
            #region proje
            var listDanisman = new List<S_ProjeDanisman_Result>();
            listDanisman = db.S_ProjeDanisman(-1).ToList();
            var listProje = db.S_Proje(-1).ToList();
            if (listProje.Count > 0)
            {
                foreach (var item in listProje)
                {
                    CreateProje(item.ProjeID, item.ProjeAciklama);

                    foreach (var item2 in listDanisman.Where(c => c.ProjeID == item.ProjeID).GroupBy(c => c.ModulID))
                    {
                        CreateModul(
                            item2.FirstOrDefault().ModulID.Value,
                            item2.FirstOrDefault().ModulAciklama,
                            item2.FirstOrDefault().ProjeID.Value);
                    }
                }
            }
            #endregion
            #region modül danışmanlar
            //danişmana göre modüller
            var a = db.S_ModulDanisman(-1).ToList();
            foreach (var item3 in a)
            {
                CreateModulDanisman(item3.ModulID.Value,
                        item3.ModulAciklama,
                        item3.DanismanID.Value);
            }
            #endregion
            #region planlar
            //planlamalarım
            //DateTime i = Genel.FirstDateOfWeekISO8601(DateTime.Now.Year, _Default.kacinciHafta);
            //DateTime s = Genel.FirstDateOfWeekISO8601(DateTime.Now.Year, _Default.kacinciHafta).AddDays(6);
            var listplanlama = new List<S_Planlama_Result>();
            //listplanlama = db.S_Planlama(-1, Genel.DanismanID).Where(c => c.Tarih >= i && c.Tarih <= s).ToList();
            listplanlama = db.S_Planlama(-1, Genel.DanismanID).ToList();
            if (listplanlama.Count > 0)
            {
                Planlamalar.Clear();
                foreach (var item in listplanlama)
                {
                    CreatePlanlama(item.ID,
                       Convert.ToInt32(item.DanismanID),
                       Convert.ToInt32(item.ModulID),
                       Convert.ToInt32(item.ProjeID),
                       Convert.ToInt32(item.YukleniciID),
                       Convert.ToInt32(item.MusteriID),
                       Convert.ToDateTime(item.Tarih),
                       item.Aciklama,
                       Convert.ToDecimal(item.Saat),
                       Convert.ToInt32(item.MusteriLokasyonID),
                       item.MusteriLokasyonAdi);
                }
            }
            #endregion
            #region planlar bu hafta
            ////planlamalarım
            //var listplanlamaBuHafta = new List<S_Planlama_Result>();
            //listplanlamaBuHafta = db.S_Planlama(-1, Genel.DanismanID).Where(c => c.Tarih >= i && c.Tarih <= s).ToList();
            ////listplanlamaBuHafta = db.S_Planlama(-1, Genel.DanismanID).ToList();
            //if (listplanlamaBuHafta.Count > 0)
            //{
            //    PlanlamalarBuHafta.Clear();
            //    foreach (var item in listplanlamaBuHafta)
            //    {
            //        CreatePlanlamaBuHafta(item.ID,
            //           Convert.ToInt32(item.DanismanID),
            //           Convert.ToInt32(item.ModulID),
            //           Convert.ToInt32(item.ProjeID),
            //           Convert.ToInt32(item.YukleniciID),
            //           Convert.ToInt32(item.MusteriID),
            //           Convert.ToDateTime(item.Tarih),
            //           item.Aciklama,
            //           Convert.ToInt32(item.Saat),
            //           Convert.ToInt32(item.MusteriLokasyonID),
            //           item.MusteriLokasyonAdi);
            //    }
            //}
            #endregion
            #region aktiviteler bu hafta
            //var listaktivitelerbuhafta = new List<S_Aktivite_Result>();
            //listaktivitelerbuhafta= db.S_Aktivite(-1, Genel.DanismanID).Where(c => c.Tarih >= i && c.Tarih <= s).ToList();
            //if(listaktivitelerbuhafta.Count>0)
            //{
            //    AktivitelerBuHafta.Clear();
            //    foreach (var item in listaktivitelerbuhafta)
            //    {
            //        CreateAktiviteBuHafta(item.ID,
            //            Convert.ToDateTime(item.Tarih),
            //            Convert.ToInt32(item.ProjeID),
            //            Convert.ToInt32(item.ModulID),
            //            Convert.ToInt32(item.DanismanID),
            //            item.Aciklama,
            //            Convert.ToInt32(item.Saat));
            //    }
            //}
            #endregion
            #region proje bazında danışmanlar
            //danışmanlar
            var listdanismaninProjeleri = db.S_DanismaninProjeleri(-1).ToList();
            if (listdanismaninProjeleri.Count > 0)
            {
                foreach (var item in listdanismaninProjeleri)
                {
                    CreateDanismanProje(
                        item.DanismanID,
                        item.Aciklama,
                        Convert.ToInt32(item.ProjeID));
                }
            }

            #endregion
            #region planlama giriş
            //planlama giriş
            //DateTime ix = Genel.FirstDateOfWeekISO8601(DateTime.Now.Year, _Default.kacinciHafta);
            //DateTime sy = Genel.FirstDateOfWeekISO8601(DateTime.Now.Year, _Default.kacinciHafta).AddDays(6);
            var listplanlamagiris = new List<S_Planlama_Result>();
            //listplanlamagiris = db.S_Planlama(-1, -1).Where(c => c.Tarih >= i && c.Tarih <= s).ToList();
            listplanlamagiris = db.S_Planlama(-1, -1).ToList();
            if (listplanlamagiris.Count > 0)
            {
                foreach (var item in listplanlamagiris)
                {
                    CreatePlanlamaGiris(item.ID,
                       Convert.ToInt32(item.DanismanID),
                       Convert.ToInt32(item.ModulID),
                       Convert.ToInt32(item.ProjeID),
                       Convert.ToInt32(item.YukleniciID),
                       Convert.ToInt32(item.MusteriID),
                       Convert.ToDateTime(item.Tarih),
                       item.Aciklama,
                       Convert.ToDecimal(item.Saat));
                }
            }
            #endregion
            #region müsteri lokasyonları


            //müşteri lokasyonları
            var listmusterilokasyon = db.S_MusteriLokasyon(-1).ToList();
            if (listmusterilokasyon.Count > 0)
            {
                foreach (var item in listmusterilokasyon)
                {
                    CreateMusteriLokasyon(item.ID, item.Aciklama, Convert.ToInt32(item.MusteriID));
                }
            }
            #endregion
            #region müşteriler


            //muüşteriler
            var listmusteriler = db.S_Musteriler(-1).ToList();
            if (listmusteriler.Count > 0)
            {
                foreach (var item in listmusteriler)
                {
                    CreateMusteriler(item.ID, item.Aciklama, Convert.ToInt32(item.ProjeID));

                }
            }
            #endregion
            #region yüklenicier


            //yükleniciler
            var listyukleniciler = db.S_Yukleniciler(-1).ToList();
            if (listyukleniciler.Count > 0)
            {
                foreach (var item in listyukleniciler)
                {
                    CreateYukleniciler(item.ID, item.Aciklama, Convert.ToInt32(item.ProjeID));
                }
            }
            #endregion
            #region cagri istekleri
            var listCagriIstekleri = db.S_CagriIstek(-1).ToList();
            //var listCagriIstekleri = db.S_CagriIstek(-1).Skip(0).Take(1000).ToList();
            if (listCagriIstekleri.Count > 0)
            {
                foreach (var item in listCagriIstekleri)
                {
                    CreateCagriIstek(item.ID,
                        item.ExternalTicketNumber,
                        item.AlternativeTicketNumber,
                        item.IstekSahibiAdiSoyadi,
                        Convert.ToDateTime(item.IstekTarihiSaati),
                        item.IstekSirketAdi,
                        item.IstekSirketKodu,
                        item.IstekAciklama,
                        item.SistemKayitTarihiSaati,
                        item.OnemDerecesi,
                        Convert.ToInt32(item.KaynakYoneticisiOnayi_TipID4));
                }
            }
            #endregion
            #region çağrı istekleri onaylananlar
            var listCagriIstekleriOnaylananlar = db.S_CagriIstekOnaylananlar(-1).ToList();

            if (listCagriIstekleriOnaylananlar.Count > 0)
            {
                foreach (var item in listCagriIstekleriOnaylananlar)
                {
                    CreateCagriIstekOnaylananlar(item.ID,
                        item.ExternalTicketNumber,
                        item.AlternativeTicketNumber,
                        item.IstekSahibiAdiSoyadi,
                        Convert.ToDateTime(item.IstekTarihiSaati),
                        item.IstekSirketAdi,
                        item.IstekSirketKodu,
                        item.IstekAciklama,
                        item.SistemKayitTarihiSaati,
                        item.OnemDerecesi,
                        Convert.ToInt32(item.KaynakYoneticisiOnayi_TipID4));
                }
            }
            #endregion
            #region bekleyen cagri
            var listBekleyenCagri = db.S_Cagri(-1, Genel.DanismanID, 1).ToList();
            if (listBekleyenCagri.Count > 0)
            {
                foreach (var item in listBekleyenCagri)
                {
                    CreateBekleyenCagrilar(item.ID,
                        item.CagriIstekID,
                        Convert.ToDateTime(item.CagriIstekKayitTarihiSaati),
                        item.InternalTicketNumber,
                        item.ExternalTicketNumber,
                        item.AlternativeTicketNumber,
                        item.IstekSahibiAdiSoyadi,
                        Convert.ToDateTime(item.IstekTarihiSaati),
                        item.IstekSirketAdi,
                        item.IstekSirketKodu,
                        item.IstekAciklama,
                        item.SistemKayitTarihiSaati,
                        item.AtananDanismanID,
                        item.YonlendirilenDanismanID,
                        Convert.ToDateTime(item.YonlendirilenDanismanTarihSaati),
                        item.KayitOlusturanKullaniciID ?? Guid.Empty,
                        item.KayitDegistirenKullaniciID ?? Guid.Empty,
                        item.CagriDurumu_TipID1);
                }
            }
            #endregion
            #region bekleyen cagri tumu
            //var listBekleyenCagriTumu = db.S_CagriTumu(1)
            var listBekleyenCagriTumu = db.S_CagriTumu(1).Skip(0).Take(1000).ToList();
            if (listBekleyenCagriTumu.Count > 0)
            {
                foreach (var item in listBekleyenCagriTumu)
                {
                    CreateBekleyenCagrilarTumu(item.ID,
                        item.CagriIstekID,
                        Convert.ToDateTime(item.CagriIstekKayitTarihiSaati),
                        item.InternalTicketNumber,
                        item.ExternalTicketNumber,
                        item.AlternativeTicketNumber,
                        item.IstekSahibiAdiSoyadi,
                        Convert.ToDateTime(item.IstekTarihiSaati),
                        item.IstekSirketAdi,
                        item.IstekSirketKodu,
                        item.IstekAciklama,
                        item.SistemKayitTarihiSaati,
                        item.AtananDanismanID,
                        item.YonlendirilenDanismanID,
                        Convert.ToDateTime(item.YonlendirilenDanismanTarihSaati),
                        item.KayitOlusturanKullaniciID ?? Guid.Empty,
                        item.KayitDegistirenKullaniciID ?? Guid.Empty,
                        item.CagriDurumu_TipID1,
                        item.ModulAdi,
                        item.DanismanAdi,
                        item.YonlendirilenDanismanAdi,
                        item.DurumAdi);
                }
            }
            #endregion
            #region açık çağrılar
            var listAcikCagrilar = db.S_Cagri(-1, Genel.DanismanID, 2).ToList();
            //var listAcikCagrilar = db.S_Cagri(-1, Genel.DanismanID, 2).Skip(464300).Take(464318).ToList();
            if (listAcikCagrilar.Count > 0)
            {
                foreach (var item in listAcikCagrilar)
                {
                    CreateAcikCagrilar(item.ID,
                        item.CagriIstekID,
                        Convert.ToDateTime(item.CagriIstekKayitTarihiSaati),
                        item.InternalTicketNumber,
                        item.ExternalTicketNumber,
                        item.AlternativeTicketNumber,
                        item.IstekSahibiAdiSoyadi,
                        Convert.ToDateTime(item.IstekTarihiSaati),
                        item.IstekSirketAdi,
                        item.IstekSirketKodu,
                        item.IstekAciklama,
                        item.SistemKayitTarihiSaati,
                        item.AtananDanismanID,
                        item.YonlendirilenDanismanID,
                        Convert.ToDateTime(item.YonlendirilenDanismanTarihSaati),
                        item.KayitOlusturanKullaniciID ?? Guid.Empty,
                        item.KayitDegistirenKullaniciID ?? Guid.Empty,
                        item.CagriDurumu_TipID1,
                        item.DosyaEkleri,
                        item.CagriTestiAciklamasi);
                }
            }
            #endregion
            #region kapalı çağrılarım
            //var listKapaliCagrilarim = db.S_Cagri(-1, Genel.DanismanID, 4)
            var listKapaliCagrilarim = db.S_Cagri(-1, Genel.DanismanID, 4).Skip(0).Take(1000).ToList();
            if (listKapaliCagrilarim.Count > 0)
            {
                foreach (var item in listKapaliCagrilarim)
                {
                    CreateKapaliCagrilar(item.ID,
                        item.CagriIstekID,
                        Convert.ToDateTime(item.CagriIstekKayitTarihiSaati),
                        item.InternalTicketNumber,
                        item.ExternalTicketNumber,
                        item.AlternativeTicketNumber,
                        item.IstekSahibiAdiSoyadi,
                        Convert.ToDateTime(item.IstekTarihiSaati),
                        item.IstekSirketAdi,
                        item.IstekSirketKodu,
                        item.IstekAciklama,
                        item.SistemKayitTarihiSaati,
                        item.AtananDanismanID,
                        item.YonlendirilenDanismanID,
                        Convert.ToDateTime(item.YonlendirilenDanismanTarihSaati),
                        item.KayitOlusturanKullaniciID ?? Guid.Empty,
                        item.KayitDegistirenKullaniciID ?? Guid.Empty,
                        item.CagriDurumu_TipID1);
                }
            }
            #endregion
            #region kapalı çağrılar tumu
            //var listKapaliCagrilarTumu = db.S_CagriTumu(4)
            var listKapaliCagrilarTumu = db.S_CagriTumu(4).Skip(0).Take(1000).ToList();
            if (listKapaliCagrilarTumu.Count > 0)
            {
                foreach (var item in listKapaliCagrilarTumu)
                {
                    CreateKapaliCagrilarTumu(item.ID,
                        item.CagriIstekID,
                        Convert.ToDateTime(item.CagriIstekKayitTarihiSaati),
                        item.InternalTicketNumber,
                        item.ExternalTicketNumber,
                        item.AlternativeTicketNumber,
                        item.IstekSahibiAdiSoyadi,
                        Convert.ToDateTime(item.IstekTarihiSaati),
                        item.IstekSirketAdi,
                        item.IstekSirketKodu,
                        item.IstekAciklama,
                        item.SistemKayitTarihiSaati,
                        item.AtananDanismanID,
                        item.YonlendirilenDanismanID,
                        Convert.ToDateTime(item.YonlendirilenDanismanTarihSaati),
                        item.KayitOlusturanKullaniciID ?? Guid.Empty,
                        item.KayitDegistirenKullaniciID ?? Guid.Empty,
                        item.CagriDurumu_TipID1,
                        item.ModulAdi,
                        item.DanismanAdi,
                        item.YonlendirilenDanismanAdi,
                        item.DurumAdi);
                }
            }
            #endregion
            #region açık çağrılar tumu
            //var listAcikCagrilarTumu = db.S_CagriTumu(2).ToList();
            var listAcikCagrilarTumu = db.S_CagriTumu(2).Skip(0).Take(1000).OrderByDescending(c => c.ID).ToList();
            if (listAcikCagrilarTumu.Count > 0)
            {
                foreach (var item in listAcikCagrilarTumu)
                {
                    CreateAcikCagrilarTumu(item.ID,
                        item.CagriIstekID,
                        Convert.ToDateTime(item.CagriIstekKayitTarihiSaati),
                        item.InternalTicketNumber,
                        item.ExternalTicketNumber,
                        item.AlternativeTicketNumber,
                        item.IstekSahibiAdiSoyadi,
                        Convert.ToDateTime(item.IstekTarihiSaati),
                        item.IstekSirketAdi,
                        item.IstekSirketKodu,
                        item.IstekAciklama,
                        item.SistemKayitTarihiSaati,
                        item.AtananDanismanID,
                        item.YonlendirilenDanismanID,
                        Convert.ToDateTime(item.YonlendirilenDanismanTarihSaati),
                        item.KayitOlusturanKullaniciID ?? Guid.Empty,
                        item.KayitDegistirenKullaniciID ?? Guid.Empty,
                        item.CagriDurumu_TipID1,
                        item.ModulAdi,
                        item.DanismanAdi,
                        item.YonlendirilenDanismanAdi,
                        item.DurumAdi);
                }
            }
            #endregion
            #region Aktiviteye Yetkili Danisman Projeleri
            var list_AktiviteyeYetkiliDanismanProjeleri = new List<S_AktiviteDanismaninProjeleri_Result>();
            int _danismanID = -1;
            _danismanID = Genel.DanismanID;
            list_AktiviteyeYetkiliDanismanProjeleri = db.S_AktiviteDanismaninProjeleri(_danismanID).ToList();
            if (list_AktiviteyeYetkiliDanismanProjeleri.Count > 0)
            {
                foreach (var item in list_AktiviteyeYetkiliDanismanProjeleri)
                {
                    CreateDanismaninAktiviteGirisimdeYetkiliProjeleri(item.ProjeID,
                        item.ProjeAdi,
                        Convert.ToInt32(item.ModulID),
                        item.ModulAdi,
                        Convert.ToInt32(item.DanismanID),
                        item.DanismanAdi);
                }
            }
            #endregion
            #region Modul danişman proje
            var list_ModulDanismanProjeID = new List<S_ProjeDanisman_Result>();
            ModulDanismanProjeIDler.Clear();
            list_ModulDanismanProjeID = db.S_ProjeDanisman(-1).Where(q => q.DanismanID == Genel.DanismanID).ToList();
            if (list_ModulDanismanProjeID.Count > 0)
            {
                foreach (var item in list_ModulDanismanProjeID)
                {
                    CreateModulDanismanProjeID(Convert.ToInt32(item.ModulID), 
                        item.ModulAciklama,
                        Convert.ToInt32(item.ProjeID));
                
                }
            }
            #endregion
            #region KisiKarti
            var list_kisikarti = db.S_Kisi(-1).ToList();
            if(list_kisikarti.Count>0)
            {
                foreach (var item in list_kisikarti)
                {
                    CreateKisi(item.ID,
                        item.AdiSoyadi,
                        item.MailAdresi,
                        item.Unvan,
                        item.Tel,
                        Convert.ToInt32(item.MusteriID),
                        Convert.ToInt32(item.YukleniciID),
                        item.NotAciklama,
                        imageToByteArray(byteArrayToImage(item.Resim)));
                }
            }

            #endregion
            #region Musteri Kartları
            var list_musteri_kartlari = db.S_MusteriTanimlari(-1).ToList();
            if(list_musteri_kartlari.Count>0)
            {
                foreach (var item in list_musteri_kartlari)
                {
                    CreateMusteriKarti(item.MusteriID, item.MusteriAdi);
                }
            }
            #endregion
            #region Yuklenici Kartları
            var list_yuklenici_kartlari = db.S_YukleniciTanimlari(-1).ToList();
            if(list_yuklenici_kartlari.Count>0)
            {
                foreach (var item in list_yuklenici_kartlari)
                {
                    CreateYukleniciKarti(item.YukleniciID, item.YukleniciAdi);
                }
            }
            #endregion
            #region Aktiviteler Tumu
            var l_aktivitelertumu = db.R_Aktiviteler().ToList();
            if(l_aktivitelertumu.Count>0)
            {
                foreach (var item in l_aktivitelertumu)
                {
                    CreateAktivitelerTumu(Convert.ToInt32(item.ID), Convert.ToDateTime(item.Tarih), Convert.ToInt32(item.ProjeID), Convert.ToInt32(item.DanismanID), 
                        Convert.ToInt32(item.ModulID), item.Aciklama, Convert.ToDecimal(item.Saat), item.YukleniciAdi, item.MusteriAdi);
                }
            }
            var l_projelertumu = db.S_Proje(-1).ToList();
            if(l_projelertumu.Count>0)
            {
                foreach (var item in l_projelertumu)
                {
                    CreateProjelerTumu(Convert.ToInt32(item.ProjeID), item.ProjeAciklama);
                }
            }
            var l_modullertumu = db.S_Modul(-1).ToList();
            if(l_modullertumu.Count>0)
            {
                foreach (var item in l_modullertumu)
                {
                    CreateModullerTumu(Convert.ToInt32(item.ModulID), item.ModulAdi);
                }
            }
            var l_danismanlartumu = db.S_DanismanTanimlari(-1).ToList();
            if(l_danismanlartumu.Count>0)
            {
                foreach (var item in l_danismanlartumu)
                {
                    CreateDanismanlarTumu(Convert.ToInt32(item.DanismanID), item.DanismanAdi);
                }
            }
            #endregion
            #region Tipler
            var list_tipler = db.S_Tip(-1).ToList();
            if (list_tipler.Count > 0)
            {
                foreach (var item in list_tipler)
                {
                    CreateTipler(item.ID, Convert.ToInt32(item.Ayirac), item.Aciklama);
                }
            }
            #endregion
            #region Projeye Şirket Bağlama
            var list_projeSirketBagla = db.S_ProjeyeSirketBagla().ToList();
            if(list_projeSirketBagla.Count>0)
            {
                foreach (var item in list_projeSirketBagla)
                {
                    CreateProjeSirketBagla(item.ID, (int)item.ProjeID, (Guid)item.SirketID);
                }
            }
            #endregion
        }
        public byte[] imageToByteArray(System.Drawing.Image imageIn)
        {
            MemoryStream ms = new MemoryStream();
            imageIn.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
            return ms.ToArray();
        }
        public Image byteArrayToImage(byte[] byteArrayIn)
        {
            MemoryStream ms = new MemoryStream(byteArrayIn);
            Image returnImage = Image.FromStream(ms);
            return returnImage;
        }
        Proje CreateProje(int _ProjeID, string _ProjeAdi)
        {
            var c = new Proje()
            {
                ProjeID = _ProjeID,
                ProjeAdi = _ProjeAdi
            };
            Projeler.Add(c);
            return c;
        }
        Modul CreateModul(int _ModulID, string _ModulAdi, int _ProjeID)
        {
            var c = new Modul()
            {
                ModulID = _ModulID,
                ModulAdi = (_ModulAdi != null) ? _ModulAdi.ToString() : "",
                ProjeID = _ProjeID
            };

            Moduller.Add(c);

            return c;
        }
        ModulDanismanProjeID CreateModulDanismanProjeID(int _ModulID, string _ModulAdi, int _ProjeID)
        {
            var c = new ModulDanismanProjeID()
            {
                ModulID = _ModulID,
                ModulAdi = (_ModulAdi != null) ? _ModulAdi.ToString() : "",
                ProjeID = _ProjeID
            };

            ModulDanismanProjeIDler.Add(c);

            return c;
        }
        Aktivite CreateAktivite(int _ID, DateTime _Tarih, int _ProjeID, int _ModulID, int _DanismanID,
        string _Aciklama, decimal _Saat) //, Modul modul
        {
            var c = new Aktivite()
            {
                ID = _ID,
                Tarih = _Tarih,
                ProjeID = _ProjeID,
                ModulID = _ModulID,
                DanismanID = _DanismanID,
                Aciklama = _Aciklama,
                Saat = _Saat
            };

            Aktiviteler.Add(c);

            return c;
        }
        Planlama CreatePlanlama(int _ID, int _DanismanID, int _ModulID, int _ProjeID,
        int _YukleniciID, int _MusteriID, DateTime _Tarih, string _Aciklama, decimal _Saat,
        int _MusteriLokasyonID, string _MusteriLokasyonAdi)
        {
            var c = new Planlama()
            {
                ID = _ID,
                DanismanID = _DanismanID,
                ModulID = _ModulID,
                ProjeID = _ProjeID,
                YukleniciID = _YukleniciID,
                MusteriID = _MusteriID,
                Tarih = _Tarih,
                Aciklama = _Aciklama,
                Saat = _Saat,
                MusteriLokasyonID = _MusteriLokasyonID,
                MusteriLokasyonAdi = _MusteriLokasyonAdi
            };
            Planlamalar.Add(c);
            return c;
        }
        Danisman CreateDanismanProje(int _DanismanID, string _DanismanAdi, int _ProjeID)
        {
            var c = new Danisman()
            {
                DanismanID = _DanismanID,
                DanismanAdi = _DanismanAdi.ToString(),
                ProjeID = _ProjeID
            };
            Danismanlar.Add(c);
            return c;
        }
        PlanlamaGiris CreatePlanlamaGiris(int _ID, int _DanismanID, int _ModulID, int _ProjeID, int _YukleniciID, int _MusteriID, DateTime _Tarih, string _Aciklama, decimal _Saat)
        {
            var c = new PlanlamaGiris()
            {
                ID = _ID,
                DanismanID = _DanismanID,
                ModulID = _ModulID,
                ProjeID = _ProjeID,
                YukleniciID = _YukleniciID,
                MusteriID = _MusteriID,
                Tarih = _Tarih,
                Aciklama = _Aciklama,
                Saat = _Saat
            };
            PlanlamalarGiris.Add(c);
            return c;
        }
        MusteriLokasyon CreateMusteriLokasyon(int _ID, string _Adi, int _MusteriID)
        {
            var c = new MusteriLokasyon()
            {
                LokasyonID = _ID,
                LokasyonAdi = _Adi,
                MusteriID = _MusteriID
            };
            MusteriLokasyonlari.Add(c);
            return c;
        }
        Musteri CreateMusteriler(int _ID, string _Adi, int _ProjeID)
        {
            var c = new Musteri()
            {
                MusteriID = _ID,
                MusteriAdi = _Adi,
                ProjeID = _ProjeID
            };
            Musteriler.Add(c);
            return c;
        }
        Yuklenici CreateYukleniciler(int _ID, string _Adi, int _ProjeID)
        {
            var c = new Yuklenici()
            {
                YukleniciID = _ID,
                YukleniciAdi = _Adi,
                ProjeID = _ProjeID
            };
            Yukleniciler.Add(c);
            return c;
        }
        ModulDanisman CreateModulDanisman(int _ModulID, string _ModulAdi, int _DanismanID)
        {
            var c = new ModulDanisman()
            {
                ModulID = _ModulID,
                ModulAdi = (_ModulAdi != null) ? _ModulAdi.ToString() : "",
                DanismanID = _DanismanID
            };
            ModulDanismanlar.Add(c);
            return c;
        }
        CagriIstek CreateCagriIstek(int _ID, string _ExternalTicketNumber, string _AlternativeTicketNumber, string _IstekSahibiAdiSoyadi,
        DateTime _IstekTarihiSaati, string _IstekSirketAdi, string _IstekSirketKodu, string _IstekAciklama, DateTime _SistemKayitTarihiSaati,
        int _OnemDerecesi, int _KaynakYoneticisiOnayi)
        {
            var c = new CagriIstek()
            {
                ID = _ID,
                ExternalTicketNumber = _ExternalTicketNumber,
                AlternativeTicketNumber = _AlternativeTicketNumber,
                IstekSahibiAdiSoyadi = _IstekSahibiAdiSoyadi,
                IstekTarihiSaati = _IstekTarihiSaati,
                IstekSirketAdi = _IstekSirketAdi,
                IstekSirketKodu = _IstekSirketKodu,
                IstekAciklama = _IstekAciklama,
                SistemKayitTarihiSaati = _SistemKayitTarihiSaati,
                OnemDerecesi = _OnemDerecesi,
                KaynakYoneticisiOnayi_TipID4 = _KaynakYoneticisiOnayi
            };
            CagriIstekleri.Add(c);
            return c;
        }
        CagriIstek CreateCagriIstekOnaylananlar(int _ID, string _ExternalTicketNumber, string _AlternativeTicketNumber, string _IstekSahibiAdiSoyadi,
        DateTime _IstekTarihiSaati, string _IstekSirketAdi, string _IstekSirketKodu, string _IstekAciklama, DateTime _SistemKayitTarihiSaati,
        int _OnemDerecesi, int _KaynakYoneticisiOnayi)
        {
            var c = new CagriIstek()
            {
                ID = _ID,
                ExternalTicketNumber = _ExternalTicketNumber,
                AlternativeTicketNumber = _AlternativeTicketNumber,
                IstekSahibiAdiSoyadi = _IstekSahibiAdiSoyadi,
                IstekTarihiSaati = _IstekTarihiSaati,
                IstekSirketAdi = _IstekSirketAdi,
                IstekSirketKodu = _IstekSirketKodu,
                IstekAciklama = _IstekAciklama,
                SistemKayitTarihiSaati = _SistemKayitTarihiSaati,
                OnemDerecesi = _OnemDerecesi,
                KaynakYoneticisiOnayi_TipID4 = _KaynakYoneticisiOnayi
            };
            CagriIstekleriOnaylananlar.Add(c);
            return c;
        }
        Cagri CreateBekleyenCagrilar(int _ID, int _CagriIstekID, DateTime _CagriIstekKayitTarihiSaati,
        string _InternalTicketNumber, string _ExternalTicketNumber, string _AlternativeTicketNumber,
        string _IstekSahibiAdiSoyadi, DateTime _IstekTarihiSaati, string _IstekSirketAdi, string _IstekSirketKodu,
        string _IstekAciklama, DateTime _SistemKayitTarihiSaati, int _AtananDanismanID, int _YonlendirilenDanismanID,
        DateTime _YonlendirilenDanismanTarihSaati, Guid _KayitOlusturanKullaniciID, Guid _KayitDegistirenKullaniciID,
        int _CagriDurumu_TipID1)
        {
            var c = new Cagri
            {
                ID = _ID,
                CagriIstekID = _CagriIstekID,
                CagriIstekKayitTarihiSaati = _CagriIstekKayitTarihiSaati,
                InternalTicketNumber = _InternalTicketNumber,
                ExternalTicketNumber = _ExternalTicketNumber,
                AlternativeTicketNumber = _AlternativeTicketNumber,
                IstekSahibiAdiSoyadi = _IstekSahibiAdiSoyadi,
                IstekTarihiSaati = _IstekTarihiSaati,
                IstekSirketAdi = _IstekSirketAdi,
                IstekSirketKodu = _IstekSirketKodu,
                IstekAciklama = _IstekAciklama,
                SistemKayitTarihiSaati = _SistemKayitTarihiSaati,
                AtananDanismanID = _AtananDanismanID,
                YonlendirilenDanismanID = _YonlendirilenDanismanID,
                YonlendirilenDanismanTarihSaati = _YonlendirilenDanismanTarihSaati,
                KayitOlusturanKullaniciID = _KayitOlusturanKullaniciID,
                KayitDegistirenKullaniciID = _KayitDegistirenKullaniciID,
                CagriDurumu_TipID1 = _CagriDurumu_TipID1
            };
            BekleyenCagrilar.Add(c);
            return c;
        }
        public CagriTumu CreateBekleyenCagrilarTumu(int _ID, int _CagriIstekID, DateTime _CagriIstekKayitTarihiSaati,
        string _InternalTicketNumber, string _ExternalTicketNumber, string _AlternativeTicketNumber,
        string _IstekSahibiAdiSoyadi, DateTime _IstekTarihiSaati, string _IstekSirketAdi, string _IstekSirketKodu,
        string _IstekAciklama, DateTime _SistemKayitTarihiSaati, int _AtananDanismanID, int _YonlendirilenDanismanID,
        DateTime _YonlendirilenDanismanTarihSaati, Guid _KayitOlusturanKullaniciID, Guid _KayitDegistirenKullaniciID,
        int _CagriDurumu_TipID1, string _ModulAdi, string _DanismanAdi, string _YonlendirilenDanismanAdi, string _DurumAdi)
                {
                    var c = new CagriTumu
                    {
                        ID = _ID,
                        CagriIstekID = _CagriIstekID,
                        CagriIstekKayitTarihiSaati = _CagriIstekKayitTarihiSaati,
                        InternalTicketNumber = _InternalTicketNumber,
                        ExternalTicketNumber = _ExternalTicketNumber,
                        AlternativeTicketNumber = _AlternativeTicketNumber,
                        IstekSahibiAdiSoyadi = _IstekSahibiAdiSoyadi,
                        IstekTarihiSaati = _IstekTarihiSaati,
                        IstekSirketAdi = _IstekSirketAdi,
                        IstekSirketKodu = _IstekSirketKodu,
                        IstekAciklama = _IstekAciklama,
                        SistemKayitTarihiSaati = _SistemKayitTarihiSaati,
                        AtananDanismanID = _AtananDanismanID,
                        YonlendirilenDanismanID = _YonlendirilenDanismanID,
                        YonlendirilenDanismanTarihSaati = _YonlendirilenDanismanTarihSaati,
                        KayitOlusturanKullaniciID = _KayitOlusturanKullaniciID,
                        KayitDegistirenKullaniciID = _KayitDegistirenKullaniciID,
                        CagriDurumu_TipID1 = _CagriDurumu_TipID1,
                        ModulAdi = _ModulAdi,
                        DanismanAdi = _DanismanAdi,
                        YonlendirilenDanismanAdi = _YonlendirilenDanismanAdi,
                        DurumAdi = _DurumAdi
                    };
                    BekleyenCagrilarTumu.Add(c);
                    return c;
                }
        Cagri CreateAcikCagrilar(int _ID, int _CagriIstekID, DateTime _CagriIstekKayitTarihiSaati,
        string _InternalTicketNumber, string _ExternalTicketNumber, string _AlternativeTicketNumber,
        string _IstekSahibiAdiSoyadi, DateTime _IstekTarihiSaati, string _IstekSirketAdi, string _IstekSirketKodu,
        string _IstekAciklama, DateTime _SistemKayitTarihiSaati, int _AtananDanismanID, int _YonlendirilenDanismanID,
        DateTime _YonlendirilenDanismanTarihSaati, Guid _KayitOlusturanKullaniciID, Guid _KayitDegistirenKullaniciID,
        int _CagriDurumu_TipID1, string _DosyaEkleri, string _CagriTestiAciklamasi)
                {
                    var c = new Cagri
                    {
                        ID = _ID,
                        CagriIstekID = _CagriIstekID,
                        CagriIstekKayitTarihiSaati = _CagriIstekKayitTarihiSaati,
                        InternalTicketNumber = _InternalTicketNumber,
                        ExternalTicketNumber = _ExternalTicketNumber,
                        AlternativeTicketNumber = _AlternativeTicketNumber,
                        IstekSahibiAdiSoyadi = _IstekSahibiAdiSoyadi,
                        IstekTarihiSaati = _IstekTarihiSaati,
                        IstekSirketAdi = _IstekSirketAdi,
                        IstekSirketKodu = _IstekSirketKodu,
                        IstekAciklama = _IstekAciklama,
                        SistemKayitTarihiSaati = _SistemKayitTarihiSaati,
                        AtananDanismanID = _AtananDanismanID,
                        YonlendirilenDanismanID = _YonlendirilenDanismanID,
                        YonlendirilenDanismanTarihSaati = _YonlendirilenDanismanTarihSaati,
                        KayitOlusturanKullaniciID = _KayitOlusturanKullaniciID,
                        KayitDegistirenKullaniciID = _KayitDegistirenKullaniciID,
                        CagriDurumu_TipID1 = _CagriDurumu_TipID1,
                        DosyaEkleri = _DosyaEkleri,
                        CagriTestiAciklamasi = _CagriTestiAciklamasi
                    };
                    AcikCagrilar.Add(c);
                    return c;
                }
        Cagri CreateKapaliCagrilar(int _ID, int _CagriIstekID, DateTime _CagriIstekKayitTarihiSaati,
        string _InternalTicketNumber, string _ExternalTicketNumber, string _AlternativeTicketNumber,
        string _IstekSahibiAdiSoyadi, DateTime _IstekTarihiSaati, string _IstekSirketAdi, string _IstekSirketKodu,
        string _IstekAciklama, DateTime _SistemKayitTarihiSaati, int _AtananDanismanID, int _YonlendirilenDanismanID,
        DateTime _YonlendirilenDanismanTarihSaati, Guid _KayitOlusturanKullaniciID, Guid _KayitDegistirenKullaniciID,
        int _CagriDurumu_TipID1)
                {
                    var c = new Cagri
                    {
                        ID = _ID,
                        CagriIstekID = _CagriIstekID,
                        CagriIstekKayitTarihiSaati = _CagriIstekKayitTarihiSaati,
                        InternalTicketNumber = _InternalTicketNumber,
                        ExternalTicketNumber = _ExternalTicketNumber,
                        AlternativeTicketNumber = _AlternativeTicketNumber,
                        IstekSahibiAdiSoyadi = _IstekSahibiAdiSoyadi,
                        IstekTarihiSaati = _IstekTarihiSaati,
                        IstekSirketAdi = _IstekSirketAdi,
                        IstekSirketKodu = _IstekSirketKodu,
                        IstekAciklama = _IstekAciklama,
                        SistemKayitTarihiSaati = _SistemKayitTarihiSaati,
                        AtananDanismanID = _AtananDanismanID,
                        YonlendirilenDanismanID = _YonlendirilenDanismanID,
                        YonlendirilenDanismanTarihSaati = _YonlendirilenDanismanTarihSaati,
                        KayitOlusturanKullaniciID = _KayitOlusturanKullaniciID,
                        KayitDegistirenKullaniciID = _KayitDegistirenKullaniciID,
                        CagriDurumu_TipID1 = _CagriDurumu_TipID1
                    };
                    KapaliCagrilarim.Add(c);
                    return c;
                }
        CagriTumu CreateKapaliCagrilarTumu(int _ID, int _CagriIstekID, DateTime _CagriIstekKayitTarihiSaati,
        string _InternalTicketNumber, string _ExternalTicketNumber, string _AlternativeTicketNumber,
        string _IstekSahibiAdiSoyadi, DateTime _IstekTarihiSaati, string _IstekSirketAdi, string _IstekSirketKodu,
        string _IstekAciklama, DateTime _SistemKayitTarihiSaati, int _AtananDanismanID, int _YonlendirilenDanismanID,
        DateTime _YonlendirilenDanismanTarihSaati, Guid _KayitOlusturanKullaniciID, Guid _KayitDegistirenKullaniciID,
        int _CagriDurumu_TipID1, string _ModulAdi, string _DanismanAdi, string _YonlendirilenDanismanAdi, string _DurumAdi)
                {
                    var c = new CagriTumu
                    {
                        ID = _ID,
                        CagriIstekID = _CagriIstekID,
                        CagriIstekKayitTarihiSaati = _CagriIstekKayitTarihiSaati,
                        InternalTicketNumber = _InternalTicketNumber,
                        ExternalTicketNumber = _ExternalTicketNumber,
                        AlternativeTicketNumber = _AlternativeTicketNumber,
                        IstekSahibiAdiSoyadi = _IstekSahibiAdiSoyadi,
                        IstekTarihiSaati = _IstekTarihiSaati,
                        IstekSirketAdi = _IstekSirketAdi,
                        IstekSirketKodu = _IstekSirketKodu,
                        IstekAciklama = _IstekAciklama,
                        SistemKayitTarihiSaati = _SistemKayitTarihiSaati,
                        AtananDanismanID = _AtananDanismanID,
                        YonlendirilenDanismanID = _YonlendirilenDanismanID,
                        YonlendirilenDanismanTarihSaati = _YonlendirilenDanismanTarihSaati,
                        KayitOlusturanKullaniciID = _KayitOlusturanKullaniciID,
                        KayitDegistirenKullaniciID = _KayitDegistirenKullaniciID,
                        CagriDurumu_TipID1 = _CagriDurumu_TipID1,
                        ModulAdi = _ModulAdi,
                        DanismanAdi = _DanismanAdi,
                        YonlendirilenDanismanAdi = _YonlendirilenDanismanAdi,
                        DurumAdi = _DurumAdi
                    };
                    KapaliCagrilarTumu.Add(c);
                    return c;
                }
        CagriTumu CreateAcikCagrilarTumu(int _ID, int _CagriIstekID, DateTime _CagriIstekKayitTarihiSaati,
        string _InternalTicketNumber, string _ExternalTicketNumber, string _AlternativeTicketNumber,
        string _IstekSahibiAdiSoyadi, DateTime _IstekTarihiSaati, string _IstekSirketAdi, string _IstekSirketKodu,
        string _IstekAciklama, DateTime _SistemKayitTarihiSaati, int _AtananDanismanID, int _YonlendirilenDanismanID,
        DateTime _YonlendirilenDanismanTarihSaati, Guid _KayitOlusturanKullaniciID, Guid _KayitDegistirenKullaniciID,
        int _CagriDurumu_TipID1, string _ModulAdi, string _DanismanAdi, string _YonlendirilenDanismanAdi, string _DurumAdi)
                {
                    var c = new CagriTumu
                    {
                        ID = _ID,
                        CagriIstekID = _CagriIstekID,
                        CagriIstekKayitTarihiSaati = _CagriIstekKayitTarihiSaati,
                        InternalTicketNumber = _InternalTicketNumber,
                        ExternalTicketNumber = _ExternalTicketNumber,
                        AlternativeTicketNumber = _AlternativeTicketNumber,
                        IstekSahibiAdiSoyadi = _IstekSahibiAdiSoyadi,
                        IstekTarihiSaati = _IstekTarihiSaati,
                        IstekSirketAdi = _IstekSirketAdi,
                        IstekSirketKodu = _IstekSirketKodu,
                        IstekAciklama = _IstekAciklama,
                        SistemKayitTarihiSaati = _SistemKayitTarihiSaati,
                        AtananDanismanID = _AtananDanismanID,
                        YonlendirilenDanismanID = _YonlendirilenDanismanID,
                        YonlendirilenDanismanTarihSaati = _YonlendirilenDanismanTarihSaati,
                        KayitOlusturanKullaniciID = _KayitOlusturanKullaniciID,
                        KayitDegistirenKullaniciID = _KayitDegistirenKullaniciID,
                        CagriDurumu_TipID1 = _CagriDurumu_TipID1,
                        ModulAdi = _ModulAdi,
                        DanismanAdi = _DanismanAdi,
                        YonlendirilenDanismanAdi = _YonlendirilenDanismanAdi,
                        DurumAdi = _DurumAdi
                    };
                    AcikCagrilarTumu.Add(c);
                    return c;
                }
        AktiviteyeYetkiliDanismanProjeleri CreateDanismaninAktiviteGirisimdeYetkiliProjeleri(int _ProjeID, string _ProjeAdi, int _ModulID, string _ModulAdi, int _DanismanID, string _DanismanAdi)
        {
            var c = new AktiviteyeYetkiliDanismanProjeleri
            {
                ProjeID = _ProjeID,
                ProjeAdi = _ProjeAdi,
                ModulID = _ModulID,
                ModulAdi = _ModulAdi,
                DanismanID = _DanismanID,
                DanismanAdi = _DanismanAdi
            };
            AktiviteDanismanProjeleri.Add(c);
            return c;
        }
        KisiKarti CreateKisi ( int _ID,string _AdiSoyadi, string _MailAdresi, string _Unvan,
        string _Tel, int _MusteriID, int _YukleniciID, string _NotAciklama, byte[] _Resim)
        {
            var c = new KisiKarti
            {
                ID = _ID,
                AdiSoyadi = _AdiSoyadi,
                MailAdresi = _MailAdresi,
                Unvan = _Unvan,
                Tel = _Tel,
                MusteriID = _MusteriID,
                YukleniciID = _YukleniciID,
                NotAciklama = _NotAciklama,
                Resim = _Resim
            };
            Kisiler.Add(c);
            return c;
        }
        MusteriKarti CreateMusteriKarti ( int _MusteriID, string _MusteriAdi)
        {
            var c = new MusteriKarti
            {
                MusteriID = _MusteriID,
                MusteriAdi = _MusteriAdi
            };
            MusteriKartlari.Add(c);
            return c;
        }
        YukleniciKarti CreateYukleniciKarti (int _YukleniciID, string _YukleniciAdi)
        {
            var c = new YukleniciKarti
            {
                YukleniciID = _YukleniciID,
                YukleniciAdi = _YukleniciAdi
            };
            YukleniciKartlari.Add(c);
            return c;
        }
        AktivitelerTumu CreateAktivitelerTumu(int _ID, DateTime _Tarih, int _ProjeID, int _DanismanID, int _ModulID, string _Aciklama, decimal _Saat, string _YukleniciAdi, string _MusteriAdi)
        {
            var c = new AktivitelerTumu
            {
                ID = _ID,
                Tarih = _Tarih,
                ProjeID = _ProjeID,
                ModulID = _ModulID,
                DanismanID = _DanismanID,
                Aciklama = _Aciklama,
                Saat = _Saat,
                YukleniciAdi = _YukleniciAdi,
                MusteriAdi = _MusteriAdi
            };
            AktiviteTumu.Add(c);
            return c;
        }
        ModullerTumu CreateModullerTumu(int _ID, string _Adi)
        {
            var c = new ModullerTumu
            {
                ID = _ID,
                Adi = _Adi
            };
            ModulTumu.Add(c);
            return c;
        }
        ProjelerTumu CreateProjelerTumu(int _ID, string _Adi)
        {
            var c = new ProjelerTumu
            {
                ID = _ID,
                Adi = _Adi
            };
            ProjeTumu.Add(c);
            return c;
        }
        DanismanlarTumu CreateDanismanlarTumu(int _ID, string _Adi)
        {
            var c = new DanismanlarTumu
            {
                ID = _ID,
                Adi = _Adi
            };
            DanismanTumu.Add(c);
            return c;
        }
        Tip CreateTipler(int _ID, int _Ayirac, string _Aciklama)
        {
            var c = new Tip
            {
                ID = _ID,
                Ayirac = _Ayirac,
                Aciklama = _Aciklama
            };
            Tipler.Add(c);
            return c;
        }
        ProjeSirketBagla CreateProjeSirketBagla(int _ID, int _ProjeID, Guid _SirketID)
        {
            var c = new ProjeSirketBagla
            {
                ID = _ID,
                ProjeID = _ProjeID,
                SirketID = _SirketID
            };
            ProjeyeSirketBaglamalari.Add(c);
            return c;
        }
    }
    public class Aktivite
    {
        public int ID { get; set; }
        public DateTime Tarih { get; set; }
        public int ProjeID { get; set; }
        public int ModulID { get; set; }
        public int DanismanID { get; set; }
        public string Aciklama { get; set; }
        public decimal Saat { get; set; }
    }
    public class Proje
    {
        public int ProjeID { get; set; }
        public string ProjeAdi { get; set; }
    }
    public class Modul
    {
        public int ModulID { get; set; }
        public string ModulAdi { get; set; }
        public int ProjeID { get; set; }
    }
    public class ModulDanismanProjeID
    {
        public int ModulID { get; set; }
        public string ModulAdi { get; set; }
        public int ProjeID { get; set; }
    }
    public class Planlama
    {
        public int ID { get; set; }
        public int DanismanID { get; set; }
        public int ModulID { get; set; }
        public int ProjeID { get; set; }
        public int YukleniciID { get; set; }
        public int MusteriID { get; set; }
        public DateTime Tarih { get; set; }
        public decimal Saat { get; set; }
        public string Aciklama { get; set; }
        public int MusteriLokasyonID { get; set; }
        public string MusteriLokasyonAdi { get; set; }
    }
    public class Danisman
    {
        public int DanismanID { get; set; }
        public string DanismanAdi { get; set; }
        public int ProjeID { get; set; }
    }
    public class PlanlamaGiris
    {
        public int ID { get; set; }
        public int DanismanID { get; set; }
        public int ModulID { get; set; }
        public int ProjeID { get; set; }
        public int YukleniciID { get; set; }
        public int MusteriID { get; set; }
        public DateTime Tarih { get; set; }
        public decimal Saat { get; set; }
        public string Aciklama { get; set; }
    }
    public class MusteriLokasyon
    {
        public int LokasyonID { get; set; }
        public string LokasyonAdi { get; set; }
        public int MusteriID { get; set; }
    }
    public class Musteri
    {
        public int MusteriID { get; set; }
        public string MusteriAdi { get; set; }
        public int ProjeID { get; set; }
    }
    public class Yuklenici
    {
        public int YukleniciID { get; set; }
        public string YukleniciAdi { get; set; }
        public int ProjeID { get; set; }
    }
    public class ModulDanisman
    {
        public int ModulID { get; set; }
        public string ModulAdi { get; set; }
        public int DanismanID { get; set; }
    }
    public class CagriIstek
    {
        public int ID { get; set; }
        public string ExternalTicketNumber { get; set; }
        public string AlternativeTicketNumber { get; set; }
        public string IstekSahibiAdiSoyadi { get; set; }
        public DateTime IstekTarihiSaati { get; set; }
        public string IstekSirketAdi { get; set; }
        public string IstekSirketKodu { get; set; }
        public string IstekAciklama { get; set; }
        public DateTime SistemKayitTarihiSaati { get; set; }
        public int OnemDerecesi { get; set; }
        public int KaynakYoneticisiOnayi_TipID4 { get; set; }
    }
    public class Cagri
    {
        public int ID { get; set; }
        public int CagriIstekID { get; set; }
        public DateTime CagriIstekKayitTarihiSaati { get; set; }
        public string InternalTicketNumber { get; set; }
        public string ExternalTicketNumber { get; set; }
        public string AlternativeTicketNumber { get; set; }
        public string IstekSahibiAdiSoyadi { get; set; }
        public DateTime IstekTarihiSaati { get; set; }
        public string IstekSirketAdi { get; set; }
        public string IstekSirketKodu { get; set; }
        public string IstekAciklama { get; set; }
        public DateTime SistemKayitTarihiSaati { get; set; }
        public int AtananDanismanID { get; set; }
        public int YonlendirilenDanismanID { get; set; }
        public DateTime YonlendirilenDanismanTarihSaati { get; set; }
        public Guid KayitOlusturanKullaniciID { get; set; }
        public Guid KayitDegistirenKullaniciID { get; set; }
        public int CagriDurumu_TipID1 { get; set; }
        public string DosyaEkleri { get; set; }
        public string CagriTestiAciklamasi { get; set; }
    }
    public class CagriTumu
    {
        public int ID { get; set; }
        public int CagriIstekID { get; set; }
        public DateTime CagriIstekKayitTarihiSaati { get; set; }
        public string InternalTicketNumber { get; set; }
        public string ExternalTicketNumber { get; set; }
        public string AlternativeTicketNumber { get; set; }
        public string IstekSahibiAdiSoyadi { get; set; }
        public DateTime IstekTarihiSaati { get; set; }
        public string IstekSirketAdi { get; set; }
        public string IstekSirketKodu { get; set; }
        public string IstekAciklama { get; set; }
        public DateTime SistemKayitTarihiSaati { get; set; }
        public int AtananDanismanID { get; set; }
        public int YonlendirilenDanismanID { get; set; }
        public DateTime YonlendirilenDanismanTarihSaati { get; set; }
        public Guid KayitOlusturanKullaniciID { get; set; }
        public Guid KayitDegistirenKullaniciID { get; set; }
        public int CagriDurumu_TipID1 { get; set; }
        public string ModulAdi { get; set; }
        public string DanismanAdi { get; set; }
        public string YonlendirilenDanismanAdi { get; set; }
        public string DurumAdi { get; set; }
    }
    public class AktiviteyeYetkiliDanismanProjeleri
    {
        public int ProjeID { get; set; }
        public string ProjeAdi { get; set; }
        public int ModulID { get; set; }
        public string ModulAdi { get; set; }
        public int DanismanID { get; set; }
        public string DanismanAdi { get; set; }
    }
    public class KisiKarti
    {
        public int ID { get; set; }
        public string AdiSoyadi { get; set; }
        public string MailAdresi { get; set; }
        public string Unvan { get; set; }
        public string Tel { get; set; }
        public int MusteriID { get; set; }
        public int YukleniciID { get; set; }
        public string NotAciklama { get; set; }
        public byte[] Resim { get; set; }
    }
    public class MusteriKarti
    {
        public int MusteriID { get; set; }
        public string MusteriAdi { get; set; }
    }
    public class YukleniciKarti
    {
        public int YukleniciID { get; set; }
        public string YukleniciAdi { get; set; }
    }
    public class ModullerTumu
    {
        public int ID { get; set; }
        public string Adi { get; set; }
    }
    public class ProjelerTumu
    {
        public int ID { get; set; }
        public string Adi { get; set; }
    }
    public class DanismanlarTumu
    {
        public int ID { get; set; }
        public string Adi { get; set; }
    }
    public class AktivitelerTumu
    {
        public int ID { get; set; }
        public DateTime Tarih { get; set; }
        public int ProjeID { get; set; }
        public int ModulID { get; set; }
        public int DanismanID { get; set; }
        public string Aciklama { get; set; }
        public decimal Saat { get; set; }
        public string YukleniciAdi { get; set; }
        public string MusteriAdi { get; set; }
    }
    public class Tip
    {
        public int ID { get; set; }
        public int Ayirac { get; set; }
        public string Aciklama { get; set; }
    }
    public class ProjeSirketBagla
    {
        public int ID { get; set; }
        public int ProjeID { get; set; }
        public Guid SirketID { get; set; }
    }
}
