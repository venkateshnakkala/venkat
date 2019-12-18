@isTest
public class UpdateCaseTest {
  public static testMethod void test1(){
       
      Contact ct =new Contact();
      ct.email='test@test.com';
      ct.LastName='Test';
      ct.Phone='7788991234';
      insert ct;
      
       case cases = new case(SuppliedEmail= 'test@test.com',Rating__c = 4.0);
        insert cases;
      Id bd= cases.Id;
      
      UpdateCase.assignToMyQueue(bd);
      
       }
}