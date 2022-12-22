/*

DUST report with following headers:
MO						-
status					?
pin						?
job quantity			-
stock scrapped			?
quantity due			?
last mss activity date	?
need date				?
promise date			?
name					?    thers is many nulls here, maybe not keep or will it be filled in?
date					?
lead time				-
____________
scanning lead time		?
days until stock		?
projected stock date	?
over under				?
location				-
product code			-
bussines unit code		-

*/

SELECT        FastPrice.dbo.WPHEADER.HDRJOBSEQ AS WorkOrder, FastPrice.dbo.WPHEADER.HDRPARTNUMBER, 
				FastPrice.dbo.WPHEADER.HDRJOBQTY, FastPrice.dbo.WPHEADER.HDRLOCATION, FastPrice.dbo.IMITEM.fldBU, 
				FastPrice.dbo.IMITEM.fldPG, WIPTracking.dbo.WorkCentersLeadTime.WC_NBR as WORKCENTER, 
				WIPTracking.dbo.WorkCentersLeadTime.Lead_Time 
				--, MAX(FastPrice.dbo.WPLABOR.WIPOPERATION) AS Last_WIPOPERATION, FastPrice.dbo.WPLABOR.WIPACTIVITYCODE,
						 
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


--WHERE        (FastPrice.dbo.WPLABOR.WIPACTIVITYCODE < 98) AND (FastPrice.dbo.WPHEADER.HDRACTIVITYCODE < 98)

WHERE        WorkOrder = 'dc430r'

GROUP BY	FastPrice.dbo.WPHEADER.HDRJOBSEQ, FastPrice.dbo.WPHEADER.HDRPARTNUMBER, 
			FastPrice.dbo.WPHEADER.HDRJOBQTY,  
			FastPrice.dbo.WPHEADER.HDRLOCATION, FastPrice.dbo.IMITEM.fldBU, 
			FastPrice.dbo.IMITEM.fldPG, WIPTracking.dbo.WorkCentersLeadTime.WC_NBR, 
			WIPTracking.dbo.WorkCentersLeadTime.Lead_Time
			--, FastPrice.dbo.WPLABOR.WIPACTIVITYCODE,
			



