trigger ContactUpdateOwnerTrigger on Contact (before insert, after insert, before update) 
{
    //LARSWEBAPP, LAFSWEBAPP
    List<Contact> newlist = new List<Contact>();
    
    Map<String,Schema.RecordTypeInfo> recTypeMap = Contact.SobjectType.getDescribe().getRecordTypeInfosByName();
    Map<Id,String> recType = new Map<Id,String>();
    recType.put(recTypeMap.get('Student Master').getRecordTypeId(), 'Student Master');
    recType.put(recTypeMap.get('Receptionist Student Master Entry').getRecordTypeId(), 'Receptionist Student Master Entry');
    recType.put(recTypeMap.get('Emergency Contact').getRecordTypeId(), 'Receptionist Student Master Entry');
    
    List<Contact> del = new List<Contact>();
    
    if(trigger.isBefore && trigger.isInsert) // before insert
    {
        for(Contact con :Trigger.new)
        {
            if(recType.containsKey(con.RecordTypeId)){ 
                newlist.add(con);
            }
        }
        RoundRobin obj = new RoundRobin(newlist);
        
        Id aId='0011a00000MADh8AAH'; // Application Community account id
        
        for(Contact con : newlist)
        { 
            con.Lead_Source_Code_1__c=con.Lead_Source_Code__c;
            con.Lead_Category_1__c=con.LeadSource;
            con.Lead_ID_1__c=con.Lead_ID__c;
            con.Lead_Source_1__c=con.Lead_Source__c;
            con.Lead_Date_1__c=system.now();
            
            if(con.accountid!=aId && recType.containsKey(con.RecordTypeId))
            {
                if(con.ownerId==UserInfo.getUserId())
                {
                    Id uid=obj.whoIsNext(con);
                    
                    if(uid!=NULL){
                        con.OwnerId=uid;
                    }
                    else{
                        del.add(con);
                    }
                }
            }
        }
     }
     else if(trigger.isBefore && trigger.isUpdate) // before update
     {
        RoundRobin obj = new RoundRobin();
     
        Map<id,Contact> contactoldmap = trigger.oldmap;
       
        Map<Id,Contact> TOGNew = new Map<Id,Contact>();
        Map<Id,Contact> TOGOld = new Map<Id,Contact>();
       
        for(Contact con : trigger.new)
        {
           if(recType.containsKey(con.RecordTypeId)) // only student master record type
           { 
               Contact conOld = contactOldMap.get(con.id);
               
               if(con.Lead_Type__c=='Application Submitted' && conOld.Lead_Type__c!='Application Submitted' && con.School_Status__c=='New Lead' && con.Program_Code__c!=NULL && !con.Program_Code__c.endsWith('-O'))
               {
                   con.OwnerId='0051a000000aFEHAA2'; // Melina
               }
               else if(con.Program_Code__c!=null && con.Citizenship_Status__c!=null && !obj.IsadminRep(con.ownerid) && (conOld.Program_Code__c==null || conOld.Citizenship_Status__c==null))
               {
                   con.OwnerId=obj.whoIsNext(con);
               }
        
               if(con.email!=NULL && con.email.indexOf('@lafilm.edu')!=-1 && conOld.email!=NULL && conOld.email.indexOf('@lafilm.edu')==-1){
                   con.other_email__c=conOld.email;
               }
               
               // TOG User Live - 0051a000002tHWnAAM, Test - 005W0000003XF97IAG
               if((con.OwnerId=='0051a000002tHWnAAM' && conOld.OwnerId!='0051a000002tHWnAAM' && con.Program_Code__c!=NULL && con.Phone!=NULL) || (con.OwnerId!='0051a000002tHWnAAM' && conOld.OwnerId=='0051a000002tHWnAAM')){
                   TOGNew.put(con.id, con);
                   TOGOld.put(conOld.Id,conOld);
               }
           }
        }
        if(!System.isFuture() && !System.isBatch() && TOGNew.size()>0){Database.executeBatch(new TOG(TOGNew, TOGOld), 200);} // before update 
   }
   else if(trigger.isAfter && trigger.isInsert) // after insert
   {
       list<Contact> toDelete = new list<Contact>();
       Map<Id,Contact> newMap = new Map<Id,Contact>();
       
       for(Contact c :trigger.new)
       {
           if(c.ownerid=='0051a000000aFEJ' && c.DoNotCall==true && recType.containsKey(c.RecordTypeId))
           {
               toDelete.add(new Contact(id=c.id));
           }
           // TOG User Live - 0051a000002tHWnAAM, Test - 005W0000003XF97IAG
           else if(c.OwnerId=='0051a000002tHWnAAM')
           {
               newMap.put(c.id,c);
           }
        }

        if(toDelete.size()>0){
            delete toDelete;
        }
        
        if(!System.isFuture() && !System.isBatch() && newMap.size()>0){Database.executeBatch(new TOG(newMap, NULL), 200);} // after insert
   }
}