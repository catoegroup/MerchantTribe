
using BVSoftware.Commerce;
using System.Data;
using System.Collections.ObjectModel;
using BVSoftware.Commerce.Catalog;
using BVSoftware.Commerce.Accounts;

namespace BVCommerce
{
    public class BaseStoreJsonPage : System.Web.UI.Page, IStorePage, BVSoftware.Commerce.IMultiStorePage
    {

        private bool _useTabIndexes = false;
        private bool _AvailableWhenInactive = false;
        

        public bool AvailableWhenInactive
        {
            get { return _AvailableWhenInactive; }
            set { _AvailableWhenInactive = value; }
        }

        public bool UseTabIndexes
        {
            get { return _useTabIndexes; }
            set { _useTabIndexes = value; }
        }
        public virtual bool DisplaysActiveCategoryTab
        {
            get { return false; }
        }
        public virtual bool IsClosedPage
        {
            get { return false; }
        }

        public System.Web.Mvc.ViewDataDictionary ViewData
        {
            get { return ((IStorePage)this.Master).ViewData; }
            set { ((IStorePage)this.Master).ViewData = value; }
        }

        public BVApplication BVApp {get;set;}
              
        public void AddBodyClass(string css)
        {
            ((IStorePage)this.Master).AddBodyClass(css);
        }

        // Redirect to the "www" version of the URL if needed
        private void RedirectBVCommerceCom(System.Web.HttpContext context)
        {
            // Bail out if we're in individual mode
            if (WebAppSettings.IsIndividualMode) return;

            if (context != null)
            {
                System.Uri url = context.Request.Url;
                string host = url.DnsSafeHost.ToLowerInvariant();
                if ("bvcommerce.com" == host)
                {
                    Response.RedirectPermanent("http://www.bvcommerce.com");
                }
            }
        }

        protected override void OnPreInit(System.EventArgs e)
        {
            base.OnPreInit(e);
            BVApp = BVApplication.InstantiateForDataBase(new RequestContext());

            // Store routing context for URL Rewriting
            BVApp.CurrentRequestContext.RoutingContext = this.Request.RequestContext;

            // Check for non-www url and redirect if needed            
            RedirectBVCommerceCom(System.Web.HttpContext.Current);

            // Determine store id        
            BVApp.CurrentStore = BVSoftware.Commerce.Utilities.UrlHelper.ParseStoreFromUrl(System.Web.HttpContext.Current.Request.Url, BVApp.AccountServices);
            if (BVApp.CurrentStore == null)
            {
                Response.Redirect("~/storenotfound");
            }

            if (BVApp.CurrentStore.Status == BVSoftware.Commerce.Accounts.StoreStatus.Deactivated)
            {
                if ((AvailableWhenInactive == false))
                {
                    Response.Redirect("~/storenotavailable");
                }
            }

            // Culture Settings
            System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(BVApp.CurrentStore.Settings.CultureCode);
            System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(BVApp.CurrentStore.Settings.CultureCode);

            //If this is a private store, force login before showing anything.
            if (BVApp.CurrentStore.Settings.IsPrivateStore == true)
            {
                if (SessionManager.IsUserAuthenticated(this.BVApp) == false)
                {
                    string nameOfPage = Request.AppRelativeCurrentExecutionFilePath;
                    // Check to make sure we're not going to end up in an endless loop of redirects
                    if ((!nameOfPage.ToLower().StartsWith("~/login.aspx")) && (!nameOfPage.ToLower().StartsWith("~/forgotpassword.aspx")) && (!nameOfPage.ToLower().StartsWith("~/contactus.aspx")))
                    {
                        Response.Redirect("~/Login.aspx?ReturnUrl=" + System.Web.HttpUtility.UrlEncode(this.Request.RawUrl));
                    }
                }
            }

            IntegrationLoader.AddIntegrations(this.BVApp.CurrentRequestContext.IntegrationEvents, this.BVApp.CurrentStore);
        }

        public virtual bool RequiresSSL
        {
            get { return false; }
        }

        protected virtual void StoreClosedCheck()
        {
        }

        protected override void OnLoad(System.EventArgs e)
        {
            base.OnLoad(e);
            StoreClosedCheck();

            if (RequiresSSL)
            {
                if (WebAppSettings.UseSsl)
                {
                    if (!Request.IsSecureConnection)
                    {
                        BVSoftware.Commerce.Utilities.SSL.SSLRedirect(this, this.BVApp.CurrentStore, BVSoftware.Commerce.Utilities.SSL.SSLRedirectTo.SSL);
                    }
                }
            }
            else
            {
                if (WebAppSettings.UseSsl)
                {
                    if (Request.IsSecureConnection)
                    {
                        BVSoftware.Commerce.Utilities.SSL.SSLRedirect(this, this.BVApp.CurrentStore, BVSoftware.Commerce.Utilities.SSL.SSLRedirectTo.NonSSL);
                    }
                }
            }

        }

    }

}