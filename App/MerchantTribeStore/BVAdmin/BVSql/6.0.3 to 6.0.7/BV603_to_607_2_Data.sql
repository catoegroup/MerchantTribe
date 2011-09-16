/*BV Commerce 6.0.3 to 6.0.7 Data Script */
		
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
-- Pointer used for text / image updates. This might not be needed, but is declared here just in case
DECLARE @pv binary(16)

-- Update 1 row in [dbo].[bvc_SiteTerm]
UPDATE [dbo].[bvc_SiteTerm] SET [SiteTermValue]=N'Related Items' WHERE [SiteTerm]=N'RelatedItems'

-- Update 3 rows in [dbo].[bvc_PrintTemplate]
UPDATE [dbo].[bvc_PrintTemplate] SET [RepeatingSection]=N'<tr>
  <td align=left valign=top>[[LineItem.Sku]]</td>
  <td align=left valign=top>[[LineItem.ProductName]]</td>
  <td align=center valign=top>[[LineItem.Quantity]]</td>
</tr>' WHERE [bvin]='39e51ef8-280d-4358-b507-8d4d8ca348a1'
UPDATE [dbo].[bvc_PrintTemplate] SET [RepeatingSection]=N'<tr>
					 <td align=left valign=top>[[LineItem.Sku]]</td>
					 <td align=left valign=top>[[LineItem.ProductName]]</td>
					 <td align=center valign=top>[[LineItem.Quantity]]</td>
					<td align=center valign=top>[[LineItem.BasePrice]]</td>
<td align=center valign=top>[[LineItem.LineTotal]]</td>
</tr>' WHERE [bvin]='6c9c2d90-9f76-42aa-8453-b77ed44c283d'
UPDATE [dbo].[bvc_PrintTemplate] SET [RepeatingSection]=N'<tr>
  <td align=left valign=top>[[LineItem.Sku]]</td>
  <td align=left valign=top>[[LineItem.ProductName]]<br />[[LineItem.ShippingStatus]]</td>
  <td align=right valign=top>[[LineItem.AdjustedPrice]]</td>
  <td align=center valign=top>[[LineItem.Quantity]]</td>
  <td align="right" valign="top">[[LineItem.LineTotal]]</td>
</tr>' WHERE [bvin]='c090c3e7-974b-4a62-afdf-716395abec3d'

-- Add 1 row to [dbo].[ecommrc_News]
SET IDENTITY_INSERT [dbo].[ecommrc_News] ON
INSERT INTO [dbo].[ecommrc_News] ([id], [TimeStampUtc], [Message]) VALUES (1, '2011-10-11 16:00:00.000', N'BV Commerce 6.0.7 released. New features include Related Products, Price Groups, Culture/Currency Settings, Country Enable/Disable, various bug fixes and more.')
SET IDENTITY_INSERT [dbo].[ecommrc_News] OFF
COMMIT TRANSACTION
GO
