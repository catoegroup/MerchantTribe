/*
Run this script on:

        ..raw607    -  This database will be modified

to synchronize it with:

        ..commerce6

You are recommended to back up your database before running this script

Script created by SQL Compare version 8.2.0 from Red Gate Software Ltd at 11/22/2010 3:03:50 PM

*/
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
PRINT N'Creating [dbo].[ecommrc_StoreDomains]'
GO
CREATE TABLE [dbo].[ecommrc_StoreDomains]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[StoreId] [bigint] NOT NULL,
[DomainName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ecommrc_StoreDomains] on [dbo].[ecommrc_StoreDomains]'
GO
ALTER TABLE [dbo].[ecommrc_StoreDomains] ADD CONSTRAINT [PK_ecommrc_StoreDomains] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_ecommrc_StoreDomains_StoreId] on [dbo].[ecommrc_StoreDomains]'
GO
CREATE NONCLUSTERED INDEX [IX_ecommrc_StoreDomains_StoreId] ON [dbo].[ecommrc_StoreDomains] ([StoreId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_ecommrc_StoreDomains_DomainName] on [dbo].[ecommrc_StoreDomains]'
GO
CREATE NONCLUSTERED INDEX [IX_ecommrc_StoreDomains_DomainName] ON [dbo].[ecommrc_StoreDomains] ([DomainName])
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
