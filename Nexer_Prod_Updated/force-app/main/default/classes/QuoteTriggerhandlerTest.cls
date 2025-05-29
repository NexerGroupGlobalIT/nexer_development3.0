@isTest
public class QuoteTriggerhandlerTest {
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
    static void testQuoteInsert(){
        List<Opportunity> oppty = [SELECT Id FROM Opportunity];
        Quote qte = (Quote)TestFactory.createSObject(new Quote  (
            Name ='New Quote', OpportunityId = oppty[0].Id, Status = 'Draft'
        ),true); 
        Quote qte2 = (Quote)TestFactory.createSObject(new Quote  (
            Name ='New Quote2', OpportunityId = oppty[0].Id, Status = 'Draft'
        ),false);
        try{
            insert qte2;
        }catch(Exception ex){
            
        }
    }
    
    @istest
    static void testQuoteUpdate(){
        List<Opportunity> oppty = [SELECT Id FROM Opportunity];
        Quote qte = (Quote)TestFactory.createSObject(new Quote  (
            Name ='New Quote', OpportunityId = oppty[0].Id, Status = 'In Review'
        ),false); 
        Quote qte2 = (Quote)TestFactory.createSObject(new Quote  (
            Name ='New Quote2', OpportunityId = oppty[0].Id, Status = 'Draft'
        ),false);
        List<Quote> qteRecords = new List<Quote>{qte,qte2};
        insert qteRecords;
        qte.Status = 'Draft';

        try{
            update qte;
        }catch(Exception ex){
            
        }
    }

}