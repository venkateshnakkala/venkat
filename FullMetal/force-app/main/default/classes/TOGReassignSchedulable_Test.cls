@isTest(SeeAllData=true)
global class TOGReassignSchedulable_Test
{
    static testMethod void test() 
    {
         TOGReassignSchedulable myClass = new TOGReassignSchedulable();   
         String chron = '0 0 23 * * ?';        
         system.schedule('Test Sched', chron, myClass);
    }
}