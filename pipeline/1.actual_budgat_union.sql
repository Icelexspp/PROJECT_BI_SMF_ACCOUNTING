SELECT 
	'ACTUAL' AS DATA_SOURCE, 
    SA.jobno AS JOBNO,
--    SA.docno AS DOCNO, 
    SA.jobstat AS JOBSTAT,
    SA.jobdate AS JOBDATE,
    SA.jobclass  AS JOBCLASS,
    case 
    	WHEN JOBCLASS = 'IM' AND sub_sysname = 'SF' THEN 'SI' 
    	WHEN JOBCLASS = 'EX' and sub_sysname = 'SF' THEN 'SE'
    	WHEN JOBCLASS = 'IM' AND sub_sysname = 'AF' THEN 'AI'
    	WHEN JOBCLASS = 'EX' and sub_sysname = 'AF' THEN 'AE'
    	WHEN JOBCLASS = 'IM' AND sub_sysname = 'CS' THEN 'CI'
    	WHEN JOBCLASS = 'EX' and sub_sysname = 'CS' THEN 'CE'	
    END
    AS JOB_TYPE,
    SA.sub_sysname AS SUB_SYSNAME,
    SA.jobowner AS JOBOWNER,
    SA.loadtype AS LOADTYPE,
    SA.saleno AS SALENO,
    SA.salename AS SALENAME,
    SA.delport AS DELPORT,
    SA.delportname AS DELPORTNAME,
    SA.recport AS RECPORT,
    SA.recportname  AS RECPORTNAME,
    SA.linername AS LINERNAME,
    SA.shippername AS SHIPPERNAME,
    SA.consigneename AS CONSIGNEENAME, 
    SA.coloadname AS COLOADNAME,
    SA.billto AS BILLTO,
    SA.etd AS ETD,
    SA.eta AS ETA,
--    SA.cbm AS CBM,
--    SA.gw AS GW,
--    SA.pkgqty AS PKGQTY,
--    SA.pkgunit AS PKGUNIT,
--    SA.ctn20 AS CTN20,
--    SA.ctn40 AS CTN40,
 --   SA.ctn40hc AS CTN40HC,
 --   SA.ctn45 AS CTN45,
    CASE 
    	WHEN ctn20 > 0 AND loadtype = 'FCL' THEN ctn20*1
    	WHEN ctn40 > 0 AND loadtype = 'FCL' THEN ctn40*2
    END
    AS NOCTN,
    SA.optcheck1 AS OPTCHECK1_SMF,
    NULL AS  OPTCHECK1_BG,
    CASE
    	WHEN OPTCHECK1 = 1 THEN 'ในเครือ'
        WHEN OPTCHECK1 = 2 THEN 'นอกเครือ'
    ELSE 'ไม่ระบุ'
    END
    AS CUSTOMER_TYPE_DESC_ACC,
    SA.rtsold AS RTSOLD,
    SA.rtcost AS RTCOST,
    SA.fromname AS FROMNAME,
    SA.hanamt AS COMMISSION,
    NULL AS bg_rtsold,
    NULL AS bg_rtcost,
    NULL AS bg_gp,
    NULL AS bg_commission,
    NULL AS total_gp,
    NULL AS total_gp_ae_se,
    NULL AS note,
    SA.YEAR AS YEAR,
    SA.MONTH AS MONTH_MM,
    NULL AS MONTH_MMM,
    concat(sa.YEAR,sa.month) AS YEARMONTH,
    CASE 
	   	WHEN JOBCLASS = 'EX' and sub_sysname = 'AF' THEN RTSOLD-RTCOST
	   	WHEN JOBCLASS = 'EX' and sub_sysname = 'SF' THEN RTSOLD-RTCOST
	ELSE 0
	END
	AS GP_AE_SE,
	CASE 
	   	WHEN JOBCLASS = 'EX' and sub_sysname = 'AF' THEN RTSOLD-RTCOST-HANAMT
	   	WHEN JOBCLASS = 'EX' and sub_sysname = 'SF' THEN RTSOLD-RTCOST-HANAMT
	ELSE 0
	END
	AS GP_NO_COM_AE_SE,
	CASE 
	   	WHEN JOBCLASS = 'EX' and sub_sysname = 'AF' THEN HANAMT
	   	WHEN JOBCLASS = 'EX' and sub_sysname = 'SF' THEN HANAMT
	ELSE 0
	END
	AS COMMISSION_AE_SE,
	CASE 
	   	WHEN JOBCLASS = 'IM' AND sub_sysname = 'SF' THEN RTSOLD-RTCOST
	   	WHEN JOBCLASS = 'IM' AND sub_sysname = 'AF' THEN RTSOLD-RTCOST
	ELSE 0
	END
	AS COMMISSION_AI_SI

