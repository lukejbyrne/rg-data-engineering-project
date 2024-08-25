USE [AdventureWorksLT2019]
GO

INSERT INTO [SalesLT].[Product]
           ([Name]
           ,[ProductNumber]
           ,[Color]
           ,[StandardCost]
           ,[ListPrice]
           ,[Size]
           ,[Weight]
           ,[ProductCategoryID]
           ,[ProductModelID]
           ,[SellStartDate]
           ,[SellEndDate]
           ,[DiscontinuedDate]
           ,[ThumbNailPhoto]
           ,[ThumbnailPhotoFileName]
           ,[rowguid]
           ,[ModifiedDate])
   VALUES
           ('Product Name', 'PN-001', 'Red', 50.00, 100.00, 'M', 1.5, 3, 12, '2024-08-25', NULL, NULL, 0x, 'thumb.jpg', NEWID(), GETDATE())

GO


