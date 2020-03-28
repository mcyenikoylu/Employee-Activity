using Quartz;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RouteServer
{

    class Gorevler : IJob
    {
        private static readonly Object _lock = new Object();
        public string JobSays { private get; set; }
        public float FloatValue { private get; set; }
        AktiviteEntities db = new AktiviteEntities();

        public void Execute(IJobExecutionContext context)
        {
            lock (_lock)
            {

                //Form1 frm = new Form1();
                //frm.txtConsole.Text += DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToLongTimeString() + " " + context.JobDetail.Key.Name + ": tetiklendi. " + Environment.NewLine;

                string mesaj = "";
                if (context.JobDetail.Key.Name == "Job1")
                {
                    Console.Beep();
                    Console.WriteLine("Mail gönderimi çalıştırılıyor...");

                    var mailList = db.S_Mail(false).ToList();
                    foreach (var item in mailList)
                    {
                        MailIslemleri.MailGonder(item.GonderilenMailAdresi, item.Konu, item.GonderenMailAdresi, item.HTML, item.PromotionName, out mesaj);
                        db.U_MailGonderildi(item.ID);

                        //frm.txtConsole.Text += DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToLongTimeString() + " " + item.GonderilenMailAdresi + ", adresine gönderildi. " + mesaj + Environment.NewLine;
                    }
                }
                else
                {
                    //standart mail gönderimleri dışındaki procedure çalıştırmak için.
                    try
                    {



                        Console.Beep();
                        Console.WriteLine("Procedure çalıştırılıyor...");

                        //SqlConnection dbConn = new SqlConnection("Data Source=.;Initial Catalog=Aktivite;User ID=sa;Password=123");
                        //dbConn.Open();

                        //SqlCommand sqlComm = new SqlCommand();
                        //sqlComm.Connection = dbConn;

                        //sqlComm.CommandType = CommandType.StoredProcedure; 
                        //sqlComm.CommandText = "SEDS_Resimler";

                        //sqlComm.Parameters.Add("@IslemTipi", SqlDbType.Int).Value = 1;
                        //sqlComm.Parameters.Add("@ResimAciklama", SqlDbType.NVarChar, 250).Value = "";

                        //string tagID = sqlComm.ExecuteScalar().ToString();

                        var list = db.S_ZamanlanmisGorevler().Where(c => c.JobAdi == context.JobDetail.Key.Name).ToList();

                        SQLRunner sqlYeni = new SQLRunner();

                        sqlYeni.DatabaseName = "Route";
                        sqlYeni.ServerName = "tecs.westus.cloudapp.azure.com";
                        sqlYeni.UserName = "sa";
                        sqlYeni.Password = "Mcy2@16";

                        //sqlYeni.DatabaseName = "Aktivite";
                        //sqlYeni.ServerName = ".";
                        //sqlYeni.UserName = "sa";
                        //sqlYeni.Password = "123";

                        bool YeniDB = sqlYeni.CreateConnection();
                        if (YeniDB)
                            sqlYeni.ExecuteNonQuery("EXEC " + list.First().ProcedureAdi);

                        //frm.txtConsole.Text += DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToShortTimeString() + " " + "EXEC Cron_EksikAktiviteGirisleriniBildir: çalıştırıldı." + Environment.NewLine;
                        Console.WriteLine("Procedure çalıştı!");
                    }
                    catch (Exception hata)
                    {
                        Console.WriteLine(hata.ToString());
                    }
                }
            }
        }

    }
}