FROM DWH_SMF.SRC_SMF_ACTUAL_ACCOUNT  SA
UNION ALL 
SELECT
	'BUDGET' AS DATA_SOURCE, 
	NULL AS JOBNO,
--	NULL AS DOCNO,
	'Open' AS JOBSTAT,
	NULL AS JOBDATE,
	NULL AS JOBCLASS,
	NULL AS JOB_TYPE,
	NULL AS SUB_SYSNAME,
	NULL AS JOBOWNER,
	NULL AS LOADTYPE,
	NULL AS SALENO,
	NULL AS SALENAME,
	NULL AS DELPORT,
	NULL AS DELPORTNAME,
	NULL AS RECPORT,
	NULL AS RECPORTNAME,
	NULL AS LINERNAME,
	NULL AS SHIPPERNAME,
	NULL AS CONSIGNEENAME,
	NULL AS COLOADNAME,
	NULL AS BILLTO,
	NULL AS ETD,
	NULL AS ETA,
--	NULL AS CBM,
--	NULL AS GW,
--	NULL AS PKGQTY,
--	NULL AS PKGUNIT,
--	NULL AS CTN20,
--	NULL AS CTN40,
--	NULL AS CTN40HC,
--	NULL AS CTN45,
	NULL AS NOCTN ,
	NULL  AS OPTCHECK1_SMF,
    TB.optcheck1 AS OPTCHECK1_BG,
    CASE
    	WHEN optcheck1 = 1 THEN 'ในเครือ'
        WHEN optcheck1 = 2 THEN 'นอกเครือ'
    ELSE 'ไม่ระบุ'
    END
    AS CUSTOMER_TYPE_DESC_ACC,
    NULL AS RTSOLD,
    NULL AS RTCOST,
    NULL AS FROMNAME,
    NULL AS COMMISSION,
    TB.rtsold_acc AS bg_rtsold,
    TB.rtcost_acc  AS bg_rtcost,
    TB.gp AS bg_gp,
    TB.commission AS bg_commission,
    TB.total_gp AS total_gp,
    TB.total_gp_ae_se AS total_gp_ae_se,
    TB.f11 AS note,
    TB.year AS YEAR,
    NULL  AS MONTH_MM,
    TB.MONTH AS MONTH_MMM,
    CASE 
			WHEN MONTH = 'Jan' THEN concat (YEAR,'01')
			WHEN MONTH = 'Feb' THEN concat (YEAR,'02')
			WHEN MONTH = 'Mar' THEN concat (YEAR,'03')
			WHEN MONTH = 'Apr' THEN concat (YEAR,'04')
			WHEN MONTH = 'May' THEN concat (YEAR,'05')
			WHEN MONTH = 'Jun' THEN concat (YEAR,'06')
			WHEN MONTH = 'Jul' THEN concat (YEAR,'07')
			WHEN MONTH = 'Aug' THEN concat (YEAR,'08')
			WHEN MONTH = 'Sep' THEN concat (YEAR,'09')
			WHEN MONTH = 'Oct' THEN concat (YEAR,'10')
			WHEN MONTH = 'Nov' THEN concat (YEAR,'11')
			WHEN MONTH = 'Dec' THEN concat (YEAR,'12')
	END
	AS YEARMONTH,
	NULL AS GP_AE_SE,
	NULL AS GP_NO_COM_AE_SE,
	NULL AS COMMISSION_AE_SE,
	NULL AS COMMISSION_AI_SI
    
FROM dwh_smf.tmep_smf_budget_account  TB

--GRANT SELECT ON DWH_SMF.V_TBFACT_SMF_ACT_BUD_ACCOUNT TO PBI_SMF;