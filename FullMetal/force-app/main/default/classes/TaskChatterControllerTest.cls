@isTest(SeeAllData=true)
public class TaskChatterControllerTest
{
    static testMethod void test()
    {
        Contact c = [select id from contact limit 1];
        ApexPages.StandardController sc = new ApexPages.StandardController(c);
        TaskChatterController t = new TaskChatterController(sc);        
        TaskChatterController.loadChatCOntroller('{"offset":"0"}');
    }
}