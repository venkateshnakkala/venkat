@isTest(SeeAllData=true)
private class TOGReassign_test
{
    static testMethod void test1() 
    {
        Test.startTest();
        TOGReassign t = new TOGReassign();
        Database.executebatch(t);
        Test.stopTest();
    }
}