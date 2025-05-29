/*******************************************************************************************
* @Name         QuoteTriggerService
* @Author       Yash Shukla
* @Description  Quote Trigger Service Class
* @Test Class   
*******************************************************************************************/
/* MODIFICATION LOG
* Version            Developer             Date                    Description
*-------------------------------------------------------------------------------------------
*  1.0             Yash Shukla            12-Mar-2025            Initial Creation    

*******************************************************************************************/
public without sharing class QuoteTriggerService implements TriggerAction.BeforeInsert, TriggerAction.BeforeUpdate{
    
    public void beforeInsert(List<Quote> triggerNew){
        //QuoteTriggerHandler.checkIfDraftQuoteExists(triggerNew);
        QuoteTriggerHandler.setApprovalStatus(triggerNew);
        QuoteTriggerHandler.setQuoteCurrency(triggerNew);
        
    }
    
    public void beforeUpdate(List<Quote> triggerNew, List<Quote> triggerOld){
        Map<String,Quote> newQuoteRecordmap = new Map<String,Quote>();
        for(Quote qte : triggerNew){
            newQuoteRecordmap.put(qte.Id,qte);
        }
        List<Quote> updatedStatusQuotes = new List<Quote>();
        List<Quote> updatedPriceQuotes = new List<Quote>();
        List<String> terminalStatus = System.Label.QuoteTerminalStatus.split(',');

        for(Quote qte : triggerOld){
            if(qte.Status != newQuoteRecordmap.get(qte.Id).Status && !terminalStatus.contains(newQuoteRecordmap.get(qte.Id).Status)){
                updatedStatusQuotes.add(newQuoteRecordmap.get(qte.Id));
            }
            if((qte.TotalPrice != newQuoteRecordmap.get(qte.Id).TotalPrice) && newQuoteRecordmap.get(qte.Id).Status != 'Rejected' && newQuoteRecordmap.get(qte.Id).Opportunity_Record_Type__c == 'Sales Deal'){
                updatedPriceQuotes.add(newQuoteRecordmap.get(qte.Id));
            }
        }
        if(!updatedStatusQuotes.isEMpty()){
            
            //QuoteTriggerHandler.checkIfDraftQuoteExists(updatedStatusQuotes);
        }
        if(!updatedPriceQuotes.isEMpty()){
            
            QuoteTriggerHandler.setApprovalStatus(updatedPriceQuotes);
        }
    }


}