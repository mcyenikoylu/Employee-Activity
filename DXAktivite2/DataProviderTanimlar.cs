using DXAktivite2;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

public static class DataProviderTanimlar
{
    static HttpSessionState Session { get { return HttpContext.Current.Session; } }
    static DemoDataObjectTanimlar DemoDataTanimlar
    {
        get
        {
            const string key = "FB1EB35F-86F5-4FFE-BB23-CBAAF1514C48";
            if (Session[key] == null)
            {
                var obj = new DemoDataObjectTanimlar();
                obj.FillObjTanimlar();
                Session[key] = obj;
            }
            return (DemoDataObjectTanimlar)Session[key];
        }
    }
    public static IEnumerable GetModuller()
    {
        return DemoDataTanimlar.Moduller;
    }
    public static IEnumerable GetDanismanTanimlari()
    {
        return DemoDataTanimlar.Danismanlarr;
    }
    public static IEnumerable GetYukleniciTanimlari()
    {
        return DemoDataTanimlar.Yuklenicilerr;
    }
    public static IEnumerable GetMusteriTanimlari()
    {
        return DemoDataTanimlar.Musterilerr;
    }
    public static IEnumerable GetMusteriLokasyonTanimlari()
    {
        return DemoDataTanimlar.MusteriLokasyonlari;
    }
    public static IEnumerable GetProjeler()
    {
        return DemoDataTanimlar.Projeler;
    }
    public static IEnumerable GetMusteriler()
    {
        return DemoDataTanimlar.Musterilerr;

    }
    public static IEnumerable GetLokasyonlar()
    {
        return DemoDataTanimlar.MusteriLokasyonlari;
    }
    public static IEnumerable GetLokasyonlar(int MusteriID)
    {
        return from c in DemoDataTanimlar.MusteriLokasyonlari
               where c.MusteriID == MusteriID
               select c;
    }
    public static IEnumerable GetYukleniciler()
    {
        return DemoDataTanimlar.Yuklenicilerr;
    }
    public static IEnumerable GetProjeDanismanTanimlari()
    {
        return DemoDataTanimlar.ProjelerTanismanTanimlari;
    }
    public static IEnumerable GetModullerDanisman(int DanismanID)
    {
        return from c in DemoDataTanimlar.ProjeModulDanismanlari
               where c.DanismanID == DanismanID
               select c;
    }
    public static IEnumerable GetDanismanModulTanimlari()
    {
        return DemoDataTanimlar.DanismanModulleriTanimlari;
    }
    public static IEnumerable GetKullaniciTanimlari()
    {
        return DemoDataTanimlar.KullaniciTanimlari;
    }
    public static IEnumerable GetSirketler()
    {
        return DemoDataTanimlar.Sirketler;
    }
    #region InsertUpdateDelete
    //MODÜL
    public static void InsertModul(int ModulID, string ModulAdi)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_Modul(ModulID, ModulAdi, false).ToList();
        var c = new Modull()
        {
            ModulID = Convert.ToInt32(list.FirstOrDefault().ID),
            ModulAdi = ModulAdi
        };

