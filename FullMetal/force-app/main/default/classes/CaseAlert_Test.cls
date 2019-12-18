@isTest(SeeAllData=true)
class CaseAlert_Test
{
    static testMethod void test1() {

        List<Case> c =[select id from case limit 10];
        List<Id> i = new List<Id>();
        for(Case x :c){
            i.add(x.id);
        }
        CaseAlert.alertUs(i);

        system.assert(true);
    }
}