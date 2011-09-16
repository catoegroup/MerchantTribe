SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('tempdb..#tmpErrors')) DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
PRINT N'Dropping foreign keys from [dbo].[bvc_MailingListMember]'
GO
ALTER TABLE [dbo].[bvc_MailingListMember] DROP
CONSTRAINT [FK_bvc_MailingListMember_bvc_MailingList]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[PageVersions]'
GO
ALTER TABLE [dbo].[PageVersions] DROP
CONSTRAINT [FK_bvc_CategoryPageVersion]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[bvc_DropShipNotification]'
GO
ALTER TABLE [dbo].[bvc_DropShipNotification] DROP
CONSTRAINT [FK_bvc_DropShipNotification_bvc_Order]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[bvc_SaleXCategory]'
GO
ALTER TABLE [dbo].[bvc_SaleXCategory] DROP
CONSTRAINT [FK_bvc_SaleXCategory_bvc_Sale]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[bvc_SaleXProduct]'
GO
ALTER TABLE [dbo].[bvc_SaleXProduct] DROP
CONSTRAINT [FK_bvc_SaleXProduct_bvc_Sale]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[bvc_SaleXProductType]'
GO
ALTER TABLE [dbo].[bvc_SaleXProductType] DROP
CONSTRAINT [FK_bvc_SaleXProductType_bvc_Sale]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[bvc_UserXContact]'
GO
ALTER TABLE [dbo].[bvc_UserXContact] DROP
CONSTRAINT [FK_bvc_UserXAffiliate_bvc_User]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[ecommrc_StoreSettings]'
GO
ALTER TABLE [dbo].[ecommrc_StoreSettings] DROP
CONSTRAINT [FK_ecommrc_StoreSettings_ecommrc_Stores]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[ecommrc_StoresXUsers]'
GO
ALTER TABLE [dbo].[ecommrc_StoresXUsers] DROP
CONSTRAINT [FK_ecommrc_StoresXUsers_ecommrc_Stores],
CONSTRAINT [FK_ecommrc_StoresXUsers_ecommrc_UserAccounts]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_Affiliate]'
GO
ALTER TABLE [dbo].[bvc_Affiliate] DROP CONSTRAINT [PK_bvc_Affiliate]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_Affiliate]'
GO
ALTER TABLE [dbo].[bvc_Affiliate] DROP CONSTRAINT [DF_bvc_Affiliate_AddressId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_AffiliateReferral]'
GO
ALTER TABLE [dbo].[bvc_AffiliateReferral] DROP CONSTRAINT [PK_bvc_AffiliateReferral]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_AffiliateReferral]'
GO
ALTER TABLE [dbo].[bvc_AffiliateReferral] DROP CONSTRAINT [DF_bvc_AffiliateReferral_StoreId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_LineItem]'
GO
ALTER TABLE [dbo].[bvc_LineItem] DROP CONSTRAINT [PK_bvc_LineItem]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_LineItem]'
GO
ALTER TABLE [dbo].[bvc_LineItem] DROP CONSTRAINT [IX_bvc_LineItem]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_LineItem]'
GO
ALTER TABLE [dbo].[bvc_LineItem] DROP CONSTRAINT [DF_bvc_LineItem_Discounts]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_LineItem]'
GO
ALTER TABLE [dbo].[bvc_LineItem] DROP CONSTRAINT [DF_bvc_LineItem_AdditionalDiscount]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_LineItem]'
GO
ALTER TABLE [dbo].[bvc_LineItem] DROP CONSTRAINT [DF_bvc_LineItem_AdminPrice]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_LineItem]'
GO
ALTER TABLE [dbo].[bvc_LineItem] DROP CONSTRAINT [DF_bvc_LineItem_GiftWrapDetails]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_MailingList]'
GO
ALTER TABLE [dbo].[bvc_MailingList] DROP CONSTRAINT [PK_bvc_MailingList]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_MailingListMember]'
GO
ALTER TABLE [dbo].[bvc_MailingListMember] DROP CONSTRAINT [PK_bvc_MailingListMember_1]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_OrderCoupon]'
GO
ALTER TABLE [dbo].[bvc_OrderCoupon] DROP CONSTRAINT [PK_bvc_OrderCoupon]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_OrderNote]'
GO
ALTER TABLE [dbo].[bvc_OrderNote] DROP CONSTRAINT [PK_bvc_OrderNote]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_OrderPackage]'
GO
ALTER TABLE [dbo].[bvc_OrderPackage] DROP CONSTRAINT [PK_bvc_OrderPackage]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_UserXContact]'
GO
ALTER TABLE [dbo].[bvc_UserXContact] DROP CONSTRAINT [PK_bvc_UserXAffiliate]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_Variants]'
GO
ALTER TABLE [dbo].[bvc_Variants] DROP CONSTRAINT [PK_bvc_Variant]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[ecommrc_AuthTokens]'
GO
ALTER TABLE [dbo].[ecommrc_AuthTokens] DROP CONSTRAINT [PK_ecommrc_AuthTokens]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[ecommrc_StoreSettings]'
GO
ALTER TABLE [dbo].[ecommrc_StoreSettings] DROP CONSTRAINT [PK_ecommrc_StoreSettings]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[ecommrc_StoresXUsers]'
GO
ALTER TABLE [dbo].[ecommrc_StoresXUsers] DROP CONSTRAINT [PK_ecommrc_StoresXUsers]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_AffiliateQuestions]'
GO
ALTER TABLE [dbo].[bvc_AffiliateQuestions] DROP CONSTRAINT [PK_bvc_AffiliateQuestions]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_AffiliateQuestions]'
GO
ALTER TABLE [dbo].[bvc_AffiliateQuestions] DROP CONSTRAINT [DF_bvc_AffiliateQuestions_Order]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_AffiliateQuestions]'
GO
ALTER TABLE [dbo].[bvc_AffiliateQuestions] DROP CONSTRAINT [DF_bvc_AffiliateQuestions_StoreId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_DropShipNotification]'
GO
ALTER TABLE [dbo].[bvc_DropShipNotification] DROP CONSTRAINT [PK_bvc_DropShipNotification]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_DropShipNotification]'
GO
ALTER TABLE [dbo].[bvc_DropShipNotification] DROP CONSTRAINT [DF_bvc_DropShipNotification_StoreId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_EmailTemplate]'
GO
ALTER TABLE [dbo].[bvc_EmailTemplate] DROP CONSTRAINT [PK_bvc_EmailTemplate]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_EmailTemplate]'
GO
ALTER TABLE [dbo].[bvc_EmailTemplate] DROP CONSTRAINT [DF_bvc_EmailTemplate_BodyPreTransform]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_EmailTemplate]'
GO
ALTER TABLE [dbo].[bvc_EmailTemplate] DROP CONSTRAINT [DF_bvc_EmailTemplate_RepeatingSectionPreTransform]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_Offers]'
GO
ALTER TABLE [dbo].[bvc_Offers] DROP CONSTRAINT [PK_bvc_Offers]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_Offers]'
GO
ALTER TABLE [dbo].[bvc_Offers] DROP CONSTRAINT [DF_bvc_Offers_StoreId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_PrintTemplate]'
GO
ALTER TABLE [dbo].[bvc_PrintTemplate] DROP CONSTRAINT [PK_bvc_PrintTemplate]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_Sale]'
GO
ALTER TABLE [dbo].[bvc_Sale] DROP CONSTRAINT [PK_Sales]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_Sale]'
GO
ALTER TABLE [dbo].[bvc_Sale] DROP CONSTRAINT [DF_bvc_Sale_StoreId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_SaleXCategory]'
GO
ALTER TABLE [dbo].[bvc_SaleXCategory] DROP CONSTRAINT [PK_bvc_SaleXCategory]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_SaleXCategory]'
GO
ALTER TABLE [dbo].[bvc_SaleXCategory] DROP CONSTRAINT [DF_bvc_SaleXCategory_StoreId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_SaleXProduct]'
GO
ALTER TABLE [dbo].[bvc_SaleXProduct] DROP CONSTRAINT [PK_bvc_SaleXProduct]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_SaleXProduct]'
GO
ALTER TABLE [dbo].[bvc_SaleXProduct] DROP CONSTRAINT [DF_bvc_SaleXProduct_StoreId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_SaleXProductType]'
GO
ALTER TABLE [dbo].[bvc_SaleXProductType] DROP CONSTRAINT [PK_bvc_SaleXProductType]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_SaleXProductType]'
GO
ALTER TABLE [dbo].[bvc_SaleXProductType] DROP CONSTRAINT [DF_bvc_SaleXProductType_StoreId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_ListItems]'
GO
ALTER TABLE [dbo].[bvc_ListItems] DROP CONSTRAINT [DF_bvc_ListItems_StoreId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_Lists]'
GO
ALTER TABLE [dbo].[bvc_Lists] DROP CONSTRAINT [DF_bvc_Lists_StoreId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [IX_bvc_AffiliateReferral] from [dbo].[bvc_AffiliateReferral]'
GO
DROP INDEX [IX_bvc_AffiliateReferral] ON [dbo].[bvc_AffiliateReferral]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [IX_bvc_ProductReview_ProductBvin] from [dbo].[bvc_ProductReview]'
GO
DROP INDEX [IX_bvc_ProductReview_ProductBvin] ON [dbo].[bvc_ProductReview]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [IX_FK_bvc_CategoryPageVersion] from [dbo].[PageVersions]'
GO
DROP INDEX [IX_FK_bvc_CategoryPageVersion] ON [dbo].[PageVersions]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [IX_bvc_Sale] from [dbo].[bvc_Sale]'
GO
DROP INDEX [IX_bvc_Sale] ON [dbo].[bvc_Sale]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [IX_bvc_ProductReview] from [dbo].[bvc_ProductReview]'
GO
DROP INDEX [IX_bvc_ProductReview] ON [dbo].[bvc_ProductReview]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [IX_bvc_Offers] from [dbo].[bvc_Offers]'
GO
DROP INDEX [IX_bvc_Offers] ON [dbo].[bvc_Offers]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [IX_bvc_SaleXCategory] from [dbo].[bvc_SaleXCategory]'
GO
DROP INDEX [IX_bvc_SaleXCategory] ON [dbo].[bvc_SaleXCategory]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [IX_bvc_SaleXProduct] from [dbo].[bvc_SaleXProduct]'
GO
DROP INDEX [IX_bvc_SaleXProduct] ON [dbo].[bvc_SaleXProduct]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [IX_bvc_SaleXProductType] from [dbo].[bvc_SaleXProductType]'
GO
DROP INDEX [IX_bvc_SaleXProductType] ON [dbo].[bvc_SaleXProductType]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Manufacturer_ForCategory_s]'
GO
DROP PROCEDURE [dbo].[bvc_Manufacturer_ForCategory_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_UserAccount_ExcludeManufacturerId_s]'
GO
DROP PROCEDURE [dbo].[bvc_UserAccount_ExcludeManufacturerId_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Offer_d]'
GO
DROP PROCEDURE [dbo].[bvc_Offer_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_DropShipNotification_d]'
GO
DROP PROCEDURE [dbo].[bvc_DropShipNotification_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Order_ByLineItemStatus_s]'
GO
DROP PROCEDURE [dbo].[bvc_Order_ByLineItemStatus_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Sale_d]'
GO
DROP PROCEDURE [dbo].[bvc_Sale_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_LineItem_ByOrderId_s]'
GO
DROP PROCEDURE [dbo].[bvc_LineItem_ByOrderId_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_MailingList_CheckMembership_s]'
GO
DROP PROCEDURE [dbo].[bvc_MailingList_CheckMembership_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_UserXContact_d]'
GO
DROP PROCEDURE [dbo].[bvc_UserXContact_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Affiliate_ByUserID_s]'
GO
DROP PROCEDURE [dbo].[bvc_Affiliate_ByUserID_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Manufacturer_d]'
GO
DROP PROCEDURE [dbo].[bvc_Manufacturer_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_RMA_d]'
GO
DROP PROCEDURE [dbo].[bvc_RMA_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Fraud_ByCriteria_s]'
GO
DROP PROCEDURE [dbo].[bvc_Fraud_ByCriteria_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_EventLog_i]'
GO
DROP PROCEDURE [dbo].[bvc_EventLog_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_OrderNote_ByOrderId_s]'
GO
DROP PROCEDURE [dbo].[bvc_OrderNote_ByOrderId_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_OrderNote_d]'
GO
DROP PROCEDURE [dbo].[bvc_OrderNote_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_MailingList_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_MailingList_All_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Affiliate_d]'
GO
DROP PROCEDURE [dbo].[bvc_Affiliate_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_UserAccount_ByVendorID_s]'
GO
DROP PROCEDURE [dbo].[bvc_UserAccount_ByVendorID_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_RMAItem_s]'
GO
DROP PROCEDURE [dbo].[bvc_RMAItem_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_RMA_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_RMA_All_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_OrderCoupon_ByOrderBvin_s]'
GO
DROP PROCEDURE [dbo].[bvc_OrderCoupon_ByOrderBvin_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Manufacturer_u]'
GO
DROP PROCEDURE [dbo].[bvc_Manufacturer_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Vendor_u]'
GO
DROP PROCEDURE [dbo].[bvc_Vendor_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Affiliate_ByReferralID_s]'
GO
DROP PROCEDURE [dbo].[bvc_Affiliate_ByReferralID_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_AffiliateReferral_i]'
GO
DROP PROCEDURE [dbo].[bvc_AffiliateReferral_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_EventLog_All_d]'
GO
DROP PROCEDURE [dbo].[bvc_EventLog_All_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_SaleXProduct_BySaleId_d]'
GO
DROP PROCEDURE [dbo].[bvc_SaleXProduct_BySaleId_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_OrderPackage_u]'
GO
DROP PROCEDURE [dbo].[bvc_OrderPackage_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Order_d]'
GO
DROP PROCEDURE [dbo].[bvc_Order_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_MailingListMember_d]'
GO
DROP PROCEDURE [dbo].[bvc_MailingListMember_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Order_Range_s]'
GO
DROP PROCEDURE [dbo].[bvc_Order_Range_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Manufacturer_s]'
GO
DROP PROCEDURE [dbo].[bvc_Manufacturer_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Affiliate_all_s]'
GO
DROP PROCEDURE [dbo].[bvc_Affiliate_all_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductImageByProduct_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductImageByProduct_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_EmailTemplate_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_EmailTemplate_All_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_RMAItem_i]'
GO
DROP PROCEDURE [dbo].[bvc_RMAItem_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_SaleXCategory_i]'
GO
DROP PROCEDURE [dbo].[bvc_SaleXCategory_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Vendor_s]'
GO
DROP PROCEDURE [dbo].[bvc_Vendor_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_AffiliateReferral_ByCriteria_s]'
GO
DROP PROCEDURE [dbo].[bvc_AffiliateReferral_ByCriteria_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_OrderPackage_s]'
GO
DROP PROCEDURE [dbo].[bvc_OrderPackage_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Order_MaxOrderNumber_s]'
GO
DROP PROCEDURE [dbo].[bvc_Order_MaxOrderNumber_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_OrderCoupon_UseTimesByUserId_s]'
GO
DROP PROCEDURE [dbo].[bvc_OrderCoupon_UseTimesByUserId_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Manufacturer_i]'
GO
DROP PROCEDURE [dbo].[bvc_Manufacturer_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ShippingMethod_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_ShippingMethod_All_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductImage_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductImage_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ShippingMethod_d]'
GO
DROP PROCEDURE [dbo].[bvc_ShippingMethod_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_LineItem_s]'
GO
DROP PROCEDURE [dbo].[bvc_LineItem_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_SaleXCategory_BySaleId_s]'
GO
DROP PROCEDURE [dbo].[bvc_SaleXCategory_BySaleId_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_RMAItem_d]'
GO
DROP PROCEDURE [dbo].[bvc_RMAItem_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Order_i]'
GO
DROP PROCEDURE [dbo].[bvc_Order_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_EventLog_d]'
GO
DROP PROCEDURE [dbo].[bvc_EventLog_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_OrderPackage_i]'
GO
DROP PROCEDURE [dbo].[bvc_OrderPackage_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Vendor_i]'
GO
DROP PROCEDURE [dbo].[bvc_Vendor_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductImage_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductImage_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_OrderCoupon_UseTimesByStore_s]'
GO
DROP PROCEDURE [dbo].[bvc_OrderCoupon_UseTimesByStore_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_UserAccount_ByManufacturerID_s]'
GO
DROP PROCEDURE [dbo].[bvc_UserAccount_ByManufacturerID_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_SaleXCategory_BySaleId_d]'
GO
DROP PROCEDURE [dbo].[bvc_SaleXCategory_BySaleId_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_SaleXCategory]'
GO
DROP TABLE [dbo].[bvc_SaleXCategory]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_AuthenticationToken_d]'
GO
DROP PROCEDURE [dbo].[bvc_AuthenticationToken_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Manufacturer_Filter_s]'
GO
DROP PROCEDURE [dbo].[bvc_Manufacturer_Filter_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_MailingList_u]'
GO
DROP PROCEDURE [dbo].[bvc_MailingList_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_EventLog_ByCriteria_s]'
GO
DROP PROCEDURE [dbo].[bvc_EventLog_ByCriteria_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_AffiliateQuestion_u]'
GO
DROP PROCEDURE [dbo].[bvc_AffiliateQuestion_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Order_UserTotals_s]'
GO
DROP PROCEDURE [dbo].[bvc_Order_UserTotals_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_OrderPackage_d]'
GO
DROP PROCEDURE [dbo].[bvc_OrderPackage_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_OrderCoupon_ByOrderBvin_d]'
GO
DROP PROCEDURE [dbo].[bvc_OrderCoupon_ByOrderBvin_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_RMAItem_ByRMABvin_s]'
GO
DROP PROCEDURE [dbo].[bvc_RMAItem_ByRMABvin_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductImage_i]'
GO
DROP PROCEDURE [dbo].[bvc_ProductImage_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_EventLog_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_EventLog_All_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Order_s]'
GO
DROP PROCEDURE [dbo].[bvc_Order_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Vendor_Filter_s]'
GO
DROP PROCEDURE [dbo].[bvc_Vendor_Filter_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Sale_u]'
GO
DROP PROCEDURE [dbo].[bvc_Sale_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_OrderCoupon_u]'
GO
DROP PROCEDURE [dbo].[bvc_OrderCoupon_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_AffiliateQuestion_s]'
GO
DROP PROCEDURE [dbo].[bvc_AffiliateQuestion_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_LineItem_ByOrderId_d]'
GO
DROP PROCEDURE [dbo].[bvc_LineItem_ByOrderId_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_LineItem_d]'
GO
DROP PROCEDURE [dbo].[bvc_LineItem_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_OrderPackage_ByOrderId_s]'
GO
DROP PROCEDURE [dbo].[bvc_OrderPackage_ByOrderId_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Order_ByUser_s]'
GO
DROP PROCEDURE [dbo].[bvc_Order_ByUser_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_MailingListMember_ByListID_s]'
GO
DROP PROCEDURE [dbo].[bvc_MailingListMember_ByListID_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Sale_s]'
GO
DROP PROCEDURE [dbo].[bvc_Sale_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_AffiliateQuestion_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_AffiliateQuestion_All_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductImage_d]'
GO
DROP PROCEDURE [dbo].[bvc_ProductImage_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_RMAItem_ByLineItemBvin_s]'
GO
DROP PROCEDURE [dbo].[bvc_RMAItem_ByLineItemBvin_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Order_ByThirdPartyOrderId_s]'
GO
DROP PROCEDURE [dbo].[bvc_Order_ByThirdPartyOrderId_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_AffiliateQuestion_i]'
GO
DROP PROCEDURE [dbo].[bvc_AffiliateQuestion_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Vendor_d]'
GO
DROP PROCEDURE [dbo].[bvc_Vendor_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_EmailTemplate_u]'
GO
DROP PROCEDURE [dbo].[bvc_EmailTemplate_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_OrderCoupon_s]'
GO
DROP PROCEDURE [dbo].[bvc_OrderCoupon_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_MailingListMember_u]'
GO
DROP PROCEDURE [dbo].[bvc_MailingListMember_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Sale_i]'
GO
DROP PROCEDURE [dbo].[bvc_Sale_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_OrderNote_u]'
GO
DROP PROCEDURE [dbo].[bvc_OrderNote_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_MailingList_Public_s]'
GO
DROP PROCEDURE [dbo].[bvc_MailingList_Public_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Order_ByCoupon_s]'
GO
DROP PROCEDURE [dbo].[bvc_Order_ByCoupon_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Fraud_u]'
GO
DROP PROCEDURE [dbo].[bvc_Fraud_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_LineItem_u]'
GO
DROP PROCEDURE [dbo].[bvc_LineItem_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_AffiliateQuestion_d]'
GO
DROP PROCEDURE [dbo].[bvc_AffiliateQuestion_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_AffiliateQuestions]'
GO
DROP TABLE [dbo].[bvc_AffiliateQuestions]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_MailingListMember_s]'
GO
DROP PROCEDURE [dbo].[bvc_MailingListMember_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Sale_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_Sale_All_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Order_ByCriteria_s]'
GO
DROP PROCEDURE [dbo].[bvc_Order_ByCriteria_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_RMA_u]'
GO
DROP PROCEDURE [dbo].[bvc_RMA_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_OrderNote_s]'
GO
DROP PROCEDURE [dbo].[bvc_OrderNote_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_EmailTemplate_s]'
GO
DROP PROCEDURE [dbo].[bvc_EmailTemplate_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_MailingListMember_i]'
GO
DROP PROCEDURE [dbo].[bvc_MailingListMember_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_AffiliateReferral_ByAffiliate_d]'
GO
DROP PROCEDURE [dbo].[bvc_AffiliateReferral_ByAffiliate_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_OrderCoupon_i]'
GO
DROP PROCEDURE [dbo].[bvc_OrderCoupon_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_RMAItem_u]'
GO
DROP PROCEDURE [dbo].[bvc_RMAItem_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Vendor_ByUserID_s]'
GO
DROP PROCEDURE [dbo].[bvc_Vendor_ByUserID_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_OrderNote_i]'
GO
DROP PROCEDURE [dbo].[bvc_OrderNote_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Sale_AllValid_s]'
GO
DROP PROCEDURE [dbo].[bvc_Sale_AllValid_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Sale]'
GO
DROP TABLE [dbo].[bvc_Sale]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Fraud_s]'
GO
DROP PROCEDURE [dbo].[bvc_Fraud_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_MailingList_i]'
GO
DROP PROCEDURE [dbo].[bvc_MailingList_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_MailingListMember_d_ByEmail_ListID]'
GO
DROP PROCEDURE [dbo].[bvc_MailingListMember_d_ByEmail_ListID]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_EmailTemplate_i]'
GO
DROP PROCEDURE [dbo].[bvc_EmailTemplate_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_RMA_s]'
GO
DROP PROCEDURE [dbo].[bvc_RMA_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Offer_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_Offer_All_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_OrderCoupon_d]'
GO
DROP PROCEDURE [dbo].[bvc_OrderCoupon_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Offer_u]'
GO
DROP PROCEDURE [dbo].[bvc_Offer_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Affiliate_u]'
GO
DROP PROCEDURE [dbo].[bvc_Affiliate_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Fraud_RuleApplies_s]'
GO
DROP PROCEDURE [dbo].[bvc_Fraud_RuleApplies_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ShippingMethod_u]'
GO
DROP PROCEDURE [dbo].[bvc_ShippingMethod_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_MailingList_d]'
GO
DROP PROCEDURE [dbo].[bvc_MailingList_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_EmailTemplate_d]'
GO
DROP PROCEDURE [dbo].[bvc_EmailTemplate_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_EmailTemplate]'
GO
DROP TABLE [dbo].[bvc_EmailTemplate]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Vendor_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_Vendor_All_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Offer_s]'
GO
DROP PROCEDURE [dbo].[bvc_Offer_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_LineItem_i]'
GO
DROP PROCEDURE [dbo].[bvc_LineItem_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ShippingMethod_s]'
GO
DROP PROCEDURE [dbo].[bvc_ShippingMethod_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_RMA_i]'
GO
DROP PROCEDURE [dbo].[bvc_RMA_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_SaleXProductType_i]'
GO
DROP PROCEDURE [dbo].[bvc_SaleXProductType_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Affiliate_s]'
GO
DROP PROCEDURE [dbo].[bvc_Affiliate_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Fraud_i]'
GO
DROP PROCEDURE [dbo].[bvc_Fraud_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Manufacturer_ByUserID_s]'
GO
DROP PROCEDURE [dbo].[bvc_Manufacturer_ByUserID_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Offer_Priority_u]'
GO
DROP PROCEDURE [dbo].[bvc_Offer_Priority_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Manufacturer_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_Manufacturer_All_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_DropShipNotification_u]'
GO
DROP PROCEDURE [dbo].[bvc_DropShipNotification_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_SaleXProductType_BySaleId_s]'
GO
DROP PROCEDURE [dbo].[bvc_SaleXProductType_BySaleId_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_UserAccount_ExcludeVendorId_s]'
GO
DROP PROCEDURE [dbo].[bvc_UserAccount_ExcludeVendorId_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Fraud_Full_s]'
GO
DROP PROCEDURE [dbo].[bvc_Fraud_Full_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_AuthenticationToken_u]'
GO
DROP PROCEDURE [dbo].[bvc_AuthenticationToken_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Affiliate_i]'
GO
DROP PROCEDURE [dbo].[bvc_Affiliate_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Offer_i]'
GO
DROP PROCEDURE [dbo].[bvc_Offer_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_OrderCoupon_ByCouponCode_d]'
GO
DROP PROCEDURE [dbo].[bvc_OrderCoupon_ByCouponCode_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_DropShipNotification_s]'
GO
DROP PROCEDURE [dbo].[bvc_DropShipNotification_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_SaleXProductType_BySaleId_d]'
GO
DROP PROCEDURE [dbo].[bvc_SaleXProductType_BySaleId_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_SaleXProductType]'
GO
DROP TABLE [dbo].[bvc_SaleXProductType]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Fraud_d]'
GO
DROP PROCEDURE [dbo].[bvc_Fraud_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_AuthenticationToken_s]'
GO
DROP PROCEDURE [dbo].[bvc_AuthenticationToken_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_SaleXProduct_i]'
GO
DROP PROCEDURE [dbo].[bvc_SaleXProduct_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ShippingMethod_i]'
GO
DROP PROCEDURE [dbo].[bvc_ShippingMethod_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Affiliate_Filter_s]'
GO
DROP PROCEDURE [dbo].[bvc_Affiliate_Filter_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Order_u]'
GO
DROP PROCEDURE [dbo].[bvc_Order_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Offer_HighestOrderByPriority_s]'
GO
DROP PROCEDURE [dbo].[bvc_Offer_HighestOrderByPriority_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Fraud_ByRule_s]'
GO
DROP PROCEDURE [dbo].[bvc_Fraud_ByRule_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_DropShipNotification_i]'
GO
DROP PROCEDURE [dbo].[bvc_DropShipNotification_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_DropShipNotification]'
GO
DROP TABLE [dbo].[bvc_DropShipNotification]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_UserXContact_i]'
GO
DROP PROCEDURE [dbo].[bvc_UserXContact_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Fraud_ByBvin_s]'
GO
DROP PROCEDURE [dbo].[bvc_Fraud_ByBvin_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_SaleXProduct_BySaleId_s]'
GO
DROP PROCEDURE [dbo].[bvc_SaleXProduct_BySaleId_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_SaleXProduct]'
GO
DROP TABLE [dbo].[bvc_SaleXProduct]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_MailingList_s]'
GO
DROP PROCEDURE [dbo].[bvc_MailingList_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_AuthenticationToken_i]'
GO
DROP PROCEDURE [dbo].[bvc_AuthenticationToken_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Offers]'
GO
DROP TABLE [dbo].[bvc_Offers]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Lists]'
GO
DROP TABLE [dbo].[bvc_Lists]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ListItems]'
GO
DROP TABLE [dbo].[bvc_ListItems]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_PrintTemplate_s]'
GO
DROP PROCEDURE [dbo].[bvc_PrintTemplate_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_PrintTemplate_i]'
GO
DROP PROCEDURE [dbo].[bvc_PrintTemplate_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_PrintTemplate_d]'
GO
DROP PROCEDURE [dbo].[bvc_PrintTemplate_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_PrintTemplate_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_PrintTemplate_All_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_PrintTemplate_u]'
GO
DROP PROCEDURE [dbo].[bvc_PrintTemplate_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_PrintTemplate]'
GO
DROP TABLE [dbo].[bvc_PrintTemplate]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[ecommrc_StoreSettings]'
GO
ALTER TABLE [dbo].[ecommrc_StoreSettings] ADD
[Id] [bigint] NOT NULL IDENTITY(1, 1)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ecommrc_StoreSettings] on [dbo].[ecommrc_StoreSettings]'
GO
ALTER TABLE [dbo].[ecommrc_StoreSettings] ADD CONSTRAINT [PK_ecommrc_StoreSettings] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_ecommrc_StoreSettings_StoreId] on [dbo].[ecommrc_StoreSettings]'
GO
CREATE NONCLUSTERED INDEX [IX_ecommrc_StoreSettings_StoreId] ON [dbo].[ecommrc_StoreSettings] ([StoreId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[ecommrc_StoresXUsers]'
GO
ALTER TABLE [dbo].[ecommrc_StoresXUsers] ADD
[Id] [bigint] NOT NULL IDENTITY(1, 1)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ecommrc_StoresXUsers] on [dbo].[ecommrc_StoresXUsers]'
GO
ALTER TABLE [dbo].[ecommrc_StoresXUsers] ADD CONSTRAINT [PK_ecommrc_StoresXUsers] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_ecommrc_StoresXUsers_StoreId] on [dbo].[ecommrc_StoresXUsers]'
GO
CREATE NONCLUSTERED INDEX [IX_ecommrc_StoresXUsers_StoreId] ON [dbo].[ecommrc_StoresXUsers] ([StoreId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_ecommrc_StoresXUsers_UserId] on [dbo].[ecommrc_StoresXUsers]'
GO
CREATE NONCLUSTERED INDEX [IX_ecommrc_StoresXUsers_UserId] ON [dbo].[ecommrc_StoresXUsers] ([UserId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_HtmlTemplates]'
GO
CREATE TABLE [dbo].[bvc_HtmlTemplates]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[StoreId] [bigint] NOT NULL,
[LastUpdatedUtc] [datetime] NOT NULL,
[DisplayName] [nvarchar] (255) NOT NULL,
[FromEmail] [nvarchar] (255) NOT NULL,
[Subject] [nvarchar] (1024) NOT NULL,
[Body] [nvarchar] (max) NOT NULL,
[RepeatingSection] [nvarchar] (max) NOT NULL,
[TemplateType] [int] NOT NULL CONSTRAINT [DF_bvc_HtmlTemplates_TemplateType] DEFAULT ((0))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_bvc_HtmlTemplates] on [dbo].[bvc_HtmlTemplates]'
GO
ALTER TABLE [dbo].[bvc_HtmlTemplates] ADD CONSTRAINT [PK_bvc_HtmlTemplates] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_HtmlTemplates_StoreId] on [dbo].[bvc_HtmlTemplates]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_HtmlTemplates_StoreId] ON [dbo].[bvc_HtmlTemplates] ([StoreId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ConversationGroups]'
GO
CREATE TABLE [dbo].[ConversationGroups]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[StoreId] [bigint] NOT NULL,
[Title] [nvarchar] (255) NOT NULL,
[Slug] [nvarchar] (255) NOT NULL,
[SortOrder] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ConversationGroups] on [dbo].[ConversationGroups]'
GO
ALTER TABLE [dbo].[ConversationGroups] ADD CONSTRAINT [PK_ConversationGroups] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Conversations]'
GO
CREATE TABLE [dbo].[Conversations]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[StoreId] [bigint] NOT NULL,
[GroupId] [bigint] NOT NULL,
[Topic] [nvarchar] (255) NOT NULL,
[Description] [nvarchar] (max) NOT NULL,
[DateCreatedUtc] [datetime] NOT NULL,
[AuthorId] [bigint] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Conversations] on [dbo].[Conversations]'
GO
ALTER TABLE [dbo].[Conversations] ADD CONSTRAINT [PK_Conversations] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[ecommrc_AuthTokens]'
GO
ALTER TABLE [dbo].[ecommrc_AuthTokens] ADD
[Id] [bigint] NOT NULL IDENTITY(1, 1)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ecommrc_AuthTokens] on [dbo].[ecommrc_AuthTokens]'
GO
ALTER TABLE [dbo].[ecommrc_AuthTokens] ADD CONSTRAINT [PK_ecommrc_AuthTokens] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Order]'
GO
ALTER TABLE [dbo].[bvc_Order] ADD
[OrderDiscountDetails] [nvarchar] (max) NOT NULL CONSTRAINT [DF_bvc_Order_OrderDiscountDetails] DEFAULT (''),
[ShippingDiscountDetails] [nvarchar] (max) NOT NULL CONSTRAINT [DF_bvc_Order_ShippingDiscountDetails] DEFAULT ('')
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_Order] DROP
COLUMN [LastProductAdded]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_Order_StoreId] on [dbo].[bvc_Order]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_Order_StoreId] ON [dbo].[bvc_Order] ([StoreId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_Order_TimeOfOrder] on [dbo].[bvc_Order]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_Order_TimeOfOrder] ON [dbo].[bvc_Order] ([TimeOfOrder])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_UserXContact]'
GO
ALTER TABLE [dbo].[bvc_UserXContact] ADD
[Id] [bigint] NOT NULL IDENTITY(1, 1)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_bvc_UserXAffiliate] on [dbo].[bvc_UserXContact]'
GO
ALTER TABLE [dbo].[bvc_UserXContact] ADD CONSTRAINT [PK_bvc_UserXAffiliate] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_UserXContact_ContactId] on [dbo].[bvc_UserXContact]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_UserXContact_ContactId] ON [dbo].[bvc_UserXContact] ([ContactId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_UserXContact_StoreId] on [dbo].[bvc_UserXContact]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_UserXContact_StoreId] ON [dbo].[bvc_UserXContact] ([StoreId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_UserXContact_UserId] on [dbo].[bvc_UserXContact]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_UserXContact_UserId] ON [dbo].[bvc_UserXContact] ([UserId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Affiliate]'
GO
ALTER TABLE [dbo].[bvc_Affiliate] ADD
[Id] [bigint] NOT NULL IDENTITY(1, 1)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_Affiliate] DROP
COLUMN [bvin]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_Affiliate] ALTER COLUMN [Address] [nvarchar] (max) NOT NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_bvc_Affiliate] on [dbo].[bvc_Affiliate]'
GO
ALTER TABLE [dbo].[bvc_Affiliate] ADD CONSTRAINT [PK_bvc_Affiliate] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Product_BySlug_s]'
GO


