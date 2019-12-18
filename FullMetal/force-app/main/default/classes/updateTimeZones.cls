global class updateTimeZones implements Database.Batchable<sObject>{

   global Database.QueryLocator start(Database.BatchableContext BC){

      return Database.getQueryLocator('select id from contact where MailingState!=NULL and MailingPostalCode!=NULL');

   }

   global void execute(Database.BatchableContext BC, List<sObject> scope)
   {
       List<Id> ids = new List<Id>();
       
       for(sObject s :scope){
           ids.add(s.id);
       }
       TimeZone.updateTimeZone(ids);
   }

   global void finish(Database.BatchableContext BC){
   }
}