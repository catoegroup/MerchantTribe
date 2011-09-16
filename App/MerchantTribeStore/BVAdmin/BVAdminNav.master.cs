using BVSoftware.Commerce;

namespace BVCommerce
{

    partial class BVAdmin_BVAdminNav : System.Web.UI.MasterPage
    {
        public string wallpaper = "BrownStripes.jpg";

        protected override void OnLoad(System.EventArgs e)
        {
            base.OnLoad(e);

            string wall = SessionManager.GetCookieString("AdminWallpaper");
            if (wall != string.Empty)
            {
                wallpaper = wall;
            }

        }
    }

}