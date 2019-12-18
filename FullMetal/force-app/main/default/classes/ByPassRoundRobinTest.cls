@IsTest
class ByPassRoundRobinTest
{
    public static testmethod void test1(){
        contact c = new contact(lastname='jfksdjfds',firstname='jfkjgsf');
        insert c;
        
        Application__c a = new Application__c(student__c=c.id, program_code__c='ASMP');
        insert a;
    }
}