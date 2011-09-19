﻿using System;
using System.Web;
using System.Web.Routing;
using System.Web.Mvc;
using System.Reflection;
using System.Collections.Generic;
using MerchantTribe.Commerce.Catalog;

namespace BVCommerce
{
    public class CustomRouter: IRouteHandler
    {        
        private class CategoryUrlMatchData
        {
            public bool IsFound {get;set;}
            public CategorySourceType SourceType {get;set;}

            public CategoryUrlMatchData()
            {
                IsFound = false;
                SourceType = CategorySourceType.Manual;
            }
        }


        public System.Web.IHttpHandler GetHttpHandler(RequestContext requestContext)
        {
            string fullSlug = (string)requestContext.RouteData.Values["slug"];
            fullSlug = fullSlug.ToLowerInvariant() ?? string.Empty;

            // Application Context
            MerchantTribe.Commerce.MerchantTribeApplication MTApp = MerchantTribe.Commerce.MerchantTribeApplication.InstantiateForDataBase(new MerchantTribe.Commerce.RequestContext());
            MTApp.CurrentRequestContext.RoutingContext = requestContext;

            // Determine store id        
            MTApp.CurrentStore = MerchantTribe.Commerce.Utilities.UrlHelper.ParseStoreFromUrl(System.Web.HttpContext.Current.Request.Url, MTApp.AccountServices);
            

            // Check for Category/Page Match
            CategoryUrlMatchData categoryMatchData = IsCategoryMatch(fullSlug, MTApp);
            if (categoryMatchData.IsFound)
            {
                switch(categoryMatchData.SourceType)
                {
                    case CategorySourceType.ByRules:
                    case CategorySourceType.CustomLink:
                    case CategorySourceType.Manual:
                        var catPage = System.Web.Compilation.BuildManager.CreateInstanceFromVirtualPath("~/category.aspx", typeof(BVCommerce.category)) as BVCommerce.category;
                        return catPage as IHttpHandler;                        
                    case CategorySourceType.DrillDown:
                        var filterPage = System.Web.Compilation.BuildManager.CreateInstanceFromVirtualPath("~/categorydrilldown.aspx", typeof(BVCommerce.categorydrilldown)) as BVCommerce.categorydrilldown;
                        return filterPage as IHttpHandler;                        
                    case CategorySourceType.FlexPage:
                        requestContext.RouteData.Values["controller"] = "FlexPage";
                        requestContext.RouteData.Values["action"] = "Index";
                        System.Web.Mvc.MvcHandler mvcHandler2 = new System.Web.Mvc.MvcHandler(requestContext);
                        return mvcHandler2;                        
                    case CategorySourceType.CustomPage:
                        var customPage = System.Web.Compilation.BuildManager.CreateInstanceFromVirtualPath("~/custompage.aspx", typeof(BVCommerce.custompage)) as BVCommerce.custompage;
                        return customPage as IHttpHandler;            
                }
            }

            // Check for Product URL
            if (IsProductUrl(fullSlug, MTApp))
            {            
                var page = System.Web.Compilation.BuildManager.CreateInstanceFromVirtualPath("~/product.aspx", typeof(BVCommerce.ProductPage)) as BVCommerce.ProductPage;
                return page as IHttpHandler;
            }

            // no match on product or category so do a 301 check
            CheckFor301(fullSlug, MTApp);

            // If not product, send to FlexPage Controller
            requestContext.RouteData.Values["controller"] = "FlexPage";
            requestContext.RouteData.Values["action"] = "Index";
            System.Web.Mvc.MvcHandler mvcHandler = new System.Web.Mvc.MvcHandler(requestContext);
            return mvcHandler;
        }

        private void CheckFor301(string slug, MerchantTribe.Commerce.MerchantTribeApplication app)
        {
            MerchantTribe.Commerce.Content.CustomUrl url = app.ContentServices.CustomUrls.FindByRequestedUrl(slug);
            if (url != null)
            {
                if (url.Bvin != string.Empty)
                {
                    if (url.IsPermanentRedirect)
                    {                        
                        app.CurrentRequestContext.RoutingContext.HttpContext.Response.RedirectPermanent(url.RedirectToUrl);
                    }
                    else
                    {
                        app.CurrentRequestContext.RoutingContext.HttpContext.Response.Redirect(url.RedirectToUrl);
                    }
                }
            }
        }

        private CategoryUrlMatchData IsCategoryMatch(string fullSlug,MerchantTribe.Commerce.MerchantTribeApplication app)
        {
 	        CategoryUrlMatchData result =new CategoryUrlMatchData();

            Category cat = app.CatalogServices.Categories.FindBySlugForStore(fullSlug, app.CurrentRequestContext.CurrentStore.Id);
            if (cat != null)
            {
                result.IsFound = true;
                result.SourceType = cat.SourceType;
            }

            return result;
        }

        private bool IsProductUrl(string fullSlug, MerchantTribe.Commerce.MerchantTribeApplication app)
        {                        
            // See if we have a matching Product URL
            MerchantTribe.Commerce.Catalog.Product p = app.CatalogServices.Products.FindBySlug(fullSlug);
            if (p != null)
            {
                if (p.Bvin != string.Empty) return true;
            }

            return false;
        }
    }

}