@isTest(SeeAllData=true)
public class LiveMessageOverDueTest
{
    static testMethod void test()
    {
        LiveMessageOverDue.find();
        LiveMessageOverDue.close();
        LiveMessageOverDue.closeAll();
    }
}