        DemoDataTanimlar.Moduller.Add(c);
    }
    public static void UpdateModul(int ModulID, string ModulAdi)
    {
        AktiviteEntities db = new AktiviteEntities();
        db.IUD_Modul(ModulID, ModulAdi, false);
        var c = DemoDataTanimlar.Moduller.First(i => i.ModulID == ModulID);
        c.ModulAdi = ModulAdi;
    }
    public static void DeleteModul(int ModulID, bool Sil)
    {
        AktiviteEntities db = new AktiviteEntities();
        db.IUD_Modul(ModulID, "", true);
        DemoDataTanimlar.Moduller.RemoveAll(c => c.ModulID == ModulID);

    }
    
    //DANIŞMAN
    public static void InsertDanisman(int DanismanID, string DanismanAdi, string UserID)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_DanismanTanimlari(DanismanID, DanismanAdi, false, UserID).ToList();
        var c = new Danismann()
        {
            DanismanID = Convert.ToInt32(list.FirstOrDefault().ID),
            DanismanAdi = DanismanAdi,
            UserID = UserID
        };
        DemoDataTanimlar.Danismanlarr.Add(c);
    }
    public static void InsertDanismanWizard(int DanismanID, string DanismanAdi, string KullaniciID, string ModulAdi)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_DanismanTanimlari(DanismanID, DanismanAdi, false, KullaniciID).ToList();
        var c = new Danismann()
        {
            DanismanID = Convert.ToInt32(list.FirstOrDefault().ID),
            DanismanAdi = DanismanAdi,
            UserID = KullaniciID
        };
        DemoDataTanimlar.Danismanlarr.Add(c);

        //burada seçilen modüller eklenecek
        var moduller = db.S_DanismanModulWizard(ModulAdi, Convert.ToInt32(list.FirstOrDefault().ID));
        foreach (var item in moduller)
        {
            var z = new DanismanModulleri()
            {
                ID = Convert.ToInt32(item.ID),
                DanismanID = Convert.ToInt32(list.FirstOrDefault().ID),
                ModulID = Convert.ToInt32(item.ModulID)
            };
            DemoDataTanimlar.DanismanModulleriTanimlari.Add(z);
            DataProvider.SetModullerDanisman(Convert.ToInt32(item.ModulID), Convert.ToInt32(item.DanismanID));
        }
        
    }
    public static void UpdateDanisman(int DanismanID, string DanismanAdi, string UserID)
    {
        AktiviteEntities db = new AktiviteEntities();
        db.IUD_DanismanTanimlari(DanismanID, DanismanAdi, false, UserID);
        var c = DemoDataTanimlar.Danismanlarr.First(i => i.DanismanID == DanismanID);
        c.DanismanAdi = DanismanAdi;
        c.UserID = UserID;
    }
    public static void DeleteDanisman(int DanismanID, bool Sil)
    {
        AktiviteEntities db = new AktiviteEntities();
        db.IUD_DanismanTanimlari(DanismanID, "", true, "");
        DemoDataTanimlar.Danismanlarr.RemoveAll(c => c.DanismanID == DanismanID);
    }

    //YÜKLENİCİ
    public static void InsertYuklenici(int YukleniciID, string YukleniciAdi)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_YukleniciTanimlari(YukleniciID, YukleniciAdi, false).ToList();
        var c = new Yuklenicii()
        {
            YukleniciID = Convert.ToInt32(list.FirstOrDefault().ID),
            YukleniciAdi = YukleniciAdi
        };
        DemoDataTanimlar.Yuklenicilerr.Add(c);
    }
    public static void UpdateYuklenici(int YukleniciID, string YukleniciAdi)
    {
        AktiviteEntities db = new AktiviteEntities();
        db.IUD_YukleniciTanimlari(YukleniciID, YukleniciAdi, false);
        var c = DemoDataTanimlar.Yuklenicilerr.First(i => i.YukleniciID == YukleniciID);
        c.YukleniciAdi = YukleniciAdi;
    }
    public static void DeleteYuklenici(int YukleniciID, bool Sil)
    {
        AktiviteEntities db = new AktiviteEntities();
        db.IUD_YukleniciTanimlari(YukleniciID, "", true);
        DemoDataTanimlar.Yuklenicilerr.RemoveAll(c => c.YukleniciID == YukleniciID);
    }

    //MÜŞTERİ
    public static void InsertMusteri(int MusteriID, string MusteriAdi)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_MusteriTanimlari(MusteriID, MusteriAdi, false).ToList();
        var c = new Musterii()
        {
            MusteriID = Convert.ToInt32(list.FirstOrDefault().ID),
            MusteriAdi = MusteriAdi
        };
        DemoDataTanimlar.Musterilerr.Add(c);
    }
    public static void UpdateMusteri(int MusteriID, string MusteriAdi)
    {
        AktiviteEntities db = new AktiviteEntities();
        db.IUD_MusteriTanimlari(MusteriID, MusteriAdi, false);
        var c = DemoDataTanimlar.Musterilerr.First(i => i.MusteriID == MusteriID);
        c.MusteriAdi = MusteriAdi;
    }
    public static void DeleteMusteri(int MusteriID, bool Sil)
    {
        AktiviteEntities db = new AktiviteEntities();
        db.IUD_MusteriTanimlari(MusteriID, "", true);
        DemoDataTanimlar.Musterilerr.RemoveAll(c => c.MusteriID == MusteriID);
    }

    //MÜŞTERİ LOKASYONLARI
    public static void InsertMusteriLokasyon(int MusteriLokasyonID, string MusteriLokasyonAdi, int MusteriID)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_MusteriLokasyonTanimlari(MusteriLokasyonID, MusteriLokasyonAdi, false, MusteriID).ToList();
        var c = new MusteriLokasyonn()
        {
            MusteriLokasyonID = Convert.ToInt32(list.FirstOrDefault().ID),
            MusteriLokasyonAdi = MusteriLokasyonAdi,
            MusteriID = MusteriID
        };
        DemoDataTanimlar.MusteriLokasyonlari.Add(c);
    }
    public static void UpdateMusteriLokasyon(int MusteriLokasyonID, string MusteriLokasyonAdi, int MusteriID)
    {
        AktiviteEntities db = new AktiviteEntities();
        db.IUD_MusteriLokasyonTanimlari(MusteriLokasyonID, MusteriLokasyonAdi, false, MusteriID);
        var c = DemoDataTanimlar.MusteriLokasyonlari.First(i => i.MusteriLokasyonID == MusteriLokasyonID);
        c.MusteriLokasyonAdi = MusteriLokasyonAdi; c.MusteriID = MusteriID;
    }
    public static void DeleteMusteriLokasyon(int MusteriLokasyonID, bool Sil)
    {
        AktiviteEntities db = new AktiviteEntities();
        db.IUD_MusteriLokasyonTanimlari(MusteriLokasyonID, "", true, -1);
        DemoDataTanimlar.MusteriLokasyonlari.RemoveAll(c => c.MusteriLokasyonID == MusteriLokasyonID);
    }

    //PROJELER
    public static void InsertProjeler(int ID, string Aciklama, string Kod, int MusteriID,
        int LokasyonID, bool Yuklenici, int YukleniciID)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_Projeler(-1, Aciklama, Kod, MusteriID, LokasyonID, Yuklenici, YukleniciID, false).ToList();
        var c = new Projeler
        {
            ID = Convert.ToInt32(list.FirstOrDefault().ID),
            Aciklama = Aciklama,
            Kod = Kod,
            MusteriID = MusteriID,
            LokasyonID = LokasyonID,
            Yuklenici = Yuklenici,
            YukleniciID = YukleniciID
        };
        DemoDataTanimlar.Projeler.Add(c);
        DataProvider.SetProjeler(Convert.ToInt32(list.FirstOrDefault().ID),Aciklama);
    }
    public static void UpdateProjeler(int ID, string Aciklama, string Kod, int MusteriID,
        int LokasyonID, bool Yuklenici, int YukleniciID)
    {
        AktiviteEntities db = new AktiviteEntities();
        db.IUD_Projeler(ID, Aciklama, Kod, MusteriID, LokasyonID, Yuklenici, YukleniciID, false);
        var c = DemoDataTanimlar.Projeler.First(i => i.ID == ID);
        c.Aciklama = Aciklama;
        c.Kod = Kod;
        c.MusteriID = MusteriID;
        c.LokasyonID = LokasyonID;
        c.Yuklenici = Yuklenici;
        c.YukleniciID = YukleniciID;
    }
    public static void DeleteProjeler(int ID, bool Sil)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_Projeler(ID, "", "", -1, -1, false, -1, true);
        DemoDataTanimlar.Projeler.RemoveAll(i => i.ID == ID);
    }
    public static void InsertProjelerWizard(string Aciklama, string Kod, int MusteriID,
    int LokasyonID, bool Yuklenici, int YukleniciID, string DanismanAdi)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_Projeler(-1, Aciklama, Kod, MusteriID, LokasyonID, Yuklenici, YukleniciID, false).ToList();
        var c = new Projeler
        {
            ID = Convert.ToInt32(list.FirstOrDefault().ID),
            Aciklama = Aciklama,
            Kod = Kod,
            MusteriID = MusteriID,
            LokasyonID = LokasyonID,
            Yuklenici = Yuklenici,
            YukleniciID = YukleniciID
        };
        DemoDataTanimlar.Projeler.Add(c);
        DataProvider.SetProjeler(Convert.ToInt32(list.FirstOrDefault().ID), Aciklama);
        var danismanlariGetir = db.S_ProjeDanismanlariGetir(DanismanAdi).ToList();
        if (danismanlariGetir.Count > 0)
        {
            int projeid = Convert.ToInt32(list.FirstOrDefault().ID);
            foreach (var item in danismanlariGetir.ToList())
            {
                DataProviderTanimlar.InsertProjeDanismanTanimlari(-1,
                    projeid,
                    Convert.ToInt32(item.DanismanID),
                    Convert.ToInt32(item.ModulID),
                    0);
            }
        }
        DataProvider.GetPlanlamalarGiris();
    }

    //PROJE DANIŞMANLARI
    public static void InsertProjeDanismanTanimlari(int ID, int ProjeID, int DanismanID, int ModulID, decimal FiyatGun)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_ProjeDanisman(ID, ProjeID, DanismanID, ModulID, FiyatGun, false);
        var c = new ProjeDanismanTanimlari
        {
            ID = Convert.ToInt32(list.FirstOrDefault().ID),
            ProjeID = ProjeID,
            DanismanID = DanismanID,
            ModulID = ModulID,
            FiyatGun = FiyatGun
        };
        DemoDataTanimlar.ProjelerTanismanTanimlari.Add(c);
        DataProvider.SetDanismanlar(DanismanID, ProjeID);
        DataProvider.SetAktiviteGirisindeYetkiliOlduguProjeninModulleri(ProjeID, ModulID);
        DataProvider.SetAktiviteDanismanProjeleri(ProjeID, DanismanID, ModulID);
    }
    public static void UpdateProjeDanismanTanimlari(int ID, int ProjeID, int DanismanID, int ModulID, decimal FiyatGun)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_ProjeDanisman(ID, ProjeID, DanismanID, ModulID, FiyatGun, false);
        var c = DemoDataTanimlar.ProjelerTanismanTanimlari.First(i => i.ID == ID);
        c.ProjeID = ProjeID;
        c.DanismanID = DanismanID;
        c.ModulID = ModulID;
        c.FiyatGun = FiyatGun;
    }
    public static void DeleteProjeDanismanTanimlari(int ID, bool Sil)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_ProjeDanisman(ID, -1, -1, -1, 0, true);
        DemoDataTanimlar.ProjelerTanismanTanimlari.RemoveAll(i => i.ID == ID);
    }

    //DANIŞMAN MODÜLLERİ
    public static void InsertDanismanModulTanimlari(int ID, int DanismanID, int ModulID)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_DanismanModul(-1, DanismanID, ModulID, false).ToList();
        var c = new DanismanModulleri
        {
            ID = Convert.ToInt32(list.FirstOrDefault().ID),
            DanismanID = DanismanID,
            ModulID = ModulID
        };
        DemoDataTanimlar.DanismanModulleriTanimlari.Add(c);

        //create modül dnaışman a ekle
        var moduladiList = db.S_Modul(list.FirstOrDefault().ModulID).ToList();
        var z = new ProjeModulDanisman
        {
            ModulID = ModulID,
            ModulAdi = moduladiList.FirstOrDefault().ModulAdi,
            DanismanID = DanismanID
        };
        DemoDataTanimlar.ProjeModulDanismanlari.Add(z);
    }
    public static void UpdateDanismanModulTanimlari(int ID, int DanismanID, int ModulID)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_DanismanModul(ID, DanismanID, ModulID, false);
        var c = DemoDataTanimlar.DanismanModulleriTanimlari.First(i => i.ID == ID);
        c.DanismanID = DanismanID;
        c.ModulID = ModulID;
    }
    public static void DeleteDanismanModulTanimlari(int ID, bool Sil)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_DanismanModul(ID, -1, -1, true);
        DemoDataTanimlar.DanismanModulleriTanimlari.RemoveAll(i => i.ID == ID);

    }

    // KULLANICI
    public static void InsertKullanici(string UserName, string Email, string Password)
    {
        try
        {
            MembershipUser user = Membership.CreateUser(UserName, Password, Email);
            AktiviteEntities db = new AktiviteEntities();
            var list = db.S_Kullanici("").Where(c => c.Email == Email & c.UserName == UserName).ToList();
            if (list.Count > 0)
            {
                var c = new Kullanici
                {
                    UserID = list.FirstOrDefault().UserId.ToString(),
                    UserName = list.FirstOrDefault().UserName.ToString(),
                    LoweredUserName = list.FirstOrDefault().UserName.ToString(),
                    Email = list.FirstOrDefault().Email.ToString(),
                    Password = ""
                };
                DemoDataTanimlar.KullaniciTanimlari.Add(c);
            }
        }
        catch (MembershipCreateUserException exc)
        {
            //if (exc.StatusCode == MembershipCreateStatus.DuplicateEmail || exc.StatusCode == MembershipCreateStatus.InvalidEmail)
            //{
            //    tbEmail.ErrorText = exc.Message;
            //    tbEmail.IsValid = false;
            //}
            //else if (exc.StatusCode == MembershipCreateStatus.InvalidPassword)
            //{
            //    tbPassword.ErrorText = exc.Message;
            //    tbPassword.IsValid = false;
            //}
            //else
            //{
            //    tbUserName.ErrorText = exc.Message;
            //    tbUserName.IsValid = false;
            //}
        }

    }
    public static void UpdateKullanici(string UserID, string UserName, string Email)
    {
        AktiviteEntities db = new AktiviteEntities();
        var list = db.IUD_Kullanici(UserID, UserName, Email).ToList();
        if(list.Count>0)
        {
            var c = DemoDataTanimlar.KullaniciTanimlari.First(z => z.UserID == UserID);
            c.UserName = UserName;
            c.LoweredUserName = UserName;
            c.Email = Email;
            
        }
    }
    public static void DeleteKullanici(string UserID)
    {
        //kullanıcı silme buttonunu false ettim. şuan için kullanıcı silmek mantıklı değil. gerekirse veritabanından işlem yapılır.
    }
    #endregion
}

