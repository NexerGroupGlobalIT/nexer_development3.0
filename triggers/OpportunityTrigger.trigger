trigger OpportunityTrigger on Opportunity (before insert, after insert, after update) {
    
    if(Trigger.isAfter && Trigger.isInsert){
        OpportunityTriggerService.handleOpportunityInsertion(Trigger.newMap);
    }
    else if(Trigger.isAfter && Trigger.isUpdate){
         OpportunityTriggerService.handleOpportunityUpdate(Trigger.oldMap, Trigger.newMap);
    }

}