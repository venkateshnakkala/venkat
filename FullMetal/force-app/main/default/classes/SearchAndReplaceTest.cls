@isTest(seealldata=true)
public class SearchAndReplaceTest
{
    static testMethod void test1(){
        SearchAndReplace r1 = new SearchAndReplace();
        SearchAndReplace r2 = new SearchAndReplace('SELECT Id from application__c limit 5',new SearchAndReplace.row('short_essay__c','test'));
        List<SearchAndReplace.row> rr = new List<SearchAndReplace.row>();
        rr.add(new SearchAndReplace.row('short_essay__c','test'));
        SearchAndReplace r3 = new SearchAndReplace('SELECT Id from application__c limit 5',rr);
        r3.set('short_essay__c','test');
    }
    static testMethod void test2(){
        
        String q='SELECT Id from application__c limit 5';
        String f='short_essay__c';
        String v='test';
        
        Test.startTest();
        SearchAndReplace r = new SearchAndReplace(q,f,v);
        Id i =Database.executeBatch(r);
        Test.stopTest();
    }
}