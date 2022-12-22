/****** Script for SelectTopNRows command from SSMS 
FROM 
(
	SELECT 
		[Id]
		,[WorkOrder]
		,[TimeStamp]
		,[StationId],
		ROW_NUMBER() OVER (PARTITION BY [WorkOrder] ORDER BY [TimeStamp] DESC) AS SortId

	FROM [WIPTracking].[dbo].[Transactions]
) as Subquery

where  SortID = 1
AND WorkOrder = 'DD670C' 

******/

--find the station id that has the newest record, and show result as 1 row intead of multiple

SELECT TOP (1000) [Id]
      ,[WorkOrder]
      ,[TimeStamp]
      ,[StationId]
	  --,max(TimeStamp) as tracklo

  FROM [WIPTracking].[dbo].[Transactions]

where WorkOrder = 'DD670C' 


 group by [Id]
      ,[WorkOrder]
      ,[TimeStamp]
      ,[StationId]
	 
	 order by [TimeStamp] DEsc
  
--SELECT TOP 1 [Id], [WorkOrder], [TimeStamp],[StationId]  FROM [WIPTracking].[dbo].[Transactions]
--Order BY [TimeStamp]