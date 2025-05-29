/*******************************************************************************************
* @Name         QuoteTrigger
* @Author       Yash Shukla
* @Description  Quote Trigger
* @Test Class   AUSF_PricingApprovalWaiverControllerTest
*******************************************************************************************/
/* MODIFICATION LOG
* Version            Developer             Date                    Description
*-------------------------------------------------------------------------------------------
*  1.0             Yash Shukla            12-Mar-2025            Initial Creation    

*******************************************************************************************/
trigger QuoteTrigger on Quote (
    before insert,
    after insert,
    before update,
    after update,
    before delete,
    after delete,
    after undelete
) {
    new MetadataTriggerHandler().run();
}