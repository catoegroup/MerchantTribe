using System.Collections.ObjectModel;
using System.Web.UI;
using BVSoftware.Commerce.Catalog;
using BVSoftware.Commerce.Content;
using System.Collections.Generic;

namespace BVCommerce
{

    partial class BVModules_ContentBlocks_Top_10_Products_adminview : BVModule
    {

        protected override void OnLoad(System.EventArgs e)
        {
            base.OnLoad(e);

            if (!Page.IsPostBack)
            {
                LoadProducts();
            }
        }

        private void LoadProducts()
        {
            System.DateTime s = new System.DateTime(1900, 1, 1);
            System.DateTime e = new System.DateTime(3000, 12, 31);
            List<Product> products = MyPage.BVApp.ReportingTopSellersByDate(s, e, 10);

            this.GridView1.DataSource = products;
            this.GridView1.DataBind();

        }

    }

}