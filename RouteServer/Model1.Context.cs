﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace RouteServer
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class AktiviteEntities : DbContext
    {
        public AktiviteEntities()
            : base("name=AktiviteEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
    
        public virtual ObjectResult<S_ZamanlanmisGorevler_Result> S_ZamanlanmisGorevler()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<S_ZamanlanmisGorevler_Result>("S_ZamanlanmisGorevler");
        }
    
        public virtual ObjectResult<S_Mail_Result> S_Mail(Nullable<bool> durum)
        {
            var durumParameter = durum.HasValue ?
                new ObjectParameter("Durum", durum) :
                new ObjectParameter("Durum", typeof(bool));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<S_Mail_Result>("S_Mail", durumParameter);
        }
    
        public virtual int U_MailGonderildi(Nullable<int> iD)
        {
            var iDParameter = iD.HasValue ?
                new ObjectParameter("ID", iD) :
                new ObjectParameter("ID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("U_MailGonderildi", iDParameter);
        }
    }
}
