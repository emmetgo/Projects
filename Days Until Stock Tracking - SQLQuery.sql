SELECT        FASTPRICE.[dbo].WPHEADER.HDRJOBSEQ, FASTPRICE.[dbo].WPHEADER.HDRPARTNUMBER, 
				FASTPRICE.[dbo].WPLABOR.WIPOPERATION, FASTPRICE.[dbo].WPLABOR.WIPACTIVITYCODE, 
				[WIPTracking].[dbo].[Transactions].[WorkOrder], [WIPTracking].[dbo].[Transactions].[TimeStamp], [WIPTracking].[dbo].[Transactions].[StationId]


FROM         

   (FASTPRICE.[dbo].WPHEADER INNER JOIN
                         FASTPRICE.[dbo].WPLABOR ON FASTPRICE.[dbo].WPHEADER.HDRJOBSEQ = FASTPRICE.[dbo].WPLABOR.WIPJOBNUMBER)
						 INNER JOIN [WIPTracking].[dbo].[Transactions] ON [WIPTracking].[dbo].[Transactions].[WorkOrder] = FASTPRICE.[dbo].WPHEADER.HDRJOBSEQ
--WHERE        (FASTPRICE.[dbo].WPHEADER.HDRJOBSEQ = 'DC754R')
WHERE        (FASTPRICE.[dbo].WPHEADER.HDRJOBSEQ = 'DC754R' OR FASTPRICE.[dbo].WPHEADER.HDRJOBSEQ = 'UHPE2443')
