/* BV Commerce 6.0.3 to 6.0.7 Schema Script */

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
PRINT N'Dropping foreign keys from [dbo].[bvc_ProductInventory]'
GO
ALTER TABLE [dbo].[bvc_ProductInventory] DROP
CONSTRAINT [FK_bvc_ProductInventory_bvc_Product]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[bvc_ProductXCategory]'
GO
ALTER TABLE [dbo].[bvc_ProductXCategory] DROP
CONSTRAINT [FK_ProductXCategory_bvc_Product],
CONSTRAINT [FK_ProductXCategory_bvc_Category]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_ProductInventory]'
GO
ALTER TABLE [dbo].[bvc_ProductInventory] DROP CONSTRAINT [PK_bvc_ProductInventory]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_ProductInventory]'
GO
ALTER TABLE [dbo].[bvc_ProductInventory] DROP CONSTRAINT [DF_bvc_ProductInventory_VariantId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_ProductInventory]'
GO
ALTER TABLE [dbo].[bvc_ProductInventory] DROP CONSTRAINT [DF_bvc_ProductInventory_StoreId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_ProductXCategory]'
GO
ALTER TABLE [dbo].[bvc_ProductXCategory] DROP CONSTRAINT [PK_bvc_ProductXCategory]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_ProductCrossSell]'
GO
ALTER TABLE [dbo].[bvc_ProductCrossSell] DROP CONSTRAINT [PK_bvc_ProductCrossSell]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_ProductCrossSell]'
GO
ALTER TABLE [dbo].[bvc_ProductCrossSell] DROP CONSTRAINT [DF_bvc_ProductCrossSell_StoreId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_ProductUpSell]'
GO
ALTER TABLE [dbo].[bvc_ProductUpSell] DROP CONSTRAINT [PK_bvc_ProductUpSell]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_ProductUpSell]'
GO
ALTER TABLE [dbo].[bvc_ProductUpSell] DROP CONSTRAINT [DF_bvc_ProductUpSell_StoreId]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [IX_bvc_ProductInventory] from [dbo].[bvc_ProductInventory]'
GO
DROP INDEX [IX_bvc_ProductInventory] ON [dbo].[bvc_ProductInventory]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [IX_bvc_ProductCrossSell] from [dbo].[bvc_ProductCrossSell]'
GO
DROP INDEX [IX_bvc_ProductCrossSell] ON [dbo].[bvc_ProductCrossSell]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [IX_bvc_ProductUpSell] from [dbo].[bvc_ProductUpSell]'
GO
DROP INDEX [IX_bvc_ProductUpSell] ON [dbo].[bvc_ProductUpSell]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Category_All_d]'
GO
DROP PROCEDURE [dbo].[bvc_Category_All_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Category_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_Category_All_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductUpSell_ByProductId_d]'
GO
DROP PROCEDURE [dbo].[bvc_ProductUpSell_ByProductId_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Category_AllVisible_s]'
GO
DROP PROCEDURE [dbo].[bvc_Category_AllVisible_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductUpSell_Count_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductUpSell_Count_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Category_ByType_s]'
GO
DROP PROCEDURE [dbo].[bvc_Category_ByType_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Category_ForMenu_s]'
GO
DROP PROCEDURE [dbo].[bvc_Category_ForMenu_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Category_i]'
GO
DROP PROCEDURE [dbo].[bvc_Category_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductUpSell_ByProduct_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductUpSell_ByProduct_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Product_ByCrossSellId_Admin_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_ByCrossSellId_Admin_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Category_Neighbors_s]'
GO
DROP PROCEDURE [dbo].[bvc_Category_Neighbors_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_PriceGroup_u]'
GO
DROP PROCEDURE [dbo].[bvc_PriceGroup_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Category_s]'
GO
DROP PROCEDURE [dbo].[bvc_Category_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Category_u]'
GO
DROP PROCEDURE [dbo].[bvc_Category_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Category_VisibleNeighbors_s]'
GO
DROP PROCEDURE [dbo].[bvc_Category_VisibleNeighbors_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_PriceGroup_s]'
GO
DROP PROCEDURE [dbo].[bvc_PriceGroup_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Category_AllProducts_d]'
GO
DROP PROCEDURE [dbo].[bvc_Category_AllProducts_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Product_ByUpSellId_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_ByUpSellId_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Address_u]'
GO
DROP PROCEDURE [dbo].[bvc_Address_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_PriceGroup_i]'
GO
DROP PROCEDURE [dbo].[bvc_PriceGroup_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Address_s]'
GO
DROP PROCEDURE [dbo].[bvc_Address_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Product_Categories_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_Categories_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_PriceGroup_d]'
GO
DROP PROCEDURE [dbo].[bvc_PriceGroup_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Address_i]'
GO
DROP PROCEDURE [dbo].[bvc_Address_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Product_ByCrossSellId_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_ByCrossSellId_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Address_d]'
GO
DROP PROCEDURE [dbo].[bvc_Address_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductCrossSell_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductCrossSell_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductCrossSell_i]'
GO
DROP PROCEDURE [dbo].[bvc_ProductCrossSell_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Address_ByType_s]'
GO
DROP PROCEDURE [dbo].[bvc_Address_ByType_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Address_ByUserId_s]'
GO
DROP PROCEDURE [dbo].[bvc_Address_ByUserId_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Product_ByUpSellId_Admin_s]'
GO
DROP PROCEDURE [dbo].[bvc_Product_ByUpSellId_Admin_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductUpSell_u]'
GO
DROP PROCEDURE [dbo].[bvc_ProductUpSell_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductCrossSell_d]'
GO
DROP PROCEDURE [dbo].[bvc_ProductCrossSell_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Address_ByUserID_d]'
GO
DROP PROCEDURE [dbo].[bvc_Address_ByUserID_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductUpSell_i]'
GO
DROP PROCEDURE [dbo].[bvc_ProductUpSell_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_PriceGroup_All_s]'
GO
DROP PROCEDURE [dbo].[bvc_PriceGroup_All_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductUpSell_d]'
GO
DROP PROCEDURE [dbo].[bvc_ProductUpSell_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductCrossSell_Count_Admin_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductCrossSell_Count_Admin_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductCrossSell_Count_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductCrossSell_Count_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductCrossSell_ByProduct_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductCrossSell_ByProduct_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Category_d]'
GO
DROP PROCEDURE [dbo].[bvc_Category_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductCrossSell_ByProductId_d]'
GO
DROP PROCEDURE [dbo].[bvc_ProductCrossSell_ByProductId_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductCrossSell]'
GO
DROP TABLE [dbo].[bvc_ProductCrossSell]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductUpSell_Count_Admin_s]'
GO
DROP PROCEDURE [dbo].[bvc_ProductUpSell_Count_Admin_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_ProductUpSell]'
GO
DROP TABLE [dbo].[bvc_ProductUpSell]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Category_ForProduct_s]'
GO
DROP PROCEDURE [dbo].[bvc_Category_ForProduct_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_Category_BySlug_s]'
GO
DROP PROCEDURE [dbo].[bvc_Category_BySlug_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[ecommrc_StoresXUsers]'
GO
ALTER TABLE [dbo].[ecommrc_StoresXUsers] ADD
[AccessMode] [int] NOT NULL CONSTRAINT [DF_ecommrc_StoresXUsers_AccessMode] DEFAULT ((1))
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PageVersions]'
GO
CREATE TABLE [dbo].[PageVersions]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[PageId] [nvarchar] (max) NOT NULL,
[AdminName] [nvarchar] (max) NOT NULL,
[AvailableScheduleId] [bigint] NOT NULL,
[AvailableStartDateUtc] [datetime] NOT NULL,
[AvailableEndDateUtc] [nvarchar] (max) NOT NULL,
[SerializedContent] [nvarchar] (max) NOT NULL,
[PublishedStatus] [int] NOT NULL,
[bvc_Category_bvin] [varchar] (36) NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_PageVersions] on [dbo].[PageVersions]'
GO
ALTER TABLE [dbo].[PageVersions] ADD CONSTRAINT [PK_PageVersions] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_FK_bvc_CategoryPageVersion] on [dbo].[PageVersions]'
GO
CREATE NONCLUSTERED INDEX [IX_FK_bvc_CategoryPageVersion] ON [dbo].[PageVersions] ([bvc_Category_bvin])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductXCategory]'
GO
ALTER TABLE [dbo].[bvc_ProductXCategory] ADD
[Id] [bigint] NOT NULL IDENTITY(1, 1)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_bvc_ProductXCategory] on [dbo].[bvc_ProductXCategory]'
GO
ALTER TABLE [dbo].[bvc_ProductXCategory] ADD CONSTRAINT [PK_bvc_ProductXCategory] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_ProductXCategory] on [dbo].[bvc_ProductXCategory]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductXCategory] ON [dbo].[bvc_ProductXCategory] ([CategoryId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Rebuilding [dbo].[bvc_ProductInventory]'
GO
CREATE TABLE [dbo].[tmp_rg_xx_bvc_ProductInventory]
(
[bvin] [varchar] (36) NOT NULL,
[ProductBvin] [varchar] (36) NOT NULL,
[VariantId] [nvarchar] (max) NOT NULL CONSTRAINT [DF_bvc_ProductInventory_VariantId] DEFAULT (''),
[QuantityOnHand] [int] NOT NULL CONSTRAINT [DF_bvc_ProductInventory_QuantityOnHand] DEFAULT ((0)),
[QuantityReserved] [int] NOT NULL CONSTRAINT [DF_bvc_ProductInventory_QuantityReserved] DEFAULT ((0)),
[QuantityAvailableForSale] AS ([QuantityOnHand]-[QuantityReserved]) PERSISTED,
[LowStockPoint] [int] NOT NULL CONSTRAINT [DF_bvc_ProductInventory_LowStockPoint] DEFAULT ((0)),
[LastUpdated] [datetime] NOT NULL,
[StoreId] [bigint] NOT NULL CONSTRAINT [DF_bvc_ProductInventory_StoreId] DEFAULT ((0))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
INSERT INTO [dbo].[tmp_rg_xx_bvc_ProductInventory]([bvin], [ProductBvin], [VariantId], [QuantityOnHand], [QuantityReserved], [LowStockPoint], [LastUpdated], [StoreId]) SELECT [bvin], [ProductBvin], [VariantId], [QuantityOnHand], [QuantityReserved], [LowStockPoint], [LastUpdated], [StoreId] FROM [dbo].[bvc_ProductInventory]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
DROP TABLE [dbo].[bvc_ProductInventory]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_rename N'[dbo].[tmp_rg_xx_bvc_ProductInventory]', N'bvc_ProductInventory'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_bvc_ProductInventory] on [dbo].[bvc_ProductInventory]'
GO
ALTER TABLE [dbo].[bvc_ProductInventory] ADD CONSTRAINT [PK_bvc_ProductInventory] PRIMARY KEY CLUSTERED  ([bvin])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_ProductInventory] on [dbo].[bvc_ProductInventory]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductInventory] ON [dbo].[bvc_ProductInventory] ([ProductBvin])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_UserAccount_d]'
GO



