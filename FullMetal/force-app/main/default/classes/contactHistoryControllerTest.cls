@isTest(SeeAllData=true)
public class contactHistoryControllerTest {
	static testMethod void test()
    {
        Application__c c = [select id from Application__c limit 1];
        ApexPages.StandardController sc = new ApexPages.StandardController(c);
        contactHistoryController t = new contactHistoryController(sc);        
        contactHistoryController.loadHistory('{"offset":"0"}');
    }
}