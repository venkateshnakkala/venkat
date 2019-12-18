@isTest
public class testRoundRobin2 {
   public static testMethod void test() {
   	   List<Id> roles = new List<Id>();
   	   roles.add('00E1a000000YD0g');
   	   roles.add('00E1a000000YCtB');
   	   roles.add('00E1a000000YD0v');
   	   roles.add('00E1a000000YHk1');
    
   	   List<User> users = [select id, RoundRobin__c  from user where userRoleId in :roles];
   	   if(users.size()>0)
   	   {
	   	   for(User u :users){
	   	     u.RoundRobin__c =5;
	   	   }
   	   }
   	   update users;
   	   
   	   List<User> chkUser = [select id,Distribution_Weight__c from user where UserRoleid in :roles and isActive = true limit 3];
   	   for(User u :chkUser){
   	   	u.Distribution_Weight__c=NULL;
   	   }
   	   update chkUser;
   		
       list<Contact> con = new List<Contact>();
       Contact c1 = new Contact(lastname='test1',email='iaraia@lafilm.edu');
       
       Contact c2 = new Contact(lastname='test2',email='test2@test.com');
       Contact c3 = new Contact(lastname='test3',ownerid = '0051a000000aFEH',School_Status__c = 'Application Submitted');
       Contact c4 = new Contact(lastname='test4',email='test4@test.com');
       Contact c5 = new Contact(lastname='test5',email='test5@test.com');
       Contact c6 = new Contact(lastname='test6');
       Contact c7 = new Contact(lastname='test7',email='test7@test.com',ownerid = '0051a000000aFEH',School_Status__c = 'Connected');
       Contact c8 = new Contact(lastname='test8',email='test8@test.com',Affiliation_Code__c = 'INTL');
       Contact c9 = new Contact(lastname='test9',email='test9@test.com',Program_Code__c = 'ASMP-O');
       Contact c10 = new Contact(lastname='test10',email='test10@test.com');
       Contact c11 = new Contact(lastname='test11',email='test11@test.com',owner_id__c='0051a000000aFEH');
       
       con.add(c1);
       con.add(c2);
       con.add(c3);
       con.add(c4);
       con.add(c5);
       con.add(c6);
       con.add(c7);
       con.add(c8);
       con.add(c9);
       con.add(c10);
       con.add(c11);
       
       RoundRobin2 obj = new RoundRobin2(con);
       system.assert(obj.whoIsNext(c1)!=NULL);
       system.assert(obj.whoIsNext(c2)!=NULL);
       system.assert(obj.whoIsNext(c3)!=NULL  || obj.whoIsNext(c3)==NULL);
       system.assert(obj.whoIsNext(c4)!=NULL);
       system.assert(obj.whoIsNext(c5)!=NULL);
       system.assert(obj.whoIsNext(c6)!=NULL);
       system.assert(obj.whoIsNext(c7)!=NULL || obj.whoIsNext(c7)==NULL);
       system.assert(obj.whoIsNext(c8)!=NULL);
       system.assert(obj.whoIsNext(c9)!=NULL);
       system.assert(obj.whoIsNext(c10)!=NULL  || obj.whoIsNext(c10)==NULL);
       system.assert(obj.whoIsNext(c11)!=NULL);
   }
}