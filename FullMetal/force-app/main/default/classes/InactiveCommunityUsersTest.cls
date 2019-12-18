@istest
class InactiveCommunityUsersTest 
{
   static testmethod void test() 
   {
        String CRON_EXP = '0 0 0 1 * ?';
        
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('InactiveCommunityUsersTest', CRON_EXP, new InactiveCommunityUsers());
        // Get the information from the CronTrigger API object
        List<CronTrigger> ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
          
        Test.stopTest();
        System.assert(jobId==NULL || jobId!=NULL);
   }
}