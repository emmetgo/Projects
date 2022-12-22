SELECT        TOP (100) PERCENT dbo.IMITEM.IMPRODUCTGROUP, SUBSTRING(dbo.IMITEM.IMPRODUCTCODE, 2, 3) AS Expr1, dbo.WPHEADER.HDRJOBSEQ, LTRIM(RTRIM(dbo.WPHEADER.HDRJOBSEQ)) AS hdrjobseqtrim, 
                         dbo.WPHEADER.HDRPARTNUMBER, LTRIM(RTRIM(dbo.WPHEADER.HDRPARTNUMBER)) AS Part, dbo.IMITEM.IMDESC, 
                         dbo.WPHEADER.HDRJOBQTY - dbo.WPHEADER.HDRCURPCSFIN - dbo.WPHEADER.HDRJTDPCSFIN - dbo.WPHEADER.HDRCURPCSSCRAP - dbo.WPHEADER.HDRJTDPCSSCRAP AS [Qty Due], 
                         
                                          
                                          CASE WHEN dbo.wpheader.hdrjobqty = 0 THEN 0 
                                          ELSE ((dbo.wpheader.hdrjobqty - wpheader.hdrjobqty - wpheader.hdrcurpcsfin - wpheader.hdrjtdpcsfin - wpheader.hdrcurpcsscrap - wpheader.hdrjtdpcsscrap) 
                         / dbo.wpheader.hdrjobqty) * 100 END 
                                          AS [%Complete], 
                                          
                                          
                                          dbo.WPHEADER.HDRJOBQTY, dbo.WPHEADER.HDRCURPCSFIN, dbo.WPHEADER.HDRCURPCSSCRAP, dbo.WPHEADER.HDRCURPCSREJECTED, 
                         dbo.WPHEADER.HDRFIRSTINPROCESSDATE, dbo.WPHEADER.HDRINPROCESSDATE, dbo.WPHEADER.HDRPICKDATE, dbo.WPHEADER.HDRACTIVITYDATE, dbo.WPHEADER.HDRPROMDATE, dbo.WPHEADER.HDRNEEDDATE, 
                         dbo.WPHEADER.HDRACTIVITYCODE, dbo.WPHEADER.HDRSTOCKDATE, dbo.WPHEADER.HDRJTDPCSFIN, dbo.WPHEADER.HDRJTDPCSSCRAP, dbo.IMCOST.FixedStd, dbo.IMCOST.CurrStd, dbo.WPHEADER.HDRSUDIR, 
                         dbo.WPHEADER.HDRSUOHD, dbo.WPHEADER.HDRMAT, dbo.WPHEADER.HDRLBR, dbo.WPHEADER.HDROHD, dbo.WPHEADER.HDRVAROHD, dbo.WPHEADER.HDRSUB, dbo.WPHEADER.HDRCOMMENTLITERAL, 
                         dbo.WPHEADER.HDRENTEREDDATE, LEFT(dbo.IMITEM.IMPRODUCTCODE, 1) AS InvType
FROM            dbo.WPHEADER LEFT OUTER JOIN
                         dbo.IMCOST ON dbo.WPHEADER.HDRPARTNUMBER = dbo.IMCOST.CUSTPART INNER JOIN
                         dbo.IMITEM ON dbo.WPHEADER.HDRPARTNUMBER = dbo.IMITEM.IMPART
WHERE        (dbo.WPHEADER.HDRACTIVITYCODE <> '99') AND (LEFT(dbo.IMITEM.IMPRODUCTCODE, 1) <> 'T') AND (dbo.IMITEM.IMSTDLOC = 'c0') AND (dbo.WPHEADER.HDRLOCATION = 'c0') AND (dbo.IMCOST.CUSTLOC = 'c0')
ORDER BY dbo.WPHEADER.HDRJOBSEQ
