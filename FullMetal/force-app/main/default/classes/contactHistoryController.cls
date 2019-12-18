global class contactHistoryController {
	public final Application__c applicationobj{get;set;}
    public static string contactId {get;set;}
    
    public contactHistoryController(ApexPages.StandardController stdCont){
    	applicationobj = (Application__c)stdCont.getRecord();
        system.debug(applicationobj.Id);
       	Application__c contactIdList = [select student__c from Application__c where id=: applicationobj.Id];
        contactId = contactIdList.Student__c;
    }
    
    @RemoteAction
	global static String loadHistory(String dataJson){
        Map<String,Object> request = (Map<String,Object>)JSON.deserializeUntyped(dataJson);
        Map<String,Object> response = new Map<String,Object>();
        List<String> dateformated = new List<String>();
        List<ContactHistory> finalContHistoryList = new List<ContactHistory>();
        map<String,String>  myMap = new map<String,String>();
        String offsetCount = (String)request.get('offset');
        String contactId = (String)request.get('contactId');
        Integer offst = integer.valueOf(offsetCount);
        /*List<ContactHistory> contHistoryList = [SELECT Id,CreatedById,CreatedBy.Name,createdDate, ContactId, Field, OldValue, NewValue 
                                            	FROM ContactHistory where ContactId= : contactId order by createdDate desc limit 10 offset: offst];*/
        List<Task> tskList = [SELECT createdDate, Id,ActivityDate,Quick_Note__c,Activity_Results__c, Who.Name,Status, CallDisposition, WhatId, Subject, CallType, CallObject FROM Task
                             	where WhoId= : contactId order by createdDate desc limit 15 offset: offst];
        system.debug(tskList);
        for(Task cont : tskList){
            DateTime dT = cont.createdDate; 
           	DateTime myDate = DateTime.newinstance(dT.year(), dT.month(), dT.day(),dT.hour(),dT.minute(),dT.second());
        	system.debug(myDate.format());
            dateformated.add(myDate.format());
            myMap.put(cont.Id, myDate.format());
        }
        
        response.put('hasError',false);
        response.put('chat',tskList);
        response.put('date',myMap);
        return JSON.serializePretty(response);
    }
}