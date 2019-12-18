trigger TrgUpdateSchoolStatusOnFive9 on Contact (after update) {

 for(Contact con:Trigger.new)
 {
     try
     {
     String SchoolStatus = con.School_Status__c.replace(' ','+');
     String PhoneNumber = con.Phone;
         if(PhoneNumber != null && PhoneNumber != '')
         {
         PhoneNumber = PhoneNumber.replace('(','').replace(')','').replace('-','');
         }
  
     String url = 'http://api.five9.com/web2campaign/AddToList?F9domain=The+Los+Angeles+Film+School&F9list=Salesforce+Contacts&salesforce_id=' + con.id + '&School+Status=' + SchoolStatus  + '&number1=' + PhoneNumber + '&F9updateCRM=1&F9key=salesforce_id&F9retResults=1';
     UpdateSchoolStatusOnFive9.UpdateStatus(url);
     }
     catch(exception ex)
     {
     system.debug(ex.getMessage());
     }
 }
}