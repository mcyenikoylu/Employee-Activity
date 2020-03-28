using DevExpress.XtraEditors;
using Quartz;
using Quartz.Impl;
using Quartz.Impl.Matchers;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace RouteServer
{
    public partial class Form1 : DevExpress.XtraBars.Ribbon.RibbonForm
    {

        public Form1()
        {
            InitializeComponent();
        }
        private void Form1_Load(object sender, EventArgs e)
        {
            this.Text += " | Versiyon " + System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString();
            marqueeProgressBarControl1.Visible = false;
        }

        private void btnBaslat_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            try
            {

                list_zamanlanmisGorevler = db.S_ZamanlanmisGorevler().ToList();
                if (list_zamanlanmisGorevler.Count > 0)
                {
                    zamanlanmisGorevAdedi = list_zamanlanmisGorevler.Count;
                    gridControl1.DataSource = list_zamanlanmisGorevler;
                    ZamanlanmisGorevler();
                }
                //timer1.Start();
                marqueeProgressBarControl1.Visible = true;
            }
            catch (Exception hata)
            {
                XtraMessageBox.Show("Veritabanı bağlantısı yapılamadı. " +  hata.Message, "Hata", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnDurdur_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            var cronlist = list_zamanlanmisGorevler.ToList();
            foreach (var item in cronlist)
            {
                string valueid = ""; valueid = item.ID.ToString();
                ISchedulerFactory schedulerFactory = new StdSchedulerFactory();
                IScheduler scheduler = schedulerFactory.GetScheduler();

                IJobDetail job = JobBuilder.Create<Gorevler>()
                .WithIdentity("Job" + valueid,
                                "Group" + valueid)
                .Build();

                scheduler.Shutdown();

                txtConsole.Text += DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToShortTimeString() + " " + job.Key.Name + ": durduruldu." + Environment.NewLine;
            }

            //timer1.Dispose();
            zamanlanmisGorevAdedi = 0;
            yeniGelenZamanlanmisGorevAdedi = 0;
            marqueeProgressBarControl1.Visible = false;
        }

        List<S_ZamanlanmisGorevler_Result> list_zamanlanmisGorevler = new List<S_ZamanlanmisGorevler_Result>();
        AktiviteEntities db = new AktiviteEntities();
        int zamanlanmisGorevAdedi = 0;
        int yeniGelenZamanlanmisGorevAdedi = 0; //sonradan gerek kalmadı.
        private void timer1_Tick(object sender, EventArgs e)
        {
            //eski tetiklenenleri liste eklememesi gerekiyor. çünkü olnar çalışır durumdalar ve zaman çizelgelerini bozar. mesele 3 saate bir denen bir trigerı bozar.

            //var list = db.S_ZamanlanmisGorevler().ToList();
            //if (list.Count > 0)
            //    yeniGelenZamanlanmisGorevAdedi = list.Count;

            //if (zamanlanmisGorevAdedi != yeniGelenZamanlanmisGorevAdedi)
            //{
            //    //yeni görevi dinamik olarak yarat ve triggerı başlat.
            //    list_zamanlanmisGorevler = list;
            //}
        }

        private void ZamanlanmisGorevler()
        {
            string valueid = "";
            var cronlist = list_zamanlanmisGorevler.ToList();
            foreach (var item in cronlist)
            {
                valueid = item.ID.ToString();
                ISchedulerFactory schedulerFactory = new StdSchedulerFactory();
                IScheduler scheduler = schedulerFactory.GetScheduler();

                IJobDetail job = JobBuilder.Create<Gorevler>()
                .WithIdentity("Job"+ valueid,
                                "Group" + valueid)
                .Build();

                ITrigger trigger = TriggerBuilder.Create()
                    .ForJob(job)
                    .WithCronSchedule(string.Format("{0} {1} {2} {3} {4} {5} {6}", item.Saniye,
                                                                            item.Dakika,
                                                                            item.Saat,
                                                                            item.Gun,
                                                                            item.Ay,
                                                                            item.Hafta,
                                                                            item.Yil))

                .WithIdentity("Trigger" + valueid,
                                "Group" + valueid)
                .StartNow()
                .Build();

                scheduler.ScheduleJob(job, trigger);
                scheduler.Start();

                txtConsole.Text += DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToLongTimeString() + " " + job.Key.Name + ": başlatıldı." + Environment.NewLine;
          
            }
            
        }
      
        private static void GetAllJobs(IScheduler scheduler)
        {
            IList<string> jobGroups = scheduler.GetJobGroupNames();
            // IList<string> triggerGroups = scheduler.GetTriggerGroupNames();

            foreach (string group in jobGroups)
            {
                var groupMatcher = GroupMatcher<JobKey>.GroupContains(group);
                var jobKeys = scheduler.GetJobKeys(groupMatcher);
                foreach (var jobKey in jobKeys)
                {
                    var detail = scheduler.GetJobDetail(jobKey);
                    var triggers = scheduler.GetTriggersOfJob(jobKey);
                    foreach (ITrigger trigger in triggers)
                    {
                        Console.WriteLine(group);
                        Console.WriteLine(jobKey.Name);
                        Console.WriteLine(detail.Description);
                        Console.WriteLine(trigger.Key.Name);
                        Console.WriteLine(trigger.Key.Group);
                        Console.WriteLine(trigger.GetType().Name);
                        Console.WriteLine(scheduler.GetTriggerState(trigger.Key));
                        DateTimeOffset? nextFireTime = trigger.GetNextFireTimeUtc();
                        if (nextFireTime.HasValue)
                        {
                            Console.WriteLine(nextFireTime.Value.LocalDateTime.ToString());
                        }

                        DateTimeOffset? previousFireTime = trigger.GetPreviousFireTimeUtc();
                        if (previousFireTime.HasValue)
                        {
                            Console.WriteLine(previousFireTime.Value.LocalDateTime.ToString());
                        }
                    }
                }
            }
        }

        private void ribbonControl1_Paint(object sender, PaintEventArgs e)
        {
            DevExpress.XtraBars.Ribbon.ViewInfo.RibbonViewInfo ribbonViewInfo = ribbonControl1.ViewInfo;
            if (ribbonViewInfo == null)
                return;
            DevExpress.XtraBars.Ribbon.ViewInfo.RibbonPanelViewInfo panelViewInfo = ribbonViewInfo.Panel;
            if (panelViewInfo == null)
                return;
            Rectangle bounds = panelViewInfo.Bounds;
            int minX = bounds.X;
            DevExpress.XtraBars.Ribbon.ViewInfo.RibbonPageGroupViewInfoCollection groups = panelViewInfo.Groups;
            if (groups == null)
                return;
            if (groups.Count > 0)
                minX = groups[groups.Count - 1].Bounds.Right;
            Image image = RouteServer.Properties.Resources.RouteServerLogo2; // DevExpress.Utils.Frames.ApplicationCaption8_1.GetImageLogoEx(LookAndFeel);
            if (bounds.Height < image.Height)
                return;
            int offset = (bounds.Height - image.Height) / 2;
            int width = image.Width + 15;
            bounds.X = bounds.Width - width;
            if (bounds.X < minX)
                return;
            bounds.Width = width;
            bounds.Y += offset;
            bounds.Height = image.Height;
            e.Graphics.DrawImage(image, bounds.Location);
        }
    }
}
