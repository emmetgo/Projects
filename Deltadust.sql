--COMBINE DUST1 AND DELTA DAYS
--the returns with some of the part numbers are the same but the work orders are diffnert at least, should the partn numbers be unique or no

SELECT        
FASTPRICE.DBO.WPHEADER.HDRJOBSEQ AS WorkOrder,
FASTPRICE.DBO.WPHEADER.HDRPARTNUMBER,
MAX(FASTPRICE.DBO.WPLABOR.WIPOPERATION) AS 'Last_WIPOPERATION', 
FASTPRICE.DBO.WPLABOR.WIPACTIVITYCODE, 
FASTPRICE.DBO.WPHEADER.HDRLOCATION, 
FASTPRICE.DBO.IMITEM.fldBU, 
FASTPRICE.DBO.IMITEM.fldPG, 
--WIPTracking.dbo.Transactions.[TimeStamp],
WIPTracking.dbo.Transactions.StationId, 
--GETDATE() as Todays_date, 
DATEDIFF(DAY, CURRENT_TIMESTAMP, WIPTracking.dbo.Transactions.[TimeStamp]) as delta


FROM	FASTPRICE.DBO.WPHEADER INNER JOIN
        FASTPRICE.DBO.WPLABOR ON FASTPRICE.DBO.WPHEADER.HDRJOBSEQ = FASTPRICE.DBO.WPLABOR.WIPJOBNUMBER INNER JOIN
        WIPTracking.dbo.Transactions ON WIPTracking.dbo.Transactions.WorkOrder = FASTPRICE.DBO.WPHEADER.HDRJOBSEQ INNER JOIN
        FASTPRICE.DBO.IMITEM ON FASTPRICE.DBO.WPHEADER.HDRPARTNUMBER = FASTPRICE.DBO.IMITEM.IMPART


WHERE	(FASTPRICE.DBO.WPLABOR.WIPACTIVITYCODE < 98) AND (FASTPRICE.DBO.WPHEADER.HDRACTIVITYCODE < 98)

GROUP BY 
FASTPRICE.DBO.WPHEADER.HDRJOBSEQ, 
FASTPRICE.DBO.WPHEADER.HDRPARTNUMBER, 
FASTPRICE.DBO.WPLABOR.WIPOPERATION,
FASTPRICE.DBO.WPLABOR.WIPACTIVITYCODE, 
FASTPRICE.DBO.WPHEADER.HDRLOCATION, 
FASTPRICE.DBO.IMITEM.fldBU, 
FASTPRICE.DBO.IMITEM.fldPG, 
--WIPTracking.dbo.Transactions.[TimeStamp], 
WIPTracking.dbo.Transactions.StationId, 
--GETDATE(),  
DATEDIFF(DAY, CURRENT_TIMESTAMP, WIPTracking.dbo.Transactions.[TimeStamp])


