using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using DevExpress.Web;
using DevExpress.DashboardWeb.Designer;
using DevExpress.DashboardCommon;

namespace DXAktivite2
{
    public class Global_asax : System.Web.HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {

            DevExpress.Web.ASPxWebControl.CallbackError += new EventHandler(Application_Error);
       
            //DashboardFileStorage dashStorage = new DashboardFileStorage(@"~/App_Data/Dashboards");
            //ASPxDashboardDesigner.Storage.SetDashboardStorage(dashStorage);

            //DashboardEFDataSource efDataSource = new DashboardEFDataSource("Views");
            //efDataSource.ConnectionParameters = new DevExpress.DataAccess.EntityFramework.EFConnectionParameters(typeof(AktiviteEntities));

            //DataSourceInMemoryStorage dataSourceStroage = new DataSourceInMemoryStorage();
            //dataSourceStroage.RegisterDataSource("efDataSource", efDataSource);
            //ASPxDashboardDesigner.Storage.SetDataSourceStorage(dataSourceStroage);

        }

        void Application_End(object sender, EventArgs e)
        {
            // Code that runs on application shutdown
        }

        void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs
        }

        void Session_Start(object sender, EventArgs e)
        {
            // Code that runs when a new session is started
        }

        void Session_End(object sender, EventArgs e)
        {
            // Code that runs when a session ends. 
            // Note: The Session_End event is raised only when the sessionstate mode
            // is set to InProc in the Web.config file. If session mode is set to StateServer 
            // or SQLServer, the event is not raised.
        }
    }
}