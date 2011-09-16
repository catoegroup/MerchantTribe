﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BVSoftware.Commerce;
using BVSoftware.CommerceDTO.v1;
using BVSoftware.CommerceDTO.v1.Catalog;
using BVSoftware.Commerce.Catalog;

namespace BVCommerce.api.rest
{
    public class ProductFilesXProductsHandler: BaseRestHandler
    {
        public ProductFilesXProductsHandler(BVSoftware.Commerce.BVApplication app)
            : base(app)
        {

        }

        // List or Find Single
        public override string GetAction(string parameters, System.Collections.Specialized.NameValueCollection querystring)
        {            
            string data = string.Empty;
            string productBvin = FirstParameter(parameters);
            

            if (string.Empty == (parameters ?? string.Empty))
            {
                // List
                ApiResponse<List<ProductFileDTO>> response = new ApiResponse<List<ProductFileDTO>>();

                var items = BVApp.CatalogServices.ProductFiles.FindByProductId(productBvin);                
                foreach (var item in items)
                {
                    response.Content.Add(item.ToDto());
                }                
                data = MerchantTribe.Web.Json.ObjectToJson(response);
            }
            
            return data;
        }

        // Create or Update
        public override string PostAction(string parameters, System.Collections.Specialized.NameValueCollection querystring, string postdata)
        {
            string data = string.Empty;
            string bvin = FirstParameter(parameters);
            string productBvin = GetParameterByIndex(1, parameters);
            
            string minutes = querystring["minutes"];
            int availableMinutes = 0;
            int.TryParse(minutes, out availableMinutes);
            
            string downloads = querystring["downloads"];
            int maxDownloads = 0;
            int.TryParse(downloads, out maxDownloads);

            ApiResponse<bool> response = new ApiResponse<bool>();

            // Single Item Delete
            response.Content = BVApp.CatalogServices.ProductFiles.AddAssociatedProduct(bvin, productBvin, availableMinutes, maxDownloads);

            data = MerchantTribe.Web.Json.ObjectToJson(response);
            return data;            
        }

        public override string DeleteAction(string parameters, System.Collections.Specialized.NameValueCollection querystring, string postdata)
        {
            string data = string.Empty;
            string bvin = FirstParameter(parameters);
            string productBvin = GetParameterByIndex(1, parameters);
            ApiResponse<bool> response = new ApiResponse<bool>();

            // Single Item Delete
            response.Content = BVApp.CatalogServices.ProductFiles.RemoveAssociatedProduct(bvin, productBvin);

            data = MerchantTribe.Web.Json.ObjectToJson(response);
            return data;
        }
    }
}