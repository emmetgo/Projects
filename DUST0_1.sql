/*
DUST report with following headers:
MO						-
job quantity			-
status					-
pn						-
stock scrapped			-
quantity due			? - a calculated feild =    total job - scrap - x - y
last mss activity date	- 
need date				- 
promise date			- 
name					?   location form wip tracker
date					?	date that the job was scanned at the location -  this is located at - tuggerDropOffData.[Date]

scanning lead time		?	 to calculate
days until stock		-	 calculate
projected stock date	-	 calculate
over under				-	 calculate
lead time				-
location				-
product code			-
bussines unit code		-
*/

SELECT        FastPrice.dbo.WPHEADER.HDRJOBSEQ AS WorkOrder, FastPrice.dbo.WPHEADER.HDRPARTNUMBER, 
				FastPrice.dbo.WPHEADER.HDRJOBQTY, FastPrice.dbo.WPHEADER.HDRLOCATION, FastPrice.dbo.IMITEM.fldBU, 
				FastPrice.dbo.IMITEM.fldPG, WIPTracking.dbo.WorkCentersLeadTime.WC_NBR as WORKCENTER, 
				WIPTracking.dbo.WorkCentersLeadTime.Lead_Time, 
				[FastPrice].[dbo].[WPHEADER].HDRACTIVITYCODE AS JobStatus, 
				FastPrice.dbo.WPLABOR.WIPACTIVITYCODE AS OperationStatus,
				sum(FastPrice.dbo.WPMATERI.[MTLCURSCRAPQTY] + FastPrice.dbo.WPMATERI.[MTLJTDSCRAPQTY]) AS Scrap,
				[FastPrice].[dbo].[WPHEADER].HDRNEEDDATE, [FastPrice].[dbo].[WPHEADER].HDRPROMDATE, 
				Getdate() AS TodaysDate, 
				DATEDIFF(day, Getdate(), HDRNEEDDATE) AS LeadDate, FastPrice.dbo.WPLABOR.WIPOPERATION,
				--dateadd(dd,sum(WIPTracking.dbo.WorkCentersLeadTime.Lead_Time) over (partition by FastPrice.dbo.WPHEADER.HDRJOBSEQ order by FastPrice.dbo.WPLABOR.WIPOPERATION),getdate()) as ProjectedStockDate,

				sum(WIPTracking.dbo.WorkCentersLeadTime.Lead_Time) over 
				(partition by FastPrice.dbo.WPHEADER.HDRJOBSEQ order by FastPrice.dbo.WPLABOR.WIPOPERATION) As DUST, 
				WIPTracking.dbo.Transactions.StationID as TrackingLocation, [FastPrice].[dbo].[WPHEADER].HDRACTIVITYDATE


FROM            FastPrice.dbo.WPHEADER INNER JOIN
                         FastPrice.dbo.WPLABOR ON FastPrice.dbo.WPHEADER.HDRJOBSEQ = FastPrice.dbo.WPLABOR.WIPJOBNUMBER 
						 INNER JOIN
                         WIPTracking.dbo.Transactions ON WIPTracking.dbo.Transactions.WorkOrder = FastPrice.dbo.WPHEADER.HDRJOBSEQ 
						 INNER JOIN
                         WIPTracking.dbo.WorkCentersLeadTime ON FastPrice.dbo.WPLABOR.WIPDEPARTMENT + FastPrice.dbo.WPLABOR.WIPMACHINE = WIPTracking.dbo.WorkCentersLeadTime.WC_NBR 
						 INNER JOIN
                         FastPrice.dbo.IMITEM ON FastPrice.dbo.WPHEADER.HDRPARTNUMBER = FastPrice.dbo.IMITEM.IMPART
						INNER JOIN
						 FastPrice.dbo.WORKCTR ON FastPrice.dbo.WORKCTR.WC_NBR = WIPTracking.dbo.WorkCentersLeadTime.WC_NBR 
						INNER JOIN
						 FastPrice.dbo.WPMATERI ON FastPrice.dbo.WPHEADER.HDRJOBSEQ = FastPrice.dbo.WPMATERI.[HDRJOBNUMBER]


WHERE        [FastPrice].[dbo].[WPHEADER].HDRACTIVITYCODE <> '99' AND 
			 [FastPrice].[dbo].[WPHEADER].HDRACTIVITYCODE <> '98' AND
				FastPrice.dbo.IMITEM.IMACTIVE = 'A'  AND 
				FastPrice.dbo.IMITEM.IMSTDLOC = 'C0'
				AND WorkOrder = 'DD402R' 
				

GROUP BY	FastPrice.dbo.WPHEADER.HDRJOBSEQ, FastPrice.dbo.WPHEADER.HDRPARTNUMBER, 
			FastPrice.dbo.WPHEADER.HDRJOBQTY,  
			FastPrice.dbo.WPHEADER.HDRLOCATION, FastPrice.dbo.IMITEM.fldBU, 
			FastPrice.dbo.IMITEM.fldPG, WIPTracking.dbo.WorkCentersLeadTime.WC_NBR, 
			WIPTracking.dbo.WorkCentersLeadTime.Lead_Time, [FastPrice].[dbo].[WPHEADER].HDRACTIVITYCODE, FastPrice.dbo.WPLABOR.WIPACTIVITYCODE,
			[FastPrice].[dbo].[WPHEADER].HDRNEEDDATE, [FastPrice].[dbo].[WPHEADER].HDRPROMDATE, FastPrice.dbo.WPLABOR.WIPOPERATION, 
			WIPTracking.dbo.Transactions.StationID, [FastPrice].[dbo].[WPHEADER].HDRACTIVITYDATE

			
ORDER BY  FastPrice.dbo.WPLABOR.WIPOPERATION
