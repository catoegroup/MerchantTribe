﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BVSoftware.Commerce.Accounts;

namespace BVCommerce.BVAdmin
{
    public partial class ChangeEmail : BaseAdminPage
    {        
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            if (!Page.IsPostBack)
            {
                if (Request.QueryString["pci"] != null)
                {
                    this.MessageBox1.ShowInformation("In order to be PCI compliant you will need to change your administrator email from the default to your own unique email address.");
                }
                UserAccount u = GetCorrectUser();
                PopulatePage(u);
            }
        }

        private UserAccount GetCorrectUser()
        {
            UserAccount u = CurrentUser;

            if (u != null)
            {
                if (u.Status == UserAccountStatus.SuperUser)
                {
                    // don't use current user, get the owner of the store instead
                    List<UserAccount> users = BVApp.AccountServices.FindAdminUsersByStoreId(BVApp.CurrentStore.Id);
                    if (users != null)
                    {
                        if (users.Count > 0)
                        {
                            return users[0];
                        }
                    }
                }
            }

            return u;
        }

        private void PopulatePage(UserAccount u)
        {
            this.litCurrentEmail.Text = u.Email;            
        }

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            this.MessageBox1.ClearMessage();

            UserAccount u = GetCorrectUser();
            if (u == null)
            {
                this.MessageBox1.ShowError("Could not locate your account.");
                return;
            }

            UserAccount other = BVApp.AccountServices.AdminUsers.FindByEmail(this.NewEmailField.Text.Trim());
            if (other != null)
            {
                if (other.Id != u.Id)
                {
                    this.MessageBox1.ShowWarning("Another administrator account with that email already exists. Try a different email or try logging in as that user first.");
                    return;
                }
            }

            u.Email = this.NewEmailField.Text.Trim();
            BVApp.AccountServices.AdminUsers.Update(u);
            this.MessageBox1.ShowOk("Email address was changed!");
            PopulatePage(u);

            // Redirect to dashboard when it was a PCI request to change email
            if (Request.QueryString["pci"] != null)
            {
                Response.Redirect("Default.aspx");
            }
        }
                          
    }
}