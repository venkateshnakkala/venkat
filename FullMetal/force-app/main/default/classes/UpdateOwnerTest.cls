@IsTest
public class UpdateOwnerTest
{
    public static testmethod void test1()
    {
        Contact c = new Contact();
        c.FirstName='fjsdkjfsdkfjsd';
        c.LastName='jhgsfkdsjfksjfs';
        c.SyStudentId__c='1013097';
        c.Program_Code__c='ASMP';
        insert c;
        
        User u = [select id from user where IsActive=true and UserRole.id!=NULL limit 1];
        
        c.ownerId=u.id;
        update c;
    }
}