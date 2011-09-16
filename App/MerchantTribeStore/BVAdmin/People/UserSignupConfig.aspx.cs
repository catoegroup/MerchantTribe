using System;
using System.Web;
using System.Web.UI.WebControls;
using BVSoftware.Commerce.Contacts;
using BVSoftware.Commerce.Membership;
using BVSoftware.Commerce;
using System.Collections.ObjectModel;
using System.Collections.Generic;

namespace BVCommerce
{

    partial class BVAdmin_People_UserSignupConfig : BaseAdminPage
    {

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!Page.IsPostBack)
            {
                BindQuestionsGrid();

                //update questions with an order
                List<UserQuestion> questions = BVApp.MembershipServices.UserQuestions.FindAll();
                int count = 1;
                foreach (UserQuestion question in questions)
                {
                    if (count == 1)
                    {
                        if (question.Order != 0)
                        {
                            break;
                        }
                    }
                    question.Order = count;
                    count += 1;
                    BVApp.MembershipServices.UserQuestions.Update(question);
                }
            }
        }

        protected void BindQuestionsGrid()
        {
            QuestionsGridView.DataSource = BVApp.MembershipServices.UserQuestions.FindAll();
            QuestionsGridView.DataKeyNames = new string[] { "bvin" };
            QuestionsGridView.DataBind();
        }

        protected override void OnPreInit(EventArgs e)
        {
            base.OnPreInit(e);
            this.PageTitle = "User Signup Config";
            this.CurrentTab = AdminTabType.People;
            ValidateCurrentUserHasPermission(SystemPermissions.PeopleView);
        }

        protected void QuestionsGridView_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            Response.Redirect("~/BVAdmin/People/UserQuestionEdit.aspx?id=" + HttpUtility.UrlEncode((string)QuestionsGridView.DataKeys[e.NewEditIndex].Value));
        }

        protected void QuestionsGridView_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            BVApp.MembershipServices.UserQuestions.Delete((string)QuestionsGridView.DataKeys[e.RowIndex].Value);
            BindQuestionsGrid();
        }

        protected void NewImageButton_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            Response.Redirect("~/BVAdmin/People/UserQuestionEdit.aspx");
        }

        protected void QuestionsGridView_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "MoveItem")
            {
                if (e.CommandSource is ImageButton)
                {
                    GridViewRow row = (GridViewRow)((ImageButton)e.CommandSource).Parent.Parent;
                    string _primaryKey = (string)((GridView)sender).DataKeys[row.RowIndex].Value;
                    //the down arrow actually moves items up the list
                    if ((string)e.CommandArgument == "Down")
                    {
                        BVApp.MembershipServices.UserQuestions.MoveUp(_primaryKey);
                    }
                    else if ((string)e.CommandArgument == "Up")
                    {
                        BVApp.MembershipServices.UserQuestions.MoveDown(_primaryKey);
                    }
                    BindQuestionsGrid();
                }
            }
        }
    }
}