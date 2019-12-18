@istest(SeeAllData=True)
public class UpdateActivityBatch_Test{
    //query the activities to process
    static testmethod void taskTestMethod(){
        
        test.startTest();
        Date duedate=system.today();
        Task tk=[SELECT ActivityDate,Subject,WhoId,WhatId,Status FROM Task Where Subject='New Student Orientation' AND Status='Pending' AND ActivityDate=:duedate Limit 1];
        UpdateActivitiesBatch bc= new UpdateActivitiesBatch();
        Database.executebatch(bc);
        test.stopTest();
        
    }
}