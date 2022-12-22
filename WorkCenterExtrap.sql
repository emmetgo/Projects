SELECT        FastPrice.dbo.WPHEADER.HDRJOBSEQ AS WorkOrder, FastPrice.dbo.WPHEADER.HDRPARTNUMBER, MAX(FastPrice.dbo.WPLABOR.WIPOPERATION) AS Last_WIPOPERATION, FastPrice.dbo.WPLABOR.WIPACTIVITYCODE, 
                         FastPrice.dbo.WPHEADER.HDRLOCATION, FastPrice.dbo.IMITEM.fldBU, FastPrice.dbo.IMITEM.fldPG, WIPTracking.dbo.WorkCentersExtrapulated.WC_NBR,
						 FastPrice.dbo.WPLABOR.WIPDEPARTMENT + FastPrice.dbo.WPLABOR.WIPMACHINE AS WORKCENTER, FastPrice.dbo.WORKCTR.[DESCRIPTION]
FROM            FastPrice.dbo.WPHEADER INNER JOIN
                         FastPrice.dbo.WPLABOR ON FastPrice.dbo.WPHEADER.HDRJOBSEQ = FastPrice.dbo.WPLABOR.WIPJOBNUMBER 
						 INNER JOIN
                         WIPTracking.dbo.Transactions ON WIPTracking.dbo.Transactions.WorkOrder = FastPrice.dbo.WPHEADER.HDRJOBSEQ 
						 INNER JOIN
                         WIPTracking.dbo.WorkCentersExtrapulated ON FastPrice.dbo.WPLABOR.WIPDEPARTMENT + FastPrice.dbo.WPLABOR.WIPMACHINE = WIPTracking.dbo.WorkCentersExtrapulated.WC_NBR 
						 INNER JOIN
                         FastPrice.dbo.IMITEM ON FastPrice.dbo.WPHEADER.HDRPARTNUMBER = FastPrice.dbo.IMITEM.IMPART
						INNER JOIN
						 FastPrice.dbo.WORKCTR ON FastPrice.dbo.WORKCTR.WC_NBR = WIPTracking.dbo.WorkCentersExtrapulated.WC_NBR


WHERE        (FastPrice.dbo.WPLABOR.WIPACTIVITYCODE < 98) AND (FastPrice.dbo.WPHEADER.HDRACTIVITYCODE < 98)

GROUP BY	FastPrice.dbo.WPHEADER.HDRJOBSEQ, FastPrice.dbo.WPHEADER.HDRPARTNUMBER, FastPrice.dbo.WPLABOR.WIPACTIVITYCODE, 
			FastPrice.dbo.WPHEADER.HDRLOCATION, FastPrice.dbo.IMITEM.fldBU, 
			FastPrice.dbo.IMITEM.fldPG, WIPTracking.dbo.WorkCentersExtrapulated.WC_NBR, 
			FastPrice.dbo.WPLABOR.WIPDEPARTMENT + FastPrice.dbo.WPLABOR.WIPMACHINE, FastPrice.dbo.WORKCTR.[DESCRIPTION]