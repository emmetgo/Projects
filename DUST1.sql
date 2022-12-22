/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [WorkOrder]
      ,[HDRPARTNUMBER]
      ,[HDRJOBQTY]
      ,[HDRLOCATION]
      ,[fldBU]
      ,[fldPG]
      ,[WORKCENTER]
      ,[Lead_Time]
      ,[JobStatus]
      ,[OperationStatus]
      ,[Scrap]
      ,[HDRNEEDDATE]
      ,[HDRPROMDATE]
      ,[TodaysDate]
      ,[LeadDate]
      ,[WIPOPERATION]
      ,[ProjectedStockDate]
      ,[DUST]
	  ,
	  dateadd(dd,[DUST]+cast(([DUST] / 7) *2  as int),getdate()) as ProjectedStockdateweekend,
	  datediff(day,(dateadd(dd,[DUST]+cast(([DUST] / 7) *2  as int),getdate())),[HDRPROMDATE]) as OverUnder


  FROM [WIPTracking].[dbo].[vw_DaysUntilStock_Sub]
