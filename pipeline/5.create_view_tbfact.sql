CREATE OR REPLACE VIEW  DWH_SMF.V_TBFACT_SMF_ACT_BUD_ACCOUNT
AS
SELECT
    data_source,
    jobno,
    jobstat,
    jobdate,
    jobclass,
    job_type,
    sub_sysname,
    jobowner,
    loadtype,
    saleno,
    salename,
    delport,
    delportname,
    recport,
    recportname,
    linername,
    shippername,
    consigneename,
    coloadname,
    billto,
    etd,
    noctn,
    optcheck1,
    optcheck1_bg,
    customer_type_desc_acc,
    rtsold,
    rtcost,
    fromname,
    hanamt,
    bg_rtsold,
    bg_rtcost,
    bg_gp,
    bg_commission,
    total_gp,
    total_gp_ae_se,
    year,
    month,
    month_mmm,
    yearmonth,
    gp_ae_se,
    gp_no_com_ae_se,
    commission_ae_se,
    commission_ai_si
FROM
    dwh_smf.tbfact_smf_act_bud_account;
--GRANT SELECT ON DWH_SMF.V_TBFACT_SMF_ACT_BUD_ACCOUNT TO PBI_SMF;