ALTER PROCEDURE [dbo].[bvc_Product_BySlug_s]

@bvin varchar(max),
@StoreId bigint,
@realbvin varchar(36) = ''

AS
	
	BEGIN TRY
	
		SET @realbvin = (SELECT bvin from bvc_Product where StoreId=@StoreId and RewriteUrl=@bvin)
		
		SELECT		
		bvin,
		SKU,
		ProductTypeID,
		ProductName,
		ListPrice,
		SitePrice,
		SiteCost,
		MetaKeywords,
		MetaDescription,
		MetaTitle,
		TaxExempt,
		TaxClass,
		NonShipping,
		ShipSeparately,
		ShippingMode,
		ShippingWeight,
		ShippingLength,
		ShippingWidth,
		ShippingHeight,
		Status,
		ImageFileSmall,
		ImageFileMedium,
		CreationDate,
		MinimumQty,
		ShortDescription,
		LongDescription,
		ManufacturerID,
		VendorID,
		GiftWrapAllowed,
		ExtraShipFee,
		LastUpdated,
		Keywords,
		TemplateName,
		PreContentColumnId,
		PostContentColumnId,
		RewriteUrl,
		SitePriceOverrideText,
		PreTransformLongDescription,
		SmallImageAlternateText,
		MediumImageAlternateText,
		OutOfStockMode,
		CustomProperties,		
		GiftWrapPrice,
		StoreId,
		Featured,
		AllowReviews,
		DescriptionTabs,
		IsAvailableForSale

		FROM bvc_Product
		WHERE StoreId=@StoreId and bvin=@realbvin
			
		EXEC bvc_ProductOption_ByProduct_s @realbvin,@StoreId
		EXEC bvc_ProductOptionItem_ByProduct_s @realbvin, @StoreId
		select * from bvc_ProductImage where ProductID=@realbvin
		EXEC bvc_ProductReview_ByProductBvin_s @realbvin,0,@StoreId
		EXEC bvc_Variant_ByProduct_s @realbvin, @StoreId

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	

	RETURN


































GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_LineItem]'
GO
ALTER TABLE [dbo].[bvc_LineItem] ADD
[DiscountDetails] [nvarchar] (max) NOT NULL CONSTRAINT [DF_bvc_LineItem_DiscountDetails] DEFAULT (''),
[ShipFromAddress] [nvarchar] (max) NOT NULL CONSTRAINT [DF_bvc_LineItem_ShipFromAddress] DEFAULT (''),
[ShipFromMode] [int] NOT NULL CONSTRAINT [DF_bvc_LineItem_ShipFromMode] DEFAULT ((1)),
[ShipFromNotificationId] [nvarchar] (50) NOT NULL CONSTRAINT [DF_bvc_LineItem_ShipFromNotificationId] DEFAULT (''),
[ShipSeparately] [bit] NOT NULL CONSTRAINT [DF_bvc_LineItem_ShipSeparately] DEFAULT ((0)),
[ExtraShipCharge] [numeric] (10, 4) NOT NULL CONSTRAINT [DF_bvc_LineItem_ExtraShipCharge] DEFAULT ((0))
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_LineItem] DROP
COLUMN [bvin],
COLUMN [Discounts],
COLUMN [AdditionalDiscount],
COLUMN [AdminPrice],
COLUMN [GiftWrapDetails]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_LineItem] ALTER COLUMN [Id] [bigint] NOT NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_bvc_LineItem] on [dbo].[bvc_LineItem]'
GO
ALTER TABLE [dbo].[bvc_LineItem] ADD CONSTRAINT [PK_bvc_LineItem] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_UserAccount_ByAffiliateID_s]'
GO


