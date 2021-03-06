SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
PRINT N'Creating [dbo].[bvc_EventLog_SQL_i]'
GO


CREATE PROCEDURE [dbo].[bvc_EventLog_SQL_i]
AS
	
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = 'procedure: ' + ERROR_PROCEDURE() + ' line: ' + CAST(ERROR_LINE() AS varchar(8)) + ' ' + ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),		
        @ErrorState = ERROR_STATE();

	IF @ErrorState = 0
	BEGIN
		SET @ErrorState = 1
	END

    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );

--	INSERT INTO
--	bvc_EventLog (bvin,EventTime,Source,Message,severity,LastUpdated)
--	VALUES(NewID(),GetUtcDate(),ERROR_PROCEDURE() + ' line:' + CAST(ERROR_LINE() AS varchar(8)),CAST(ERROR_NUMBER() AS varchar(8)) + ' ' + CAST(ERROR_STATE() AS varchar(8)) +
--	' ' + ERROR_MESSAGE(), ERROR_SEVERITY(),GetUtcDate())	

	RETURN

GO




PRINT N'Creating [dbo].[bvc_WebAppSetting_s]'
GO


CREATE PROCEDURE [dbo].[bvc_WebAppSetting_s]

@SettingName nvarchar(255)

AS
	BEGIN TRY
		SELECT SettingName,SettingValue FROM bvc_WebAppSetting WHERE
		SettingName=@SettingName
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_RewardsPoints_Capture_u]'
GO




CREATE PROCEDURE [dbo].[bvc_RewardsPoints_Capture_u]
@bvin varchar(36),
@amount int,
@StoreId bigint

AS	
	BEGIN TRY
		DECLARE @succeeded bit
		DECLARE @CurrentAmount int
		SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
		BEGIN TRANSACTION
			SET @CurrentAmount = (SELECT Sum(PointsHeld) from bvc_RewardsPoints WHERE UserId = @bvin and StoreId=@StoreId);
			IF @CurrentAmount - @amount >= 0
			BEGIN
				INSERT INTO bvc_RewardsPoints (UserId, Points, PointsHeld, TransactionTime, StoreId)
				VALUES(@bvin, 0, -1 * @amount, GETUTCDATE(), @StoreId)				
				SET @succeeded = 1
			END
			ELSE
			BEGIN
				SET @succeeded = 0
			END			
		COMMIT TRANSACTION		
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	RETURN @succeeded
















GO
PRINT N'Creating [dbo].[bvc_WebAppSetting_u]'
GO


CREATE PROCEDURE [dbo].[bvc_WebAppSetting_u]

@SettingName nvarchar(255),
@SettingValue text

AS

	BEGIN TRY
		DECLARE @c int
		SET @c = ( SELECT COUNT(SettingName) FROM bvc_WebAppSetting WHERE SettingName=@SettingName)

		if @c < 1
			INSERT INTO bvc_WebAppSetting(SettingName,SettingValue) VALUES (@SettingName,@SettingValue)
		ELSE
			UPDATE bvc_WebAppSetting SET SettingValue=@SettingValue WHERE SettingName=@SettingName
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_RewardsPoints_DecAmt_u]'
GO




CREATE PROCEDURE [dbo].[bvc_RewardsPoints_DecAmt_u]
@bvin varchar(36),
@amount int,
@StoreId bigint

AS
	BEGIN TRY
		DECLARE @succeeded bit
		DECLARE @CurrentAmount int
		SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
		BEGIN TRANSACTION
			SET @CurrentAmount = (SELECT SUM(Points) FROM bvc_RewardsPoints WHERE UserId = @bvin and StoreId=@StoreId);
			IF @CurrentAmount - @amount >= 0
			BEGIN
				INSERT INTO bvc_RewardsPoints (UserId, Points, PointsHeld, TransactionTime, StoreId)
				VALUES(@bvin, -1 * @amount,0, GETUTCDATE(), @StoreId)								
				SET @succeeded = 1
			END
			ELSE
			BEGIN
				SET @succeeded = 0
			END			
		COMMIT TRANSACTION		
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	RETURN @succeeded
















GO
PRINT N'Creating [dbo].[bvc_RewardsPoints_Hold_u]'
GO




CREATE PROCEDURE [dbo].[bvc_RewardsPoints_Hold_u]
@bvin varchar(36),
@amount int,
@StoreId bigint

AS
	BEGIN TRY
		DECLARE @CurrentAmount int
		DECLARE @succeeded bit
		SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
		BEGIN TRANSACTION
			SET @CurrentAmount = (SELECT SUM(Points) FROM bvc_RewardsPoints WHERE UserId = @bvin and StoreId=@StoreId);
			IF @CurrentAmount - @amount >= 0
			BEGIN
				INSERT INTO bvc_RewardsPoints (UserId, Points, PointsHeld, TransactionTime, StoreId)
				VALUES(@bvin, -1 * @amount, @amount, GETUTCDATE(), @StoreId)								
				SET @succeeded = 1
			END
			ELSE
			BEGIN
				SET @succeeded = 0
			END			
		COMMIT TRANSACTION		
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	RETURN @succeeded
















GO
PRINT N'Creating [dbo].[bvc_RewardsPoints_UnHold_u]'
GO





CREATE PROCEDURE [dbo].[bvc_RewardsPoints_UnHold_u]
@bvin varchar(36),
@amount int,
@StoreId bigint

AS
	BEGIN TRY
		DECLARE @CurrentAmount int
		DECLARE @succeeded bit
		SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
		BEGIN TRANSACTION
			SET @CurrentAmount = (SELECT SUM(PointsHeld) FROM bvc_RewardsPoints WHERE UserId = @bvin and StoreId=@StoreId);
			IF @CurrentAmount - @amount >= 0
			BEGIN			
				INSERT INTO bvc_RewardsPoints (UserId, Points, PointsHeld, TransactionTime, StoreId)
				VALUES(@bvin, @amount,-1 *  @amount, GETUTCDATE(), @StoreId)												
				SET @succeeded = 1
			END
			ELSE
			BEGIN
				SET @succeeded = 0
			END			
		COMMIT TRANSACTION		
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	RETURN @succeeded

















GO
PRINT N'Creating [dbo].[bvc_RewardsPoints_IncAmt_u]'
GO



CREATE PROCEDURE [dbo].[bvc_RewardsPoints_IncAmt_u]
@bvin varchar(36),
@amount int,
@StoreId bigint

AS
	BEGIN TRY		
		DECLARE @succeeded bit
		SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
		BEGIN TRANSACTION
			BEGIN
				INSERT INTO bvc_RewardsPoints (UserId, Points, PointsHeld, TransactionTime, StoreId)
				VALUES(@bvin, @amount,0, GETUTCDATE(), @StoreId)	
				SET @succeeded = 1
			END		
		COMMIT TRANSACTION		
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	RETURN @succeeded
















GO
PRINT N'Creating [dbo].[bvc_WebAppSettings_s]'
GO


CREATE PROCEDURE [dbo].[bvc_WebAppSettings_s]

AS
	BEGIN TRY
		SELECT SettingName,SettingValue FROM bvc_WebAppSetting
		ORDER BY SettingName
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_RewardsPoints_TotalIssued_s]'
GO





CREATE PROCEDURE [dbo].[bvc_RewardsPoints_TotalIssued_s]
@StoreId bigint

AS
	BEGIN TRY
		Select SUM(Points) from bvc_RewardsPoints where StoreId=@StoreId
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH

















GO
PRINT N'Creating [dbo].[bvc_RewardsPoints_TotalReserved_s]'
GO





CREATE PROCEDURE [dbo].[bvc_RewardsPoints_TotalReserved_s]
@StoreId bigint

AS
	BEGIN TRY
		Select SUM(PointsHeld) from bvc_RewardsPoints where StoreId=@StoreId
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH

















GO
PRINT N'Creating [dbo].[bvc_RewardsPoints_AvailableForUser_s]'
GO






CREATE PROCEDURE [dbo].bvc_RewardsPoints_AvailableForUser_s
@UserId nvarchar(50),
@StoreId bigint

AS
	BEGIN TRY
		Select SUM(Points) from bvc_RewardsPoints where UserId=@UserId AND StoreId=@StoreId
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH


















GO
PRINT N'Creating [dbo].[bvc_RewardsPoints_HeldForUser_s]'
GO






CREATE PROCEDURE [dbo].[bvc_RewardsPoints_HeldForUser_s]
@UserId nvarchar(50),
@StoreId bigint

AS
	BEGIN TRY
		Select SUM(PointsHeld) from bvc_RewardsPoints where UserId=@UserId AND StoreId=@StoreId
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	RETURN 1
	


















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
PRINT N'Creating [dbo].[bvc_ProductOption_Shared_s ]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductOption_Shared_s ]
	@StoreId bigint
AS
BEGIN
	BEGIN TRY
		SELECT bvin, StoreId, OptionType, Name, NameIsHidden, IsVariant, IsShared, Settings		
		FROM bvc_ProductOptions
		WHERE IsShared = 1  and StoreId=@StoreId
		ORDER BY Name
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END
























GO
PRINT N'Creating [dbo].[bvc_ProductOption_ByProduct_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductOption_ByProduct_s]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36),
	@StoreId bigint
AS
BEGIN
	BEGIN TRY
		SELECT bvin, opt.StoreId, OptionType, Name, NameIsHidden, IsVariant, IsShared, Settings
		FROM bvc_ProductOptions opt JOIN bvc_ProductXOption x ON
		opt.bvin = x.OptionBvin
		WHERE (@StoreId = -1 OR opt.StoreId=@StoreId) AND x.ProductBvin = @bvin
		Order By x.SortOrder
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END



























GO
PRINT N'Creating [dbo].[bvc_ProductOption_u ]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductOption_u ]
	@bvin varchar(36), 
	@StoreId bigint,
	@OptionType int,
	@Name nvarchar(255),
	@NameIsHidden bit,
	@IsVariant bit,
	@IsShared bit,
	@Settings nvarchar(Max)
	
AS
BEGIN
	BEGIN TRY				
		BEGIN TRANSACTION	
					
				UPDATE bvc_ProductOptions 
				SET 
				StoreId=@StoreId,
				OptionType=@OptionType,
				Name=@Name,
				NameIsHidden=@NameIsHidden,
				IsVariant=@IsVariant,
				IsShared=@IsShared,
				Settings=@Settings
				Where Bvin = @bvin and StoreId=@StoreId
								
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION		

		EXEC bvc_EventLog_SQL_i
	END CATCH
END






























GO
PRINT N'Creating [dbo].[bvc_ProductOption_s ]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductOption_s ]
	@bvin varchar(36),
	@StoreId bigint
AS
BEGIN
	BEGIN TRY
		SELECT bvin, StoreId, OptionType, Name, NameIsHidden, IsVariant, IsShared, Settings
		FROM bvc_ProductOptions WHERE bvin = @bvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END























GO
PRINT N'Creating [dbo].[bvc_ProductOption_RemoveFromProduct_d ]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductOption_RemoveFromProduct_d ]	
	@ProductBvin varchar(36),
	@OptionBvin varchar(36),
	@StoreId bigint
AS
BEGIN
	BEGIN TRY	
		DELETE FROM bvc_ProductXOption WHERE OptionBvin = @OptionBvin AND ProductBvin = @ProductBvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN
END





















GO
PRINT N'Creating [dbo].[bvc_ProductOption_i ]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductOption_i ]
	@bvin varchar(36), 
	@StoreId bigint,
	@OptionType int,
	@Name nvarchar(255),
	@NameIsHidden bit,
	@IsVariant bit,
	@IsShared bit,
	@Settings nvarchar(Max)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT INTO bvc_ProductOptions 
				(bvin,
				StoreId,
				OptionType, 
				Name, 
				NameIsHidden,				
				IsVariant,
				IsShared,
				Settings)
				VALUES 
				(@bvin,
				@StoreId,
				@OptionType, 
				@Name, 
				@NameIsHidden,				
				@IsVariant,
				@IsShared,
				@Settings)
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION		

		EXEC bvc_EventLog_SQL_i
	END CATCH
END




























GO
PRINT N'Creating [dbo].[bvc_ProductOption_d ]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductOption_d ]	
	@bvin varchar(36),
	@StoreId bigint
AS
BEGIN

	BEGIN TRANSACTION

		BEGIN TRY		

			Delete FROM bvc_ProductXOption WHERE OptionBvin=@bvin and StoreId=@StoreId
			Delete FROM bvc_ProductOptionsItems where OptionBvin=@bvin AND StoreId=@StoreId		
			Delete FROM bvc_ProductOptions WHERE bvin=@bvin
				
			COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
	
		EXEC bvc_EventLog_SQL_i
	END CATCH	
END

























GO
PRINT N'Creating [dbo].[bvc_ProductOptionItem_u ]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductOptionItem_u ]
	@bvin varchar(36), 
	@StoreId bigint,
	@OptionBvin varchar(36),	
	@Name nvarchar(255),
	@PriceAdjustment decimal(18,10),
	@WeightAdjustment decimal (18,10),
	@IsLabel bit,
	@SortOrder int
	
AS
BEGIN
	BEGIN TRY				
		BEGIN TRANSACTION	
					
				UPDATE bvc_ProductOptionsItems
				SET 
				StoreId=@StoreId,
				OptionBvin=@OptionBvin,
				Name=@Name,
				PriceAdjustment=@PriceAdjustment,
				WeightAdjustment=@WeightAdjustment,
				IsLabel=@IsLabel,
				SortOrder=@SortOrder		
				Where Bvin = @bvin and StoreId=@StoreId
								
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION		

		EXEC bvc_EventLog_SQL_i
	END CATCH
END































GO
PRINT N'Creating [dbo].[bvc_ProductOptionItem_i ]'
GO




CREATE PROCEDURE [dbo].[bvc_ProductOptionItem_i ]
	@bvin varchar(36), 
	@StoreId bigint,
	@OptionBvin varchar(36),	
	@Name nvarchar(255),
	@PriceAdjustment decimal(18,10),
	@WeightAdjustment decimal (18,10),
	@IsLabel bit,
	@SortOrder int = 1
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		
			IF (Select Count(bvin) FROM bvc_ProductOptionsItems WHERE OptionBvin=@OptionBvin) > 0
				BEGIN
					SET @SortOrder = (Select Max(SortOrder) FROM bvc_ProductOptionsItems where OptionBvin=@OptionBvin)+1
				END
			ELSE
				BEGIN
					SET @SortOrder = 1
				END
		
			INSERT INTO bvc_ProductOptionsItems
				(bvin,
				StoreId,
				OptionBvin, 
				Name, 
				PriceAdjustment,
				WeightAdjustment,
				IsLabel,
				SortOrder)
				VALUES 
				(@bvin,
				@StoreId,
				@OptionBvin, 
				@Name, 
				@PriceAdjustment,				
				@WeightAdjustment,
				@IsLabel,
				@SortOrder)
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION		

		EXEC bvc_EventLog_SQL_i
	END CATCH
END





























GO
PRINT N'Creating [dbo].[bvc_ProductOptionItem_s ]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductOptionItem_s ]
	@bvin varchar(36),
	@StoreId bigint
AS
BEGIN
	BEGIN TRY
		SELECT bvin, StoreId, OptionBvin, Name, PriceAdjustment, WeightAdjustment, IsLabel, SortOrder
		FROM bvc_ProductOptionsItems WHERE bvin = @bvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END
























GO
PRINT N'Creating [dbo].[bvc_ProductOptionItem_ByProduct_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductOptionItem_ByProduct_s]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36),
	@StoreId bigint
AS
BEGIN
	BEGIN TRY
		SELECT bvin, StoreId, OptionBvin, Name, PriceAdjustment, WeightAdjustment, IsLabel, SortOrder
		FROM bvc_ProductOptionsItems
		WHERE (@StoreId = -1 OR StoreId=@StoreId) AND OptionBvin in 				
			(Select OptionBvin from bvc_ProductXOption WHERE ProductBvin=@bvin and (@StoreId = -1 OR StoreId=@StoreId))			
		Order by OptionBvin, SortOrder
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END




























GO
PRINT N'Creating [dbo].[bvc_SiteTerm_d]'
GO


CREATE PROCEDURE [dbo].[bvc_SiteTerm_d]

@SiteTerm nvarchar(500)

AS
	BEGIN TRY
		DELETE FROM bvc_SiteTerm WHERE SiteTerm=@SiteTerm
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	RETURN 







GO
PRINT N'Creating [dbo].[bvc_ProductOptionItem_d ]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductOptionItem_d ]	
	@bvin varchar(36),
	@StoreId bigint
AS
BEGIN

	BEGIN TRANSACTION

		BEGIN TRY		

			Delete FROM bvc_ProductOptionsItems where Bvin=@bvin AND StoreId=@StoreId		
				
			COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
	
		EXEC bvc_EventLog_SQL_i
	END CATCH	
END


























GO
PRINT N'Creating [dbo].[bvc_ProductOptionItem_ByOption_s]'
GO




CREATE PROCEDURE [dbo].[bvc_ProductOptionItem_ByOption_s]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36),
	@StoreId bigint
AS
BEGIN
	BEGIN TRY
		SELECT bvin, StoreId, OptionBvin, Name, PriceAdjustment, WeightAdjustment, IsLabel, SortOrder
		FROM bvc_ProductOptionsItems
		WHERE StoreId=@StoreId AND OptionBvin = @bvin 							
		Order by SortOrder
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END





























GO
PRINT N'Creating [dbo].[bvc_ProductOptionItem_SortOrder_u]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductOptionItem_SortOrder_u]

@Id varchar(36),
@SortOrder int,
@StoreId bigint

AS

	BEGIN TRY
		UPDATE bvc_ProductOptionsItems
		SET
		SortOrder=@SortOrder
		WHERE bvin=@Id AND StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

GO
PRINT N'Creating [dbo].[bvc_SiteTerm_i]'
GO


CREATE PROCEDURE [dbo].[bvc_SiteTerm_i]

@SiteTerm nvarchar(255),
@SiteTermValue nvarchar(500)

AS
	BEGIN TRY
		INSERT INTO bvc_SiteTerm (SiteTerm,SiteTermValue)
			VALUES (@SiteTerm,@SiteTermValue)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN 






GO
PRINT N'Creating [dbo].[bvc_ProductXOption_i]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductXOption_i]
@OptionBvin varchar(36),
@ProductBvin varchar(36),
@SortOrder int = 1,
@CurrentCount int = 0,
@StoreId bigint
AS
	BEGIN TRY
		SET @CurrentCount = (SELECT Count(OptionBvin) as c FROM bvc_ProductXOption WHERE ProductBvin=@ProductBvin and StoreId=@StoreId) 
		IF @CurrentCount > 0
			BEGIN
				SET @SortOrder =  (Select Max(SortOrder) as MaxSort FROM bvc_ProductXOption WHERE ProductBvin=@ProductBvin and StoreId=@StoreId)
				SET @SortOrder = @SortOrder + 1
			END
		ELSE
			SET @SortOrder =  1

		/* Select prevents the same option from being added to the same product more than once */			
		If (Select COUNT(OptionBvin) as opt from bvc_ProductXOption WHERE OptionBvin=@OptionBvin AND ProductBvin=@ProductBvin and StoreId=@StoreId) < 1
			BEGIN
				INSERT INTO
				bvc_ProductXOption
				(ProductBvin,OptionBvin,SortOrder,StoreId)
				VALUES(@ProductBvin,@OptionBvin,@SortOrder,@StoreId)
			END
					
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_SiteTerm_All_s]'
GO


CREATE PROCEDURE [dbo].[bvc_SiteTerm_All_s]

AS
	
	BEGIN TRY
		SELECT SiteTerm,SiteTermValue FROM bvc_SiteTerm
		ORDER BY SiteTerm
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN







GO
PRINT N'Creating [dbo].[bvc_ProductXOption_d_all]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductXOption_d_all]
@ProductBvin varchar(36),
@StoreId bigint
AS
	BEGIN TRY
		DELETE FROM bvc_ProductXOption
		WHERE ProductBvin=@ProductBvin and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

GO
PRINT N'Creating [dbo].[bvc_ProductXOption_d]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductXOption_d]
@OptionBvin varchar(36),
@ProductBvin varchar(36),
@StoreId bigint
AS
	BEGIN TRY
		DELETE FROM bvc_ProductXOption
		WHERE OptionBvin=@OptionBvin
		AND ProductBvin=@ProductBvin and StoreId=@StoreId

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

GO
PRINT N'Creating [dbo].[bvc_ProductXOption_SortOrder_u]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductXOption_SortOrder_u]

@OptionBvin varchar(36),
@ProductBvin varchar(36),
@SortOrder int,
@StoreId bigint

AS

	BEGIN TRY
		UPDATE bvc_ProductXOption
		SET
		SortOrder=@SortOrder
		WHERE OptionBvin=@OptionBvin AND ProductBvin=@ProductBvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

GO
PRINT N'Creating [dbo].[bvc_SiteTerm_s]'
GO


CREATE PROCEDURE [dbo].[bvc_SiteTerm_s]

@SiteTerm nvarchar(255)

AS

	BEGIN TRY
		SELECT SiteTerm,SiteTermValue FROM bvc_SiteTerm WHERE
		SiteTerm=@SiteTerm
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	RETURN





GO
PRINT N'Creating [dbo].[bvc_ProductXOption_ByCategory_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductXOption_ByCategory_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT OptionBvin,ProductBvin,SortOrder,StoreId
		FROM bvc_ProductXOption
		WHERE ProductBvin=@bvin and StoreId=@StoreId
		ORDER BY SortOrder

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
GO
PRINT N'Creating [dbo].[bvc_SiteTerm_u]'
GO


CREATE PROCEDURE [dbo].[bvc_SiteTerm_u]

@SiteTerm nvarchar(255),
@SiteTermValue nvarchar(500)

AS
	BEGIN TRY
		UPDATE bvc_SiteTerm SET SiteTermValue=@SiteTermValue WHERE SiteTerm=@SiteTerm
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
		
	RETURN 





GO
PRINT N'Creating [dbo].[bvc_Variant_ByProduct_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Variant_ByProduct_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT bvin,ProductID,Sku,Price,SelectionData,StoreId
		FROM bvc_Variants
		WHERE ProductID=@bvin and (@StoreId=-1 OR StoreId=@StoreId)
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_Variant_s]'
GO



CREATE PROCEDURE [dbo].[bvc_Variant_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT bvin,ProductID,Sku,Price,SelectionData,StoreId
		FROM bvc_Variants
		WHERE bvin=@bvin and StoreId=@StoreId

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_Variant_u]'
GO



CREATE PROCEDURE [dbo].[bvc_Variant_u]

@bvin varchar(36),
@ProductID varchar(36),
@Sku nvarchar(255),
@Price decimal(18,10),
@SelectionData nvarchar(Max),
@StoreId bigint

AS
	BEGIN TRY
		UPDATE bvc_Variants
		SET
		bvin=@bvin,
		ProductID=@ProductID,
		Sku=@Sku,
		Price=@Price,
		SelectionData=@SelectionData
				
		WHERE bvin=@bvin and StoreId=@StoreId

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_Variant_i]'
GO



CREATE PROCEDURE [dbo].[bvc_Variant_i]

@bvin varchar(36),
@ProductID varchar(36),
@Sku nvarchar(255),
@Price decimal(18,10),
@SelectionData nvarchar(Max),
@StoreId bigint


AS
	BEGIN TRY
		
		INSERT INTO bvc_Variants
		(
		bvin,ProductID,Sku,Price,SelectionData,StoreId
		)
		VALUES
		(
		@bvin,@ProductID,@Sku,@Price,@SelectionData,@StoreId
		)

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH














GO
PRINT N'Creating [dbo].[bvc_Variant_d]'
GO



CREATE PROCEDURE [dbo].[bvc_Variant_d]

@bvin varchar(36),
@StoreId bigint

AS

	BEGIN TRY
		DELETE FROM bvc_Variants WHERE bvin=@bvin and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_Variant_ByProduct_d]'
GO




CREATE PROCEDURE [dbo].[bvc_Variant_ByProduct_d]

@bvin varchar(36),
@StoreId bigint

AS

	BEGIN TRY
		DELETE FROM bvc_Variants WHERE ProductId=@bvin and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_Product_ByFacet_CountForKeys_s]'
GO



CREATE PROCEDURE [dbo].[bvc_Product_ByFacet_CountForKeys_s]
	@Keys varchar(Max),
	@StoreId bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @keytable TABLE (rownum int IDENTITY (1, 1) Primary key NOT NULL , 
							 keyvalue nvarchar(MAX) NOT NULL,	
							 productcount int NOT NULL)
	
	INSERT INTO @keytable (keyvalue, productcount)
	SELECT stringvalue as keyvalue, 0  as productcount from ListOfKeysToTable(@Keys)
	
	-- Walk the temp table to calculate results
	declare @RowCnt int 
	declare @MaxRows int 
	declare @WorkingKey nvarchar(MAX) 
	declare @WorkingCount int 

	select @RowCnt = 1 
	select @MaxRows=count(*) from @keytable
	
	while @RowCnt <= @MaxRows 
		begin 

			SELECT @WorkingKey = keyvalue from @keytable WHERE rownum = @RowCnt
									
			SELECT @WorkingCount = 0									
			exec bvc_Product_ByFacet_Count_s @WorkingKey, @StoreId, @WorkingCount OUTPUT			
			UPDATE @keytable set productcount=@WorkingCount WHERE keyvalue=@WorkingKey

			SELECT @RowCnt = @RowCnt + 1 
		end


	Select keyvalue,productcount from @keytable
		
END


GO
PRINT N'Creating [dbo].[bvc_CartCleanup_d]'
GO






CREATE PROCEDURE [dbo].[bvc_CartCleanup_d]

@OlderThanDate datetime,
@StoreId bigint

AS
BEGIN TRY

	BEGIN TRANSACTION
		DECLARE @CartIds Table (
			CartId varchar(36)
		)

		--declare cursor for use below
		DECLARE @currbvin varchar(36)
		DECLARE bvin_cartcursor CURSOR LOCAL
			FOR SELECT * FROM @CartIds

		--delete out all of our product choices
		INSERT INTO @CartIds SELECT DISTINCT bvin FROM bvc_Order WHERE TimeOfOrder < @OlderThanDate AND IsPlaced = 0
		and StoreId=@StoreId
		OPEN bvin_cartcursor
		FETCH NEXT FROM bvin_cartcursor	INTO @currbvin

		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC bvc_Order_d @currbvin
			FETCH NEXT FROM bvin_cartcursor	INTO @currbvin
		END
		CLOSE bvin_cartcursor		
		DEALLOCATE bvin_cartcursor
	COMMIT
END TRY
BEGIN CATCH
	IF CURSOR_STATUS('local', 'bvin_cartcursor') > -1
		CLOSE bvin_cartcursor	

	IF CURSOR_STATUS('local', 'bvin_cartcursor') = -1
		DEALLOCATE bvin_cartcursor

	IF XACT_STATE() <> 0
		ROLLBACK TRANSACTION
	EXEC bvc_EventLog_SQL_i
	RETURN 0
END CATCH

RETURN 
	


















GO
PRINT N'Creating [dbo].[bvc_SearchQuery_s]'
GO
CREATE PROCEDURE [dbo].[bvc_SearchQuery_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT bvin,QueryPhrase,ShopperID,LastUpdated,StoreId
		FROM
			bvc_SearchQuery
		WHERE
			bvin=@bvin and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ComponentSettings_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ComponentSettings_s]

@ComponentID varchar(36),
@StoreId bigint

AS
	
	BEGIN TRY
		SELECT 
		SettingName,
		SettingValue,
		ComponentID,
		DeveloperId,
		ComponentType,
		ComponentSubType,
		StoreId
		 FROM bvc_ComponentSetting WHERE
		ComponentID=@ComponentID
		and StoreId=@StoreId
		ORDER BY SettingName

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ProductInventory_i]'
GO
-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_i] 
	-- Add the parameters for the stored procedure here
	@bvin varchar(36), 
	@ProductBvin varchar(36),	
	@VariantId nvarchar(MAX),
	@QuantityOnHand int,
	@QuantityReserved int,	
	@LowStockPoint int,	
	@StoreId bigint

AS
BEGIN

	BEGIN TRY
		DELETE FROM bvc_ProductInventory 
		WHERE productBvin = @ProductBvin AND
			VariantId=@VariantId and StoreId=@StoreId

		INSERT INTO bvc_ProductInventory
		(
		bvin, 
		ProductBvin,
		VariantId,
		QuantityOnHand,
		LowStockPoint,
		QuantityReserved,
		LastUpdated,
		StoreId
		)
		VALUES
		(
		@bvin,
		@ProductBvin,
		@VariantId,
		@QuantityOnHand,
		@LowStockPoint,
		@QuantityReserved,
		GetUtcDate(),
		@StoreId
		)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
    
END















GO
PRINT N'Creating [dbo].[bvc_ProductXCategory_d]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductXCategory_d]
@CategoryID varchar(36),
@ProductID varchar(36),
@StoreId bigint
AS
	BEGIN TRY
		DELETE FROM bvc_ProductXCategory
		WHERE CategoryID=@CategoryID
		AND ProductID=@ProductID and StoreId=@StoreId

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductInventory_Reserve_u]'
GO

-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_Reserve_u] 

	@ProductBvin varchar(36),
	@VariantId nvarchar(MAX),
	@Quantity int,
	@StoreId bigint

AS
BEGIN

	BEGIN TRY
		UPDATE bvc_ProductInventory
		SET	
		QuantityReserved = QuantityReserved + @Quantity,
		LastUpdated=GetUtcDate()
		WHERE ProductBvin=@ProductBvin AND
				VariantId=@VariantId and StoreId=@StoreId

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END














GO
PRINT N'Creating [dbo].[bvc_UserAccount_All_s]'
GO

CREATE PROCEDURE [dbo].[bvc_UserAccount_All_s]
	@StoreId bigint
AS

BEGIN TRY
	SELECT bvin,[Password],[Firstname],[LastName],Salt,TaxExempt,
			Email,CreationDate,LastLoginDate,Comment,AddressBook,
			LastUpdated,Locked,LockedUntil,FailedLoginCount,
			Phones,PricingGroup,CustomQuestionAnswers, StoreId
	FROM bvc_User
	WHERE StoreId=@StoreId
	ORDER BY [Email],[LastName],[FirstName]

	RETURN
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH



















GO
PRINT N'Creating [dbo].[bvc_ProductReview_d]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductReview_d]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		DELETE FROM bvc_ProductReview WHERE bvin=@bvin  and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
GO
PRINT N'Creating [dbo].[bvc_ProductXCategory_d_all]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductXCategory_d_all]
@ProductID varchar(36),
@StoreId bigint
AS
	BEGIN TRY
		DELETE FROM bvc_ProductXCategory
		WHERE ProductID=@ProductID and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ContactUsQuestion_d]'
GO

CREATE PROCEDURE [dbo].[bvc_ContactUsQuestion_d]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		DELETE FROM bvc_ContactUsQuestions WHERE bvin = @bvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH








GO
PRINT N'Creating [dbo].[bvc_ProductInventory_Reset_u]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductInventory_Reset_u] 
	@StoreId bigint
AS
BEGIN

	BEGIN TRY
		UPDATE bvc_ProductInventory
		SET	
		QuantityReserved = 0,
		QuantityOnHand= 0,		
		LastUpdated=GetUtcDate()		
		WHERE  StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END














GO
PRINT N'Creating [dbo].[bvc_ProductReview_i]'
GO





CREATE PROCEDURE [dbo].[bvc_ProductReview_i]
@bvin varchar(36),
@Approved int,
@Description nvarchar(max),
@Karma int,
@ProductBvin varchar(36),
@Rating int,
@ReviewDate dateTime,
@UserID varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		INSERT INTO
		bvc_ProductReview
		(
		bvin,
		LastUpdated,
		Approved, 
		Description, 
		Karma,
		ProductBvin,
		Rating, 
		ReviewDate, 
		UserID,
		StoreId
		)
			VALUES
			(
		@bvin, 
		GetUtcDate(),
		@Approved, 
		@Description, 
		@Karma,
		@ProductBvin,
		@Rating, 
		@ReviewDate, 
		@UserID,
		@StoreId
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_Product_All_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_All_s]
@StartRowIndex int = 0,
@MaximumRows int = 9999999,
@StoreId bigint
AS

	BEGIN TRY;
		WITH Products AS (SELECT
			ROW_NUMBER() OVER (ORDER BY ProductName) As RowNum,
			bvc_Product.bvin,
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
			bvc_Product.Status,
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
			bvc_Product.LastUpdated,
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
			WHERE StoreId=@StoreId)
		
		SELECT *, (SELECT COUNT(*) FROM Products) AS TotalRowCount FROM Products WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
		ORDER BY RowNum
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH





























GO
PRINT N'Creating [dbo].[bvc_CustomUrl_BySystemData_s]'
GO

CREATE PROCEDURE [dbo].[bvc_CustomUrl_BySystemData_s]
	
@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY	
		SELECT 
			bvin,
			RequestedUrl,
			RedirectToUrl,
			IsPermanentRedirect,
			SystemDataType,
			SystemData,
			LastUpdated,
			StoreID
		FROM bvc_CustomUrl
		WHERE SystemData=@bvin
		and StoreId=@StoreId
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ContactUsQuestion_i]'
GO








CREATE PROCEDURE [dbo].[bvc_ContactUsQuestion_i]

@bvin varchar(36),
@QuestionName nvarchar(50),
@QuestionType int,
@Values nvarchar(max),
@Order int,
@StoreId bigint

AS
	BEGIN TRY
		SET @Order = (SELECT MAX([Order]) FROM bvc_ContactUsQuestions WHERE StoreId=@StoreId)
		IF @Order IS NULL
			SET @Order = 0
		SET @Order = @Order + 1

		INSERT INTO	bvc_ContactUsQuestions
		(
		bvin,
		QuestionName,
		QuestionType,
		[Values],
		[Order],
		LastUpdated,
		StoreId)
		VALUES(
		@bvin,
		@QuestionName,
		@QuestionType,
		@Values,
		@Order,
		GetUtcDate(),
		@StoreId
		) 

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_Audit_d]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[bvc_Audit_d]	
	@StoreId bigint
AS
BEGIN	
	Declare @removebefore DateTime
	Select @removebefore = DateAdd(yy,-1,GetUTCDate())
			
	Delete bvc_Audit where TimeStampUtc < @removebefore	 and StoreId=@StoreId
	
END
GO
PRINT N'Creating [dbo].[bvc_Reporting_OrderStatusSummary_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Reporting_OrderStatusSummary_s]
@StoreId bigint
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT StatusCode, COUNT(StatusCode) as OrderCount 
      
	FROM bvc_Order
	where StoreId=@StoreId AND
	IsPlaced = '1'
	Group By StatusCode
  
END
GO
PRINT N'Creating [dbo].[bvc_ProductXCategory_i]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductXCategory_i]
@CategoryID varchar(36),
@ProductID varchar(36),
@SortOrder int = 1,
@CurrentCount int = 0,
@StoreId bigint
AS
	BEGIN TRY
		SET @CurrentCount = (SELECT Count(CategoryID) as c FROM bvc_ProductXCategory WHERE CategoryID=@CategoryID and StoreId=@StoreId) 
		IF @CurrentCount > 0
			BEGIN
				SET @SortOrder =  (Select Max(SortOrder) as MaxSort FROM bvc_ProductXCategory WHERE CategoryID=@CategoryID and StoreId=@StoreId)
				SET @SortOrder = @SortOrder + 1
			END
		ELSE
			SET @SortOrder =  1
			
		INSERT INTO
		bvc_ProductXCategory
		(ProductID,CategoryID, SortOrder,StoreId)
		VALUES(@ProductID,@CategoryID,@SortOrder,@StoreId)

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH










GO
PRINT N'Creating [dbo].[bvc_ProductInventory_ResetProduct_u]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductInventory_ResetProduct_u] 

	@ProductBvin varchar(36),
	@StoreId bigint

AS
BEGIN

	BEGIN TRY
		UPDATE bvc_ProductInventory
		SET	
		QuantityReserved = 0,
		QuantityOnHand= 0,
		LastUpdated=GetUtcDate()
		WHERE  StoreId=@StoreId AND (ProductBvin = @ProductBvin)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END














GO
PRINT N'Creating [dbo].[bvc_ContactUsQuestion_s]'
GO









CREATE PROCEDURE [dbo].[bvc_ContactUsQuestion_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT bvin, 
		QuestionName, 
		QuestionType, 
		[Values], 
		[Order], 
		LastUpdated,
		StoreId 
		FROM bvc_ContactUsQuestions 
		WHERE bvin = @bvin and StoreId=@StoreId
		ORDER BY [Order]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_UserAccount_ByCriteria_s]'
GO




CREATE PROCEDURE [dbo].[bvc_UserAccount_ByCriteria_s]
@FirstName nvarchar(50) = NULL,
@LastName nvarchar(100) = NULL,
@Email nvarchar(100) = NULL,
@StartRowIndex int = 0,
@MaximumRows int = 9999999,
@StoreId bigint


AS

BEGIN
	BEGIN TRY
		SET NOCOUNT ON;
		
		WITH UserAccounts AS
		(SELECT ROW_NUMBER() OVER (ORDER BY LastName, FirstName, Email) As RowNum,
			bvin,[Password],[Firstname],[LastName],Salt,TaxExempt,
			Email,CreationDate,LastLoginDate,Comment,AddressBook,
			LastUpdated,Locked,LockedUntil,FailedLoginCount,
			Phones,PricingGroup,CustomQuestionAnswers,StoreId
		FROM bvc_User
		WHERE 
			StoreId = @StoreId AND 
			(
			(firstname = @FirstName OR @FirstName IS NULL) 
			AND (lastname = @LastName OR @LastName IS NULL) 
			AND (email = @Email OR @Email IS NULL))
			)

		SELECT *, (SELECT COUNT(*) FROM UserAccounts) AS TotalRowCount FROM UserAccounts
			WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END

















GO
PRINT N'Creating [dbo].[bvc_ProductReview_s]'
GO





CREATE PROCEDURE [dbo].[bvc_ProductReview_s]
@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT 
			r.bvin,
			r.LastUpdated,
			r.Approved, 
			r.Description,
			r.ProductBvin,
			r.Karma, 
			r.Rating, 
			r.ReviewDate, 
			r.UserID,
			p.ProductName,
			r.StoreId

		FROM bvc_ProductReview r
		JOIN 
		bvc_Product p on r.ProductBvin = p.bvin
		WHERE  r.bvin=@bvin and r.StoreId=@StoreId



		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















GO
PRINT N'Creating [dbo].[bvc_CustomUrl_d]'
GO
CREATE PROCEDURE [dbo].[bvc_CustomUrl_d]
	
@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		DELETE bvc_CustomUrl WHERE bvin=@bvin and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ContactUsQuestion_u]'
GO

CREATE PROCEDURE [dbo].[bvc_ContactUsQuestion_u]

@bvin varchar(36),
@QuestionName nvarchar(50),
@QuestionType int,
@Values nvarchar(max),
@Order int,
@StoreId bigint

AS
	BEGIN TRY
		UPDATE bvc_ContactUsQuestions 
		SET bvin = @bvin, QuestionName = @QuestionName, QuestionType = @QuestionType, 
			[Values] = @Values, 
			[Order] = @Order, 
			LastUpdated = GetUtcDate() 
			WHERE bvin = @bvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH









GO
PRINT N'Creating [dbo].[bvc_WishList_d]'
GO

CREATE PROCEDURE [dbo].[bvc_WishList_d]	
	@bvin varchar(36),
	@StoreId bigint	
AS
BEGIN
	BEGIN TRY    
		DELETE FROM bvc_WishList
		WHERE	bvin = @bvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END




GO
PRINT N'Creating [dbo].[bvc_UserAccount_s]'
GO

CREATE PROCEDURE [dbo].[bvc_UserAccount_s]

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
PRINT N'Creating [dbo].[bvc_ProductInventory_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductInventory_s] 
	-- Add the parameters for the stored procedure here
	@bvin varchar(36),
	@StoreId bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		-- Insert statements for procedure here
		SELECT
		bvin, 
		ProductBvin,
		VariantId,
		QuantityOnHand,				
		QuantityReserved,
		QuantityAvailableForSale,
		LowStockPoint,		
		LastUpdated,
		StoreId
		FROM bvc_ProductInventory
		WHERE bvin=@bvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END














GO
PRINT N'Creating [dbo].[bvc_ProductXCategory_SortOrder_u]'
GO
CREATE PROCEDURE [dbo].[bvc_ProductXCategory_SortOrder_u]

@CategoryId varchar(36),
@ProductId varchar(36),
@SortOrder int,
@StoreId bigint

AS

	BEGIN TRY
		UPDATE bvc_ProductXCategory
		SET
		SortOrder=@SortOrder
		WHERE CategoryID=@CategoryId AND ProductId=@ProductId and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	












GO
PRINT N'Creating [dbo].[bvc_ProductXCategory_ByProduct_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductXCategory_ByProduct_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT categoryId,productId,SortOrder,StoreId
		FROM bvc_ProductXCategory
		WHERE productId=@bvin and StoreId=@StoreId
		ORDER BY SortOrder

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

GO
PRINT N'Creating [dbo].[bvc_ProductReview_u]'
GO




CREATE PROCEDURE [dbo].[bvc_ProductReview_u]
@bvin varchar(36),
@Approved int,
@Description nvarchar(max),
@Karma int,
@ProductBvin varchar(36),
@Rating int,
@ReviewDate dateTime,
@UserID varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		UPDATE
			bvc_ProductReview
		SET
			bvin = @bvin,
			LastUpdated = GetUtcDate(),
			Approved = @Approved,
			Description = @Description,
			Karma = @Karma,
			ProductBvin = @ProductBvin,
			Rating = @Rating,
			ReviewDate = @ReviewDate,
			UserID = @UserID
		WHERE
			bvin=@bvin and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_ProductFile_ByBvinAndProductBvin_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductFile_ByBvinAndProductBvin_s]

@bvin varchar(36),
@ProductBvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT
		bvc_ProductFile.bvin,
		bvc_ProductFileXProduct.ProductID,
		bvc_ProductFileXProduct.AvailableMinutes,
		bvc_ProductFileXProduct.MaxDownloads,
		bvc_ProductFile.[FileName],
		bvc_ProductFile.ShortDescription,
		bvc_ProductFileXProduct.LastUpdated,
		bvc_ProductFile.StoreId
		FROM bvc_ProductFile LEFT JOIN bvc_ProductFileXProduct ON bvc_ProductFile.bvin = bvc_ProductFileXProduct.ProductFileId
		WHERE bvin=@bvin
		 And bvc_ProductFileXProduct.ProductId = @ProductBvin
		  and bvc_ProductFile.StoreId=@StoreId
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
















GO
PRINT N'Creating [dbo].[bvc_Product_Count_All_s]'
GO


CREATE PROCEDURE [dbo].[bvc_Product_Count_All_s]
@StoreId bigint
AS

	BEGIN TRY;
	
		Select COUNT(*) as TotalCount from bvc_Product WHERE (@storeId=-1 OR StoreId=@StoreId)
			
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH






























GO
PRINT N'Creating [dbo].[bvc_CustomUrl_i]'
GO

CREATE PROCEDURE [dbo].[bvc_CustomUrl_i]

@bvin varchar(36),
@RequestedUrl nvarchar(Max),
@RedirectToUrl nvarchar(Max),
@IsPermanentRedirect bit,
@SystemDataType int,
@SystemData varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		INSERT INTO bvc_CustomUrl
		(
		bvin,
		RequestedUrl,
		RedirectToUrl,
		IsPermanentRedirect,
		SystemDataType,
		SystemData,
		LastUpdated,
		StoreId
		)
		VALUES
		(
		@bvin,
		@RequestedUrl,
		@RedirectToUrl,
		@IsPermanentRedirect,
		@SystemDataType,
		@SystemData,
		GetUtcDate(),
		@StoreId
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ContentBlock_d]'
GO


CREATE PROCEDURE [dbo].[bvc_ContentBlock_d]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY

		DELETE bvc_ContentBlock WHERE bvin=@bvin and StoreId=@StoreId
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_ProductReviewKarma_u]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductReviewKarma_u] 

@Bvin varchar(36),
@KarmaModifier int = 0,
@StoreId bigint

AS
	BEGIN TRY
		UPDATE bvc_ProductReview
		SET
		Karma=Karma+@KarmaModifier
		WHERE
		Bvin=@Bvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH








GO
PRINT N'Creating [dbo].[bvc_ProductInventory_SetAvailableQuantity_u]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductInventory_SetAvailableQuantity_u] 

	@ProductBvin varchar(36),
	@VariantId nvarchar(MAX),
	@Quantity int,
	@StoreId bigint

AS
BEGIN

	BEGIN TRY
		UPDATE bvc_ProductInventory
		SET	
		QuantityOnHand=@Quantity,
		LastUpdated=GetUtcDate()
		WHERE ProductBvin=@ProductBvin AND
				VariantId=@VariantId and StoreId=@StoreId

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
END














GO
PRINT N'Creating [dbo].[bvc_ProductFile_Count_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductFile_Count_s]

@StoreId bigint
	
AS
	BEGIN TRY
		SELECT
		COUNT(*) As FileCount
		FROM bvc_ProductFile
		WHERE StoreId=@StoreId
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_CustomUrl_s]'
GO

CREATE PROCEDURE [dbo].[bvc_CustomUrl_s]
	
@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT 
			bvin,
			RequestedUrl,
			RedirectToUrl,
			IsPermanentRedirect,
			SystemDataType,
			SystemData,
			LastUpdated, 
			StoreId
		FROM bvc_CustomUrl
		WHERE bvin=@bvin and StoreId=@StoreId
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ContentBlock_i]'
GO
CREATE PROCEDURE [dbo].[bvc_ContentBlock_i]

@bvin varchar(36),
@ColumnID varchar(36),
@SortOrder int,
@ControlName nvarchar(512),
@StoreId bigint,
@SerializedSettings ntext,
@SerializedLists ntext

AS
	BEGIN TRY
		IF (Select Count(bvin) FROM bvc_ContentBlock WHERE ColumnID=@ColumnID and StoreId=@StoreId) > 0
			BEGIN
			SET @SortOrder = (Select Max(SortOrder) FROM bvc_ContentBlock WHERE ColumnID=@ColumnID and StoreId=@StoreId)+1
			END
		ELSE
			BEGIN
			SET @SortOrder = 1
			END
			
			
		INSERT INTO bvc_ContentBlock
		(
		bvin,
		ColumnID,
		SortOrder,
		ControlName,
		LastUpdated,
		StoreId,
		SerializedSettings,
		SerializedLists
		)
		VALUES
		(
		@bvin,
		@ColumnID,
		@SortOrder,
		@ControlName,
		GetUtcDate(),
		@StoreId,
		@SerializedSettings,
		@SerializedLists
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_WishList_i]'
GO
CREATE PROCEDURE [dbo].[bvc_WishList_i]	

@bvin varchar(36),
@userId varchar(36),
@ProductBvin varchar(36),
@Quantity int,
@Modifiers nvarchar(max),
@Inputs nvarchar(max),
@StoreId bigint


AS
BEGIN
	BEGIN TRY		
		INSERT INTO bvc_WishList 
			([bvin],UserId,ProductBvin,Quantity,Modifiers,Inputs, StoreId) 
			VALUES
			(@bvin,@UserId,@ProductBvin,@Quantity,@Modifiers,@Inputs, @StoreId)
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END



GO
PRINT N'Creating [dbo].[bvc_ProductFile_d]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductFile_d]

@bvin varchar(36),
@StoreId bigint

AS
	
	BEGIN TRY
		BEGIN TRANSACTION
			DELETE FROM bvc_ProductFileXProduct WHERE ProductFileId = @bvin	 and StoreId=@StoreId
			DELETE FROM bvc_ProductFile WHERE bvin=@bvin and StoreId=@StoreId
		COMMIT TRANSACTION
		RETURN
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_ProductInventory_Ship_u]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductInventory_Ship_u] 

	@ProductBvin varchar(36),
	@VariantId nvarchar(MAX),
	@Quantity int,
	@StoreId bigint

AS
BEGIN

	BEGIN TRY	
		UPDATE bvc_ProductInventory
		SET	
		QuantityReserved = QuantityReserved - @Quantity,
		QuantityOnHand = QuantityOnHand - @Quantity,
		LastUpdated=GetUtcDate()
		
		WHERE ProductBvin=@ProductBvin and 
			VariantId=@VariantId AND StoreId=@StoreId

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END














GO
PRINT N'Creating [dbo].[bvc_ProductReviewNotApproved_s]'
GO






CREATE PROCEDURE [dbo].[bvc_ProductReviewNotApproved_s]
	@StoreId bigint
AS
	BEGIN TRY
		SELECT 
		bvc_ProductReview.bvin,
		bvc_ProductReview.LastUpdated,
		bvc_ProductReview.Approved, 
		bvc_ProductReview.Description,
		bvc_ProductReview.ProductBvin,
		bvc_ProductReview.Karma, 
		bvc_ProductReview.Rating, 
		bvc_ProductReview.ReviewDate, 
		bvc_ProductReview.UserID,
		bvc_Product.ProductName,
		bvc_ProductReview.StoreId

		FROM bvc_ProductReview JOIN bvc_Product ON bvc_ProductReview.ProductBvin = bvc_Product.bvin
		WHERE  Approved = 0 and bvc_ProductReview.StoreId=@StoreId
		Order BY ReviewDate ASC

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
















GO
PRINT N'Creating [dbo].[bvc_ContentBlock_s]'
GO
CREATE PROCEDURE [dbo].[bvc_ContentBlock_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT 
			bvin,
			ColumnID,
			SortOrder,
			ControlName,
			LastUpdated, 
			StoreId, 
			SerializedSettings,
			SerializedLists
			FROM bvc_ContentBlock			
			WHERE bvin=@bvin and StoreId=@StoreId
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_CustomUrl_u]'
GO

CREATE PROCEDURE [dbo].[bvc_CustomUrl_u]

@bvin varchar(36),
@RequestedUrl nvarchar(Max),
@RedirectToUrl nvarchar(Max),
@IsPermanentRedirect bit,
@SystemDataType int,
@SystemData varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		UPDATE bvc_CustomUrl
		SET
		bvin=@bvin,
		RequestedUrl=@RequestedUrl,
		RedirectToUrl=@RedirectToUrl,
		IsPermanentRedirect=@IsPermanentRedirect,
		SystemDataType=@SystemDataType,
		SystemData=@SystemData,
		LastUpdated=GetUtcDate()
		WHERE bvin=@bvin and StoreId=@StoreId
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ProductFile_i]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductFile_i]

	@bvin varchar(36),
	@ProductID varchar(36),
	@AvailableMinutes int,
	@MaxDownloads int,
	@FileName nvarchar(100),
	@ShortDescription nvarchar(100),
	@StoreId bigint

AS
	DECLARE @count int

	SELECT @count = COUNT(*) FROM bvc_ProductFile WHERE bvin = @bvin and StoreId=@StoreId

	BEGIN TRY
		BEGIN TRANSACTION
			IF @count = 0
			BEGIN
				INSERT INTO bvc_ProductFile 
				(bvin, [FileName], ShortDescription, LastUpdated,StoreId) 
				VALUES (@bvin, @FileName, @ShortDescription, GetUtcDate(),@StoreId)
			END
		
			IF @ProductId != ''
			BEGIN
				INSERT INTO bvc_ProductFileXProduct (ProductFileId, ProductId, AvailableMinutes, MaxDownloads, LastUpdated, StoreId)
					VALUES (@bvin, @ProductID, @AvailableMinutes, @MaxDownloads, GetUtcDate(), @StoreId)
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN
















GO
PRINT N'Creating [dbo].[bvc_ComponentSetting_ByComponentID_d]'
GO


CREATE PROCEDURE [dbo].[bvc_ComponentSetting_ByComponentID_d]

@bvin varchar(36),
@StoreId bigint

	AS
		BEGIN TRY 
			DELETE FROM bvc_ComponentSetting WHERE ComponentID=@bvin and StoreId=@StoreId
			DELETE FROM bvc_ComponentSettingList WHERE ComponentId=@bvin and StoreId=@StoreId
		END TRY
		BEGIN CATCH
			EXEC bvc_EventLog_SQL_i
		END CATCH

	RETURN













GO
PRINT N'Creating [dbo].[bvc_ProductInventory_u]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductInventory_u] 
	@bvin varchar(36), 
	@ProductBvin varchar(36),
	@VariantId nvarchar(MAX),
	@QuantityOnHand int,
	@QuantityReserved int,	
	@LowStockPoint int,	
	@StoreId bigint
AS
BEGIN
	BEGIN TRY
		UPDATE bvc_ProductInventory
		SET
		bvin=@bvin,
		ProductBvin=@ProductBvin,
		VariantId=@VariantId,
		QuantityOnHand=@QuantityOnHand,		
		QuantityReserved=@QuantityReserved,
		LowStockPoint=@LowStockPoint,
		LastUpdated=GetUtcDate()
		WHERE bvin=@bvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END















GO
PRINT N'Creating [dbo].[bvc_ContentBlock_SortOrder_u]'
GO
CREATE PROCEDURE [dbo].[bvc_ContentBlock_SortOrder_u]

@bvin varchar(36),
@SortOrder int,
@StoreId bigint

AS

	BEGIN TRY
		UPDATE bvc_ContentBlock
		SET
		SortOrder=@SortOrder,LastUpdated=GetUtcDate()
		WHERE bvin=@bvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	












GO
PRINT N'Creating [dbo].[bvc_CustomUrlByRedirectToUrl_s]'
GO

CREATE PROCEDURE [dbo].[bvc_CustomUrlByRedirectToUrl_s]

@RedirectToUrl nvarchar(Max),
@StoreId bigint

AS
	BEGIN TRY
		SELECT bvin,
			RequestedUrl,
			RedirectToUrl,
			IsPermanentRedirect,
			SystemDataType,
			SystemData,
			LastUpdated,
			StoreId
		FROM bvc_CustomUrl
		WHERE RedirectToUrl=@RedirectToUrl and StoreId=@StoreId
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ProductFile_ProductCount_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductFile_ProductCount_s]

@bvin varchar(36),
@StoreId bigint

AS

	BEGIN TRY	
		SELECT
		COUNT(*) As ProductCount
		FROM bvc_ProductFileXProduct
		WHERE ProductFileId = @bvin and StoreId=@StoreId
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_ProductInventory_Unreserve_u]'
GO

-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_Unreserve_u] 

	@ProductBvin varchar(36),
	@VariantId nvarchar(MAX),
	@Quantity int,
	@StoreId bigint

AS
BEGIN

	BEGIN TRY
		UPDATE bvc_ProductInventory
		SET	
		QuantityReserved = QuantityReserved - @Quantity,
		LastUpdated=GetUtcDate()
		WHERE ProductBvin=@ProductBvin and
		VariantId=@VariantId and StoreId=@StoreId

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
END















GO
PRINT N'Creating [dbo].[bvc_ContentBlock_u]'
GO
CREATE PROCEDURE [dbo].[bvc_ContentBlock_u]

@bvin varchar(36),
@ColumnID varchar(36),
@SortOrder int,
@ControlName nvarchar(512),
@StoreId bigint,
@SerializedSettings ntext,
@SerializedLists ntext

AS
	BEGIN TRY
		UPDATE bvc_ContentBlock
		SET
		
		bvin=@bvin,
		ColumnID=@ColumnID,
		SortOrder=@SortOrder,
		ControlName=@ControlName,
		SerializedSettings=@SerializedSettings,
		SerializedLists=@SerializedLists,
		LastUpdated=GetUtcDate()
		
		WHERE bvin=@bvin and StoreId=@StoreId
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_CustomUrlByRequestedUrl_s]'
GO

CREATE PROCEDURE [dbo].[bvc_CustomUrlByRequestedUrl_s]

@RequestedUrl nvarchar(Max),
@StoreId bigint

AS
	BEGIN TRY
		SELECT 
			bvin,
				RequestedUrl,
				RedirectToUrl,
				IsPermanentRedirect,
				SystemDataType,
				SystemData,
				LastUpdated, 
				StoreId
		FROM bvc_CustomUrl
		WHERE RequestedUrl=@RequestedUrl and StoreId=@StoreId
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ProductFile_RemoveProduct_d]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductFile_RemoveProduct_d]

@FileBvin varchar(36),
@ProductBvin varchar(36),
@StoreId bigint

AS
	
	BEGIN TRY
		DELETE FROM bvc_ProductFileXProduct WHERE ProductFileId = @FileBvin	AND ProductId = @ProductBvin and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_ProductInventory_Unship_u]'
GO

-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_Unship_u] 

	@ProductBvin varchar(36),
	@VariantId nvarchar(Max),
	@Quantity int,
	@StoreId bigint

AS
BEGIN

	BEGIN TRY
		UPDATE bvc_ProductInventory
		SET	
		QuantityReserved = QuantityReserved + @Quantity,
		LastUpdated=GetUtcDate()
		WHERE ProductBvin=@ProductBvin AND
		VariantId=@VariantId and StoreId=@StoreId

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END














GO
PRINT N'Creating [dbo].[bvc_ProductType_Count_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductType_Count_s]

@ProductTypeBvin varchar(36),
@StoreId bigint

AS

	BEGIN TRY
		SELECT COUNT(bvin) AS ProductTypeCount FROM bvc_Product WHERE ProductTypeID=@ProductTypeBvin AND StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH





GO
PRINT N'Creating [dbo].[bvc_ProductFile_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductFile_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT
		bvc_ProductFile.bvin,bvc_ProductFileXProduct.ProductID,
		bvc_ProductFileXProduct.AvailableMinutes,
		bvc_ProductFileXProduct.MaxDownloads,
		bvc_ProductFile.[FileName],
		bvc_ProductFile.ShortDescription,
		bvc_ProductFileXProduct.LastUpdated,
		bvc_ProductFile.StoreId
		FROM bvc_ProductFile LEFT JOIN bvc_ProductFileXProduct ON bvc_ProductFile.bvin = bvc_ProductFileXProduct.ProductFileId
		WHERE bvin=@bvin and bvc_ProductFile.StoreId=@StoreId
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















GO
PRINT N'Creating [dbo].[bvc_Product_ByFile_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_ByFile_s]

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
		p.LastUpdated,
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
		p.StoreId,
		Featured,
		AllowReviews,
		DescriptionTabs,
		IsAvailableForSale
		
		FROM bvc_Product p JOIN bvc_ProductFileXProduct px ON p.bvin = px.ProductID
		WHERE px.ProductFileId = @bvin and p.StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN




























GO
PRINT N'Creating [dbo].[bvc_ProductFile_u]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductFile_u]

@bvin varchar(36),
@ProductID varchar(36),
@AvailableMinutes int,
@MaxDownloads int,
@FileName nvarchar(100),
@ShortDescription nvarchar(100),
@StoreId bigint

AS

	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE bvc_ProductFile
			SET
			bvin=@bvin,
			FileName=@FileName,
			ShortDescription=@ShortDescription,
			LastUpdated=GetUtcDate()
			WHERE
			bvin=@bvin and StoreId=@StoreId

			IF @ProductId != ''
			BEGIN
				UPDATE bvc_ProductFileXProduct
				SET
				AvailableMinutes=@AvailableMinutes,
				MaxDownloads=@MaxDownloads,
				LastUpdated=GetUtcDate()		
				WHERE
				ProductFileId = @bvin And ProductId = @ProductId and StoreId=@StoreId

				IF @@ROWCOUNT = 0
				BEGIN
					INSERT INTO bvc_ProductFileXProduct
					(ProductFileId, ProductId, AvailableMinutes, MaxDownloads, LastUpdated,StoreId)
					VALUES (@bvin, @ProductId, @AvailableMinutes, @MaxDownloads, GetUtcDate(),@StoreId)
				END
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH	

	RETURN

























GO
PRINT N'Creating [dbo].[bvc_ProductCount_ByCategory_s]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductCount_ByCategory_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY			
		SELECT
		Count(*) As [Count]			
		FROM bvc_Product p JOIN bvc_ProductXCategory px ON p.bvin = px.ProductID
		WHERE p.StoreId=@StoreId
		AND px.CategoryID = @bvin			
		AND p.IsAvailableForSale = 1
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



	RETURN





















GO
PRINT N'Creating [dbo].[bvc_ContentColumn_d]'
GO


CREATE PROCEDURE [dbo].[bvc_ContentColumn_d]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		
		/*DELETE bvc_ComponentSettingList WHERE componentID IN (
		SELECT bvin FROM bvc_ContentBlock WHERE ColumnID=@bvin) and StoreId=@StoreId

		DELETE bvc_ComponentSetting WHERE componentID IN (
		SELECT bvin FROM bvc_ContentBlock WHERE ColumnID=@bvin)
		and StoreId=@StoreId*/

		DELETE bvc_ContentBlock WHERE ColumnID=@bvin and StoreId=@StoreId
		
		DELETE bvc_ContentColumn WHERE bvin=@bvin and StoreId=@StoreId
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_Product_BySlug_s]'
GO


CREATE PROCEDURE [dbo].[bvc_Product_BySlug_s]

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
PRINT N'Creating [dbo].[bvc_ContactUsQuestion_All_s]'
GO

CREATE PROCEDURE [dbo].[bvc_ContactUsQuestion_All_s]

@StoreId bigint

AS
	BEGIN TRY
		SELECT 
			bvin, 
			QuestionName, 
			QuestionType, 
			[Values], 
			[Order], 
			LastUpdated,
			StoreID 
			FROM bvc_ContactUsQuestions 
			WHERE Storeid=@StoreId
			ORDER BY [Order]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


















GO
PRINT N'Creating [dbo].[bvc_ProductType_Exists_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductType_Exists_s]

@ProductTypeName nvarchar(512),
@storeid bigint

AS
	BEGIN TRY
		SELECT 
			bvin,
			ProductTypeName,
			IsPermanent,
			LastUpdated,
			StoreId

		FROM bvc_ProductType

		WHERE ProductTypeName=@ProductTypeName
		AND storeid=@storeid
		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i	
	END CATCH

	RETURN





GO
PRINT N'Creating [dbo].[bvc_ProductOption_ByProduct_d]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductOption_ByProduct_d]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36),
	@StoreId bigint
AS
BEGIN
	BEGIN TRY
		DELETE bvc_ProductOptionsItems where OptionBvin in 
			(select bvin from bvc_ProductOptions where IsShared = 0 and bvin in 
				(select OptionBvin from bvc_ProductXOption where ProductBvin=@bvin and StoreId=@StoreId)
			)
		
		DELETE bvc_ProductOptions where IsShared = 0 and bvin in (select OptionBvin from bvc_ProductXOption where ProductBvin=@bvin and StoreId=@StoreId)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END




























GO
PRINT N'Creating [dbo].[bvc_ProductFileByFilenameAndDescription_s]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductFileByFilenameAndDescription_s]

@fileName nvarchar(100),
@shortDescription nvarchar(100),
@StoreId bigint

AS
	BEGIN TRY
		SELECT
		bvc_ProductFile.bvin
		FROM bvc_ProductFile WHERE FileName = @fileName AND ShortDescription = @shortDescription and StoreId=@StoreId

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















GO
PRINT N'Creating [dbo].[bvc_Product_AllStores_s]'
GO


CREATE PROCEDURE [dbo].[bvc_Product_AllStores_s]
@StartRowIndex int = 0,
@MaximumRows int = 9999999

AS

	BEGIN TRY;
		WITH Products AS (SELECT
			ROW_NUMBER() OVER (ORDER BY ProductName) As RowNum,
			bvc_Product.bvin,
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
			bvc_Product.Status,
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
			bvc_Product.LastUpdated,
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
			)
		
		SELECT *, (SELECT COUNT(*) FROM Products) AS TotalRowCount FROM Products WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
		ORDER BY RowNum
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH






























GO
PRINT N'Creating [dbo].[bvc_Policy_ByType_s]'
GO




CREATE PROCEDURE [dbo].[bvc_Policy_ByType_s]

@bvin int,
@StoreId bigint,
@blockbvin varchar(36) = ''
AS
	BEGIN TRY
		SELECT TOP 1 bvin,Title,SystemPolicy,LastUpdated,StoreId,PolicyType
		FROM bvc_Policy
		WHERE PolicyType=@bvin and StoreId=@StoreId

		Set @blockbvin = (Select top 1 bvin from bvc_Policy where PolicyType=@bvin and StoreId=@StoreId)
		
		exec bvc_PolicyBlock_ByPolicyId_s @blockbvin, @StoreId
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















GO
PRINT N'Creating [dbo].[bvc_ContentColumn_i]'
GO
CREATE PROCEDURE [dbo].[bvc_ContentColumn_i]
@bvin varchar(36),
@DisplayName nvarchar(512),
@SystemColumn int = 0,
@StoreId bigint

AS
	BEGIN TRY
		INSERT INTO bvc_ContentColumn
		(
		bvin,
		DisplayName,
		SystemColumn,
		LastUpdated,
		StoreId
		)
		VALUES
		(
		@bvin,
		@DisplayName,
		@SystemColumn,
		GetUtcDate(),
		@StoreId
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_Product_Featured_s]'
GO



CREATE PROCEDURE [dbo].[bvc_Product_Featured_s]

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
		p.LastUpdated,
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
		p.StoreId,
		Featured,
		AllowReviews,
		DescriptionTabs,
		IsAvailableForSale
		
		FROM bvc_Product p
		WHERE p.StoreId=@StoreId AND Featured = 1 and IsAvailableForSale = 1
		Order by LastUpdated desc
		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN






























GO
PRINT N'Creating [dbo].[bvc_ProductFileByProduct_s]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductFileByProduct_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY	
		SELECT
		bvc_ProductFile.bvin,bvc_ProductFileXProduct.ProductID,bvc_ProductFileXProduct.AvailableMinutes,
		bvc_ProductFileXProduct.MaxDownloads,bvc_ProductFile.[FileName],
		bvc_ProductFile.ShortDescription,bvc_ProductFileXProduct.LastUpdated, bvc_ProductFile.StoreId
		
		FROM bvc_ProductFile JOIN bvc_ProductFileXProduct ON bvc_ProductFile.bvin = bvc_ProductFileXProduct.ProductFileId
		WHERE bvc_ProductFileXProduct.ProductID=@bvin 
		 and bvc_ProductFile.StoreId=@StoreId
		ORDER BY ShortDescription
		

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















GO
PRINT N'Creating [dbo].[bvc_ProductFile_AddProduct_i]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductFile_AddProduct_i]

@FileBvin varchar(36),
@ProductBvin varchar(36),
@AvailableMinutes int,
@MaxDownloads int,
@StoreId bigint

AS
	
	BEGIN TRY
		INSERT INTO bvc_ProductFileXProduct(ProductFileId, ProductId, AvailableMinutes, MaxDownloads, LastUpdated,StoreId)
			VALUES(@FileBvin, @ProductBvin, @AvailableMinutes, @MaxDownloads, GetUtcDate(),@StoreId)
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_ProductFile_All_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductFile_All_s]
@StartRowIndex int = 0,
@MaximumRows int = 9999999,
@StoreId bigint
AS
	BEGIN TRY;
		WITH files As
		(SELECT 
			ROW_NUMBER() OVER (ORDER BY FileName) As RowNum,
			bvin, [FileName], ShortDescription, StoreId
		FROM bvc_ProductFile WHERE StoreId=@StoreId)

		SELECT *, (SELECT COUNT(*) FROM files) AS TotalRowCount FROM files
			WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum
		
		RETURN	
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















GO
PRINT N'Creating [dbo].[bvc_UserAccount_Filter_s]'
GO




CREATE PROCEDURE [dbo].[bvc_UserAccount_Filter_s]
	
@filter nvarchar(max),
@StartRowIndex int = 0,
@MaximumRows int = 9999999,
@StoreId bigint

AS

BEGIN
	BEGIN TRY
		SET NOCOUNT ON;
		
		WITH UserAccounts AS
		(SELECT ROW_NUMBER() OVER (ORDER BY LastName, FirstName, Email) As RowNum,
			bvin,[Password],[Firstname],[LastName],Salt,TaxExempt,
			Email,CreationDate,LastLoginDate,Comment,AddressBook,
			LastUpdated,Locked,LockedUntil,FailedLoginCount,Phones,
			PricingGroup,CustomQuestionAnswers,StoreId
		FROM bvc_User
		WHERE StoreId=@StoreId AND ( (firstname LIKE @filter) OR
			(lastname LIKE @filter) OR (email LIKE @filter) OR
			(AddressBook LIKE @filter) OR (Phones LIKE @filter)
			) )

		SELECT *, (SELECT COUNT(*) FROM UserAccounts) AS TotalRowCount FROM UserAccounts
			WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END
















GO
PRINT N'Creating [dbo].[bvc_ContentBlock_ByColumnID_s]'
GO
CREATE PROCEDURE [dbo].[bvc_ContentBlock_ByColumnID_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT 
			bvin,ColumnID,SortOrder,
			ControlName,LastUpdated, StoreId, SerializedSettings, SerializedLists
			FROM bvc_ContentBlock
			WHERE ColumnID=@bvin and StoreId=@StoreId
		ORDER BY SortOrder

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH










GO
PRINT N'Creating [dbo].[bvc_ProductType_i]'
GO




CREATE PROCEDURE [dbo].[bvc_ProductType_i]
@bvin varchar(36),
@ProductTypeName nvarchar(512),
@IsPermanent bit,
@storeid bigint

AS
	
	BEGIN TRY
		INSERT INTO bvc_ProductType
		(
			bvin,
			ProductTypeName,
			IsPermanent,
			LastUpdated,
			StoreId
		)
		VALUES
		(
			@bvin,
			@ProductTypeName,
			@IsPermanent,
			GetUtcDate(),
			@StoreId
		)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	RETURN






GO
PRINT N'Creating [dbo].[bvc_ContentColumn_u]'
GO
CREATE PROCEDURE [dbo].[bvc_ContentColumn_u]

@bvin varchar(36),
@DisplayName nvarchar(512),
@SystemColumn int = 0,
@StoreId bigint

AS
	BEGIN TRY
		UPDATE bvc_ContentColumn
		SET
		bvin=@bvin,
		DisplayName=@DisplayName,
		SystemColumn=@SystemColumn,
		LastUpdated=GetUtcDate()
		WHERE bvin=@bvin and StoreId=@StoreId
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductFilter_ByName_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductFilter_ByName_s]
	@name nvarchar(300),
	@page nvarchar(1000),
	@StoreId bigint
AS
BEGIN
	BEGIN TRY
		SELECT bvin, FilterName, Criteria, Page, LastUpdated,StoreId 
		FROM bvc_ProductFilter 
		WHERE FilterName = @name And Page = @page and StoreId=@StoreId
	END TRY
	BEGIN CATCH		
		EXEC bvc_EventLog_SQL_i
	END CATCH
END



























GO
PRINT N'Creating [dbo].[bvc_OrderStatusCode_d]'
GO

CREATE PROCEDURE [dbo].[bvc_OrderStatusCode_d]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		DELETE FROM bvc_OrderStatusCode WHERE bvin=@bvin and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_UserAccount_i]'
GO


CREATE PROCEDURE [dbo].[bvc_UserAccount_i]

@bvin varchar(36),
@Password varchar(36),
@FirstName varchar(36),
@LastName nvarchar(100),
@Salt varchar(36),
@TaxExempt int,
@Email nvarchar(100),
@CreationDate datetime,
@LastLoginDate datetime,
@Comment ntext,
@AddressBook ntext,
@Locked int,
@LockedUntil datetime,
@FailedLoginCount int,
@Phones nvarchar(Max),
@PricingGroup varchar(36),
@CustomQuestionAnswers nvarchar(Max),
@StoreId bigint

AS
	BEGIN TRY
		INSERT INTO bvc_User
		(bvin,
		[Password],
		[FirstName],
		[LastName],
		Salt,
		TaxExempt,
		Email,
		CreationDate,
		LastLoginDate,
		Comment,
		AddressBook,
		LastUpdated,
		Locked,
		LockedUntil,
		FailedLoginCount,
		Phones,
		PricingGroup,
		CustomQuestionAnswers,
		StoreId
		)
		
		VALUES
		(@bvin,
		@Password,
		@FirstName,
		@LastName,
		@Salt,
		@TaxExempt,
		@Email,
		@CreationDate,
		@LastLoginDate,
		@Comment,
		@AddressBook,
		GetUtcDate(),
		@Locked,
		@LockedUntil,
		@FailedLoginCount,
		@Phones,
		@PricingGroup,
		@CustomQuestionAnswers,
		@StoreId
		)

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
















GO
PRINT N'Creating [dbo].[bvc_ProductFilter_d ]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductFilter_d ]
	@bvin varchar(36),
	@StoreId bigint
AS
BEGIN
	BEGIN TRY
		DELETE FROM bvc_ProductFilter WHERE bvin = @bvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH		
		EXEC bvc_EventLog_SQL_i
	END CATCH
END




























GO
PRINT N'Creating [dbo].[bvc_ContentColumn_All_s]'
GO
CREATE PROCEDURE [dbo].[bvc_ContentColumn_All_s]

@StoreId bigint

AS
	BEGIN TRY
		SELECT bvin,DisplayName,SystemColumn,LastUpdated,StoreId 
		FROM bvc_ContentColumn
		WHERE StoreId=@StoreId
		ORDER BY DisplayName
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
Return











GO
PRINT N'Creating [dbo].[bvc_ProductType_Properties_s]'
GO




CREATE PROCEDURE [dbo].[bvc_ProductType_Properties_s]

@bvin varchar(36),
@storeid bigint

AS

	BEGIN TRY
	
				SELECT 
				id,
				PropertyName,
				DisplayName,
				DisplayOnSite,
				DisplayToDropShipper,
				TypeCode,
				DefaultValue,
				CultureCode,
				SortOrder,
				LastUpdated,
				pp.StoreId

				FROM bvc_ProductProperty pp 
				JOIN bvc_ProductTypeXProductProperty ptp 
				ON pp.Id = ptp.PropertyId

				WHERE ptp.ProductTypeBvin=@bvin and pp.StoreId=@StoreId

				ORDER BY ptp.SortOrder ASC
		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN






GO
PRINT N'Creating [dbo].[bvc_ContentColumn_ByName_s]'
GO

CREATE PROCEDURE [dbo].[bvc_ContentColumn_ByName_s]

@DisplayName nvarchar(512),
@columnBvin varchar(36) = '',
@StoreId bigint

AS
	BEGIN TRY
		SELECT bvin,DisplayName,SystemColumn,LastUpdated, StoreId
		FROM bvc_ContentColumn
		WHERE DisplayName=@DisplayName and StoreId=@StoreId
		
		SET @columnBvin = (Select bvin FROM bvc_ContentColumn WHERE DisplayName=@DisplayName and StoreId=@StoreId)
			
		EXEC bvc_ContentBlock_ByColumnID_s @columnBvin, @StoreId
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ContentColumn_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ContentColumn_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT bvin,DisplayName,SystemColumn,LastUpdated, StoreId
		FROM bvc_ContentColumn
		WHERE bvin=@bvin and StoreId=@StoreId
		
		EXEC bvc_ContentBlock_ByColumnID_s @bvin, @StoreId
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	













GO
PRINT N'Creating [dbo].[bvc_OrderStatusCode_i]'
GO



CREATE PROCEDURE [dbo].[bvc_OrderStatusCode_i]

@bvin varchar(36),
@SortOrder int,
@StatusName nvarchar(Max),
@SystemCode int,
@StoreId bigint

AS

	BEGIN TRY
		IF (Select Count(bvin) FROM bvc_OrderStatusCode WHERE StoreId=@StoreId) > 0
			BEGIN
			SET @SortOrder = (Select Max(SortOrder) FROM bvc_OrderStatusCode where StoreId=@StoreId)+1
			END
		ELSE
			BEGIN
			SET @SortOrder = 1
			END

		INSERT INTO
		bvc_OrderStatusCode
		(
		bvin,
		SortOrder,
		StatusName,
		SystemCode,
		LastUpdated,
		StoreId
		)
		VALUES
		(
		@bvin,
		@SortOrder,
		@StatusName,
		@SystemCode,
		GetUtcDate(),
		@StoreId
		)

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_ProductFilter_i ]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductFilter_i ]
	@bvin varchar(36), 
	@name nvarchar(300),
	@criteria nvarchar(max),
	@page nvarchar(1000),
	@StoreId bigint
AS
BEGIN
	BEGIN TRY
		INSERT INTO bvc_ProductFilter 
		(bvin, FilterName, Criteria, Page, LastUpdated,StoreId) 
		VALUES (@bvin, @name, @criteria, @page, GetUtcDate(), @StoreId)		
	END TRY
	BEGIN CATCH		
		EXEC bvc_EventLog_SQL_i
	END CATCH
END



























GO
PRINT N'Creating [dbo].[bvc_ProductFilter_All_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductFilter_All_s]
	@page nvarchar(1000),
	@StoreId bigint
AS
BEGIN
	BEGIN TRY
		SELECT bvin, FilterName, Criteria, Page, LastUpdated,StoreId 
		FROM bvc_ProductFilter 
		WHERE Page = @page  and StoreId=@StoreId
		ORDER BY FilterName
	END TRY
	BEGIN CATCH		
		EXEC bvc_EventLog_SQL_i
	END CATCH
END



























GO
PRINT N'Creating [dbo].[bvc_ProductType_Property_u]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductType_Property_u]

@ProductTypeBvin varchar(36),
@PropertyId bigint,
@SortOrder int,
@storeid bigint

AS
	BEGIN TRY
	
				UPDATE bvc_ProductTypeXProductProperty		
				SET
					SortOrder=@SortOrder
				WHERE ProductTypeBvin=@ProductTypeBvin
					AND PropertyId=@PropertyId
					AND StoreId=@storeid
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN





GO
PRINT N'Creating [dbo].[bvc_ProductFilter_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductFilter_s]
	@bvin varchar(36),
	@StoreId bigint
AS
BEGIN
	BEGIN TRY
		SELECT bvin, FilterName, Criteria, Page, LastUpdated,StoreId 
		FROM bvc_ProductFilter WHERE bvin = @bvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH		
		EXEC bvc_EventLog_SQL_i
	END CATCH
END



























GO
PRINT N'Creating [dbo].[bvc_ProductType_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductType_s]

@bvin varchar(36),
@storeid bigint

AS

	BEGIN TRY
		SELECT 
		bvin,
		ProductTypeName,
		IsPermanent,
		LastUpdated,
		StoreId

		FROM bvc_ProductType

		WHERE bvin=@bvin and storeid=@storeid
		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN





GO
PRINT N'Creating [dbo].[bvc_OrderStatusCode_s]'
GO


CREATE PROCEDURE [dbo].[bvc_OrderStatusCode_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT 
		bvin,
		SortOrder,
		StatusName,
		SystemCode,
		LastUpdated,
		StoreId
		FROM bvc_OrderStatusCode
		WHERE bvin=@bvin and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_ProductFilter_u]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductFilter_u]
	@bvin varchar(36), 
	@name nvarchar(300),
	@criteria nvarchar(max),
	@page nvarchar(1000),
	@StoreId bigint
AS
BEGIN
	BEGIN TRY
		UPDATE bvc_ProductFilter 
		SET bvin = @bvin, FilterName = @name, Criteria = @criteria, Page = @page, LastUpdated = GetUtcDate() 
		WHERE bvin = @bvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH		
		EXEC bvc_EventLog_SQL_i
	END CATCH
END



























GO
PRINT N'Creating [dbo].[bvc_UserAccount_u]'
GO

CREATE PROCEDURE [dbo].[bvc_UserAccount_u]

@bvin varchar(36),
@Password varchar(36),
@FirstName varchar(36),
@LastName nvarchar(100),
@Salt varchar(36),
@TaxExempt int,
@Email nvarchar(100),
@CreationDate datetime,
@LastLoginDate datetime,
@Comment ntext,
@AddressBook ntext,
@Locked int,
@LockedUntil datetime,
@FailedLoginCount int,
@Phones nvarchar(Max),
@PricingGroup varchar(36),
@CustomQuestionAnswers nvarchar(Max),
@StoreId bigint


AS
	BEGIN TRY
		UPDATE bvc_User
		SET 
		[Password]=@Password,
		[FirstName]=@FirstName,
		Salt=@Salt,
		[LastName]=@LastName,
		TaxExempt=@TaxExempt,
		Email=@Email,
		CreationDate = @CreationDate,
		LastLoginDate=@LastLoginDate,
		Comment=@Comment,
		AddressBook=@AddressBook,
		LastUpdated=GetUtcDate(),
		Locked=@Locked,
		LockedUntil=@LockedUntil,
		FailedLoginCount=@FailedLoginCount,
		Phones=@Phones,
		PricingGroup=@PricingGroup,
		CustomQuestionAnswers=@CustomQuestionAnswers
		
		WHERE bvin=@bvin and StoreId=@StoreId

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
















GO
PRINT N'Creating [dbo].[bvc_ProductType_u]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductType_u]

@bvin  varchar(36),
@ProductTypeName nvarchar(512),
@IsPermanent bit,
@storeid bigint

AS

	BEGIN TRY
		UPDATE bvc_ProductType

		SET
		ProductTypeName=@ProductTypeName,
		IsPermanent=@IsPermanent,
		LastUpdated = GetUtcDate()		
		WHERE [bvin]=@bvin and storeid=@storeid
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH






GO
PRINT N'Creating [dbo].[bvc_OrderStatusCode_SortOrder_u]'
GO


CREATE PROCEDURE [dbo].[bvc_OrderStatusCode_SortOrder_u]

@bvin varchar(36),
@SortOrder int,
@StoreId bigint

AS
	BEGIN TRY
		UPDATE bvc_OrderStatusCode SET SortOrder=@SortOrder,LastUpdated=GetUtcDate() 
		WHERE bvin=@bvin and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_ProductTypeProperty_d]'
GO




CREATE PROCEDURE [dbo].[bvc_ProductTypeProperty_d]

@ProductTypeBvin varchar(36),
@PropertyId bigint,
@StoreId bigint

 AS
	BEGIN TRY
	
				DELETE FROM bvc_ProductTypeXProductProperty
				WHERE
				ProductTypeBvin=@ProductTypeBvin AND
				PropertyId=@PropertyId
				 and StoreId=@StoreId
				 
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN






GO
PRINT N'Creating [dbo].[bvc_OrderStatusCode_u]'
GO


CREATE PROCEDURE [dbo].[bvc_OrderStatusCode_u]

@bvin varchar(36),
@SortOrder int,
@StatusName nvarchar(Max),
@SystemCode int,
@StoreId bigint

AS
	BEGIN TRY
		UPDATE bvc_OrderStatusCode
		SET 
		bvin=@bvin,
		SortOrder=@SortOrder,
		StatusName=@StatusName,
		SystemCode=@SystemCode,	
		LastUpdated=GetUtcDate()
		WHERE bvin=@bvin and StoreId=@StoreId

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_Product_i]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_i]

@bvin varchar(36),
@SKU varchar(50),
@ProductTypeID varchar(36),
@ProductName nvarchar(512),
@ListPrice  numeric(18,10),
@SitePrice  numeric(18,10),
@SiteCost numeric(18,10),
@MetaKeywords  nvarchar(255),
@MetaDescription  nvarchar(255),
@MetaTitle  nvarchar(512),
@TaxExempt  int,
@TaxClass  varchar(36),
@NonShipping  int,
@ShipSeparately  int,
@ShippingMode  int,
@ShippingWeight  numeric(18,10),
@ShippingLength numeric(18,10),
@ShippingWidth numeric(18,10),
@ShippingHeight numeric(18,10),
@Status int,
@ImageFileSmall nvarchar(1000),
@ImageFileMedium nvarchar(1000),
@MinimumQty int,
@ShortDescription nvarchar(255),
@LongDescription nvarchar(max),
@ManufacturerID varchar(36),
@VendorID varchar(36),
@GiftWrapAllowed int,
@ExtraShipFee numeric(18,10),
@Keywords nvarchar(Max),
@TemplateName nvarchar(512),
@PreContentColumnId varchar(36),
@PostContentColumnId varchar(36),
@RewriteUrl nvarchar(Max),
@SitePriceOverrideText nvarchar(255),
@PreTransformLongDescription nvarchar(max),
@SmallImageAlternateText nvarchar(255),
@MediumImageAlternateText nvarchar(255),
@OutOfStockMode int,
@CustomProperties nvarchar(max),
@GiftWrapPrice numeric(18,10),
@StoreId bigint,
@Featured bit,
@AllowReviews bit,
@DescriptionTabs ntext,
@IsAvailableForSale bit

AS
	BEGIN TRY
		INSERT INTO bvc_Product
		(
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
		)
		VALUES
		(
		@bvin,
		@SKU,
		@ProductTypeID,
		@ProductName,
		@ListPrice,
		@SitePrice,
		@SiteCost,
		@MetaKeywords,
		@MetaDescription,
		@MetaTitle,
		@TaxExempt,
		@TaxClass,
		@NonShipping,
		@ShipSeparately,
		@ShippingMode,
		@ShippingWeight,
		@ShippingLength,
		@ShippingWidth,
		@ShippingHeight,
		@Status,
		@ImageFileSmall,
		@ImageFileMedium,
		GetUtcDate(),
		@MinimumQty,
		@ShortDescription,
		@LongDescription,
		@ManufacturerID,
		@VendorID,
		@GiftWrapAllowed,
		@ExtraShipFee,
		GetUtcDate(),
		@Keywords,
		@TemplateName,
		@PreContentColumnId,
		@PostContentColumnId,
		@RewriteUrl,
		@SitePriceOverrideText,
		@PreTransformLongDescription,
		@SmallImageAlternateText,
		@MediumImageAlternateText,
		@OutOfStockMode,
		@CustomProperties,		
		@GiftWrapPrice,
		@StoreId,
		@Featured,
		@AllowReviews,
		@DescriptionTabs,
		@IsAvailableForSale
		)


		RETURN
	END TRY
	BEGIN CATCH		
		EXEC bvc_EventLog_SQL_i
	END CATCH






























GO
PRINT N'Creating [dbo].[bvc_UserQuestion_d]'
GO
CREATE PROCEDURE [dbo].[bvc_UserQuestion_d]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		DELETE FROM bvc_UserQuestions WHERE bvin = @bvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH








GO
PRINT N'Creating [dbo].[bvc_SearchQuery_All_d]'
GO
CREATE PROCEDURE [dbo].[bvc_SearchQuery_All_d]
	@StoreId bigint
AS

	BEGIN TRY
		DELETE FROM bvc_SearchQuery 
		WHERE StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductTypeProperty_i]'
GO





CREATE PROCEDURE [dbo].[bvc_ProductTypeProperty_i]

@ProductTypeBvin varchar(36),
@PropertyId bigint,
@SortOrder int,
@StoreId bigint

 AS
	BEGIN TRY
	
				INSERT INTO bvc_ProductTypeXProductProperty 
				(ProductTypeBvin,PropertyId,SortOrder,StoreId)
				VALUES (@ProductTypeBvin,@PropertyId,@SortOrder,@storeid)

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


RETURN







GO
PRINT N'Creating [dbo].[bvc_ProductInventory_Adjust_u]'
GO

-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_Adjust_u] 

	@ProductBvin varchar(36),
	@VariantId nvarchar(MAX),
	@Adjustment int,
	@StoreId bigint

AS
BEGIN
	BEGIN TRY
		UPDATE bvc_ProductInventory
		SET	
		QuantityOnHand=QuantityOnHand + @Adjustment,
		LastUpdated=GetUtcDate()
		WHERE ProductBvin=@ProductBvin AND
			VariantId=@VariantId and StoreId=@StoreId

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END














GO
PRINT N'Creating [dbo].[bvc_UserQuestion_i]'
GO

CREATE PROCEDURE [dbo].[bvc_UserQuestion_i]

@bvin varchar(36),
@QuestionName nvarchar(50),
@QuestionType int,
@Values nvarchar(max),
@Order int,
@StoreId bigint

AS
	BEGIN TRY
		SET @Order = (SELECT MAX([Order]) FROM bvc_UserQuestions WHERE StoreId=@StoreId)
		IF @Order IS NULL
			SET @Order = 0
		SET @Order = @Order + 1

		INSERT INTO	bvc_UserQuestions
		(
		bvin,
		QuestionName,
		QuestionType,
		[Values],
		[Order],
		LastUpdated,
		StoreId)
		VALUES(
		@bvin,
		@QuestionName,
		@QuestionType,
		@Values,
		@Order,
		GetUtcDate(),
		@StoreId
		) 

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_CustomUrl_All_S]'
GO


CREATE PROCEDURE [dbo].[bvc_CustomUrl_All_S]
@StartRowIndex int = 0,
@MaximumRows int = 9999999,
@StoreId bigint
AS
	BEGIN TRY;
		WITH Urls AS
		(SELECT 
		ROW_NUMBER() OVER (ORDER BY RequestedUrl) As RowNum,
		bvin,
		RequestedUrl,
		RedirectToUrl,
		IsPermanentRedirect,
		SystemDataType,
		SystemData,
		LastUpdated,
		StoreId
		FROM bvc_CustomUrl where StoreId=@StoreId)
		
		SELECT *, (SELECT COUNT(*) FROM Urls) AS TotalRowCount FROM Urls
			WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH














GO
PRINT N'Creating [dbo].[bvc_Product_Light_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_Light_s]

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
		WHERE bvin=@bvin  and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	

	RETURN


































GO
PRINT N'Creating [dbo].[bvc_Policy_i]'
GO
CREATE PROCEDURE [dbo].[bvc_Policy_i]

@bvin varchar(36),
@Title nvarchar(Max),
@SystemPolicy int,
@StoreId bigint,
@PolicyType int

AS
	BEGIN TRY
		INSERT INTO bvc_Policy
		(
		bvin,
		Title,
		SystemPolicy,
		LastUpdated,
		StoreId,
		PolicyType
		)
		VALUES
		(
		@bvin,
		@Title,
		@SystemPolicy,
		GetUtcDate(),
		@StoreId,
		@PolicyType
		)
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH










GO
PRINT N'Creating [dbo].[bvc_UserQuestion_s]'
GO

CREATE PROCEDURE [dbo].[bvc_UserQuestion_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT bvin, QuestionName, QuestionType, [Values], [Order], LastUpdated,StoreId 
		FROM bvc_UserQuestions 
		WHERE bvin = @bvin and StoreId=@StoreId 
		ORDER BY [Order]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


















GO
PRINT N'Creating [dbo].[bvc_PolicyBlock_ByPolicyId_s]'
GO



CREATE PROCEDURE [dbo].[bvc_PolicyBlock_ByPolicyId_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT bvin,[Name],[Description],PolicyID,SortOrder,LastUpdated,DescriptionPreTransform,StoreId
		FROM bvc_PolicyBlock
		WHERE PolicyID=@bvin and StoreId=@StoreId 
		ORDER BY SortOrder
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_OrderStatusCode_All_s]'
GO



CREATE PROCEDURE [dbo].[bvc_OrderStatusCode_All_s]

@StoreId bigint

AS
	BEGIN TRY
		SELECT bvin,SortOrder,StatusName,SystemCode,LastUpdated,StoreId
		FROM bvc_OrderStatusCode
		WHERE  StoreId=@StoreId
		ORDER BY SortOrder
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_Policy_u]'
GO

CREATE PROCEDURE [dbo].[bvc_Policy_u]

@bvin varchar(36),
@Title nvarchar(Max),
@SystemPolicy int,
@StoreId bigint,
@PolicyType int

AS
	BEGIN TRY
		Update bvc_Policy
		SET
		bvin=@bvin,
		Title=@Title,
		SystemPolicy=@SystemPolicy,
		LastUpdated=GetUtcDate(),
		PolicyType = @PolicyType
		WHERE
		bvin=@bvin and StoreId=@StoreId
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_Policy_All_s]'
GO
CREATE PROCEDURE [dbo].[bvc_Policy_All_s]

@StoreId bigint

AS
	BEGIN TRY
		SELECT bvin,Title,SystemPolicy,LastUpdated,StoreId,PolicyType
		FROM bvc_Policy
		WHERE StoreId=@StoreId
		ORDER BY Title
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_UserQuestion_u]'
GO
CREATE PROCEDURE [dbo].[bvc_UserQuestion_u]

@bvin varchar(36),
@QuestionName nvarchar(50),
@QuestionType int,
@Values nvarchar(max),
@Order int,
@StoreId bigint

AS
	BEGIN TRY
		UPDATE bvc_UserQuestions SET bvin = @bvin, QuestionName = @QuestionName, QuestionType = @QuestionType, 
			[Values] = @Values, [Order] = @Order, LastUpdated = GetUtcDate() WHERE bvin = @bvin and StoreId=@StoreId	
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH









GO
PRINT N'Creating [dbo].[bvc_Policy_d]'
GO
CREATE PROCEDURE [dbo].[bvc_Policy_d]
	
	@bvin varchar(36),
	@StoreId bigint
	
AS
	BEGIN TRY
		DELETE bvc_PolicyBlock WHERE policyID=@bvin and StoreId=@StoreId
		DELETE bvc_Policy WHERE bvin=@bvin and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_PolicyBlock_d]'
GO

CREATE PROCEDURE [dbo].[bvc_PolicyBlock_d]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		DELETE FROM bvc_PolicyBlock WHERE bvin=@bvin and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_Product_ByOrder_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_ByOrder_s]

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
			WHERE bvin IN (
			SELECT ProductId FROM bvc_LineItem WHERE OrderBvin=@bvin and StoreId=@StoreId
			)

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



























GO
PRINT N'Creating [dbo].[bvc_Policy_s]'
GO



CREATE PROCEDURE [dbo].[bvc_Policy_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT bvin,Title,SystemPolicy,LastUpdated,StoreId,PolicyType
		FROM bvc_Policy
		WHERE bvin=@bvin and StoreId=@StoreId

		exec bvc_PolicyBlock_ByPolicyId_s @bvin, @StoreId
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH














GO
PRINT N'Creating [dbo].[bvc_ComponentSetting_i]'
GO


CREATE PROCEDURE [dbo].[bvc_ComponentSetting_i]

@ComponentID varchar(36),
@SettingName nvarchar(100),
@SettingValue text,
@DeveloperId nvarchar(15),
@ComponentType nvarchar(25),
@ComponentSubType nvarchar(25),
@StoreId bigint

AS
	BEGIN TRY

		DELETE bvc_ComponentSetting WHERE ComponentID=@ComponentID
		AND SettingName = @SettingName and StoreId=@StoreId

		INSERT INTO bvc_ComponentSetting
		(ComponentID,SettingName,SettingValue,DeveloperId,ComponentType,ComponentSubType, StoreId)
		VALUES
		(@ComponentID,@SettingName,@SettingValue,@DeveloperId,@ComponentType,@ComponentSubType, @StoreId)
	
	RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_ProductProperty_Exists_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductProperty_Exists_s]

@PropertyName nvarchar(512),
@StoreId bigint

AS
	BEGIN TRY
		SELECT 
			id,
			PropertyName,
			DisplayName,
			DisplayOnSite,
			DisplayToDropShipper,
			TypeCode,
			DefaultValue,
			CultureCode,
			LastUpdated,
			StoreId

		FROM bvc_ProductProperty

		WHERE PropertyName=@PropertyName and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN





GO
PRINT N'Creating [dbo].[bvc_WishList_u]'
GO
CREATE PROCEDURE [dbo].[bvc_WishList_u]	

@bvin varchar(36),
@userId varchar(36),
@ProductBvin varchar(36),
@Quantity int,
@Modifiers nvarchar(max),
@Inputs nvarchar(max),
@StoreId bigint
AS
BEGIN
	BEGIN TRY		
		UPDATE bvc_WishList
		SET Userid = @userid,
		ProductBvin = @ProductBvin,
		Quantity = @Quantity,
		Modifiers = @Modifiers,
		Inputs = @Inputs
		WHERE bvin = @bvin and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END

 




GO
PRINT N'Creating [dbo].[bvc_ProductProperty_All_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductProperty_All_s]
	@StoreId bigint
AS

	BEGIN TRY
		SELECT 
			id,
			PropertyName,
			DisplayName,
			DisplayOnSite,
			DisplayToDropShipper,
			TypeCode,
			DefaultValue,
			CultureCode,
			LastUpdated,
			StoreId

		FROM bvc_ProductProperty
		WHERE StoreId=@StoreId
		ORDER BY PropertyName
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN





GO
PRINT N'Creating [dbo].[bvc_PolicyBlock_i]'
GO



CREATE PROCEDURE [dbo].[bvc_PolicyBlock_i]

@bvin varchar(36),
@Name nvarchar(255),
@Description ntext,
@PolicyID varchar(36),
@SortOrder int,
@DescriptionPreTransform ntext,
@StoreId bigint

AS
	BEGIN TRY
		IF (Select Count(bvin) FROM bvc_PolicyBlock WHERE PolicyId=@PolicyId and StoreId=@StoreId) > 0
			BEGIN
			SET @SortOrder = (Select Max(SortOrder) FROM bvc_PolicyBlock WHERE PolicyId=@PolicyId and StoreId=@StoreId)+1
			END
		ELSE
			BEGIN
			SET @SortOrder = 1
			END

		INSERT INTO
		bvc_PolicyBlock
		(bvin,[Name],[Description],PolicyID,SortOrder,LastUpdated,DescriptionPreTransform,StoreId)
		VALUES(@bvin,@Name,@Description,@PolicyID,@SortOrder,GetUtcDate(),@DescriptionPreTransform,@StoreId)

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_ProductProperty_i]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductProperty_i]
@id bigint,
@PropertyName nvarchar(512),
@DisplayName nvarchar(512),
@DisplayOnSite int,
@DisplayToDropShipper int,
@TypeCode int,
@DefaultValue nvarchar(max),
@CultureCode nvarchar(10),
@StoreId bigint

AS
	BEGIN TRY
		INSERT INTO bvc_ProductProperty
		(PropertyName,DisplayName,DisplayOnSite,DisplayToDropShipper,TypeCode,DefaultValue,
		CultureCode, LastUpdated,StoreId)
		VALUES (@PropertyName,@DisplayName,@DisplayOnSite,@DisplayToDropShipper,@TypeCode,
		@DefaultValue,@CultureCode, GetUtcDate(),@StoreId)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	
	RETURN





GO
PRINT N'Creating [dbo].[bvc_ComponentSetting_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ComponentSetting_s]

@ComponentID varchar(36),
@SettingName nvarchar(100),
@StoreId bigint

AS
	
BEGIN TRY
	SELECT SettingValue,ComponentID,SettingName,DeveloperId,ComponentType,ComponentSubType 
	FROM bvc_ComponentSetting WHERE
	ComponentID=@ComponentID and
	SettingName =@SettingName and
	StoreId=@StoreId

	RETURN
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH













GO
PRINT N'Creating [dbo].[bvc_PolicyBlock_s]'
GO


CREATE PROCEDURE [dbo].[bvc_PolicyBlock_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT bvin,[Name],Description,PolicyID,SortOrder,LastUpdated,DescriptionPreTransform,StoreId
		FROM bvc_PolicyBlock
		WHERE bvin=@bvin and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_ComponentSettingList_All_s]'
GO
CREATE PROCEDURE [dbo].[bvc_ComponentSettingList_All_s]

@StoreId bigint

AS
BEGIN TRY
	SELECT 
	bvin,ComponentID,DeveloperId,ComponentType,
	ComponentSubType,ListName,SortOrder,
	Setting1,Setting2,Setting3,Setting4,Setting5,
	Setting6,Setting7,Setting8,Setting9,Setting10,
	LastUpdated 
	FROM bvc_ComponentSettingList
	WHERE StoreId=@StoreId
	ORDER By ComponentId,SortOrder
	
	RETURN
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductProperty_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductProperty_s]

@id bigint,
@StoreId bigint

AS

BEGIN TRY
	SELECT 
		id,
		PropertyName,
		DisplayName,
		DisplayOnSite,
		DisplayToDropShipper,
		TypeCode,
		DefaultValue,
		CultureCode,
		LastUpdated,
		StoreId
	FROM bvc_ProductProperty
	WHERE id=@id and StoreId=@StoreId
	
	SELECT
		id,
		PropertyId,
		ChoiceName,
		SortOrder,
		LastUpdated,
		StoreId
	FROM bvc_ProductPropertyChoice
	WHERE PropertyId = @id and StoreId=@StoreId
	ORDER BY SortOrder
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH

	RETURN





GO
PRINT N'Creating [dbo].[bvc_ProductReview_ByProductBvin_s]'
GO









CREATE PROCEDURE [dbo].[bvc_ProductReview_ByProductBvin_s]

@bvin varchar(36),
@moderate int = 0,
@StoreId bigint

AS

	BEGIN TRY
		IF @moderate = 1
			BEGIN
			SELECT 
			r.bvin,
			r.LastUpdated,
			r.Approved, 
			r.Description, 
			r.Karma,
			r.ProductBvin, 
			r.Rating, 
			r.ReviewDate, 
			r.UserID,
			p.ProductName,
			r.StoreId
			FROM bvc_ProductReview r
			JOIN bvc_Product p on r.ProductBvin = p.bvin
			WHERE r.ProductBvin = @bvin and (@storeId = -1 OR p.StoreId=@StoreId)
			ORDER BY r.Karma DESC, r.ReviewDate DESC
			END
		ELSE
			BEGIN
			SELECT 
			r.bvin,
			r.LastUpdated,
			r.Approved, 
			r.Description, 
			r.Karma,
			r.ProductBvin, 
			r.Rating, 
			r.ReviewDate, 
			r.UserID,
			p.ProductName,
			r.StoreId
			FROM bvc_ProductReview r
			JOIN bvc_Product p on r.ProductBvin = p.bvin
			WHERE r.ProductBvin = @bvin AND r.Approved = 1  and (@StoreId= -1 OR p.StoreId=@StoreId)
			ORDER BY r.Karma DESC, r.ReviewDate DESC
			END
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_PolicyBlock_SortOrder_u]'
GO


CREATE PROCEDURE [dbo].[bvc_PolicyBlock_SortOrder_u]

@bvin varchar(36),
@SortOrder int,
@StoreId bigint

AS
	BEGIN TRY
		UPDATE bvc_PolicyBlock SET SortOrder=@SortOrder,LastUpdated=GetUtcDate() WHERE bvin=@bvin and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_ComponentSettingList_ByComponentId_s]'
GO
CREATE PROCEDURE [dbo].[bvc_ComponentSettingList_ByComponentId_s]

@bvin varchar(36),
@StoreId bigint

AS
BEGIN TRY
	SELECT 
	bvin,ComponentID,DeveloperId,ComponentType,
	ComponentSubType,ListName,SortOrder,
	Setting1,Setting2,Setting3,Setting4,Setting5,
	Setting6,Setting7,Setting8,Setting9,Setting10,
	LastUpdated, StoreId 
	FROM bvc_ComponentSettingList
	WHERE ComponentId = @bvin and StoreId=@StoreId
	ORDER By ListName, SortOrder
	
	RETURN
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH












GO
PRINT N'Creating [dbo].[bvc_UserAccount_ByAffiliateID_s]'
GO


CREATE PROCEDURE [dbo].[bvc_UserAccount_ByAffiliateID_s]

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
PRINT N'Creating [dbo].[bvc_ProductProperty_u]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductProperty_u]

@id bigint,
@PropertyName nvarchar(512),
@DisplayName nvarchar(512),
@DisplayOnSite int,
@DisplayToDropShipper int,
@TypeCode int,
@DefaultValue nvarchar(max),
@CultureCode nvarchar(10),
@StoreId bigint

AS
	BEGIN TRY
			UPDATE bvc_ProductProperty
			
			SET
			PropertyName=@PropertyName,
			DisplayName=@DisplayName,
			DisplayOnSite=@DisplayOnSite,
			DisplayToDropShipper=@DisplayToDropShipper,
			TypeCode=@TypeCode,
			DefaultValue=@DefaultValue,
			CultureCode=@CultureCode,
			LastUpdated=GetUtcDate()
			WHERE id=@id and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	RETURN





GO
PRINT N'Creating [dbo].[bvc_ComponentSettingList_ByListName_d]'
GO


CREATE PROCEDURE [dbo].[bvc_ComponentSettingList_ByListName_d]

@componentID varchar(36),
@listName nvarchar(Max),
@StoreId bigint

AS
	
BEGIN TRY
	DELETE FROM bvc_ComponentSettingList 
	WHERE ComponentId = @componentId 
	AND ListName = @listName	
	AND StoreId=@StoreId
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH

		
RETURN












GO
PRINT N'Creating [dbo].[bvc_PolicyBlock_u]'
GO


CREATE PROCEDURE [dbo].[bvc_PolicyBlock_u]

@bvin varchar(36),
@Name nvarchar(255),
@PolicyID varchar(36),
@Description ntext,
@DescriptionPreTransform ntext,
@SortOrder int,
@StoreId bigint

AS
	BEGIN TRY
		UPDATE bvc_PolicyBlock
		SET [Name]=@Name,
		[Description]=@Description,
		DescriptionPreTransform=@DescriptionPreTransform,
		PolicyID=@PolicyID,
		SortOrder=@SortOrder,
		LastUpdated=GetUtcDate()
		
		WHERE bvin=@bvin and StoreId=@StoreId

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_Product_u]'
GO


CREATE PROCEDURE [dbo].[bvc_Product_u]

@bvin varchar(36),
@SKU varchar(50),
@ProductName nvarchar(512),
@ProductTypeID varchar(36),
@ListPrice  numeric(18,10),
@SitePrice  numeric(18,10),
@SiteCost numeric(18,10),
@MetaKeywords  nvarchar(255),
@MetaDescription  nvarchar(255),
@MetaTitle  nvarchar(512),
@TaxExempt  int,
@TaxClass  varchar(36),
@NonShipping  int,
@ShipSeparately  int,
@ShippingMode  int,
@ShippingWeight  numeric(18,10),
@ShippingLength numeric(18,10),
@ShippingWidth numeric(18,10),
@ShippingHeight numeric(18,10),
@Status int,
@ImageFileSmall nvarchar(1000),
@ImageFileMedium nvarchar(1000),
@MinimumQty int,
@ShortDescription nvarchar(255),
@LongDescription nvarchar(max),
@ManufacturerID varchar(36),
@VendorID varchar(36),
@GiftWrapAllowed int,
@ExtraShipFee numeric(18,10),
@Keywords nvarchar(Max),
@TemplateName nvarchar(512),
@PreContentColumnId varchar(36),
@PostContentColumnId varchar(36),
@RewriteUrl nvarchar(Max),
@SitePriceOverrideText nvarchar(255),
@PreTransformLongDescription nvarchar(max),
@SmallImageAlternateText nvarchar(255),
@MediumImageAlternateText nvarchar(255),
@OutOfStockMode int,
@CustomProperties nvarchar(max),
@GiftWrapPrice numeric(18,10),
@StoreId bigint,
@Featured bit,
@AllowReviews bit,
@DescriptionTabs ntext,
@IsAvailableForSale bit

AS
	BEGIN TRY
		UPDATE bvc_Product
		SET
		
		SKU=@SKU,
		ProductName=@ProductName,
		ProductTypeID=@ProductTypeID,
		ListPrice=@ListPrice,
		SitePrice=@SitePrice,
		SiteCost=@SiteCost,
		MetaKeywords=@MetaKeywords,
		MetaDescription=@MetaDescription,
		MetaTitle=@MetaTitle,
		TaxExempt=@TaxExempt,
		TaxClass=@TaxClass,
		NonShipping=@NonShipping,
		ShipSeparately=@ShipSeparately,
		ShippingMode=@ShippingMode,
		ShippingWeight=@ShippingWeight,
		ShippingLength=@ShippingLength,
		ShippingWidth=@ShippingWidth,
		ShippingHeight=@ShippingHeight,
		Status=@Status,
		ImageFileSmall=@ImageFileSmall,
		ImageFileMedium=@ImageFileMedium,
		MinimumQty=@MinimumQty,
		ShortDescription=@ShortDescription,
		LongDescription=@LongDescription,
		ManufacturerID=@ManufacturerID,
		VendorID=@VendorID,
		GiftWrapAllowed=@GiftWrapAllowed,
		ExtraShipFee=@ExtraShipFee,
		LastUpdated = GetUtcDate(),
		Keywords=@Keywords,
		TemplateName=@TemplateName,
		PreContentColumnId=@PreContentColumnId,
		PostContentColumnId=@PostContentColumnId,
		RewriteUrl=@RewriteUrl,
		SitePriceOverrideText=@SitePriceOverrideText,
		PreTransformLongDescription=@PreTransformLongDescription,
		SmallImageAlternateText=@SmallImageAlternateText,
		MediumImageAlternateText=@MediumImageAlternateText,
		OutOfStockMode=@OutOfStockMode,
		CustomProperties=@CustomProperties,		
		GiftWrapPrice=@GiftWrapPrice,
		Featured = @Featured,
		AllowReviews =@AllowReviews,
		DescriptionTabs = @DescriptionTabs,
		IsAvailableForSale=@IsAvailableForSale

		WHERE bvin=@bvin and StoreId=@StoreId

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH





























GO
PRINT N'Creating [dbo].[bvc_UserAccount_ByEmail_s]'
GO






CREATE PROCEDURE [dbo].[bvc_UserAccount_ByEmail_s]

@UserEmail nvarchar(100),
@StoreId bigint

AS
	BEGIN TRY
		Declare @bvin varchar(36)
		SET @bvin = (SELECT bvin FROM bvc_User WHERE Email=@UserEmail and StoreId=@StoreId)
		
		exec bvc_UserAccount_s @bvin, @StoreId


		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH














GO
PRINT N'Creating [dbo].[bvc_Product_ByCategoryFiltered_s]'
GO
CREATE PROCEDURE [dbo].[bvc_Product_ByCategoryFiltered_s]

@bvin varchar(36),
@ManufacturerId varchar(36) = null,
@ProductTypeId varchar(36) = null,
@StartRowIndex int = 0,
@MaximumRows int = 9999999,
@DisplaySortOrder int = 0,
@StoreId bigint

AS
	BEGIN TRY;
			
			WITH products AS (SELECT
			RowNum = 
				CASE 
					WHEN @DisplaySortOrder = 0 THEN ROW_NUMBER() OVER (ORDER BY SortOrder)
					WHEN @DisplaySortOrder = 1 THEN ROW_NUMBER() OVER (ORDER BY SortOrder)
					WHEN @DisplaySortOrder = 2 THEN ROW_NUMBER() OVER (ORDER BY ProductName)
					WHEN @DisplaySortOrder = 3 THEN ROW_NUMBER() OVER (ORDER BY SitePrice)
					WHEN @DisplaySortOrder = 4 THEN ROW_NUMBER() OVER (ORDER BY SitePrice DESC)					
					WHEN @DisplaySortOrder = 5 THEN ROW_NUMBER() OVER (ORDER BY m.DisplayName, ProductName)
					ELSE ROW_NUMBER() OVER (ORDER BY SortOrder)
				END,			
			p.bvin,
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
			p.Status,
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
			p.LastUpdated,
			Keywords,
			TemplateName,
			PreContentColumnId,
			PostContentColumnId,
			RewriteUrl,
			SitePriceOverrideText,
			px.SortOrder,
			PreTransformLongDescription,
			SmallImageAlternateText,
			MediumImageAlternateText,
			p.OutOfStockMode,
			p.CustomProperties,			
			p.GiftWrapPrice	,
			p.StoreId,
			Featured,
			AllowReviews,
			DescriptionTabs,
			IsAvailableForSale
			
			FROM bvc_Product p JOIN bvc_ProductXCategory px ON p.bvin = px.ProductID 
			LEFT JOIN bvc_ProductInventory AS bpi ON p.bvin = bpi.ProductBvin			
			LEFT JOIN bvc_Manufacturer AS m ON p.ManufacturerId = m.Bvin			
			WHERE px.CategoryID = @bvin
			AND (@ProductTypeId IS NULL OR (p.ProductTypeId = @ProductTypeId))
			AND (@ManufacturerId IS NULL OR (p.ManufacturerId = @ManufacturerId))
			AND p.Status = 1			
			AND p.StoreId = @StoreId
			AND (p.IsAvailableForSale = 1)
			)
			
			SELECT *, (SELECT COUNT(*) FROM products) AS TotalRowCount FROM products WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH







GO
PRINT N'Creating [dbo].[bvc_ProductPropertyByProductType_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductPropertyByProductType_s]

@bvin varchar(36),
@StoreId bigint

AS

BEGIN TRY
	SELECT 
		id,
		PropertyName,
		DisplayName,
		DisplayOnSite,
		DisplayToDropShipper,
		TypeCode,
		DefaultValue,
		CultureCode,
		LastUpdated,
		b.SortOrder,
		a.StoreId
	FROM bvc_ProductProperty AS a JOIN bvc_ProductTypeXProductProperty AS b ON a.id = b.PropertyId
	WHERE b.ProductTypeBvin = @bvin and a.StoreId=@StoreId
	ORDER BY b.SortOrder
		
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH

	RETURN





GO
PRINT N'Creating [dbo].[bvc_Product_ByOption_s]'
GO


CREATE PROCEDURE [dbo].[bvc_Product_ByOption_s]

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
		p.LastUpdated,
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
		p.StoreId,
		Featured,
		AllowReviews,
		DescriptionTabs,
		IsAvailableForSale
		
		FROM bvc_Product p JOIN bvc_ProductXOption px ON p.bvin = px.ProductBvin
		WHERE px.OptionBvin = @bvin and p.StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN





























GO
PRINT N'Creating [dbo].[bvc_ProductVolumeDiscounts_d]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductVolumeDiscounts_d]

@bvin varchar(36),
@StoreId bigint

AS

	BEGIN TRY
		DELETE FROM bvc_ProductVolumeDiscounts WHERE
		bvin=@bvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ComponentSettingList_ByListName_s]'
GO

CREATE PROCEDURE [dbo].[bvc_ComponentSettingList_ByListName_s]

@componentID varchar(36),
@ListName nvarchar(Max),
@StoreId bigint

AS
BEGIN TRY	
	IF @ListName = '' 
		BEGIN
			SELECT 
			bvin,ComponentID,DeveloperId,ComponentType,
			ComponentSubType,ListName,SortOrder,
			Setting1,Setting2,Setting3,Setting4,Setting5,
			Setting6,Setting7,Setting8,Setting9,Setting10,
			LastUpdated, StoreId
			FROM bvc_ComponentSettingList
			WHERE ComponentID=@ComponentID and StoreID=@StoreId
			ORDER BY ListName,SortOrder
		END
	ELSE
		BEGIN
			SELECT 
			bvin,ComponentID,DeveloperId,ComponentType,
			ComponentSubType,ListName,SortOrder,
			Setting1,Setting2,Setting3,Setting4,Setting5,
			Setting6,Setting7,Setting8,Setting9,Setting10,
			LastUpdated, StoreId
			FROM bvc_ComponentSettingList
			WHERE ComponentID=@ComponentID AND ListName=@ListName
			and StoreId=@StoreId
			ORDER BY SortOrder
		END
			
	RETURN
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH












GO
PRINT N'Creating [dbo].[bvc_Product_ByCriteria_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_ByCriteria_s]

@Keyword nvarchar(Max) = NULL,
@ManufacturerId varchar(36) = NULL,
@VendorId varchar(36) = NULL,
@Status int = NULL,
@InventoryStatus int = NULL,
@ProductTypeId varchar(36) = NULL,
@CategoryId varchar(36) = NULL,
@NotCategoryId varchar(36) = NULL,
@StartRowIndex int = 0,
@MaximumRows int = 9999999,
@DisplayInactive bit,
@StoreId bigint

AS
	BEGIN TRY			

		BEGIN			
			WITH cte_Product AS 
			(SELECT	RowNum = ROW_NUMBER() OVER (ORDER BY ProductName ASC),			
			bvin,
			SKU,
			ProductName,			
			ProductTypeID,			
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
			IsAvailableForSale
			FROM bvc_Product 	
			WHERE
				(	@Keyword IS NULL OR
					SKU like '%%' + @Keyword + '%%' OR 
					ProductName LIKE '%%' + @Keyword + '%%' OR
					MetaDescription LIKE '%%'+@Keyword+'%%' OR
					MetaKeywords LIKE '%%'+@Keyword+'%%' OR
					ShortDescription LIKE '%%'+@Keyword+'%%' OR
					LongDescription LIKE '%%'+@Keyword+'%%' OR
					Keywords LIKE '%%'+@Keyword+'%%')
				AND
				StoreId=@StoreId
				AND
				(@ManufacturerId IS NULL OR ManufacturerID=@ManufacturerId)
				AND
				(@VendorId IS NULL OR VendorId = @VendorId)
				AND
				(@Status IS NULL OR Status = @Status)
				AND
				((@InventoryStatus IS NULL) OR (IsAvailableForSale = @InventoryStatus))
				AND
				(@ProductTypeId IS NULL OR ProductTypeId = @ProductTypeId)
				AND
				(@CategoryId IS NULL OR EXISTS (Select CategoryId,ProductId FROM bvc_ProductXCategory WHERE ProductId=bvin AND CategoryId=@CategoryID))
				AND
				(@NotCategoryId IS NULL OR NOT EXISTS (Select CategoryId,ProductId FROM bvc_ProductXCategory WHERE ProductId=bvin AND CategoryId=@NotCategoryID))
				AND
				(@DisplayInactive = 1 OR Status = 1))

			SELECT DISTINCT rownum,
			products.bvin,
			SKU,
			ProductName,			
			ProductTypeID,			
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
			products.LastUpdated,
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
			products.StoreId, 
			Featured,
			AllowReviews,
			IsAvailableForSale,
		    (SELECT COUNT(*) FROM cte_Product) AS TotalRowCount 
			FROM cte_Product AS products
			WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum
		END
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_Sql_i
	END CATCH








GO
PRINT N'Creating [dbo].[bvc_Product_UniqueSku_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_UniqueSku_s] 
	@sku nvarchar(50),
	@bvin varchar(36),
	@StoreId bigint
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SELECT Count(*) FROM bvc_Product WHERE Sku = @sku AND bvin != @bvin and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END



GO
PRINT N'Creating [dbo].[bvc_ProductType_All_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductType_All_s]

@storeid bigint

AS



BEGIN TRY
	SELECT 
		bvin,
		ProductTypeName,
		IsPermanent,
		LastUpdated,
		StoreId
	FROM bvc_ProductType where storeid=@storeid
	ORDER BY ProductTypeName
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH

	RETURN






GO
PRINT N'Creating [dbo].[bvc_ProductPropertyChoice_d]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductPropertyChoice_d]

@id bigint,
@storeid bigint

 AS
	BEGIN TRY	
				DELETE FROM bvc_ProductPropertyChoice WHERE id=@id and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN






GO
PRINT N'Creating [dbo].[bvc_SearchQuery_All_s]'
GO
CREATE PROCEDURE [dbo].[bvc_SearchQuery_All_s]

@MaxResults bigint,
@StoreId bigint

AS
	BEGIN TRY
		SELECT Top (@MaxResults)
		bvin,QueryPhrase,ShopperID,LastUpdated,StoreId
		FROM bvc_SearchQuery
		WHERE StoreId=@StoreId 
		ORDER BY QueryPhrase
			
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ComponentSettingList_d]'
GO

CREATE PROCEDURE [dbo].[bvc_ComponentSettingList_d]

@bvin varchar(36),
@StoreId bigint

AS

	BEGIN TRY
		DELETE bvc_ComponentSettingList WHERE bvin=@bvin and StoreId=@StoreId

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_UserAccount_d]'
GO



CREATE PROCEDURE [dbo].[bvc_UserAccount_d]

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
PRINT N'Creating [dbo].[bvc_ProductVolumeDiscounts_i]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductVolumeDiscounts_i]

@bvin varchar(36),
@ProductID varchar(36),
@Qty int,
@DiscountType int,
@Amount numeric(18,10),
@StoreId bigint

AS

	BEGIN TRY
		INSERT INTO bvc_ProductVolumeDiscounts
		(bvin,ProductID,Qty,Amount,DiscountType,LastUpdated,StoreId)
		VALUES
		(@bvin,@ProductID,@Qty,@Amount,@DiscountType,GetUtcDate(),@StoreId)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductPropertyChoice_i]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductPropertyChoice_i]

@id bigint,
@PropertyId bigint,
@ChoiceName nvarchar(512),
@SortOrder int,
@storeid bigint

 AS
	BEGIN TRY
	
	
				INSERT INTO bvc_ProductPropertyChoice 
				(PropertyId,ChoiceName,SortOrder,LastUpdated,StoreId)

				VALUES (@PropertyId,@ChoiceName,@SortOrder,GetUtcDate(),@storeid)
		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


RETURN





GO
PRINT N'Creating [dbo].[bvc_SearchQuery_ByDate_d]'
GO
CREATE PROCEDURE [dbo].[bvc_SearchQuery_ByDate_d]

@DeleteDate as DateTime,
@StoreId bigint

AS

	BEGIN TRY
		DELETE FROM bvc_SearchQuery 
		WHERE LastUpdated <= @DeleteDate and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_Product_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_s]

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
PRINT N'Creating [dbo].[bvc_Product_BySkuAll_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_BySkuAll_s]

@bvin varchar(50),
@StoreId bigint

AS
	BEGIN TRY
		DECLARE @ProductBvin varchar(50)
		SET @ProductBvin = (Select bvin FROM bvc_Product WHERE sku=@bvin and StoreId=@StoreId)
		EXEC bvc_Product_s @ProductBvin, @StoreId
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
























GO
PRINT N'Creating [dbo].[bvc_ProductPropertyChoicesForPropertyList_s]'
GO




CREATE PROCEDURE [dbo].[bvc_ProductPropertyChoicesForPropertyList_s]

@ids as nvarchar(max),
@storeid bigint
AS
	BEGIN TRY
		
	
	
				SELECT id,PropertyId,ChoiceName,SortOrder,LastUpdated,StoreId

				FROM bvc_ProductPropertyChoice

				WHERE PropertyId in 
				(
					SELECT number from ListOfBigIntsToTable(@Ids)
				)		
				and StoreId=@StoreId

				ORDER By PropertyId,SortOrder		
	
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN






GO
PRINT N'Creating [dbo].[bvc_ComponentSettingList_i]'
GO

CREATE PROCEDURE [dbo].[bvc_ComponentSettingList_i]

@bvin varchar(36),
@ComponentID varchar(36),
@DeveloperId nvarchar(15),
@ComponentType nvarchar(25),
@ComponentSubType nvarchar(25),
@ListName nvarchar(255),
@SortOrder int,
@Setting1 nvarchar(Max),
@Setting2 nvarchar(Max),
@Setting3 nvarchar(Max),
@Setting4 nvarchar(Max),
@Setting5 nvarchar(Max),
@Setting6 nvarchar(Max),
@Setting7 nvarchar(Max),
@Setting8 nvarchar(Max),
@Setting9 nvarchar(Max),
@Setting10 nvarchar(Max),
@StoreId bigint

AS

	BEGIN TRY
		IF (Select Count(bvin) FROM bvc_ComponentSettingList 
								WHERE ComponentID=@ComponentID 
									AND ListName=@ListName
									AND StoreId=@StoreId) > 0
			BEGIN
			SET @SortOrder = (Select Max(SortOrder) 
							FROM bvc_ComponentSettingList 
							WHERE ComponentID=@ComponentID 
							AND ListName=@ListName
							And StoreId=@StoreId)+1
			END
		ELSE
			BEGIN
			SET @SortOrder = 1
			END
			
			
		INSERT INTO bvc_ComponentSettingList
		(
		bvin,
		ComponentID,
		DeveloperId,
		ComponentType,
		ComponentSubType,
		ListName,	
		SortOrder,	
		Setting1,
		Setting2,
		Setting3,
		Setting4,
		Setting5,
		Setting6,
		Setting7,
		Setting8,
		Setting9,
		Setting10,
		LastUpdated,
		StoreId
		)
		VALUES
		(
		@bvin,
		@ComponentID,
		@DeveloperId,
		@ComponentType,
		@ComponentSubType,
		@ListName,	
		@SortOrder,	
		@Setting1,
		@Setting2,
		@Setting3,
		@Setting4,
		@Setting5,
		@Setting6,
		@Setting7,
		@Setting8,
		@Setting9,
		@Setting10,
		GetUtcDate(),
		@StoreId
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ProductPropertyChoice_u]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductPropertyChoice_u]

@id bigint,
@PropertyId bigint,
@ChoiceName nvarchar(512),
@SortOrder int,
@storeid bigint

AS
	BEGIN TRY
			
				UPDATE bvc_ProductPropertyChoice		
				SET
				PropertyId=@PropertyId,
				ChoiceName=@ChoiceName,
				SortOrder=@SortOrder,
				LastUpdated=GetUtcDate()		
				WHERE id=@id and StoreId=@StoreId
		

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN






GO
PRINT N'Creating [dbo].[bvc_SearchQuery_ByQueryPhrase_s]'
GO
CREATE PROCEDURE [dbo].[bvc_SearchQuery_ByQueryPhrase_s]

@QueryPhrase nvarchar(Max),
@StoreId bigint

AS
	BEGIN TRY
		SELECT bvin,QueryPhrase,ShopperID,LastUpdated,StoreId 
		FROM bvc_SearchQuery
		WHERE QueryPhrase=@QueryPhrase and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductVolumeDiscounts_s]'
GO
CREATE PROCEDURE [dbo].[bvc_ProductVolumeDiscounts_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT bvin,ProductID,Qty,DiscountType,Amount,LastUpdated,StoreId
		FROM bvc_ProductVolumeDiscounts
		WHERE bvin=@bvin and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH









GO
PRINT N'Creating [dbo].[bvc_ProductInventory_All_s]'
GO
-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_All_s] 
	@StoreId bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		SELECT
		bvin, 
		ProductBvin,
		VariantId,
		QuantityOnHand,
		LowStockPoint,
		QuantityReserved,
		QuantityAvailableForSale,
		LastUpdated,
		StoreId
		FROM bvc_ProductInventory	
		WHERE StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END














GO
PRINT N'Creating [dbo].[bvc_ProductPropertyChoicesForProperty_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductPropertyChoicesForProperty_s]

@id as bigint,
@storeid bigint
AS
	BEGIN TRY
		
	
	
				SELECT id,PropertyId,ChoiceName,SortOrder,LastUpdated,StoreId

				FROM bvc_ProductPropertyChoice

				WHERE PropertyId=@id and StoreId=@StoreId

				ORDER By SortOrder
		
	
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN





GO
PRINT N'Creating [dbo].[bvc_ComponentSettingList_s]'
GO
CREATE PROCEDURE [dbo].[bvc_ComponentSettingList_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT 
		bvin,ComponentID,DeveloperId,ComponentType,ComponentSubType,ListName,SortOrder,
		Setting1,Setting2,Setting3,Setting4,Setting5,
		Setting6,Setting7,Setting8,Setting9,Setting10,
		LastUpdated, StoreId
		FROM bvc_ComponentSettingList
		WHERE bvin=@bvin and StoreId=@StoreId
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_UserQuestion_All_s]'
GO

CREATE PROCEDURE [dbo].[bvc_UserQuestion_All_s]
	@StoreId bigint
AS
	BEGIN TRY
		SELECT bvin, QuestionName, QuestionType, [Values], [Order], LastUpdated,StoreId 
		FROM bvc_UserQuestions 
		WHERE StoreId=@StoreId
		ORDER BY [Order]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

















GO
PRINT N'Creating [dbo].[bvc_Product_ByFacet_s]'
GO


CREATE PROCEDURE [dbo].[bvc_Product_ByFacet_s]
	@PropertyChoiceIds varchar(Max),
	--@PropertiesRequired varchar(Max),
	@StartRowIndex int = 0,
	@MaximumRows int = 10,
	@StoreId bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
		
	
	WITH cte as (
		SELECT ProductBvin,COUNT(ProductBvin) as C, ROW_NUMBER() over (order by Count(ProductBvin) desc) as rownum
		FROM bvc_ProductPropertyValue
		where (
				PropertyChoiceId in 
				(
					SELECT number from ListOfBigIntsToTable(@PropertyChoiceIds)
				)	
				--and PropertyId in 
				--(
				--	SELECT number from ListOfBigIntsToTable(@PropertiesRequired)
				--)
				and StoreId=@StoreId
			  )
		group by ProductBvin    
		)
		select ProductBvin from cte 		
		where C = (SELECT COUNT(*) from ListOfBigIntsToTable(@PropertyChoiceIds))
		AND rownum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
		
	
END

GO
PRINT N'Creating [dbo].[bvc_ProductVolumeDiscounts_u]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductVolumeDiscounts_u]

@bvin varchar(36),
@Qty int,
@DiscountType int,
@Amount numeric(18,10),
@ProductID varchar(36),
@StoreId bigint

AS

	BEGIN TRY
		UPDATE bvc_ProductVolumeDiscounts
		SET
		Qty=@Qty,
		DiscountType=@DiscountType,
		Amount=@Amount,
		ProductID=@ProductID,
		LastUpdated=GetUtcDate()
		WHERE bvin=@bvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_SearchQuery_ByShopperID_s]'
GO
CREATE PROCEDURE [dbo].[bvc_SearchQuery_ByShopperID_s]
	
	@bvin varchar(36),
	@StoreId bigint
AS

	BEGIN TRY
		SELECT bvin,QueryPhrase,ShopperID,LastUpdated,StoreId FROM bvc_SearchQuery
		WHERE shopperID=@bvin and StoreId=@StoreId ORDER BY LastUpdated DESC
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_Product_ProductsOrderedCount_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_ProductsOrderedCount_s]

@StartDate datetime = NULL,
@EndDate datetime = NULL,
@MaxRows bigint = 1000,
@StoreId bigint
AS
	BEGIN TRY
		SELECT TOP (@MaxRows)
		p.bvin,
		p.ProductName,
		SUM(l.Quantity) AS "Total Ordered"	
		FROM
		bvc_LineItem l
		JOIN bvc_Product p ON l.productID = p.bvin
		WHERE 
			l.OrderBvin IN 
			(
			SELECT bvin FROM bvc_Order 
			WHERE
			IsPlaced = 1 AND
			(TimeOfOrder >= @StartDate OR @StartDate IS NULL)
			AND			
			(TimeOfOrder <= @EndDate OR @EndDate IS NULL)
			)
			AND p.IsAvailableForSale = 1
			 and p.StoreId=@StoreId
		GROUP BY p.bvin, p.ProductName		
		ORDER BY SUM(l.Quantity) DESC
      RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH






















GO
PRINT N'Creating [dbo].[bvc_Product_ByFacet_Count_s]'
GO



CREATE PROCEDURE [dbo].[bvc_Product_ByFacet_Count_s]
	@PropertyChoiceIds varchar(Max),
	--@PropertiesRequired varchar(Max),
	@StoreId bigint,
	@productcount int out
AS
BEGIN	
	SET NOCOUNT ON;
	
	
	
	
			
	DECLARE @matching TABLE (ProductBvin nvarchar(50), ProductCount int)
	
	INSERT INTO @matching (ProductBvin,ProductCount)
	SELECT ProductBvin, COUNT(ProductBvin) as ProductCount
	FROM bvc_ProductPropertyValue
	WHERE PropertyChoiceId in (Select number from ListOfBigIntsToTable(@PropertyChoiceIds))		  
			AND StoreId=@StoreId
	group by ProductBvin
	
	
	SET @productcount = (Select COUNT(*) from @matching where ProductCount = (SELECT COUNT(*) from ListOfBigIntsToTable(@PropertyChoiceIds)))
			
	--SELECT COUNT(*) as TotalProducts from @matching			
									
END


GO
PRINT N'Creating [dbo].[bvc_ProductInventory_AllLowStock_s]'
GO
-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_AllLowStock_s] 
	@StoreId bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		SELECT
		bvin, 
		ProductBvin,
		VariantId,
		QuantityOnHand,
		LowStockPoint,		
		QuantityReserved,
		QuantityAvailableForSale,
		LastUpdated,
		StoreId
		FROM bvc_ProductInventory 
		WHERE QuantityAvailableForSale <= LowStockPoint and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END















GO
PRINT N'Creating [dbo].[bvc_ProductPropertyValue_ClearAll_d]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductPropertyValue_ClearAll_d]

@ProductBvin varchar(36),
@storeid bigint

AS

	BEGIN TRY		
		DELETE FROM bvc_ProductPropertyValue WHERE ProductBvin=@ProductBvin	and StoreId=@StoreId	
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH







GO
PRINT N'Creating [dbo].[bvc_ComponentSettingList_SortOrder_u]'
GO
CREATE PROCEDURE [dbo].[bvc_ComponentSettingList_SortOrder_u]

@bvin varchar(36),
@SortOrder int,
@StoreId bigint

AS

	BEGIN TRY
		UPDATE bvc_ComponentSettingList
		SET
		SortOrder=@SortOrder,LastUpdated=GetUtcDate()
		WHERE bvin=@bvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	












GO
PRINT N'Creating [dbo].[bvc_Product_SuggestedItems]'
GO
CREATE PROCEDURE [dbo].[bvc_Product_SuggestedItems]

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
PRINT N'Creating [dbo].[bvc_ProductVolumeDiscountsByProduct_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductVolumeDiscountsByProduct_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT bvin,ProductID,Qty,DiscountType,Amount,LastUpdated,StoreId
		FROM bvc_ProductVolumeDiscounts
		WHERE ProductID=@bvin and StoreId=@StoreId
		ORDER BY Qty ASC
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_SearchQuery_d]'
GO
CREATE PROCEDURE [dbo].[bvc_SearchQuery_d]

@bvin varchar(36),
@StoreId bigint
AS
	BEGIN TRY
		DELETE FROM bvc_SearchQuery WHERE bvin=@bvin and StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductPropertyValue_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductPropertyValue_s]

@ProductBvin varchar(36),
@PropertyId bigint,
@storeid bigint,
@Exists int = 0

AS

BEGIN TRY
		
		
				SELECT ProductBvin,PropertyId,PropertyChoiceId,PropertyValue,StoreId
				FROM bvc_ProductPropertyValue 
				WHERE ProductBvin=@ProductBvin 
				AND PropertyId=@PropertyId
				 and StoreId=@StoreId		
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH






GO
PRINT N'Creating [dbo].[bvc_ProductInventory_ByProductId_d]'
GO
-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_ByProductId_d] 
	@bvin varchar(36),
	@StoreId bigint
AS
BEGIN
	BEGIN TRY
		DELETE FROM bvc_ProductInventory 
		WHERE ProductBvin=@bvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END












GO
PRINT N'Creating [dbo].[bvc_ComponentSettingList_u]'
GO

CREATE PROCEDURE [dbo].[bvc_ComponentSettingList_u]

@bvin varchar(36),
@ComponentID varchar(36),
@DeveloperId nvarchar(15),
@ComponentType nvarchar(25),
@ComponentSubType nvarchar(25),
@ListName nvarchar(255),
@SortOrder int,
@Setting1 nvarchar(Max),
@Setting2 nvarchar(Max),
@Setting3 nvarchar(Max),
@Setting4 nvarchar(Max),
@Setting5 nvarchar(Max),
@Setting6 nvarchar(Max),
@Setting7 nvarchar(Max),
@Setting8 nvarchar(Max),
@Setting9 nvarchar(Max),
@Setting10 nvarchar(Max),
@StoreId bigint

AS
	
	BEGIN TRY
		UPDATE bvc_ComponentSettingList
		SET
		
		bvin=@bvin,
		ComponentID=@ComponentID,
		DeveloperId=@DeveloperId,
		ComponentType=@ComponentType,
		ComponentSubType=@ComponentSubType,
		SortOrder=@SortOrder,
		ListName=@ListName,
		Setting1=@Setting1,
		Setting2=@Setting2,
		Setting3=@Setting3,
		Setting4=@Setting4,
		Setting5=@Setting5,
		Setting6=@Setting6,
		Setting7=@Setting7,
		Setting8=@Setting8,
		Setting9=@Setting9,
		Setting10=@Setting10,
		LastUpdated=GetUtcDate()
		
		WHERE bvin=@bvin and StoreId=@StoreId
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_WishList_ForUser_s]'
GO

CREATE PROCEDURE [dbo].[bvc_WishList_ForUser_s]
@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT 
			bvc_WishList.bvin,bvc_WishList.UserId,
			bvc_WishList.ProductBvin,bvc_WishList.Quantity,
			bvc_WishList.Modifiers,bvc_WishList.Inputs,
			bvc_WishList.StoreId
		FROM bvc_WishList 
		JOIN bvc_Product 
		on 
		bvc_WishList.ProductBvin = bvc_Product.bvin 
		WHERE 
		bvc_WishList.UserId = @bvin AND bvc_Product.IsAvailableForSale = 1 and bvc_Product.StoreId=@StoreId
		 and bvc_Wishlist.StoreId=@StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



GO
PRINT N'Creating [dbo].[bvc_WishList_s]'
GO

CREATE PROCEDURE [dbo].[bvc_WishList_s]	
	@bvin varchar(36),
	@StoreId bigint
AS
BEGIN
	BEGIN TRY
		SELECT bvc_WishList.bvin,bvc_WishList.UserId,bvc_WishList.ProductBvin,bvc_WishList.Quantity,bvc_WishList.Modifiers,bvc_WishList.Inputs,
		bvc_WishList.StoreId
		FROM bvc_WishList 
		JOIN bvc_Product 
		on 
		bvc_WishList.ProductBvin = bvc_Product.bvin 
		WHERE bvc_WishList.StoreId=@StoreId AND
		bvc_WishList.Bvin = @bvin AND bvc_Product.IsAvailableForSale = 1 and bvc_Product.StoreId = @StoreId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END








GO
PRINT N'Creating [dbo].[bvc_ProductVolumeDiscountsByQtyForProduct_s]'
GO



CREATE  PROCEDURE [dbo].[bvc_ProductVolumeDiscountsByQtyForProduct_s]

@ProductID varchar(36),
@Qty int,
@StoreId bigint

AS

	BEGIN TRY
		SELECT TOP 1  bvin,ProductID,Qty,DiscountType,Amount,LastUpdated,StoreId
		FROM bvc_ProductVolumeDiscounts
		WHERE ProductID=@ProductID and StoreId=@StoreId
		AND Qty <= @Qty
		ORDER BY Qty Desc
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_SearchQuery_i]'
GO
CREATE PROCEDURE [dbo].[bvc_SearchQuery_i]

@bvin varchar(36),
@QueryPhrase nvarchar(Max),
@ShopperID varchar(36),
@StoreId bigint

AS

	BEGIN TRY			
		INSERT INTO
		bvc_SearchQuery
		(
		bvin,
		QueryPhrase,
		ShopperID,
		LastUpdated,
		StoreId
		)
		VALUES
		(
		@bvin,
		@QueryPhrase,
		@ShopperID,
		GetUtcDate(),
		@StoreId
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductPropertyValue_u]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductPropertyValue_u]

@ProductBvin varchar(36),
@PropertyId bigint,
@PropertyChoiceId bigint,
@PropertyValue nvarchar(max),
@StoreId bigint,
@Exists int = 0

AS

	BEGIN TRY		
		Set @Exists = (Select COUNT(*) from bvc_ProductProperty 
						WHERE id=@PropertyId and StoreId=@storeid)						
		if (@Exists > 0)
			BEGIN	
				DELETE FROM bvc_ProductPropertyValue WHERE ProductBvin=@ProductBvin AND PropertyId=@PropertyId and StoreId=@StoreId
		
				INSERT INTO bvc_ProductPropertyValue 
				(ProductBvin,PropertyId,PropertyChoiceId,PropertyValue, StoreId) 
				VALUES (@ProductBvin,@PropertyId,@PropertyChoiceId,@PropertyValue, @StoreId)

			END
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH






GO
PRINT N'Creating [dbo].[bvc_ProductInventory_ByProductId_s]'
GO
-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_ByProductId_s] 
	-- Add the parameters for the stored procedure here
	@bvin varchar(36),
	@StoreId bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
    
		SELECT
		bvin, 
		ProductBvin,
		VariantId,
		QuantityOnHand,
		QuantityReserved,
		QuantityAvailableForSale,
		LowStockPoint,
		LastUpdated,
		StoreId
		FROM bvc_ProductInventory
		WHERE ProductBvin=@bvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END














GO
PRINT N'Creating [dbo].[bvc_ComponentSettings_All_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ComponentSettings_All_s]

@StoreId bigint

AS
	
BEGIN TRY
	SELECT 
		SettingValue,
		ComponentID,
		SettingName,
		DeveloperId,
		ComponentType,
		ComponentSubType,
		StoreId
		FROM bvc_ComponentSetting
		where StoreId=@StoreId

	RETURN
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH














GO
PRINT N'Creating [dbo].[bvc_Product_d]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_d]

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
PRINT N'Creating [dbo].[bvc_SearchQuery_Report_s]'
GO
CREATE PROCEDURE [dbo].[bvc_SearchQuery_Report_s]
	@StoreId bigint
AS
	BEGIN TRY
		SELECT DISTINCT	
		QueryPhrase, Count(*) as QueryCount FROM bvc_SearchQuery
		WHERE StoreId=@StoreId
		Group By QueryPhrase		
		ORDER BY QueryCount DESC	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductInventory_d]'
GO
-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_d] 
	-- Add the parameters for the stored procedure here
	@bvin varchar(36),
	@StoreId bigint
AS
BEGIN
	BEGIN TRY
		DELETE FROM bvc_ProductInventory WHERE bvin=@bvin and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END











GO
PRINT N'Creating [dbo].[bvc_ProductXCategory_ByCategory_s]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductXCategory_ByCategory_s]

@bvin varchar(36),
@StoreId bigint

AS
	BEGIN TRY
		SELECT categoryId,productId,SortOrder,StoreId
		FROM bvc_ProductXCategory
		WHERE categoryId=@bvin and StoreId=@StoreId
		ORDER BY SortOrder

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductPropertyValues_ForProduct_s]'
GO
CREATE PROCEDURE [dbo].[bvc_ProductPropertyValues_ForProduct_s]
(
@ProductBvin varchar(36),
@TypeBvin varchar(36),
@StoreId bigint
)
AS
	BEGIN
	
	BEGIN TRY
		SET @TypeBvin = (SELECT ProductTypeId FROM bvc_Product Where [Bvin]=@ProductBvin and StoreId=@StoreId)
		
		SELECT ProductBvin,PropertyId,PropertyChoiceId,PropertyValue,StoreId FROM bvc_ProductPropertyValue WHERE		
		ProductBvin=@ProductBvin and StoreId=@StoreId AND
		PropertyId IN (SELECT PropertyId FROM bvc_ProductTypeXProductProperty WHERE ProductTypeBvin = @TypeBvin and StoreId=@StoreId)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	
	END
	/* SET NOCOUNT ON */
	RETURN



GO
PRINT N'Creating [dbo].[bvc_Product_BySku_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_BySku_s]

@bvin varchar(50),
@StoreId bigint

AS
	BEGIN TRY
		DECLARE @ProductBvin varchar(50)
		SET @ProductBvin = (Select bvin FROM bvc_Product WHERE sku=@bvin and StoreId=@StoreId)
		EXEC bvc_Product_s @ProductBvin, @StoreId
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH























GO
PRINT N'Creating [dbo].[bvc_Product_All_d]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_All_d]

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
PRINT N'Creating [dbo].[bvc_ProductType_Available_Properties_s]'
GO




CREATE PROCEDURE [dbo].[bvc_ProductType_Available_Properties_s]

@bvin varchar(36),
@storeid bigint

AS
	BEGIN TRY
		SELECT 
			id,
			PropertyName,
			DisplayName,
			DisplayOnSite,
			DisplayToDropShipper,
			TypeCode,
			DefaultValue,
			CultureCode,
			LastUpdated,
			StoreId

		FROM bvc_ProductProperty

		WHERE id NOT IN (SELECT PropertyId FROM bvc_ProductTypeXProductProperty WHERE ProductTypeBvin=@bvin and StoreId=@StoreId) 
		AND StoreId=@storeid

		ORDER BY PropertyName
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN






GO
PRINT N'Creating [dbo].[bvc_UserAccount_ExcludeAffiliateId_s]'
GO




CREATE PROCEDURE [dbo].[bvc_UserAccount_ExcludeAffiliateId_s]

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
PRINT N'Creating [dbo].[bvc_ProductType_d]'
GO





CREATE PROCEDURE [dbo].[bvc_ProductType_d]

@bvin as varchar(36),
@storeid bigint
AS

	BEGIN TRY
		BEGIN TRAN
		
					UPDATE bvc_Product SET ProductTypeId = '' WHERE ProductTypeId = @bvin and StoreId=@StoreId
					DELETE FROM bvc_ProductTypeXProductProperty Where ProductTypeBvin=@bvin and StoreId=@StoreId
					DELETE FROM bvc_ProductType WHERE bvin=@bvin and StoreId=@StoreId

		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN







GO
PRINT N'Creating [dbo].[bvc_ProductType_ForCategory_s]'
GO
CREATE PROCEDURE [dbo].[bvc_ProductType_ForCategory_s]

@bvin varchar(36),
@StoreId bigint

AS

BEGIN TRY
	SELECT DISTINCT
		pt.bvin,
		pt.ProductTypeName,
		pt.IsPermanent,
		pt.LastUpdated,
		pt.StoreId
	FROM bvc_ProductType AS pt
	JOIN bvc_Product AS p ON p.ProductTypeId = pt.Bvin
	JOIN bvc_ProductXCategory AS pc ON p.Bvin = pc.ProductId
	JOIN bvc_Category As c ON pc.CategoryId = c.Bvin
	WHERE c.Bvin = @bvin and p.StoreId=@StoreId
	ORDER BY ProductTypeName
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH

	RETURN


GO
PRINT N'Creating [dbo].[bvc_Product_ProductsOrderedCount_Admin_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_ProductsOrderedCount_Admin_s]

@StartDate datetime = NULL,
@EndDate datetime = NULL,
@StoreId bigint

AS
	BEGIN TRY
		SELECT 
		p.SKU,
		p.bvin,
		p.ProductName,
		SUM(l.Quantity) AS "Total Ordered"	
		FROM
		bvc_LineItem l
		JOIN bvc_Product p ON l.productID = p.bvin
		WHERE 
			l.OrderBvin IN 
			(
			SELECT bvin FROM bvc_Order 
			WHERE
			IsPlaced = 1 AND 			
			(TimeOfOrder >= @StartDate OR @StartDate IS NULL)
			AND			
			(TimeOfOrder <= @EndDate OR @EndDate IS NULL)
			)
			 and p.StoreId=@StoreId
		GROUP BY p.bvin,p.sku, p.ProductName		
		ORDER BY SUM(l.Quantity) DESC
      RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH





















GO
PRINT N'Creating [dbo].[bvc_ProductProperty_d]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductProperty_d]

@id as bigint,
@StoreId bigint

AS

	BEGIN TRY
		DELETE FROM bvc_ProductPropertyChoice WHERE PropertyId=@id and StoreId=@StoreId
		DELETE FROM bvc_ProductTypeXProductProperty Where PropertyId=@id and StoreId=@StoreId
		DELETE FROM bvc_ProductPropertyValue WHERE PropertyId=@id and StoreId=@StoreId
		DELETE FROM bvc_ProductProperty WHERE id=@id and StoreId=@StoreId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN





GO
PRINT N'Creating [dbo].[bvc_Product_ByCategory_s]'
GO


CREATE PROCEDURE [dbo].[bvc_Product_ByCategory_s]

@bvin varchar(36),
@ignoreInventory bit = 0,
@showInactive bit = 1,
@StartRowIndex int = 0,
@MaximumRows int = 9999999,
@DisplaySortOrder int = 0,
@StoreId bigint

AS
	BEGIN TRY;
			
			WITH products AS (SELECT
			RowNum = 
				CASE 
					WHEN @DisplaySortOrder = 0 THEN ROW_NUMBER() OVER (ORDER BY SortOrder)
					WHEN @DisplaySortOrder = 1 THEN ROW_NUMBER() OVER (ORDER BY SortOrder)
					WHEN @DisplaySortOrder = 2 THEN ROW_NUMBER() OVER (ORDER BY ProductName)
					WHEN @DisplaySortOrder = 3 THEN ROW_NUMBER() OVER (ORDER BY SitePrice)
					WHEN @DisplaySortOrder = 4 THEN ROW_NUMBER() OVER (ORDER BY SitePrice DESC)					
					WHEN @DisplaySortOrder = 5 THEN ROW_NUMBER() OVER (ORDER BY m.DisplayName, ProductName)
					ELSE ROW_NUMBER() OVER (ORDER BY SortOrder)
				END,			
			p.bvin,
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
			p.Status,
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
			p.LastUpdated,
			Keywords,
			TemplateName,
			PreContentColumnId,
			PostContentColumnId,
			RewriteUrl,
			SitePriceOverrideText,
			px.SortOrder,
			PreTransformLongDescription,
			SmallImageAlternateText,
			MediumImageAlternateText,
			p.OutOfStockMode,
			p.CustomProperties,			
			p.GiftWrapPrice,
			p.StoreId,
			Featured,
			AllowReviews,
			DescriptionTabs,
			IsAvailableForSale
			
			FROM bvc_Product p JOIN bvc_ProductXCategory px ON p.bvin = px.ProductID 			
			LEFT JOIN bvc_Manufacturer AS m ON p.ManufacturerId = m.Bvin
			WHERE p.StoreId=@StoreId
			AND px.CategoryID = @bvin			
			AND ((@showInactive = 1) OR (p.IsAvailableForSale = 1)))
			
			SELECT *, (SELECT COUNT(*) FROM products) AS TotalRowCount FROM products WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



GO
