SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
PRINT N'Dropping foreign keys from [dbo].[bvc_ProductFileXProduct]'
GO
ALTER TABLE [dbo].[bvc_ProductFileXProduct] DROP
CONSTRAINT [FK_bvc_ProductFileXProduct_bvc_ProductFile]
GO
PRINT N'Dropping foreign keys from [dbo].[bvc_ProductPropertyValue]'
GO
ALTER TABLE [dbo].[bvc_ProductPropertyValue] DROP
CONSTRAINT [FK_bvc_ProductPropertyValue_bvc_Product]
GO
PRINT N'Dropping foreign keys from [dbo].[bvc_ProductTypeXProductProperty]'
GO
ALTER TABLE [dbo].[bvc_ProductTypeXProductProperty] DROP
CONSTRAINT [FK_ProductTypeProperties_ProductType]
GO
PRINT N'Dropping constraints from [dbo].[bvc_ProductFileXProduct]'
GO
ALTER TABLE [dbo].[bvc_ProductFileXProduct] DROP CONSTRAINT [PK_bvc_ProductFileXProduct]
GO
PRINT N'Dropping constraints from [dbo].[bvc_ProductPropertyValue]'
GO
ALTER TABLE [dbo].[bvc_ProductPropertyValue] DROP CONSTRAINT [PK_bvc_ProductPropertyValue]
GO
PRINT N'Dropping constraints from [dbo].[bvc_ProductPropertyValue]'
GO
ALTER TABLE [dbo].[bvc_ProductPropertyValue] DROP CONSTRAINT [DF_bvc_ProductPropertyValue_PropertyChoiceId]
GO
PRINT N'Dropping constraints from [dbo].[bvc_ProductTypeXProductProperty]'
GO
ALTER TABLE [dbo].[bvc_ProductTypeXProductProperty] DROP CONSTRAINT [PK_bvc_ProductTypeXProductProperty]
GO
PRINT N'Dropping constraints from [dbo].[bvc_ProductTypeXProductProperty]'
GO
ALTER TABLE [dbo].[bvc_ProductTypeXProductProperty] DROP CONSTRAINT [IX_ProductTypeProperties]
GO
PRINT N'Dropping constraints from [dbo].[bvc_ComponentSetting]'
GO
ALTER TABLE [dbo].[bvc_ComponentSetting] DROP CONSTRAINT [PK_bvc_ComponentSetting]
GO
PRINT N'Dropping constraints from [dbo].[bvc_ComponentSetting]'
GO
ALTER TABLE [dbo].[bvc_ComponentSetting] DROP CONSTRAINT [DF_bvc_ComponentSetting_StoreId]
GO
PRINT N'Dropping constraints from [dbo].[bvc_ComponentSettingList]'
GO
ALTER TABLE [dbo].[bvc_ComponentSettingList] DROP CONSTRAINT [PK_bvc_ComponentSettingList]
GO
PRINT N'Dropping constraints from [dbo].[bvc_ComponentSettingList]'
GO
ALTER TABLE [dbo].[bvc_ComponentSettingList] DROP CONSTRAINT [DF_bvc_ComponentSettingList_SortOrder]
GO
PRINT N'Dropping constraints from [dbo].[bvc_ComponentSettingList]'
GO
ALTER TABLE [dbo].[bvc_ComponentSettingList] DROP CONSTRAINT [DF_bvc_ComponentSettingList_StoreId]
GO
PRINT N'Dropping constraints from [dbo].[bvc_ContactUsQuestions]'
GO
ALTER TABLE [dbo].[bvc_ContactUsQuestions] DROP CONSTRAINT [PK_bvc_ContactUsQuestions]
GO
PRINT N'Dropping constraints from [dbo].[bvc_ContactUsQuestions]'
GO
ALTER TABLE [dbo].[bvc_ContactUsQuestions] DROP CONSTRAINT [DF_bvc_ContactUsQuestions_Order]
GO
PRINT N'Dropping constraints from [dbo].[bvc_ContactUsQuestions]'
GO
ALTER TABLE [dbo].[bvc_ContactUsQuestions] DROP CONSTRAINT [DF_bvc_ContactUsQuestions_StoreId]
GO
PRINT N'Dropping constraints from [dbo].[bvc_OrderStatusCode]'
GO
ALTER TABLE [dbo].[bvc_OrderStatusCode] DROP CONSTRAINT [PK_bvc_OrderStatusCode]
GO
PRINT N'Dropping constraints from [dbo].[bvc_OrderStatusCode]'
GO
ALTER TABLE [dbo].[bvc_OrderStatusCode] DROP CONSTRAINT [DF_bvc_OrderStatusCode_SystemCode]
GO
PRINT N'Dropping constraints from [dbo].[bvc_OrderStatusCode]'
GO
ALTER TABLE [dbo].[bvc_OrderStatusCode] DROP CONSTRAINT [DF_bvc_OrderStatusCode_SortOrder]
GO
PRINT N'Dropping constraints from [dbo].[bvc_OrderStatusCode]'
GO
ALTER TABLE [dbo].[bvc_OrderStatusCode] DROP CONSTRAINT [DF_bvc_OrderStatusCode_StoreId]
GO
PRINT N'Dropping constraints from [dbo].[bvc_SiteTerm]'
GO
ALTER TABLE [dbo].[bvc_SiteTerm] DROP CONSTRAINT [PK_bvc_SiteTerm]
GO
PRINT N'Dropping constraints from [dbo].[bvc_WebAppSetting]'
GO
ALTER TABLE [dbo].[bvc_WebAppSetting] DROP CONSTRAINT [PK_bvc_WebAppSetting]
GO
PRINT N'Dropping constraints from [dbo].[bvc_WishList]'
GO
ALTER TABLE [dbo].[bvc_WishList] DROP CONSTRAINT [PK_bvc_WishList_1]
GO
PRINT N'Dropping constraints from [dbo].[bvc_WishList]'
GO
ALTER TABLE [dbo].[bvc_WishList] DROP CONSTRAINT [DF_bvc_WishList_UserId]
GO
PRINT N'Dropping constraints from [dbo].[bvc_WishList]'
GO
ALTER TABLE [dbo].[bvc_WishList] DROP CONSTRAINT [DF_bvc_WishList_Quantity]
GO
PRINT N'Dropping constraints from [dbo].[bvc_WishList]'
GO
ALTER TABLE [dbo].[bvc_WishList] DROP CONSTRAINT [DF_bvc_WishList_Modifiers]
GO
PRINT N'Dropping constraints from [dbo].[bvc_WishList]'
GO
ALTER TABLE [dbo].[bvc_WishList] DROP CONSTRAINT [DF_bvc_WishList_Inputs]
GO
PRINT N'Dropping index [IX_bvc_ProductPropertyValue] from [dbo].[bvc_ProductPropertyValue]'
GO
DROP INDEX [IX_bvc_ProductPropertyValue] ON [dbo].[bvc_ProductPropertyValue]
GO
PRINT N'Dropping index [IX_bvc_ComponentSetting] from [dbo].[bvc_ComponentSetting]'
GO
DROP INDEX [IX_bvc_ComponentSetting] ON [dbo].[bvc_ComponentSetting]
GO
PRINT N'Dropping index [IX_bvc_ComponentSettingList] from [dbo].[bvc_ComponentSettingList]'
GO
DROP INDEX [IX_bvc_ComponentSettingList] ON [dbo].[bvc_ComponentSettingList]
GO
PRINT N'Dropping index [IX_bvc_ComponentSettingList_1] from [dbo].[bvc_ComponentSettingList]'
GO
DROP INDEX [IX_bvc_ComponentSettingList_1] ON [dbo].[bvc_ComponentSettingList]
GO
PRINT N'Dropping [dbo].[bvc_EventLog_SQL_i]'
GO
DROP PROCEDURE [dbo].[bvc_EventLog_SQL_i]
GO
PRINT N'Dropping [dbo].[ListOfStringsToTable]'
GO
DROP FUNCTION [dbo].[ListOfStringsToTable]
GO
PRINT N'Dropping [dbo].[ListOfGuidsToTable]'
GO
DROP FUNCTION [dbo].[ListOfGuidsToTable]
GO
PRINT N'Dropping [dbo].[bvc_ProductType_ForCategory_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductType_ForCategory_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductFile_ByBvinAndProductBvin_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductFile_ByBvinAndProductBvin_s]
GO
PRINT N'Dropping [dbo].[bvc_Product_ByFacet_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_ByFacet_s]
GO
PRINT N'Dropping [dbo].[bvc_Product_ByCategoryFiltered_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_ByCategoryFiltered_s]
GO
PRINT N'Dropping [dbo].[bvc_UserAccount_ByAffiliateID_s]'
GO
DROP PROCEDURE [dbo].[bvc_UserAccount_ByAffiliateID_s]
GO
PRINT N'Dropping [dbo].[bvc_Product_ByOrder_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_ByOrder_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductFilter_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductFilter_All_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductFilter_i ]'
GO
DROP PROCEDURE [dbo].[bvc_ProductFilter_i ]
GO
PRINT N'Dropping [dbo].[bvc_OrderStatusCode_i]'
GO
DROP PROCEDURE [dbo].[bvc_OrderStatusCode_i]
GO
PRINT N'Dropping [dbo].[bvc_ContentColumn_s]'
GO
DROP PROCEDURE [dbo].[bvc_ContentColumn_s]
GO
PRINT N'Dropping [dbo].[bvc_ContentColumn_ByName_s]'
GO
DROP PROCEDURE [dbo].[bvc_ContentColumn_ByName_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductType_Properties_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductType_Properties_s]
GO
PRINT N'Dropping [dbo].[bvc_ContentColumn_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_ContentColumn_All_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductFilter_d ]'
GO
DROP PROCEDURE [dbo].[bvc_ProductFilter_d ]
GO
PRINT N'Dropping [dbo].[bvc_UserAccount_i]'
GO
DROP PROCEDURE [dbo].[bvc_UserAccount_i]
GO
PRINT N'Dropping [dbo].[bvc_OrderStatusCode_d]'
GO
DROP PROCEDURE [dbo].[bvc_OrderStatusCode_d]
GO
PRINT N'Dropping [dbo].[bvc_ProductFilter_ByName_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductFilter_ByName_s]
GO
PRINT N'Dropping [dbo].[bvc_ContentColumn_u]'
GO
DROP PROCEDURE [dbo].[bvc_ContentColumn_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductType_i]'
GO
DROP PROCEDURE [dbo].[bvc_ProductType_i]
GO
PRINT N'Dropping [dbo].[bvc_ContentBlock_ByColumnID_s]'
GO
DROP PROCEDURE [dbo].[bvc_ContentBlock_ByColumnID_s]
GO
PRINT N'Dropping [dbo].[bvc_UserAccount_Filter_s]'
GO
DROP PROCEDURE [dbo].[bvc_UserAccount_Filter_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductFile_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductFile_All_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductFile_AddProduct_i]'
GO
DROP PROCEDURE [dbo].[bvc_ProductFile_AddProduct_i]
GO
PRINT N'Dropping [dbo].[bvc_ProductFileByProduct_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductFileByProduct_s]
GO
PRINT N'Dropping [dbo].[bvc_Product_Featured_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_Featured_s]
GO
PRINT N'Dropping [dbo].[bvc_ContentColumn_i]'
GO
DROP PROCEDURE [dbo].[bvc_ContentColumn_i]
GO
PRINT N'Dropping [dbo].[bvc_Policy_ByType_s]'
GO
DROP PROCEDURE [dbo].[bvc_Policy_ByType_s]
GO
PRINT N'Dropping [dbo].[bvc_Product_AllStores_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_AllStores_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductFileByFilenameAndDescription_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductFileByFilenameAndDescription_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductType_Exists_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductType_Exists_s]
GO
PRINT N'Dropping [dbo].[bvc_ContactUsQuestion_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_ContactUsQuestion_All_s]
GO
PRINT N'Dropping [dbo].[bvc_Product_ByCategory_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_ByCategory_s]
GO
PRINT N'Dropping [dbo].[bvc_Product_BySlug_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_BySlug_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductProperty_d]'
GO
DROP PROCEDURE [dbo].[bvc_ProductProperty_d]
GO
PRINT N'Dropping [dbo].[bvc_ContentColumn_d]'
GO
DROP PROCEDURE [dbo].[bvc_ContentColumn_d]
GO
PRINT N'Dropping [dbo].[bvc_Product_ProductsOrderedCount_Admin_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_ProductsOrderedCount_Admin_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductCount_ByCategory_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductCount_ByCategory_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductFile_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductFile_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductType_d]'
GO
DROP PROCEDURE [dbo].[bvc_ProductType_d]
GO
PRINT N'Dropping [dbo].[bvc_Product_ByFile_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_ByFile_s]
GO
PRINT N'Dropping [dbo].[bvc_UserAccount_ExcludeAffiliateId_s]'
GO
DROP PROCEDURE [dbo].[bvc_UserAccount_ExcludeAffiliateId_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductFile_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductFile_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductType_Available_Properties_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductType_Available_Properties_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductType_Count_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductType_Count_s]
GO
PRINT N'Dropping [dbo].[bvc_Product_All_d]'
GO
DROP PROCEDURE [dbo].[bvc_Product_All_d]
GO
PRINT N'Dropping [dbo].[bvc_ProductInventory_Unship_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductInventory_Unship_u]
GO
PRINT N'Dropping [dbo].[bvc_Product_BySku_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_BySku_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductFile_RemoveProduct_d]'
GO
DROP PROCEDURE [dbo].[bvc_ProductFile_RemoveProduct_d]
GO
PRINT N'Dropping [dbo].[bvc_ProductPropertyValues_ForProduct_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductPropertyValues_ForProduct_s]
GO
PRINT N'Dropping [dbo].[bvc_CustomUrlByRequestedUrl_s]'
GO
DROP PROCEDURE [dbo].[bvc_CustomUrlByRequestedUrl_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductXCategory_ByCategory_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductXCategory_ByCategory_s]
GO
PRINT N'Dropping [dbo].[bvc_ContentBlock_u]'
GO
DROP PROCEDURE [dbo].[bvc_ContentBlock_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductInventory_d]'
GO
DROP PROCEDURE [dbo].[bvc_ProductInventory_d]
GO
PRINT N'Dropping [dbo].[bvc_ProductInventory_Unreserve_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductInventory_Unreserve_u]
GO
PRINT N'Dropping [dbo].[bvc_SearchQuery_Report_s]'
GO
DROP PROCEDURE [dbo].[bvc_SearchQuery_Report_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductFile_ProductCount_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductFile_ProductCount_s]
GO
PRINT N'Dropping [dbo].[bvc_Product_d]'
GO
DROP PROCEDURE [dbo].[bvc_Product_d]
GO
PRINT N'Dropping [dbo].[bvc_CustomUrlByRedirectToUrl_s]'
GO
DROP PROCEDURE [dbo].[bvc_CustomUrlByRedirectToUrl_s]
GO
PRINT N'Dropping [dbo].[bvc_ComponentSettings_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_ComponentSettings_All_s]
GO
PRINT N'Dropping [dbo].[bvc_ContentBlock_SortOrder_u]'
GO
DROP PROCEDURE [dbo].[bvc_ContentBlock_SortOrder_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductInventory_ByProductId_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductInventory_ByProductId_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductInventory_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductInventory_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductPropertyValue_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductPropertyValue_u]
GO
PRINT N'Dropping [dbo].[bvc_ComponentSetting_ByComponentID_d]'
GO
DROP PROCEDURE [dbo].[bvc_ComponentSetting_ByComponentID_d]
GO
PRINT N'Dropping [dbo].[bvc_SearchQuery_i]'
GO
DROP PROCEDURE [dbo].[bvc_SearchQuery_i]
GO
PRINT N'Dropping [dbo].[bvc_ProductFile_i]'
GO
DROP PROCEDURE [dbo].[bvc_ProductFile_i]
GO
PRINT N'Dropping [dbo].[bvc_ProductVolumeDiscountsByQtyForProduct_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductVolumeDiscountsByQtyForProduct_s]
GO
PRINT N'Dropping [dbo].[bvc_CustomUrl_u]'
GO
DROP PROCEDURE [dbo].[bvc_CustomUrl_u]
GO
PRINT N'Dropping [dbo].[bvc_WishList_s]'
GO
DROP PROCEDURE [dbo].[bvc_WishList_s]
GO
PRINT N'Dropping [dbo].[bvc_ContentBlock_s]'
GO
DROP PROCEDURE [dbo].[bvc_ContentBlock_s]
GO
PRINT N'Dropping [dbo].[bvc_WishList_ForUser_s]'
GO
DROP PROCEDURE [dbo].[bvc_WishList_ForUser_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductReviewNotApproved_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductReviewNotApproved_s]
GO
PRINT N'Dropping [dbo].[bvc_ComponentSettingList_u]'
GO
DROP PROCEDURE [dbo].[bvc_ComponentSettingList_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductInventory_Ship_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductInventory_Ship_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductInventory_ByProductId_d]'
GO
DROP PROCEDURE [dbo].[bvc_ProductInventory_ByProductId_d]
GO
PRINT N'Dropping [dbo].[bvc_ProductFile_d]'
GO
DROP PROCEDURE [dbo].[bvc_ProductFile_d]
GO
PRINT N'Dropping [dbo].[bvc_ProductPropertyValue_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductPropertyValue_s]
GO
PRINT N'Dropping [dbo].[bvc_WishList_i]'
GO
DROP PROCEDURE [dbo].[bvc_WishList_i]
GO
PRINT N'Dropping [dbo].[bvc_SearchQuery_d]'
GO
DROP PROCEDURE [dbo].[bvc_SearchQuery_d]
GO
PRINT N'Dropping [dbo].[bvc_ContentBlock_i]'
GO
DROP PROCEDURE [dbo].[bvc_ContentBlock_i]
GO
PRINT N'Dropping [dbo].[bvc_ProductVolumeDiscountsByProduct_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductVolumeDiscountsByProduct_s]
GO
PRINT N'Dropping [dbo].[bvc_CustomUrl_s]'
GO
DROP PROCEDURE [dbo].[bvc_CustomUrl_s]
GO
PRINT N'Dropping [dbo].[bvc_Product_SuggestedItems]'
GO
DROP PROCEDURE [dbo].[bvc_Product_SuggestedItems]
GO
PRINT N'Dropping [dbo].[bvc_ProductFile_Count_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductFile_Count_s]
GO
PRINT N'Dropping [dbo].[bvc_ComponentSettingList_SortOrder_u]'
GO
DROP PROCEDURE [dbo].[bvc_ComponentSettingList_SortOrder_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductInventory_SetAvailableQuantity_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductInventory_SetAvailableQuantity_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductPropertyValue_ClearAll_d]'
GO
DROP PROCEDURE [dbo].[bvc_ProductPropertyValue_ClearAll_d]
GO
PRINT N'Dropping [dbo].[bvc_ProductReviewKarma_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductReviewKarma_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductInventory_AllLowStock_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductInventory_AllLowStock_s]
GO
PRINT N'Dropping [dbo].[bvc_ContentBlock_d]'
GO
DROP PROCEDURE [dbo].[bvc_ContentBlock_d]
GO
PRINT N'Dropping [dbo].[bvc_Product_ByFacet_Count_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_ByFacet_Count_s]
GO
PRINT N'Dropping [dbo].[bvc_CustomUrl_i]'
GO
DROP PROCEDURE [dbo].[bvc_CustomUrl_i]
GO
PRINT N'Dropping [dbo].[bvc_Product_ProductsOrderedCount_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_ProductsOrderedCount_s]
GO
PRINT N'Dropping [dbo].[bvc_Product_Count_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_Count_All_s]
GO
PRINT N'Dropping [dbo].[bvc_SearchQuery_ByShopperID_s]'
GO
DROP PROCEDURE [dbo].[bvc_SearchQuery_ByShopperID_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductVolumeDiscounts_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductVolumeDiscounts_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductReview_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductReview_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductXCategory_ByProduct_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductXCategory_ByProduct_s]
GO
PRINT N'Dropping [dbo].[bvc_UserQuestion_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_UserQuestion_All_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductXCategory_SortOrder_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductXCategory_SortOrder_u]
GO
PRINT N'Dropping [dbo].[bvc_ComponentSettingList_s]'
GO
DROP PROCEDURE [dbo].[bvc_ComponentSettingList_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductInventory_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductInventory_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductPropertyChoicesForProperty_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductPropertyChoicesForProperty_s]
GO
PRINT N'Dropping [dbo].[bvc_UserAccount_s]'
GO
DROP PROCEDURE [dbo].[bvc_UserAccount_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductInventory_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductInventory_All_s]
GO
PRINT N'Dropping [dbo].[bvc_WishList_d]'
GO
DROP PROCEDURE [dbo].[bvc_WishList_d]
GO
PRINT N'Dropping [dbo].[bvc_ProductVolumeDiscounts_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductVolumeDiscounts_s]
GO
PRINT N'Dropping [dbo].[bvc_ContactUsQuestion_u]'
GO
DROP PROCEDURE [dbo].[bvc_ContactUsQuestion_u]
GO
PRINT N'Dropping [dbo].[bvc_SearchQuery_ByQueryPhrase_s]'
GO
DROP PROCEDURE [dbo].[bvc_SearchQuery_ByQueryPhrase_s]
GO
PRINT N'Dropping [dbo].[bvc_CustomUrl_d]'
GO
DROP PROCEDURE [dbo].[bvc_CustomUrl_d]
GO
PRINT N'Dropping [dbo].[bvc_ProductPropertyChoice_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductPropertyChoice_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductReview_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductReview_s]
GO
PRINT N'Dropping [dbo].[bvc_ComponentSettingList_i]'
GO
DROP PROCEDURE [dbo].[bvc_ComponentSettingList_i]
GO
PRINT N'Dropping [dbo].[bvc_UserAccount_ByCriteria_s]'
GO
DROP PROCEDURE [dbo].[bvc_UserAccount_ByCriteria_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductPropertyChoicesForPropertyList_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductPropertyChoicesForPropertyList_s]
GO
PRINT N'Dropping [dbo].[bvc_ContactUsQuestion_s]'
GO
DROP PROCEDURE [dbo].[bvc_ContactUsQuestion_s]
GO
PRINT N'Dropping [dbo].[bvc_Product_BySkuAll_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_BySkuAll_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductInventory_ResetProduct_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductInventory_ResetProduct_u]
GO
PRINT N'Dropping [dbo].[bvc_Product_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductXCategory_i]'
GO
DROP PROCEDURE [dbo].[bvc_ProductXCategory_i]
GO
PRINT N'Dropping [dbo].[bvc_SearchQuery_ByDate_d]'
GO
DROP PROCEDURE [dbo].[bvc_SearchQuery_ByDate_d]
GO
PRINT N'Dropping [dbo].[bvc_Reporting_OrderStatusSummary_s]'
GO
DROP PROCEDURE [dbo].[bvc_Reporting_OrderStatusSummary_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductPropertyChoice_i]'
GO
DROP PROCEDURE [dbo].[bvc_ProductPropertyChoice_i]
GO
PRINT N'Dropping [dbo].[bvc_Audit_d]'
GO
DROP PROCEDURE [dbo].[bvc_Audit_d]
GO
PRINT N'Dropping [dbo].[bvc_ProductVolumeDiscounts_i]'
GO
DROP PROCEDURE [dbo].[bvc_ProductVolumeDiscounts_i]
GO
PRINT N'Dropping [dbo].[bvc_ContactUsQuestion_i]'
GO
DROP PROCEDURE [dbo].[bvc_ContactUsQuestion_i]
GO
PRINT N'Dropping [dbo].[bvc_UserAccount_d]'
GO
DROP PROCEDURE [dbo].[bvc_UserAccount_d]
GO
PRINT N'Dropping [dbo].[bvc_CustomUrl_BySystemData_s]'
GO
DROP PROCEDURE [dbo].[bvc_CustomUrl_BySystemData_s]
GO
PRINT N'Dropping [dbo].[bvc_ComponentSettingList_d]'
GO
DROP PROCEDURE [dbo].[bvc_ComponentSettingList_d]
GO
PRINT N'Dropping [dbo].[bvc_Product_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_All_s]
GO
PRINT N'Dropping [dbo].[bvc_SearchQuery_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_SearchQuery_All_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductReview_i]'
GO
DROP PROCEDURE [dbo].[bvc_ProductReview_i]
GO
PRINT N'Dropping [dbo].[bvc_ProductPropertyChoice_d]'
GO
DROP PROCEDURE [dbo].[bvc_ProductPropertyChoice_d]
GO
PRINT N'Dropping [dbo].[bvc_ProductInventory_Reset_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductInventory_Reset_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductType_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductType_All_s]
GO
PRINT N'Dropping [dbo].[bvc_ContactUsQuestion_d]'
GO
DROP PROCEDURE [dbo].[bvc_ContactUsQuestion_d]
GO
PRINT N'Dropping [dbo].[bvc_ContactUsQuestions]'
GO
DROP TABLE [dbo].[bvc_ContactUsQuestions]
GO
PRINT N'Dropping [dbo].[bvc_Product_UniqueSku_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_UniqueSku_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductXCategory_d_all]'
GO
DROP PROCEDURE [dbo].[bvc_ProductXCategory_d_all]
GO
PRINT N'Dropping [dbo].[bvc_Product_ByCriteria_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_ByCriteria_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductReview_d]'
GO
DROP PROCEDURE [dbo].[bvc_ProductReview_d]
GO
PRINT N'Dropping [dbo].[bvc_ComponentSettingList_ByListName_s]'
GO
DROP PROCEDURE [dbo].[bvc_ComponentSettingList_ByListName_s]
GO
PRINT N'Dropping [dbo].[bvc_UserAccount_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_UserAccount_All_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductVolumeDiscounts_d]'
GO
DROP PROCEDURE [dbo].[bvc_ProductVolumeDiscounts_d]
GO
PRINT N'Dropping [dbo].[bvc_ProductInventory_Reserve_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductInventory_Reserve_u]
GO
PRINT N'Dropping [dbo].[bvc_Product_ByOption_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_ByOption_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductXCategory_d]'
GO
DROP PROCEDURE [dbo].[bvc_ProductXCategory_d]
GO
PRINT N'Dropping [dbo].[bvc_ProductPropertyByProductType_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductPropertyByProductType_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductInventory_i]'
GO
DROP PROCEDURE [dbo].[bvc_ProductInventory_i]
GO
PRINT N'Dropping [dbo].[bvc_ComponentSettings_s]'
GO
DROP PROCEDURE [dbo].[bvc_ComponentSettings_s]
GO
PRINT N'Dropping [dbo].[bvc_UserAccount_ByEmail_s]'
GO
DROP PROCEDURE [dbo].[bvc_UserAccount_ByEmail_s]
GO
PRINT N'Dropping [dbo].[bvc_SearchQuery_s]'
GO
DROP PROCEDURE [dbo].[bvc_SearchQuery_s]
GO
PRINT N'Dropping [dbo].[bvc_Product_u]'
GO
DROP PROCEDURE [dbo].[bvc_Product_u]
GO
PRINT N'Dropping [dbo].[bvc_CartCleanup_d]'
GO
DROP PROCEDURE [dbo].[bvc_CartCleanup_d]
GO
PRINT N'Dropping [dbo].[bvc_PolicyBlock_u]'
GO
DROP PROCEDURE [dbo].[bvc_PolicyBlock_u]
GO
PRINT N'Dropping [dbo].[bvc_ComponentSettingList_ByListName_d]'
GO
DROP PROCEDURE [dbo].[bvc_ComponentSettingList_ByListName_d]
GO
PRINT N'Dropping [dbo].[bvc_ProductProperty_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductProperty_u]
GO
PRINT N'Dropping [dbo].[bvc_ComponentSettingList_ByComponentId_s]'
GO
DROP PROCEDURE [dbo].[bvc_ComponentSettingList_ByComponentId_s]
GO
PRINT N'Dropping [dbo].[bvc_PolicyBlock_SortOrder_u]'
GO
DROP PROCEDURE [dbo].[bvc_PolicyBlock_SortOrder_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductReview_ByProductBvin_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductReview_ByProductBvin_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductProperty_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductProperty_s]
GO
PRINT N'Dropping [dbo].[bvc_ComponentSettingList_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_ComponentSettingList_All_s]
GO
PRINT N'Dropping [dbo].[bvc_ComponentSettingList]'
GO
DROP TABLE [dbo].[bvc_ComponentSettingList]
GO
PRINT N'Dropping [dbo].[bvc_PolicyBlock_s]'
GO
DROP PROCEDURE [dbo].[bvc_PolicyBlock_s]
GO
PRINT N'Dropping [dbo].[bvc_ComponentSetting_s]'
GO
DROP PROCEDURE [dbo].[bvc_ComponentSetting_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductProperty_i]'
GO
DROP PROCEDURE [dbo].[bvc_ProductProperty_i]
GO
PRINT N'Dropping [dbo].[bvc_PolicyBlock_i]'
GO
DROP PROCEDURE [dbo].[bvc_PolicyBlock_i]
GO
PRINT N'Dropping [dbo].[bvc_ProductProperty_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductProperty_All_s]
GO
PRINT N'Dropping [dbo].[bvc_WishList_u]'
GO
DROP PROCEDURE [dbo].[bvc_WishList_u]
GO
PRINT N'Dropping [dbo].[bvc_WishList]'
GO
DROP TABLE [dbo].[bvc_WishList]
GO
PRINT N'Dropping [dbo].[bvc_ProductProperty_Exists_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductProperty_Exists_s]
GO
PRINT N'Dropping [dbo].[bvc_ComponentSetting_i]'
GO
DROP PROCEDURE [dbo].[bvc_ComponentSetting_i]
GO
PRINT N'Dropping [dbo].[bvc_ComponentSetting]'
GO
DROP TABLE [dbo].[bvc_ComponentSetting]
GO
PRINT N'Dropping [dbo].[bvc_Policy_s]'
GO
DROP PROCEDURE [dbo].[bvc_Policy_s]
GO
PRINT N'Dropping [dbo].[bvc_PolicyBlock_d]'
GO
DROP PROCEDURE [dbo].[bvc_PolicyBlock_d]
GO
PRINT N'Dropping [dbo].[bvc_Policy_d]'
GO
DROP PROCEDURE [dbo].[bvc_Policy_d]
GO
PRINT N'Dropping [dbo].[bvc_UserQuestion_u]'
GO
DROP PROCEDURE [dbo].[bvc_UserQuestion_u]
GO
PRINT N'Dropping [dbo].[bvc_Policy_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_Policy_All_s]
GO
PRINT N'Dropping [dbo].[bvc_Policy_u]'
GO
DROP PROCEDURE [dbo].[bvc_Policy_u]
GO
PRINT N'Dropping [dbo].[bvc_OrderStatusCode_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_OrderStatusCode_All_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductOption_d ]'
GO
DROP PROCEDURE [dbo].[bvc_ProductOption_d ]
GO
PRINT N'Dropping [dbo].[bvc_PolicyBlock_ByPolicyId_s]'
GO
DROP PROCEDURE [dbo].[bvc_PolicyBlock_ByPolicyId_s]
GO
PRINT N'Dropping [dbo].[bvc_UserQuestion_s]'
GO
DROP PROCEDURE [dbo].[bvc_UserQuestion_s]
GO
PRINT N'Dropping [dbo].[bvc_Policy_i]'
GO
DROP PROCEDURE [dbo].[bvc_Policy_i]
GO
PRINT N'Dropping [dbo].[bvc_Product_Light_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_Light_s]
GO
PRINT N'Dropping [dbo].[bvc_CustomUrl_All_S]'
GO
DROP PROCEDURE [dbo].[bvc_CustomUrl_All_S]
GO
PRINT N'Dropping [dbo].[bvc_UserQuestion_i]'
GO
DROP PROCEDURE [dbo].[bvc_UserQuestion_i]
GO
PRINT N'Dropping [dbo].[bvc_ProductInventory_Adjust_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductInventory_Adjust_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductTypeProperty_i]'
GO
DROP PROCEDURE [dbo].[bvc_ProductTypeProperty_i]
GO
PRINT N'Dropping [dbo].[bvc_SearchQuery_All_d]'
GO
DROP PROCEDURE [dbo].[bvc_SearchQuery_All_d]
GO
PRINT N'Dropping [dbo].[bvc_UserQuestion_d]'
GO
DROP PROCEDURE [dbo].[bvc_UserQuestion_d]
GO
PRINT N'Dropping [dbo].[bvc_Product_i]'
GO
DROP PROCEDURE [dbo].[bvc_Product_i]
GO
PRINT N'Dropping [dbo].[bvc_OrderStatusCode_u]'
GO
DROP PROCEDURE [dbo].[bvc_OrderStatusCode_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductTypeProperty_d]'
GO
DROP PROCEDURE [dbo].[bvc_ProductTypeProperty_d]
GO
PRINT N'Dropping [dbo].[bvc_OrderStatusCode_SortOrder_u]'
GO
DROP PROCEDURE [dbo].[bvc_OrderStatusCode_SortOrder_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductType_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductType_u]
GO
PRINT N'Dropping [dbo].[bvc_UserAccount_u]'
GO
DROP PROCEDURE [dbo].[bvc_UserAccount_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductFilter_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductFilter_u]
GO
PRINT N'Dropping [dbo].[bvc_OrderStatusCode_s]'
GO
DROP PROCEDURE [dbo].[bvc_OrderStatusCode_s]
GO
PRINT N'Dropping [dbo].[bvc_OrderStatusCode]'
GO
DROP TABLE [dbo].[bvc_OrderStatusCode]
GO
PRINT N'Dropping [dbo].[bvc_ProductType_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductType_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductFilter_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductFilter_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductType_Property_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductType_Property_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductOption_ByProduct_d]'
GO
DROP PROCEDURE [dbo].[bvc_ProductOption_ByProduct_d]
GO
PRINT N'Dropping [dbo].[ListOfBigIntsToTable]'
GO
DROP FUNCTION [dbo].[ListOfBigIntsToTable]
GO
PRINT N'Dropping [dbo].[bvc_Product_ByFacet_CountForKeys_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_ByFacet_CountForKeys_s]
GO
PRINT N'Dropping [dbo].[ListOfKeysToTable]'
GO
DROP FUNCTION [dbo].[ListOfKeysToTable]
GO
PRINT N'Dropping [dbo].[bvc_Variant_ByProduct_d]'
GO
DROP PROCEDURE [dbo].[bvc_Variant_ByProduct_d]
GO
PRINT N'Dropping [dbo].[bvc_Variant_d]'
GO
DROP PROCEDURE [dbo].[bvc_Variant_d]
GO
PRINT N'Dropping [dbo].[bvc_Variant_i]'
GO
DROP PROCEDURE [dbo].[bvc_Variant_i]
GO
PRINT N'Dropping [dbo].[bvc_Variant_u]'
GO
DROP PROCEDURE [dbo].[bvc_Variant_u]
GO
PRINT N'Dropping [dbo].[bvc_Variant_s]'
GO
DROP PROCEDURE [dbo].[bvc_Variant_s]
GO
PRINT N'Dropping [dbo].[bvc_Variant_ByProduct_s]'
GO
DROP PROCEDURE [dbo].[bvc_Variant_ByProduct_s]
GO
PRINT N'Dropping [dbo].[bvc_SiteTerm_u]'
GO
DROP PROCEDURE [dbo].[bvc_SiteTerm_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductXOption_ByCategory_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductXOption_ByCategory_s]
GO
PRINT N'Dropping [dbo].[bvc_SiteTerm_s]'
GO
DROP PROCEDURE [dbo].[bvc_SiteTerm_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductXOption_SortOrder_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductXOption_SortOrder_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductXOption_d]'
GO
DROP PROCEDURE [dbo].[bvc_ProductXOption_d]
GO
PRINT N'Dropping [dbo].[bvc_ProductXOption_d_all]'
GO
DROP PROCEDURE [dbo].[bvc_ProductXOption_d_all]
GO
PRINT N'Dropping [dbo].[bvc_SiteTerm_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_SiteTerm_All_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductXOption_i]'
GO
DROP PROCEDURE [dbo].[bvc_ProductXOption_i]
GO
PRINT N'Dropping [dbo].[bvc_SiteTerm_i]'
GO
DROP PROCEDURE [dbo].[bvc_SiteTerm_i]
GO
PRINT N'Dropping [dbo].[bvc_ProductOptionItem_SortOrder_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductOptionItem_SortOrder_u]
GO
PRINT N'Dropping [dbo].[bvc_ProductOptionItem_ByOption_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductOptionItem_ByOption_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductOptionItem_d ]'
GO
DROP PROCEDURE [dbo].[bvc_ProductOptionItem_d ]
GO
PRINT N'Dropping [dbo].[bvc_SiteTerm_d]'
GO
DROP PROCEDURE [dbo].[bvc_SiteTerm_d]
GO
PRINT N'Dropping [dbo].[bvc_SiteTerm]'
GO
DROP TABLE [dbo].[bvc_SiteTerm]
GO
PRINT N'Dropping [dbo].[bvc_ProductOptionItem_ByProduct_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductOptionItem_ByProduct_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductOptionItem_s ]'
GO
DROP PROCEDURE [dbo].[bvc_ProductOptionItem_s ]
GO
PRINT N'Dropping [dbo].[bvc_ProductOptionItem_i ]'
GO
DROP PROCEDURE [dbo].[bvc_ProductOptionItem_i ]
GO
PRINT N'Dropping [dbo].[bvc_ProductOptionItem_u ]'
GO
DROP PROCEDURE [dbo].[bvc_ProductOptionItem_u ]
GO
PRINT N'Dropping [dbo].[bvc_ProductOption_i ]'
GO
DROP PROCEDURE [dbo].[bvc_ProductOption_i ]
GO
PRINT N'Dropping [dbo].[bvc_ProductOption_RemoveFromProduct_d ]'
GO
DROP PROCEDURE [dbo].[bvc_ProductOption_RemoveFromProduct_d ]
GO
PRINT N'Dropping [dbo].[bvc_ProductOption_s ]'
GO
DROP PROCEDURE [dbo].[bvc_ProductOption_s ]
GO
PRINT N'Dropping [dbo].[bvc_ProductOption_u ]'
GO
DROP PROCEDURE [dbo].[bvc_ProductOption_u ]
GO
PRINT N'Dropping [dbo].[bvc_ProductOption_ByProduct_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductOption_ByProduct_s]
GO
PRINT N'Dropping [dbo].[bvc_ProductOption_Shared_s ]'
GO
DROP PROCEDURE [dbo].[bvc_ProductOption_Shared_s ]
GO
PRINT N'Dropping [dbo].[bvc_RewardsPoints_HeldForUser_s]'
GO
DROP PROCEDURE [dbo].[bvc_RewardsPoints_HeldForUser_s]
GO
PRINT N'Dropping [dbo].[bvc_RewardsPoints_AvailableForUser_s]'
GO
DROP PROCEDURE [dbo].[bvc_RewardsPoints_AvailableForUser_s]
GO
PRINT N'Dropping [dbo].[bvc_RewardsPoints_TotalReserved_s]'
GO
DROP PROCEDURE [dbo].[bvc_RewardsPoints_TotalReserved_s]
GO
PRINT N'Dropping [dbo].[bvc_RewardsPoints_TotalIssued_s]'
GO
DROP PROCEDURE [dbo].[bvc_RewardsPoints_TotalIssued_s]
GO
PRINT N'Dropping [dbo].[bvc_WebAppSettings_s]'
GO
DROP PROCEDURE [dbo].[bvc_WebAppSettings_s]
GO
PRINT N'Dropping [dbo].[bvc_RewardsPoints_IncAmt_u]'
GO
DROP PROCEDURE [dbo].[bvc_RewardsPoints_IncAmt_u]
GO
PRINT N'Dropping [dbo].[bvc_RewardsPoints_UnHold_u]'
GO
DROP PROCEDURE [dbo].[bvc_RewardsPoints_UnHold_u]
GO
PRINT N'Dropping [dbo].[bvc_RewardsPoints_Hold_u]'
GO
DROP PROCEDURE [dbo].[bvc_RewardsPoints_Hold_u]
GO
PRINT N'Dropping [dbo].[bvc_RewardsPoints_DecAmt_u]'
GO
DROP PROCEDURE [dbo].[bvc_RewardsPoints_DecAmt_u]
GO
PRINT N'Dropping [dbo].[bvc_WebAppSetting_u]'
GO
DROP PROCEDURE [dbo].[bvc_WebAppSetting_u]
GO
PRINT N'Dropping [dbo].[bvc_RewardsPoints_Capture_u]'
GO
DROP PROCEDURE [dbo].[bvc_RewardsPoints_Capture_u]
GO
PRINT N'Dropping [dbo].[bvc_WebAppSetting_s]'
GO
DROP PROCEDURE [dbo].[bvc_WebAppSetting_s]
GO
PRINT N'Dropping [dbo].[bvc_WebAppSetting]'
GO
DROP TABLE [dbo].[bvc_WebAppSetting]
GO
PRINT N'Altering [dbo].[bvc_ProductFileXProduct]'
GO
ALTER TABLE [dbo].[bvc_ProductFileXProduct] ADD
[Id] [bigint] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_bvc_ProductFileXProduct] on [dbo].[bvc_ProductFileXProduct]'
GO
ALTER TABLE [dbo].[bvc_ProductFileXProduct] ADD CONSTRAINT [PK_bvc_ProductFileXProduct] PRIMARY KEY CLUSTERED  ([Id])
GO
PRINT N'Creating index [IX_bvc_ProductFileXProduct_2] on [dbo].[bvc_ProductFileXProduct]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductFileXProduct_2] ON [dbo].[bvc_ProductFileXProduct] ([ProductId])
GO
PRINT N'Altering [dbo].[bvc_ProductPropertyValue]'
GO
ALTER TABLE [dbo].[bvc_ProductPropertyValue] ADD
[Id] [bigint] NOT NULL IDENTITY(1, 1)
GO
ALTER TABLE [dbo].[bvc_ProductPropertyValue] DROP
COLUMN [PropertyChoiceId]
GO
PRINT N'Creating primary key [PK_bvc_ProductPropertyValue] on [dbo].[bvc_ProductPropertyValue]'
GO
ALTER TABLE [dbo].[bvc_ProductPropertyValue] ADD CONSTRAINT [PK_bvc_ProductPropertyValue] PRIMARY KEY CLUSTERED  ([Id])
GO
PRINT N'Creating index [IX_bvc_ProductPropertyValue_1] on [dbo].[bvc_ProductPropertyValue]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductPropertyValue_1] ON [dbo].[bvc_ProductPropertyValue] ([ProductBvin])
GO
PRINT N'Creating index [IX_bvc_ProductPropertyValue_2] on [dbo].[bvc_ProductPropertyValue]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductPropertyValue_2] ON [dbo].[bvc_ProductPropertyValue] ([PropertyId])
GO
PRINT N'Altering [dbo].[bvc_ProductTypeXProductProperty]'
GO
ALTER TABLE [dbo].[bvc_ProductTypeXProductProperty] ADD
[Id] [bigint] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_bvc_ProductTypeXProductProperty] on [dbo].[bvc_ProductTypeXProductProperty]'
GO
ALTER TABLE [dbo].[bvc_ProductTypeXProductProperty] ADD CONSTRAINT [PK_bvc_ProductTypeXProductProperty] PRIMARY KEY CLUSTERED  ([Id])
GO
PRINT N'Creating index [IX_ProductTypePropertiesTypeBvin] on [dbo].[bvc_ProductTypeXProductProperty]'
GO
CREATE NONCLUSTERED INDEX [IX_ProductTypePropertiesTypeBvin] ON [dbo].[bvc_ProductTypeXProductProperty] ([ProductTypeBvin])
GO
PRINT N'Creating index [IX_bvc_ProductTypeXProductProperty_PropertyId] on [dbo].[bvc_ProductTypeXProductProperty]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductTypeXProductProperty_PropertyId] ON [dbo].[bvc_ProductTypeXProductProperty] ([PropertyId])
GO
PRINT N'Creating index [IX_bvc_ProductTypeXProductProperty_StoreId] on [dbo].[bvc_ProductTypeXProductProperty]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductTypeXProductProperty_StoreId] ON [dbo].[bvc_ProductTypeXProductProperty] ([StoreId])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_ProductFileXProduct]'
GO
ALTER TABLE [dbo].[bvc_ProductFileXProduct] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_ProductFileXProduct_bvc_ProductFile] FOREIGN KEY ([ProductFileId]) REFERENCES [dbo].[bvc_ProductFile] ([bvin]) ON DELETE CASCADE ON UPDATE CASCADE
GO
PRINT N'Adding foreign keys to [dbo].[bvc_ProductPropertyValue]'
GO
ALTER TABLE [dbo].[bvc_ProductPropertyValue] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_ProductPropertyValue_bvc_Product] FOREIGN KEY ([ProductBvin]) REFERENCES [dbo].[bvc_Product] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_ProductTypeXProductProperty]'
GO
ALTER TABLE [dbo].[bvc_ProductTypeXProductProperty] WITH NOCHECK ADD
CONSTRAINT [FK_ProductTypeProperties_ProductType] FOREIGN KEY ([ProductTypeBvin]) REFERENCES [dbo].[bvc_ProductType] ([bvin])
GO
