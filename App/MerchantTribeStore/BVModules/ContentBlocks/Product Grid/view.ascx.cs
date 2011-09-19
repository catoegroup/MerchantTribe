using System.Collections.ObjectModel;
using System.Text;
using MerchantTribe.Commerce.Catalog;
using MerchantTribe.Commerce.Content;
using System.Collections.Generic;

namespace BVCommerce
{

    partial class BVModules_ContentBlocks_Product_Grid_view : BVModule
    {

        protected override void OnLoad(System.EventArgs e)
        {
            base.OnLoad(e);
            LoadProductGrid();
        }

        private void LoadProductGrid()
        {
            ContentBlock b = MyPage.MTApp.ContentServices.Columns.FindBlock(this.BlockId);
            List<ContentBlockSettingListItem> myProducts = b.Lists.FindList("ProductGrid");
            if (myProducts != null)
            {

                StringBuilder sb = new StringBuilder();
                int column = 1;

                if (b != null)
                {
                    int maxColumns = b.BaseSettings.GetIntegerSetting("GridColumns");
                    if (maxColumns < 1) maxColumns = 3;

                    foreach (ContentBlockSettingListItem sett in myProducts)
                    {
                        string bvin = sett.Setting1;
                        Product p = MyPage.MTApp.CatalogServices.Products.Find(bvin);
                        if (p != null)
                        {
                            bool isLastInRow = false;
                            bool isFirstInRow = false;
                            if ((column == 1))
                            {
                                isFirstInRow = true;
                            }

                            if ((column == maxColumns))
                            {
                                column = 1;
                                isLastInRow = true;
                            }
                            else
                            {
                                column += 1;
                            }
                            UserSpecificPrice price = MyPage.MTApp.PriceProduct(p, MyPage.MTApp.CurrentCustomer, null);
                            MerchantTribe.Commerce.Utilities.HtmlRendering.RenderSingleProduct(ref sb, p, isLastInRow, isFirstInRow, this.Page, price);
                        }

                    }
                }
                this.litMain.Text = sb.ToString();
            }
        }

    }
}