ALTER PROCEDURE [dbo].[bvc_UserAccount_d]

@bvin varchar(36),
@StoreId bigint

AS

	BEGIN TRY

		BEGIN TRANSACTION


			/*DELETE FROM bvc_WishList WHERE UserID=@bvin
			SELECT @err = @@error IF @err <> 0 BEGIN ROLLBACK TRANSACTION RETURN @err END*/

			/*DELETE FROM bvc_SecurityToken WHERE UserID=@bvin
			SELECT @err = @@error IF @err <> 0 BEGIN ROLLBACK TRANSACTION RETURN @err END*/
							
			DELETE FROM bvc_UserXContact WHERE UserId=@bvin and StoreId=@StoreId

			DELETE FROM bvc_User WHERE bvin=@bvin and StoreId=@StoreId
			
	   COMMIT

	   RETURN 
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_UserAccount_s]'
GO

ALTER PROCEDURE [dbo].[bvc_UserAccount_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY	
		SELECT bvin,[Password],[Firstname],[LastName],Salt,
		TaxExempt,Email,CreationDate,LastLoginDate,Comment,AddressBook,LastUpdated,
		Locked,LockedUntil,FailedLoginCount,Phones,PricingGroup,CustomQuestionAnswers,
		 StoreId
		FROM bvc_User Where bvin=@bvin and StoreId=@StoreId		

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Product_SuggestedItems]'
GO
ALTER PROCEDURE [dbo].[bvc_Product_SuggestedItems]

