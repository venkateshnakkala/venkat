global class TOGSchedulable implements Schedulable
{
    
    global void execute(SchedulableContext ctx)
    {
      String soql = 'select Id,DoNotCall, Phone,School_Status__c,Email,FirstName,High_School_Graduation_Year__c,LastName,Lead_Date__c,Lead_Source__c,Lead_Source_Code__c,MailingPostalCode,Program__c,Program_Code__c, Affiliation_Code__c, exclude_tog__c from contact where Days_in_Attempted__c=7 and OwnerId!=\'0051a000002tHWnAAM\' and (not Program_Code__c like \'%-O\') and (not Affiliation_Code__c like \'INTL%\') and school_status__c like \'%Attempt%\' and phone!=NULL and exclude_tog__c=false';
      
      if(Test.IsRunningTest()){
          soql=soql+' limit 5';
      }
      TOG t = new TOG(soql);
      Database.executebatch(t, 5);
    }
}