public without sharing class MyClass {

    public static void createCase() {
        list <Account> accList = [select Id from Account where name = 'My Account'];
        list <Case> caseList = new list <Case>();
        for(Account acc : accList) {
            caseList.add(new Case(AccountId = acc.Id, Status = 'New', Subject = 'Some Subject...'));
        }
        insert caseList;
    }
}