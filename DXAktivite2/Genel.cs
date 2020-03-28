using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Web;

namespace DXAktivite2
{
    public class Genel
    {
        /// <summary>
        /// Sistemde login olan aktif kullanıcı id.
        /// </summary>
        public static Guid KullaniciGUID;
        public static string KullaniciIDs = "";
        public static int DanismanID = -1;
        public static string Theme = "";
        public static int BirGunKacSaat = -1;
        public static DateTime HaftaninIlkTarihiISO8601(int year, int weekOfYear)
        {
            DateTime jan1 = new DateTime(year, 1, 1);
            int daysOffset = DayOfWeek.Thursday - jan1.DayOfWeek;

            DateTime firstThursday = jan1.AddDays(daysOffset);
            var cal = CultureInfo.CurrentCulture.Calendar;
            int firstWeek = cal.GetWeekOfYear(firstThursday, CalendarWeekRule.FirstFourDayWeek, DayOfWeek.Monday);

            var weekNum = weekOfYear;
            if (firstWeek <= 1)
            {
                weekNum -= 1;
            }
            var result = firstThursday.AddDays(weekNum * 7);
            return result.AddDays(-3);
        }
        public static DateTime OncekiHaftaIlkGunu(DateTime date)
        {
            ////önceki haftanın ilk gününü verir.
            //DateTime ldowDate = HaftaninIlkGunu(date);
            //return ldowDate.AddDays(-14);
            DayOfWeek weekStart = DayOfWeek.Monday; // or Sunday, or whenever
            DateTime startingDate = DateTime.Today;

            while (startingDate.DayOfWeek != weekStart)
                startingDate = startingDate.AddDays(-1);

            DateTime previousWeekStart = startingDate.AddDays(-7);
            //  DateTime previousWeekEnd = startingDate.AddDays(-1);
            return previousWeekStart;
        }
        public static DateTime OncekiHaftaSonGunu(DateTime date)
        {
            ////önceki haftanın ilk gününü verir.
            //DateTime ldowDate = HaftaninIlkGunu(date);
            //return ldowDate.AddDays(-8);
            DayOfWeek weekStart = DayOfWeek.Monday; // or Sunday, or whenever
            DateTime startingDate = DateTime.Today;

            while (startingDate.DayOfWeek != weekStart)
                startingDate = startingDate.AddDays(-1);

            // DateTime previousWeekStart = startingDate.AddDays(-7);
            DateTime previousWeekEnd = startingDate.AddDays(-1);
            return previousWeekEnd;
        }
        public static DateTime SonrakiHaftaIlkGunu(DateTime date)
        {
            //sonraki haftanın ilk gününü verir.

            //DateTime fdowDate = HaftaninIlkGunu(date);
            //return fdowDate;

            DayOfWeek weekStart = DayOfWeek.Monday; // or Sunday, or whenever
            DateTime startingDate = DateTime.Today;

            while (startingDate.DayOfWeek != weekStart)
                startingDate = startingDate.AddDays(-1);

            DateTime previousWeekStart = startingDate.AddDays(7);
            //  DateTime previousWeekEnd = startingDate.AddDays(-1);
            return previousWeekStart;
        }
        public static DateTime SonrakiHaftaSonGunu(DateTime date)
        {
            ////sonraki haftanın ilk gününü verir.
            //DateTime fdowDate = HaftaninSonGunu(date);
            //return fdowDate;
            DayOfWeek weekStart = DayOfWeek.Monday; // or Sunday, or whenever
            DateTime startingDate = DateTime.Today;

            while (startingDate.DayOfWeek != weekStart)
                startingDate = startingDate.AddDays(-1);

            // DateTime previousWeekStart = startingDate.AddDays(-7);
            DateTime previousWeekEnd = startingDate.AddDays(13);
            return previousWeekEnd;
        }
        public static string GetIPAddress()
        {
            IPHostEntry ipHostInfo = Dns.GetHostEntry(Dns.GetHostName()); // `Dns.Resolve()` method is deprecated.
            IPAddress ipAddress = ipHostInfo.AddressList[0];
            return ipAddress.ToString();
        }
        public static string GetHostAdi()
        {
            IPHostEntry ipHostInfo = Dns.GetHostEntry(Dns.GetHostName()); // `Dns.Resolve()` method is deprecated.
            return ipHostInfo.HostName.ToString();
        }
        public static string GetClientIp()
        {
            var ipAddress = string.Empty;
            if (System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] != null)
            { ipAddress = System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString(); }

            else if (System.Web.HttpContext.Current.Request.ServerVariables["HTTP_CLIENT_IP"] != null && System.Web.HttpContext.Current.Request.ServerVariables["HTTP_CLIENT_IP"].Length != 0) { ipAddress = System.Web.HttpContext.Current.Request.ServerVariables["HTTP_CLIENT_IP"]; } else if (System.Web.HttpContext.Current.Request.UserHostAddress.Length != 0) { ipAddress = System.Web.HttpContext.Current.Request.UserHostName; }

            return ipAddress;
        }
        public static string GetirDisIP()
        {
            try
            {
                string DisIP;
                DisIP = (new System.Net.WebClient()).DownloadString("http://checkip.dyndns.org/");
                DisIP = (new System.Text.RegularExpressions.Regex(@"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}")).Matches(DisIP)[0].ToString();
                return DisIP;
            }
            catch (Exception)
            {
                return "";
            }

            //string q = "";
            //return q;
        }
    }
}