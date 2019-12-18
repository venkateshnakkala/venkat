@isTest(SeeAllData=true)
public class AllTrigger_Test{
    static testmethod void test1(){
        insert new et4ae5__Configuration__c(et4ae5__Support_Ticket_Recipient__c = 'example@example.com');
        Contact con = new Contact(firstname='test', lastname='test');
        insert con;
        Event evn = new Event(DurationInMinutes=60, ActivityDateTime=DateTime.now());
        insert evn;
        Task tsk = new Task();
        insert tsk;
        Campaign ca = [select id from Campaign limit 1];
        CampaignMember cam = new CampaignMember(ContactId=con.id, CampaignId=ca.id);
        insert cam;
    }
}