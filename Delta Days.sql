--selcet wip transaction, htere is a date, add date
--find tthe differnece betweeen that date and todayts date
--number of days between two dates



SELECT  WIPTracking.dbo.Transactions.Id,
      WIPTracking.dbo.Transactions.WorkOrder
      ,WIPTracking.dbo.Transactions.[TimeStamp]
      ,WIPTracking.dbo.Transactions.StationId, --GETDATE() as Todays_date, 
	 DATEDIFF(DAY, CURRENT_TIMESTAMP, WIPTracking.dbo.Transactions.[TimeStamp]) as Delta



FROM
WIPTracking.dbo.Transactions

Group by
WIPTracking.dbo.Transactions.Id,
      WIPTracking.dbo.Transactions.WorkOrder
      ,WIPTracking.dbo.Transactions.[TimeStamp]
      ,WIPTracking.dbo.Transactions.StationId, 
	  --GETDATE(),
	  DATEDIFF(DAY, CURRENT_TIMESTAMP, WIPTracking.dbo.Transactions.[TimeStamp])