ALTER PROCEDURE [dbo].[bvc_UserAccount_ByAffiliateID_s]

	@bvin varchar(36),
	@StoreId bigint

AS
BEGIN
	BEGIN TRY
		SET NOCOUNT ON;

		SELECT bvin,[Password],[Firstname],[LastName],Salt,TaxExempt,
			Email,CreationDate,LastLoginDate,Comment,AddressBook,
			LastUpdated,Locked,LockedUntil,FailedLoginCount,
			Phones,PricingGroup,CustomQuestionAnswers, StoreId
		FROM bvc_User
		WHERE StoreId=@StoreId 
		AND bvin IN (
			SELECT UserID 
			FROM bvc_UserXContact JOIN bvc_Affiliate 
			ON bvc_UserXContact.ContactId = bvc_Affiliate.Id 
			WHERE ContactID=@bvin and bvc_Affiliate.StoreId=@StoreId)
		ORDER BY [Email],[LastName],[FirstName]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END




















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Product_s]'
GO

ALTER PROCEDURE [dbo].[bvc_Product_s]

@bvin varchar(36),
@StoreId bigint

AS
	
	BEGIN TRY
		SELECT

		bvin,
		SKU,
		ProductTypeID,
		ProductName,
		ListPrice,
		SitePrice,
		SiteCost,
		MetaKeywords,
		MetaDescription,
		MetaTitle,
		TaxExempt,
		TaxClass,
		NonShipping,
		ShipSeparately,
		ShippingMode,
		ShippingWeight,
		ShippingLength,
		ShippingWidth,
		ShippingHeight,
		Status,
		ImageFileSmall,
		ImageFileMedium,
		CreationDate,
		MinimumQty,
		ShortDescription,
		LongDescription,
		ManufacturerID,
		VendorID,
		GiftWrapAllowed,
		ExtraShipFee,
		LastUpdated,
		Keywords,
		TemplateName,
		PreContentColumnId,
		PostContentColumnId,
		RewriteUrl,
		SitePriceOverrideText,
		PreTransformLongDescription,
		SmallImageAlternateText,
		MediumImageAlternateText,
		OutOfStockMode,
		CustomProperties,		
		GiftWrapPrice,
		StoreId,
		Featured,
		AllowReviews,
		DescriptionTabs,
		IsAvailableForSale

		FROM bvc_Product		
		WHERE bvin=@bvin and (@StoreId = -1 OR StoreId=@StoreId)
			
		EXEC bvc_ProductOption_ByProduct_s @bvin,@StoreId
		EXEC bvc_ProductOptionItem_ByProduct_s @bvin, @StoreId
		Select * from bvc_ProductImage where ProductId = @bvin
		EXEC bvc_ProductReview_ByProductBvin_s @bvin,0,@StoreId
		EXEC bvc_Variant_ByProduct_s @bvin, @StoreId

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	

	RETURN

































GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Product_d]'
GO

ALTER PROCEDURE [dbo].[bvc_Product_d]

@bvin varchar(36),
@StoreId bigint

AS

BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
					
			DELETE bvc_WishList WHERE ProductBvin=@bvin and StoreId=@StoreId
			DELETE bvc_ProductFileXProduct WHERE ProductID=@bvin and StoreId=@StoreId
			DELETE bvc_ProductReview WHERE ProductBvin=@bvin and StoreId=@StoreId
			DELETE bvc_ProductVolumeDiscounts WHERE ProductID=@bvin and StoreId=@StoreId
			DELETE bvc_ProductImage WHERE ProductID=@bvin and StoreId=@StoreId
			DELETE bvc_ProductXCategory WHERE ProductID=@bvin and StoreId=@StoreId
			DELETE bvc_ProductPropertyValue WHERE ProductBvin = @bvin and StoreId=@StoreId
			DELETE bvc_CustomUrl WHERE SystemData = @bvin and StoreId=@StoreId		
			EXEC bvc_ProductInventory_ByProductId_d @bvin, @StoreId
			DELETE bvc_ProductImage WHERE ProductID = @bvin			
			EXEC bvc_Variant_ByProduct_d @bvin, @StoreId						
			DELETE bvc_Product WHERE bvin=@bvin and StoreId=@StoreId		
			EXEC bvc_ProductOption_ByProduct_d @bvin, @StoreId					
	
		COMMIT
				
	END TRY
	BEGIN CATCH		
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION			
		EXEC bvc_EventLog_SQL_i
		RETURN 0
	END CATCH

