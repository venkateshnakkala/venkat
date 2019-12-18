@isTest
public class TestQueryController {

    static testmethod void StartTest()
    {
   	    QueryController qc = new QueryController();
        qc.ShowAllQueries();
        qc.AddNewQuery();
        qc.QueryName = 'Test Query';
        qc.SaveQuery();
        
        Query__c que1 = new Query__c();
        que1.Name = 'My Query 1';
        que1.Sequence__c = 1;
        insert que1;
        
        Query__c que2 = new Query__c();
        que2.Name = 'My Query 2';
        que2.Sequence__c = 2;
        insert que2;
        
        qc.QueryID = que1.id;
        qc.EditMode = true;
        qc.EditQuery();
        qc.UpdateQuery();
        
        qc.Down();
        qc.Up();
        
        qc.DeleteQuery();
              
    }
    
}