@MaxResults bigint,
@bvin varchar(36),
@StoreId bigint

AS

	BEGIN TRY				
		BEGIN
			SELECT TOP(@MaxResults)
				a.ProductID, SUM(a.Quantity) AS "Total Ordered"
				FROM 
				(
					SELECT 
						p.bvin AS ProductID, 
						Quantity
					FROM bvc_LineItem l
					JOIN bvc_Order o on l.OrderBvin = o.bvin 
					JOIN bvc_Product p ON p.bvin = l.ProductId
					WHERE o.IsPlaced = 1 AND p.IsAvailableForSale = 1
					 and p.StoreId=@StoreId
					 and p.bvin <> @bvin
					AND	OrderBvin IN
					(SELECT OrderBvin
						FROM bvc_LineItem
						WHERE ProductID = @bvin and StoreId=@StoreId)
				) AS a
				GROUP BY a.ProductID
				ORDER BY SUM(a.Quantity) DESC			
		END		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


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
			DELETE bvc_SaleXProduct WHERE ProductID=@bvin and StoreId=@StoreId
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
PRINT N'Altering [dbo].[bvc_Product_All_d]'
GO

ALTER PROCEDURE [dbo].[bvc_Product_All_d]

@StoreId bigint

AS

BEGIN
	DECLARE @err int

	DECLARE @Ids2 Table (
		ProductId varchar(36)
	)

	BEGIN TRY
	
		BEGIN TRANSACTION
						
			--declare cursor for use below
			DECLARE @currbvinproduct varchar(36)
			DECLARE bvinproduct_cursor CURSOR LOCAL
				FOR SELECT * FROM @Ids2
			
			BEGIN
				--delete out all of our product choices
				INSERT INTO @Ids2 SELECT DISTINCT bvin FROM bvc_Product WHERE StoreId=@StoreId
				OPEN bvinproduct_cursor
				FETCH NEXT FROM bvinproduct_cursor	INTO @currbvinproduct
		
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC bvc_Product_d @currbvinproduct, @StoreId
					FETCH NEXT FROM bvinproduct_cursor	INTO @currbvinproduct
				END
				CLOSE bvinproduct_cursor
				DEALLOCATE bvinproduct_cursor

				DELETE bvc_ProductPropertyValue WHERE StoreId=@StoreId
				DELETE bvc_ProductFile WHERE StoreId=@StoreId
				
			END
					
			COMMIT
	END TRY

	BEGIN CATCH
		--cursor cleanup
		IF CURSOR_STATUS('local', 'bvinproduct_cursor') > -1
			CLOSE bvinproduct_cursor
		
		IF CURSOR_STATUS('local', 'bvinproduct_cursor') = -1
			DEALLOCATE bvinproduct_cursor

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
PRINT N'Creating [dbo].[bvc_ProductRelationships]'
GO
CREATE TABLE [dbo].[bvc_ProductRelationships]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[ProductId] [nvarchar] (36) NOT NULL,
[RelatedProductId] [nvarchar] (36) NOT NULL,
[IsSubstitute] [bit] NOT NULL CONSTRAINT [DF_bvc_ProductRelationships_IsSubtitute] DEFAULT ((0)),
[SortOrder] [int] NOT NULL CONSTRAINT [DF_bvc_ProductRelationships_SortOrder] DEFAULT ((0)),
[MarketingDescription] [nvarchar] (max) NOT NULL,
[StoreId] [bigint] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_bvc_ProductRelationships] on [dbo].[bvc_ProductRelationships]'
GO
ALTER TABLE [dbo].[bvc_ProductRelationships] ADD CONSTRAINT [PK_bvc_ProductRelationships] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_ProductRelationships_ProductId] on [dbo].[bvc_ProductRelationships]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductRelationships_ProductId] ON [dbo].[bvc_ProductRelationships] ([ProductId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_ProductRelationships_RelatedProductId] on [dbo].[bvc_ProductRelationships]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductRelationships_RelatedProductId] ON [dbo].[bvc_ProductRelationships] ([RelatedProductId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_Promotions]'
GO
CREATE TABLE [dbo].[bvc_Promotions]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[LastUpdatedUtc] [datetime] NOT NULL,
[Name] [nvarchar] (255) NOT NULL,
[StoreId] [bigint] NOT NULL,
[StartDateUtc] [datetime] NOT NULL,
[EndDateUtc] [datetime] NOT NULL,
[IsEnabled] [bit] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_bvc_Promotions] on [dbo].[bvc_Promotions]'
GO
ALTER TABLE [dbo].[bvc_Promotions] ADD CONSTRAINT [PK_bvc_Promotions] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_Promotions_StoreId] on [dbo].[bvc_Promotions]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_Promotions_StoreId] ON [dbo].[bvc_Promotions] ([StoreId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[bvc_ProductInventory]'
GO
ALTER TABLE [dbo].[bvc_ProductInventory] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_ProductInventory_bvc_Product] FOREIGN KEY ([ProductBvin]) REFERENCES [dbo].[bvc_Product] ([bvin])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[bvc_ProductXCategory]'
GO
ALTER TABLE [dbo].[bvc_ProductXCategory] WITH NOCHECK ADD
CONSTRAINT [FK_ProductXCategory_bvc_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[bvc_Product] ([bvin]),
CONSTRAINT [FK_ProductXCategory_bvc_Category] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[bvc_Category] ([bvin])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[PageVersions]'
GO
ALTER TABLE [dbo].[PageVersions] ADD
CONSTRAINT [FK_bvc_CategoryPageVersion] FOREIGN KEY ([bvc_Category_bvin]) REFERENCES [dbo].[bvc_Category] ([bvin]) ON DELETE CASCADE
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