public class DemoDataObjectTanimlar
{
    AktiviteEntities db = new AktiviteEntities();
    public List<Modull> Moduller { get; set; }
    public List<Danismann> Danismanlarr { get; set; }
    public List<Yuklenicii> Yuklenicilerr { get; set; }
    public List<Musterii> Musterilerr { get; set; }
    public List<MusteriLokasyonn> MusteriLokasyonlari { get; set; }
    public List<Projeler> Projeler { get; set; }
    public List<ProjeDanismanTanimlari> ProjelerTanismanTanimlari { get; set; }
    public List<ProjeModulDanisman> ProjeModulDanismanlari { get; set; }
    public List<DanismanModulleri> DanismanModulleriTanimlari { get; set; }
    public List<Kullanici> KullaniciTanimlari { get; set; }
    public List<SirketInFirma> Sirketler { get; set; }
    public void FillObjTanimlar()
    {
        Moduller = new List<Modull>();
        Danismanlarr = new List<Danismann>();
        Yuklenicilerr = new List<Yuklenicii>();
        Musterilerr = new List<Musterii>();
        MusteriLokasyonlari = new List<MusteriLokasyonn>();
        Projeler = new List<Projeler>();
        ProjelerTanismanTanimlari = new List<ProjeDanismanTanimlari>();
        ProjeModulDanismanlari = new List<ProjeModulDanisman>();
        DanismanModulleriTanimlari = new List<DanismanModulleri>();
        KullaniciTanimlari = new List<Kullanici>();
        Sirketler = new List<SirketInFirma>();
        #region Createler
        var listModul = db.S_Modul(-1).ToList();
        if (listModul.Count > 0)
        {
            foreach (var item in listModul)
            {
                CreateModul(item.ModulID, item.ModulAdi);
            }
        }
        var listDanisman = db.S_DanismanTanimlari(-1).ToList();
        if (listDanisman.Count > 0)
        {
            foreach (var item in listDanisman)
            {
                CreateDanisman(item.DanismanID, item.DanismanAdi, item.UserID.ToString());
            }
        }
        //yüklenici S_... procedure
        var listYuklenici = db.S_YukleniciTanimlari(-1).ToList();
        if (listYuklenici.Count > 0)
        {
            foreach (var item in listYuklenici)
            {
                CreateYuklenicii(item.YukleniciID, item.YukleniciAdi);
            }
        }
        //müşteri
        var listMusteri = db.S_MusteriTanimlari(-1).ToList();
        if (listMusteri.Count > 0)
        {
            foreach (var item in listMusteri)
            {
                CreateMusterii(item.MusteriID, item.MusteriAdi);
            }
        }
        //müşteri lokasyonları
        var listlokasyon = db.S_MusteriLokasyonTanimlari(-1).ToList();
        if (listlokasyon.Count > 0)
        {
            foreach (var item in listlokasyon)
            {
                CreateMusteriLokasyonn(item.MusteriLokasyonID, item.MusteriLokasyonAdi, Convert.ToInt32(item.MusteriID));
            }
        }
        //projeler
        var listprojeler = db.S_Proje(-1).ToList();
        if (listprojeler.Count > 0)
        {
            foreach (var item in listprojeler)
            {
                CreateProjeler(item.ProjeID,
                    item.ProjeAciklama,
                    item.Kod,
                    Convert.ToInt32(item.MusteriID),
                    Convert.ToInt32(item.MusteriLokasyonID),
                    Convert.ToBoolean(item.Yuklenici),
                    Convert.ToInt32(item.YukleniciID));
            }
        }
        //proje danişmanları tanımları
        var listProjejDanisman = db.S_ProjeDanisman(-1).ToList();
        if (listProjejDanisman.Count > 0)
        {
            foreach (var item in listProjejDanisman)
            {
                CreateProjeDanismanTanimlari(item.ID,
                    Convert.ToInt32(item.ProjeID),
                    Convert.ToInt32(item.DanismanID),
                    Convert.ToInt32(item.ModulID),
                    Convert.ToDecimal(item.FiyatGun));
            }
        }
        //proje danisman modülleri
        var listprojemoduldanisman = db.S_ProjeModulDanisman(-1).ToList();
        if (listprojemoduldanisman.Count > 0)
        {
            foreach (var item3 in listprojemoduldanisman)
            {
                CreateModulDanisman(item3.ModulID.Value,
                        item3.ModulAciklama,
                        item3.DanismanID.Value);
            }
        }
        //danişman modülleri
        var listDanismanModulleri = db.S_DanismanModul(-1).ToList();
        if (listDanismanModulleri.Count > 0)
        {
            foreach (var item in listDanismanModulleri)
            {
                CreateDanismanModulleri(item.ID,
                    Convert.ToInt32(item.DanismanID),
                    Convert.ToInt32(item.ModulID));
            }
        }
        //kullanicilar
        var listKullanici = db.S_Kullanici("").ToList();
        if (listKullanici.Count > 0)
        {
            foreach (var item in listKullanici)
            {
                CreateKullanicilar(item.UserId.ToString(), item.UserName, item.LoweredUserName, item.Email);
            }
        }
        //sirketler
        var listSirketler = db.S_Sirket().ToList();
        if(listSirketler.Count>0)
        {
            foreach (var item in listSirketler)
            {
                CreateSirket(item.SirketId, (Guid)item.FirmaId, item.SirketAdi, (DateTime)item.Tarih, (bool)item.Aktif);
            }
        }
        #endregion
    }
    Modull CreateModul(int _ModulID, string _ModulAdi)
    {
        var c = new Modull()
        {
            ModulID = _ModulID,
            ModulAdi = _ModulAdi
        };
        Moduller.Add(c);
        return c;
    }
    Danismann CreateDanisman(int _DanismanID, string _DanismanAdi, string _UserID)
    {
        var c = new Danismann()
        {
            DanismanID = _DanismanID,
            DanismanAdi = _DanismanAdi,
            UserID = _UserID
        };
        Danismanlarr.Add(c);
        return c;
    }
    Yuklenicii CreateYuklenicii(int _YukleniciID, string _YukleniciAdi)
    {
        var c = new Yuklenicii()
        {
            YukleniciID = _YukleniciID,
            YukleniciAdi = _YukleniciAdi
        };
        Yuklenicilerr.Add(c);
        return c;
    }
    Musterii CreateMusterii(int _MusteriID, string _MusteriAdi)
    {
        var c = new Musterii()
        {
            MusteriID = _MusteriID,
            MusteriAdi = _MusteriAdi
        };
        Musterilerr.Add(c);
        return c;
    }
    MusteriLokasyonn CreateMusteriLokasyonn(int _MusteriLokasyonID, string _MusteriLokasyonAdi, int _MusteriID)
    {
        var c = new MusteriLokasyonn()
        {
            MusteriLokasyonID = _MusteriLokasyonID,
            MusteriLokasyonAdi = _MusteriLokasyonAdi,
            MusteriID = _MusteriID

        };
        MusteriLokasyonlari.Add(c);
        return c;

    }
    Projeler CreateProjeler(int _ID, string _Aciklama, string _Kod,
        int _MusteriID, int _LokasyonID, bool _Yuklenici, int _YukleniciID)
    {
        var c = new Projeler()
        {
            ID = _ID,
            Aciklama = _Aciklama,
            Kod = _Kod,
            MusteriID = _MusteriID,
            LokasyonID = _LokasyonID,
            Yuklenici = _Yuklenici,
            YukleniciID = _YukleniciID
        };
        Projeler.Add(c);
        return c;
    }
    ProjeDanismanTanimlari CreateProjeDanismanTanimlari(int _ID, int _ProjeID, int _DanismanID, int _ModulID, decimal _FiyatGun)
    {
        var c = new ProjeDanismanTanimlari()
        {
            ID = _ID,
            ProjeID = _ProjeID,
            DanismanID = _DanismanID,
            ModulID = _ModulID,
            FiyatGun = _FiyatGun
        };
        ProjelerTanismanTanimlari.Add(c);
        return c;
    }
    ProjeModulDanisman CreateModulDanisman(int _ModulID, string _ModulAdi, int _DanismanID)
    {
        var c = new ProjeModulDanisman()
        {
            ModulID = _ModulID,
            ModulAdi = _ModulAdi,
            DanismanID = _DanismanID
        };
        ProjeModulDanismanlari.Add(c);
        return c;
    }
    DanismanModulleri CreateDanismanModulleri(int _ID, int _DanismanID, int _ModulID)
    {
        var c = new DanismanModulleri()
        {
            ID = _ID,
            DanismanID = _DanismanID,
            ModulID = _ModulID
        };
        DanismanModulleriTanimlari.Add(c);
        return c;
    }
    Kullanici CreateKullanicilar(string _UserID, string _UserName, string _LoweredUserName, string _Email)
    {
        var c = new Kullanici()
        {
            UserID = _UserID,
            UserName = _UserName,
            LoweredUserName = _LoweredUserName,
            Email = _Email,
            Password = ""
        };
        KullaniciTanimlari.Add(c);
        return c;
    }
    SirketInFirma CreateSirket(Guid _SirketId, Guid _FirmaId, string _SirketAdi, DateTime _Tarih, bool _Aktif)
    {
        var c = new SirketInFirma()
        {
            SirketId = _SirketId,
            FirmaId = _FirmaId,
            SirketAdi = _SirketAdi,
            Tarih = _Tarih,
            Aktif = _Aktif
        };
        Sirketler.Add(c);
        return c;
    }
}

