@isTest
public class OpportunityTriggerTest {
     @testSetup
    static void testDataSetup(){
        Account accInstance = (Account)TestFactory.createSObject(new Account  (
            Name ='New Account'
        ),true);
        Opportunity oppInstance = (Opportunity)TestFactory.createSObject(new Opportunity  (
            Name ='New Opportunity', AccountId = accInstance.Id, StageName = 'Qualification', CloseDate = System.Today()
        ),true); 
    }
    
    @istest
    static void testOpptyInsert(){
        List<Opportunity> oppty = [SELECT Id,AccountId FROM Opportunity LIMIT 1];
        Opportunity oppInstance = (Opportunity)TestFactory.createSObject(new Opportunity  (
            Name ='New Opportunity Child', AccountId = oppty[0].AccountId, StageName = 'Qualification', CloseDate = System.Today(),
            Parent_Opportunity__c = oppty[0].Id, Amount = 20000
        ),true); 
        
    }
    
    @istest
    static void testOpptyUpdate(){
        List<Opportunity> oppty = [SELECT Id,AccountId FROM Opportunity LIMIT 1];
        Opportunity oppInstance = (Opportunity)TestFactory.createSObject(new Opportunity  (
            Name ='New Opportunity Child', AccountId = oppty[0].AccountId, StageName = 'Qualification', CloseDate = System.Today(),
            Parent_Opportunity__c = oppty[0].Id, Amount = 20000
        ),true); 
        oppInstance.Amount = 23000;
        update oppInstance;
        
    }

}