END

RETURN





































GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Rebuilding [dbo].[bvc_AffiliateReferral]'
GO
CREATE TABLE [dbo].[tmp_rg_xx_bvc_AffiliateReferral]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[AffiliateId] [bigint] NOT NULL CONSTRAINT [DF_bvc_AffiliateReferral_AffiliateId] DEFAULT ((0)),
[referrerurl] [nvarchar] (1000) NOT NULL,
[TimeOfReferralUtc] [datetime] NOT NULL CONSTRAINT [DF_bvc_AffiliateReferral_TimeOfReferralUtc] DEFAULT ('2011-01-01'),
[StoreId] [bigint] NOT NULL CONSTRAINT [DF_bvc_AffiliateReferral_StoreId] DEFAULT ((0))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_rg_xx_bvc_AffiliateReferral] ON
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_rg_xx_bvc_AffiliateReferral]([Id], [referrerurl], [StoreId]) SELECT [Id], [referrerurl], [StoreId] FROM [dbo].[bvc_AffiliateReferral]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET IDENTITY_INSERT [dbo].[tmp_rg_xx_bvc_AffiliateReferral] OFF
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
DROP TABLE [dbo].[bvc_AffiliateReferral]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_rename N'[dbo].[tmp_rg_xx_bvc_AffiliateReferral]', N'bvc_AffiliateReferral'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_bvc_AffiliateReferral] on [dbo].[bvc_AffiliateReferral]'
GO
ALTER TABLE [dbo].[bvc_AffiliateReferral] ADD CONSTRAINT [PK_bvc_AffiliateReferral] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[ecommrc_UserAccounts]'
GO
ALTER TABLE [dbo].[ecommrc_UserAccounts] ADD
[Salt] [nvarchar] (50) NOT NULL CONSTRAINT [DF_ecommrc_UserAccounts_Salt] DEFAULT (''),
[ResetKey] [nvarchar] (50) NOT NULL CONSTRAINT [DF_ecommrc_UserAccounts_ResetKey] DEFAULT ('')
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_MailingListMember]'
GO
ALTER TABLE [dbo].[bvc_MailingListMember] ADD
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[LastUpdatedUtc] [datetime] NOT NULL CONSTRAINT [DF_bvc_MailingListMember_LastUpdatedUtc] DEFAULT ('2001-01-01')
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_MailingListMember] DROP
COLUMN [bvin],
COLUMN [LastUpdated]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_MailingListMember] ALTER COLUMN [ListID] [bigint] NOT NULL
ALTER TABLE [dbo].[bvc_MailingListMember] ALTER COLUMN [FirstName] [nvarchar] (255) NOT NULL
ALTER TABLE [dbo].[bvc_MailingListMember] ALTER COLUMN [LastName] [nvarchar] (255) NOT NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_bvc_MailingListMember] on [dbo].[bvc_MailingListMember]'
GO
ALTER TABLE [dbo].[bvc_MailingListMember] ADD CONSTRAINT [PK_bvc_MailingListMember] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_MailingList]'
GO
ALTER TABLE [dbo].[bvc_MailingList] ADD
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[LastUpdatedUtc] [datetime] NOT NULL CONSTRAINT [DF_bvc_MailingList_LastUpdatedUtc] DEFAULT ('2001-01-01 00:00')
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_MailingList] DROP
COLUMN [bvin],
COLUMN [LastUpdated]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_MailingList] ALTER COLUMN [Private] [bit] NOT NULL
ALTER TABLE [dbo].[bvc_MailingList] ALTER COLUMN [Name] [nvarchar] (255) NOT NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_bvc_MailingList_1] on [dbo].[bvc_MailingList]'
GO
ALTER TABLE [dbo].[bvc_MailingList] ADD CONSTRAINT [PK_bvc_MailingList_1] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Promotions]'
GO
ALTER TABLE [dbo].[bvc_Promotions] ADD
[Mode] [int] NOT NULL CONSTRAINT [DF_bvc_Promotions_Mode] DEFAULT ((0)),
[CustomerDescription] [nvarchar] (255) NOT NULL CONSTRAINT [DF_bvc_Promotions_CustomerDescription] DEFAULT (''),
[QualificationsXml] [nvarchar] (max) NOT NULL CONSTRAINT [DF_bvc_Promotions_QualificationsXml] DEFAULT (''),
[ActionsXml] [nvarchar] (max) NOT NULL CONSTRAINT [DF_bvc_Promotions_ActionsXml] DEFAULT ('')
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_Promotions_Mode] on [dbo].[bvc_Promotions]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_Promotions_Mode] ON [dbo].[bvc_Promotions] ([Mode])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_Promotions_IsEnabled] on [dbo].[bvc_Promotions]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_Promotions_IsEnabled] ON [dbo].[bvc_Promotions] ([IsEnabled])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_OrderCoupon]'
GO
ALTER TABLE [dbo].[bvc_OrderCoupon] ADD
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[UserId] [varchar] (36) NOT NULL CONSTRAINT [DF_bvc_OrderCoupon_UserId] DEFAULT (''),
[IsUsed] [bit] NOT NULL CONSTRAINT [DF_bvc_OrderCoupon_IsUsed] DEFAULT ((0))
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_OrderCoupon] DROP
COLUMN [bvin]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_rename N'[dbo].[bvc_OrderCoupon].[LastUpdated]', N'LastUpdatedUtc', 'COLUMN'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_bvc_OrderCoupon_1] on [dbo].[bvc_OrderCoupon]'
GO
ALTER TABLE [dbo].[bvc_OrderCoupon] ADD CONSTRAINT [PK_bvc_OrderCoupon_1] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_OrderNote]'
GO
ALTER TABLE [dbo].[bvc_OrderNote] ADD
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[IsPublic] [bit] NOT NULL CONSTRAINT [DF_bvc_OrderNote_IsPublic] DEFAULT ((0))
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_OrderNote] DROP
COLUMN [bvin],
COLUMN [NoteType]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_rename N'[dbo].[bvc_OrderNote].[LastUpdated]', N'LastUpdatedUtc', 'COLUMN'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_bvc_OrderNote_1] on [dbo].[bvc_OrderNote]'
GO
ALTER TABLE [dbo].[bvc_OrderNote] ADD CONSTRAINT [PK_bvc_OrderNote_1] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_OrderPackage]'
GO
ALTER TABLE [dbo].[bvc_OrderPackage] ADD
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[LastUpdatedUtc] [datetime] NOT NULL CONSTRAINT [DF_bvc_OrderPackage_LastUpdatedUtc] DEFAULT ('2011-01-01')
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_OrderPackage] DROP
COLUMN [bvin],
COLUMN [TimeInTransit],
COLUMN [LastUpdated]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_rename N'[dbo].[bvc_OrderPackage].[ShipDate]', N'ShipDateUtc', 'COLUMN'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_bvc_OrderPackage] on [dbo].[bvc_OrderPackage]'
GO
ALTER TABLE [dbo].[bvc_OrderPackage] ADD CONSTRAINT [PK_bvc_OrderPackage] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_UserAccount_ExcludeAffiliateId_s]'
GO




