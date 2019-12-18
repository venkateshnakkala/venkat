trigger ContactCreateAccountTrigger on Contact (before insert) {

    Id userId = userinfo.getProfileId();
    Id roleId = userinfo.getUserRoleId();
    Profile p = [select id from profile where name='Application User'];
   
    Lafilmschool_Application__mdt appFlow = [select Enable_Flow__c  from Lafilmschool_Application__mdt where DeveloperName= 'ApplicationFlow'];
    
      Boolean checknewapp =  appFlow.Enable_Flow__c!= null && appFlow.Enable_Flow__c.equalsIgnoreCase('TRUE');
         
    if(userId!=p.id && !checknewapp)
    {
        List<Account> accountList = New List <Account>();
        List<RecordType> rec = [select id, name from RecordType where name='Student Master' or name='Receptionist Student Master Entry'];
        Map<Id,String> recType = new Map<Id,String>();
        
        for(RecordType R :rec){
            recType.put(R.id, R.name);
        }
        
        for(Contact con : trigger.new) 
        {
            if(recType.containsKey(Con.RecordTypeId))
            {
                String accName=(con.firstname==NULL)?con.lastname:con.firstname + ' '+con.lastname;
                Account acc = new Account ();
                acc.name = accName;
                if(roleId==NULL){
                    acc.ownerId='0051a000000aFEHAA2';
                }    
                accountList.add(acc);
            }
        }
        
        insert accountList; 
        Integer x=0;
        
        for(Contact con : trigger.new) { 
            if(con.AccountId == null) {
                con.AccountId = accountList[x].id;
            }
            x++;
        }
    }
}