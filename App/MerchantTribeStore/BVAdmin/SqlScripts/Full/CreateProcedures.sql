SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
PRINT N'Creating [dbo].[ecommrc_GenerateOrderNumber]'
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ecommrc_GenerateOrderNumber]

@storeid bigint

AS

	BEGIN TRY		
		BEGIN TRAN
		
		DECLARE @OrderNumberSeed bigint
		DECLARE @MaxOrderNumber bigint
			
		SET @OrderNumberSeed = (SELECT CAST(COALESCE(SettingValue,0) AS bigint) 
			FROM ecommrc_StoreSettings WITH (UPDLOCK) WHERE SettingName = 'LastOrderNumber'
			AND StoreId=@storeid)
				
		--SET @MaxOrderNumber = (SELECT COALESCE(MAX(OrderNumber), -1) FROM bvc_Order)
		--IF @OrderNumberSeed < @MaxOrderNumber
		--		SET @OrderNumberSeed = @MaxOrderNumber
				
		SET @OrderNumberSeed = @OrderNumberSeed + 1
		
		UPDATE ecommrc_StoreSettings SET SettingValue = @OrderNumberSeed 
			WHERE SettingName = 'LastOrderNumber'
			AND StoreId=@storeid
		
		COMMIT
		
		SELECT @OrderNumberSeed	AS OrderNumber	
	END TRY
	BEGIN CATCH
		ROLLBACK
		--EXEC bvc_EventLog_SQL_i
	END CATCH
	


GO

