global class updateRecords implements Database.Batchable<sObject>{

   global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'select id, ssn__c from contact where systudentid__c!=NULL';
        return Database.getQueryLocator(query);
    }

   public void execute(Database.BatchableContext BC, List<Contact> scope){

     for(Contact s : scope){
         s.DSSN__c=s.SSN__c;
     }

     update scope;
    }

   public void finish(Database.BatchableContext BC){
   }
}