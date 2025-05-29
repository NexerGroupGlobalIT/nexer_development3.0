/*******************************************************************************************
* @Name         QuoteTriggerHandler
* @Author       Yash Shukla
* @Description  Quote Trigger Handler Class
* @Test Class   
*******************************************************************************************/
/* MODIFICATION LOG
* Version            Developer             Date                    Description
*-------------------------------------------------------------------------------------------
*  1.0             Yash Shukla            12-Mar-2025            Initial Creation    

*******************************************************************************************/
public without sharing class QuoteTriggerHandler {
    
    public static void setApprovalStatus(List<Quote> quoteRecords){
        for(Quote qte : quoteRecords){
            if(((qte.CurrencyIsoCode == 'SEK' && qte.TotalPrice>500000) || (qte.CurrencyIsoCode == 'USD' && qte.TotalPrice>50000)|| (qte.CurrencyIsoCode == 'EUR' && qte.TotalPrice>50000) || (qte.CurrencyIsoCode == 'GBP' && qte.TotalPrice>50000)) && qte.Opportunity_Record_Type__c == 'Sales Deal'){
                qte.Approval_Status__c = 'Not Submitted';
            }
            else{
                qte.Approval_Status__c = 'Not Required';
            }
        }
    }
        
    /*public static void checkIfDraftQuoteExists(List<Quote> quoteRecords){
        Set<String> oppIds = new Set<String>();
        List<String> quoteIds = new List<String>();
        for(Quote qte : quoteRecords){
            oppIds.add(qte.OpportunityId);
            if(String.isNotBlank(qte.Id)){
                quoteIds.add(qte.Id);
            }
        }
        List<String> terminalStatus = System.Label.QuoteTerminalStatus.split(',');
        if(!oppIds.isEmpty()){
            Map<String,List<Quote>> oppIdQuotesMap = new Map<String,List<Quote>>();
            for(Quote qte : [SELECT Id, OpportunityId, Status, Name FROM Quote WHERE OpportunityId IN:oppIds 
                             AND Status NOT IN:terminalStatus]){
                if(!quoteIds.contains(qte.Id)){
                    if(!oppIdQuotesMap.containsKey(qte.OpportunityId)){
                        oppIdQuotesMap.put(qte.OpportunityId, new List<Quote>());
                    }
                    oppIdQuotesMap.get(qte.OpportunityId).add(qte);
                }
            }
            if(!oppIdQuotesMap.isEmpty()){
                for(Quote newquote : quoteRecords){
                    if(oppIdQuotesMap.containsKey(newquote.OpportunityId)){
                        newquote.addError(System.Label.Quote_Draft_Error_Message+' '+oppIdQuotesMap.get(newquote.OpportunityId)[0].Name);
                    }
                }
            }
        }
    }*/
    
    public static void setQuoteCurrency(List<Quote> quoteRecords){
        Set<String> oppIds = new Set<String>();
        for(Quote qte : quoteRecords){
            oppIds.add(qte.OpportunityId);
        }
        Map<String,String> oppId_CurrencyMap = new Map<String,String>();
        if(!oppIds.isEmpty()){
            for(Opportunity oppty : [SELECT Id, Name, CurrencyIsoCode FROM Opportunity WHERE Id IN:oppIds]){
                oppId_CurrencyMap.put(oppty.Id, oppty.CurrencyIsoCode);
            }
            for(Quote qte : quoteRecords){
                qte.CurrencyIsoCode = oppId_CurrencyMap.get(qte.OpportunityId);
         	}
        }
    }
}