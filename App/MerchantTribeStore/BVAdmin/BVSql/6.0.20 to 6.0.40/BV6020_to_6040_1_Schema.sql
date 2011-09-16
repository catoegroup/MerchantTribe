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
PRINT N'Dropping constraints from [dbo].[bvc_Variants]'
GO
ALTER TABLE [dbo].[bvc_Variants] DROP CONSTRAINT [PK_bvc_Variant]
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
PRINT N'Dropping index [IX_bvc_ProductReview] from [dbo].[bvc_ProductReview]'
GO
DROP INDEX [IX_bvc_ProductReview] ON [dbo].[bvc_ProductReview]
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
PRINT N'Dropping [dbo].[bvc_ShippingMethod_s]'
GO
DROP PROCEDURE [dbo].[bvc_ShippingMethod_s]
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
PRINT N'Dropping [dbo].[bvc_ShippingMethod_d]'
GO
DROP PROCEDURE [dbo].[bvc_ShippingMethod_d]
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
PRINT N'Altering [dbo].[bvc_AffiliateReferral]'
GO
ALTER TABLE [dbo].[bvc_AffiliateReferral] ALTER COLUMN [TimeOfReferralUtc] [datetime] NOT NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_MailingListMember]'
GO
ALTER TABLE [dbo].[bvc_MailingListMember] ALTER COLUMN [FirstName] [nvarchar] (255) NOT NULL
ALTER TABLE [dbo].[bvc_MailingListMember] ALTER COLUMN [LastName] [nvarchar] (255) NOT NULL
ALTER TABLE [dbo].[bvc_MailingListMember] ALTER COLUMN [LastUpdatedUtc] [datetime] NOT NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_MailingList]'
GO
ALTER TABLE [dbo].[bvc_MailingList] ALTER COLUMN [Name] [nvarchar] (255) NOT NULL
ALTER TABLE [dbo].[bvc_MailingList] ALTER COLUMN [LastUpdatedUtc] [datetime] NOT NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Promotions]'
GO
ALTER TABLE [dbo].[bvc_Promotions] ALTER COLUMN [CustomerDescription] [nvarchar] (255) NOT NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_OrderCoupon]'
GO
ALTER TABLE [dbo].[bvc_OrderCoupon] ALTER COLUMN [IsUsed] [bit] NOT NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_OrderPackage]'
GO
ALTER TABLE [dbo].[bvc_OrderPackage] ALTER COLUMN [LastUpdatedUtc] [datetime] NOT NULL
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
PRINT N'Adding constraints to [dbo].[bvc_AffiliateReferral]'
GO
ALTER TABLE [dbo].[bvc_AffiliateReferral] ADD CONSTRAINT [DF_bvc_AffiliateReferral_TimeOfReferralUtc] DEFAULT ('2011-01-01') FOR [TimeOfReferralUtc]
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
ALTER TABLE [dbo].[bvc_MailingList] ADD CONSTRAINT [DF_bvc_MailingList_LastUpdatedUtc] DEFAULT ('2001-01-01 00:00') FOR [LastUpdatedUtc]
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
ALTER TABLE [dbo].[bvc_MailingListMember] ADD CONSTRAINT [DF_bvc_MailingListMember_LastUpdatedUtc] DEFAULT ('2001-01-01') FOR [LastUpdatedUtc]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding constraints to [dbo].[bvc_OrderCoupon]'
GO
ALTER TABLE [dbo].[bvc_OrderCoupon] ADD CONSTRAINT [DF_bvc_OrderCoupon_IsUsed] DEFAULT ((0)) FOR [IsUsed]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding constraints to [dbo].[bvc_OrderPackage]'
GO
ALTER TABLE [dbo].[bvc_OrderPackage] ADD CONSTRAINT [DF_bvc_OrderPackage_LastUpdatedUtc] DEFAULT ('2011-01-01') FOR [LastUpdatedUtc]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding constraints to [dbo].[bvc_Promotions]'
GO
ALTER TABLE [dbo].[bvc_Promotions] ADD CONSTRAINT [DF_bvc_Promotions_CustomerDescription] DEFAULT ('') FOR [CustomerDescription]
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