ALTER PROCEDURE [dbo].[bvc_UserAccount_ExcludeAffiliateId_s]

	@bvin varchar(36),
	@StoreId bigint

AS
BEGIN
	BEGIN TRY		
		SET NOCOUNT ON;

		SELECT bvin,[Password],[Firstname],[LastName],Salt,TaxExempt,
			Email,CreationDate,LastLoginDate,Comment,AddressBook,
			LastUpdated,Locked,LockedUntil,FailedLoginCount,
			Phones,PricingGroup,CustomQuestionAnswers,StoreId
		FROM bvc_User
		WHERE StoreId=@StoreId AND bvin Not IN 
			(SELECT UserID 
			FROM bvc_UserXContact 
			JOIN bvc_Affiliate 
			ON bvc_UserXContact.ContactId = bvc_Affiliate.Id 
			WHERE ContactID=@bvin and bvc_Affiliate.StoreId=@StoreId)
			
		ORDER BY [Email],[LastName],[FirstName]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END



















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[PageVersions]'
GO
ALTER TABLE [dbo].[PageVersions] DROP
COLUMN [bvc_Category_bvin]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[PageVersions] ALTER COLUMN [PageId] [nvarchar] (50) NOT NULL
ALTER TABLE [dbo].[PageVersions] ALTER COLUMN [AvailableEndDateUtc] [datetime] NOT NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ApiKeys]'
GO
CREATE TABLE [dbo].[ApiKeys]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[StoreId] [bigint] NOT NULL,
[ApiKey] [nvarchar] (100) NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ApiKeys] on [dbo].[ApiKeys]'
GO
ALTER TABLE [dbo].[ApiKeys] ADD CONSTRAINT [PK_ApiKeys] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Table_StoreId] on [dbo].[ApiKeys]'
GO
CREATE NONCLUSTERED INDEX [IX_Table_StoreId] ON [dbo].[ApiKeys] ([StoreId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ConversationAuthors]'
GO
CREATE TABLE [dbo].[ConversationAuthors]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[StoreId] [bigint] NOT NULL,
[DisplayName] [nvarchar] (50) NOT NULL,
[Bio] [nvarchar] (1024) NOT NULL,
[AuthenticationType] [int] NOT NULL,
[AuthenticationKey] [nvarchar] (max) NOT NULL,
[AccessLevel] [int] NOT NULL,
[Avatar] [varbinary] (max) NULL,
[Verified] [bit] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ConversationAuthors] on [dbo].[ConversationAuthors]'
GO
ALTER TABLE [dbo].[ConversationAuthors] ADD CONSTRAINT [PK_ConversationAuthors] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ConversationMessages]'
GO
CREATE TABLE [dbo].[ConversationMessages]
(
[Id] [bigint] NOT NULL,
[StoreId] [bigint] NOT NULL,
[ConversationId] [bigint] NOT NULL,
[AuthorId] [bigint] NOT NULL,
[Message] [nvarchar] (max) NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ConversationMessages] on [dbo].[ConversationMessages]'
GO
ALTER TABLE [dbo].[ConversationMessages] ADD CONSTRAINT [PK_ConversationMessages] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[QueuedTasks]'
GO
CREATE TABLE [dbo].[QueuedTasks]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[StoreId] [bigint] NOT NULL,
[FriendlyName] [nvarchar] (255) NOT NULL,
[TaskProcessorName] [nvarchar] (255) NOT NULL,
[TaskProcessorId] [uniqueidentifier] NOT NULL,
[Payload] [nvarchar] (max) NOT NULL,
[Status] [int] NOT NULL,
[StatusNotes] [nvarchar] (max) NOT NULL,
[StartAtUtc] [datetime] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_QueuedTasks] on [dbo].[QueuedTasks]'
GO
ALTER TABLE [dbo].[QueuedTasks] ADD CONSTRAINT [PK_QueuedTasks] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_QueuedTasks_StoreId] on [dbo].[QueuedTasks]'
GO
CREATE NONCLUSTERED INDEX [IX_QueuedTasks_StoreId] ON [dbo].[QueuedTasks] ([StoreId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_QueuedTasks_Status] on [dbo].[QueuedTasks]'
GO
CREATE NONCLUSTERED INDEX [IX_QueuedTasks_Status] ON [dbo].[QueuedTasks] ([Status])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ToDoItems]'
GO
CREATE TABLE [dbo].[ToDoItems]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[AccountId] [bigint] NOT NULL,
[IsComplete] [bit] NOT NULL,
[SortOrder] [int] NOT NULL,
[Title] [nvarchar] (255) NOT NULL,
[Details] [nvarchar] (max) NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ToDoItems] on [dbo].[ToDoItems]'
GO
ALTER TABLE [dbo].[ToDoItems] ADD CONSTRAINT [PK_ToDoItems] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_ProductReview_ProductBvin] on [dbo].[bvc_ProductReview]'
GO
CREATE CLUSTERED INDEX [IX_bvc_ProductReview_ProductBvin] ON [dbo].[bvc_ProductReview] ([ProductBvin])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_Variants_ProductIdClustered] on [dbo].[bvc_Variants]'
GO
CREATE CLUSTERED INDEX [IX_bvc_Variants_ProductIdClustered] ON [dbo].[bvc_Variants] ([ProductId], [StoreId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_Address_Type] on [dbo].[bvc_Address]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_Address_Type] ON [dbo].[bvc_Address] ([AddressType])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_Address_StoreId] on [dbo].[bvc_Address]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_Address_StoreId] ON [dbo].[bvc_Address] ([StoreId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_EventLog] on [dbo].[bvc_EventLog]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_EventLog] ON [dbo].[bvc_EventLog] ([StoreId], [Severity])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_ProductReview] on [dbo].[bvc_ProductReview]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_bvc_ProductReview] ON [dbo].[bvc_ProductReview] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_bvc_Variant] on [dbo].[bvc_Variants]'
GO
ALTER TABLE [dbo].[bvc_Variants] ADD CONSTRAINT [PK_bvc_Variant] PRIMARY KEY NONCLUSTERED  ([bvin])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_Variants_BvinProductStore] on [dbo].[bvc_Variants]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_Variants_BvinProductStore] ON [dbo].[bvc_Variants] ([bvin], [ProductId], [StoreId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_ecommrc_OrderTransactions_OrderBvin] on [dbo].[ecommrc_OrderTransactions]'
GO
CREATE NONCLUSTERED INDEX [IX_ecommrc_OrderTransactions_OrderBvin] ON [dbo].[ecommrc_OrderTransactions] ([OrderId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_ecommrc_OrderTransactions_StoreId] on [dbo].[ecommrc_OrderTransactions]'
GO
CREATE NONCLUSTERED INDEX [IX_ecommrc_OrderTransactions_StoreId] ON [dbo].[ecommrc_OrderTransactions] ([StoreId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding constraints to [dbo].[bvc_LineItem]'
GO
ALTER TABLE [dbo].[bvc_LineItem] ADD CONSTRAINT [IX_bvc_LineItem] UNIQUE CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding constraints to [dbo].[bvc_Affiliate]'
GO
ALTER TABLE [dbo].[bvc_Affiliate] ADD CONSTRAINT [DF_bvc_Affiliate_AddressId] DEFAULT (N'') FOR [Address]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding constraints to [dbo].[bvc_MailingList]'
GO
ALTER TABLE [dbo].[bvc_MailingList] ADD CONSTRAINT [DF_bvc_MailingList_Name] DEFAULT ('') FOR [Name]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding constraints to [dbo].[bvc_MailingListMember]'
GO
ALTER TABLE [dbo].[bvc_MailingListMember] ADD CONSTRAINT [DF_bvc_MailingListMember_FirstName] DEFAULT ('') FOR [FirstName]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_MailingListMember] ADD CONSTRAINT [DF_bvc_MailingListMember_LastName] DEFAULT ('') FOR [LastName]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[bvc_UserXContact]'
GO
ALTER TABLE [dbo].[bvc_UserXContact] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_UserXAffiliate_bvc_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[bvc_User] ([bvin])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[bvc_MailingListMember]'
GO
ALTER TABLE [dbo].[bvc_MailingListMember] ADD
CONSTRAINT [FK_bvc_MailingListMember_bvc_MailingList] FOREIGN KEY ([ListID]) REFERENCES [dbo].[bvc_MailingList] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Conversations]'
GO
ALTER TABLE [dbo].[Conversations] ADD
CONSTRAINT [FK_Conversations_ConversationGroups] FOREIGN KEY ([GroupId]) REFERENCES [dbo].[ConversationGroups] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[ecommrc_StoreSettings]'
GO
ALTER TABLE [dbo].[ecommrc_StoreSettings] ADD
CONSTRAINT [FK_ecommrc_StoreSettings_ecommrc_Stores] FOREIGN KEY ([StoreId]) REFERENCES [dbo].[ecommrc_Stores] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[ecommrc_StoresXUsers]'
GO
ALTER TABLE [dbo].[ecommrc_StoresXUsers] ADD
CONSTRAINT [FK_ecommrc_StoresXUsers_ecommrc_Stores] FOREIGN KEY ([StoreId]) REFERENCES [dbo].[ecommrc_Stores] ([Id]),
CONSTRAINT [FK_ecommrc_StoresXUsers_ecommrc_UserAccounts] FOREIGN KEY ([UserId]) REFERENCES [dbo].[ecommrc_UserAccounts] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT 'The database update succeeded'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO
