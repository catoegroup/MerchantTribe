SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
PRINT N'Creating [dbo].[ListOfBigIntsToTable]'
GO


CREATE FUNCTION [dbo].[ListOfBigIntsToTable]
(
	@list nvarchar(MAX)
)
RETURNS 
 @tbl TABLE 
(
	number bigint NOT NULL
)
AS
BEGIN

	DECLARE @pos        int,
			@nextpos    int,
			@valuelen   int

	SELECT @pos = 0, @nextpos = 1
	WHILE @nextpos > 0
	BEGIN
		SELECT @nextpos = charindex(',', @list, @pos + 1)
		SELECT @valuelen = CASE WHEN @nextpos > 0
	THEN @nextpos
	ELSE len(@list) + 1
	END - @pos - 1
	
	INSERT @tbl (number)
	VALUES (convert(bigint, substring(@list, @pos + 1, @valuelen)))
	SELECT @pos = @nextpos
	END

	
	RETURN 
END

GO
PRINT N'Creating [dbo].[ListOfKeysToTable]'
GO




CREATE FUNCTION [dbo].[ListOfKeysToTable]
(
	@list nvarchar(MAX)
)
RETURNS 
 @tbl TABLE 
(
	stringvalue nvarchar(MAX) NOT NULL
)
AS
BEGIN

	DECLARE @pos        int,
			@nextpos    int,
			@valuelen   int

	SELECT @pos = 0, @nextpos = 1
	WHILE @nextpos > 0
	BEGIN
		SELECT @nextpos = charindex('|', @list, @pos + 1)
		SELECT @valuelen = CASE WHEN @nextpos > 0
	THEN @nextpos
	ELSE len(@list) + 1
	END - @pos - 1
	
	INSERT @tbl (stringvalue)
	VALUES (substring(@list, @pos + 1, @valuelen))
	SELECT @pos = @nextpos
	END
	
	RETURN 
END



GO
PRINT N'Creating [dbo].[ListOfGuidsToTable]'
GO


CREATE FUNCTION [dbo].[ListOfGuidsToTable]
(
	@list nvarchar(MAX)
)
RETURNS 
 @tbl TABLE 
(
	bvin nvarchar(36) NOT NULL
)
AS
BEGIN

	DECLARE @pos        int,
			@nextpos    int,
			@valuelen   int

	SELECT @pos = 0, @nextpos = 1
	WHILE @nextpos > 0
	BEGIN
		SELECT @nextpos = charindex(',', @list, @pos + 1)
		SELECT @valuelen = CASE WHEN @nextpos > 0
	THEN @nextpos
	ELSE len(@list) + 1
	END - @pos - 1
	
	INSERT @tbl (bvin)
	VALUES (substring(@list, @pos + 1, @valuelen))
	SELECT @pos = @nextpos
	END
	
	RETURN 
END

GO
PRINT N'Creating [dbo].[ListOfStringsToTable]'
GO



CREATE FUNCTION [dbo].[ListOfStringsToTable]
(
	@list nvarchar(MAX)
)
RETURNS 
 @tbl TABLE 
(
	stringvalue nvarchar(MAX) NOT NULL
)
AS
BEGIN

	DECLARE @pos        int,
			@nextpos    int,
			@valuelen   int

	SELECT @pos = 0, @nextpos = 1
	WHILE @nextpos > 0
	BEGIN
		SELECT @nextpos = charindex(',', @list, @pos + 1)
		SELECT @valuelen = CASE WHEN @nextpos > 0
	THEN @nextpos
	ELSE len(@list) + 1
	END - @pos - 1
	
	INSERT @tbl (stringvalue)
	VALUES (substring(@list, @pos + 1, @valuelen))
	SELECT @pos = @nextpos
	END
	
	RETURN 
END


GO