public class Modull
{
    public int ModulID { get; set; }
    public string ModulAdi { get; set; }

}
public class Danismann
{
    public int DanismanID { get; set; }
    public string DanismanAdi { get; set; }
    public string UserID { get; set; }
}
public class Yuklenicii
{
    public int YukleniciID { get; set; }
    public string YukleniciAdi { get; set; }
}
public class Musterii
{
    public int MusteriID { get; set; }
    public string MusteriAdi { get; set; }
}
public class MusteriLokasyonn
{
    public int MusteriLokasyonID { get; set; }
    public string MusteriLokasyonAdi { get; set; }
    public int MusteriID { get; set; }
}
public class Projeler
{
    public int ID { get; set; }
    public string Aciklama { get; set; }
    public string Kod { get; set; }
    public int MusteriID { get; set; }
    public int LokasyonID { get; set; }
    public bool Yuklenici { get; set; }
    public int YukleniciID { get; set; }
}
public class ProjeDanismanTanimlari
{
    public int ID { get; set; }
    public int ProjeID { get; set; }
    public int DanismanID { get; set; }
    public int ModulID { get; set; }
    public decimal FiyatGun { get; set; }
}
public class ProjeModulDanisman
{
    public int ModulID { get; set; }
    public string ModulAdi { get; set; }
    public int DanismanID { get; set; }
}
public class DanismanModulleri
{
    public int ID { get; set; }
    public int DanismanID { get; set; }
    public int ModulID { get; set; }
}
public class Kullanici
{
    public string UserID { get; set; }
    public string UserName { get; set; }
    public string LoweredUserName { get; set; }
    public string Email { get; set; }
    public string Password { get; set; }
}
public class SirketInFirma
{
    public Guid SirketId { get; set; }
    public Guid FirmaId { get; set; }
    public string SirketAdi { get; set; }
    public DateTime Tarih { get; set; }
    public bool Aktif { get; set; }
}
