/*******************************************************************************************
* @Name         OpportunityTriggerService
* @Author       Yash Shukla
* @Description  Opportunity Trigger Service Class
* @Test Class   
*******************************************************************************************/
/* MODIFICATION LOG
* Version            Developer             Date                    Description
*-------------------------------------------------------------------------------------------
*  1.0             Yash Shukla            01-May-2025            Initial Creation    
*******************************************************************************************/
public class OpportunityTriggerService {
    
    public static void handleOpportunityInsertion(Map<Id,Opportunity> opportunityMap){
        Map<String,Decimal> oppIdCalculatedAmountMap = new Map<String,Decimal>();
        for(Id oppId : opportunityMap.keySet()){
            if(String.isNotBlank(opportunityMap.get(oppId).Parent_Opportunity__c )){
                if(!oppIdCalculatedAmountMap.containsKey(opportunityMap.get(oppId).Parent_Opportunity__c)){
                    oppIdCalculatedAmountMap.put(opportunityMap.get(oppId).Parent_Opportunity__c, 0);
                }
                Decimal calculatedVal = oppIdCalculatedAmountMap.get(opportunityMap.get(oppId).Parent_Opportunity__c);
                calculatedVal += (opportunityMap.get(oppId).Amount == null)?0:opportunityMap.get(oppId).Amount;
                oppIdCalculatedAmountMap.put(opportunityMap.get(oppId).Parent_Opportunity__c,calculatedVal);
            }
        }
        List<Opportunity> parentOpportunities = new List<Opportunity>();
        if(!oppIdCalculatedAmountMap.isEMpty()){
            parentOpportunities = [SELECT Id, Amount, RollUp_Child_Opportunites_Amount__c  FROM Opportunity Where ID IN:oppIdCalculatedAmountMap.keySet()];
            for(Opportunity oppty : parentOpportunities){
                oppty.RollUp_Child_Opportunites_Amount__c = oppty.RollUp_Child_Opportunites_Amount__c == null ? 0 : oppty.RollUp_Child_Opportunites_Amount__c;
                oppty.RollUp_Child_Opportunites_Amount__c += oppIdCalculatedAmountMap.get(oppty.Id);
            }
            update parentOpportunities;
        }
    }
    
    public static void handleOpportunityUpdate(Map<Id,Opportunity> opportunityMapOldValues, Map<Id,Opportunity> opportunityMapNewValues){
        Map<String,Decimal> oppIdCalculatedAmountMap = new Map<String,Decimal>();
        for(Id oppId : opportunityMapNewValues.keySet()){
            if(String.isNotBlank(opportunityMapNewValues.get(oppId).Parent_Opportunity__c )){
                if(opportunityMapNewValues.get(oppId).Amount != opportunityMapOldValues.get(oppId).Amount){
                    if(!oppIdCalculatedAmountMap.containsKey(opportunityMapNewValues.get(oppId).Parent_Opportunity__c)){
                        oppIdCalculatedAmountMap.put(opportunityMapNewValues.get(oppId).Parent_Opportunity__c, 0);
                    }
                    Decimal calculatedVal = oppIdCalculatedAmountMap.get(opportunityMapNewValues.get(oppId).Parent_Opportunity__c);
                    calculatedVal += (opportunityMapNewValues.get(oppId).Amount - opportunityMapOldValues.get(oppId).Amount);
                    oppIdCalculatedAmountMap.put(opportunityMapNewValues.get(oppId).Parent_Opportunity__c,calculatedVal);
                }
            }
        }
        List<Opportunity> parentOpportunities = new List<Opportunity>();
        if(!oppIdCalculatedAmountMap.isEMpty()){
            parentOpportunities = [SELECT Id, Amount, RollUp_Child_Opportunites_Amount__c  FROM Opportunity Where ID IN:oppIdCalculatedAmountMap.keySet()];
            for(Opportunity oppty : parentOpportunities){
                oppty.RollUp_Child_Opportunites_Amount__c = oppty.RollUp_Child_Opportunites_Amount__c == null ? 0 : oppty.RollUp_Child_Opportunites_Amount__c;
                oppty.RollUp_Child_Opportunites_Amount__c += oppIdCalculatedAmountMap.get(oppty.Id);
            }
            update parentOpportunities;
        }
    }

}