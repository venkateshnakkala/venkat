global class TaskChatterController {
    public final Contact contactobj{get;set;}
    public static string email {get;set;}
    public static string ownerName {get;set;}
    
    public TaskChatterController(ApexPages.StandardController stdCont){
    	this.contactobj = (Contact)stdCont.getRecord();
    List<Contact> contactUserList = [select id,Name,owner.name,Email from contact where id =: contactobj.Id];
        email = contactUserList[0].Email;   
        String owner = contactUserList[0].owner.name.substringBefore(' '); 
        ownerName = owner;
    }
    
    @RemoteAction
	global static String loadChatCOntroller(String dataJson){
        Map<String,Object> request = (Map<String,Object>)JSON.deserializeUntyped(dataJson);
        Map<String,Object> response = new Map<String,Object>();
        String offsetCount = (String)request.get('offset');
        String contactId = (String)request.get('contactId');
        Integer offst = integer.valueOf(offsetCount);
        //List<Task> tskList = [SELECT Id, WhoId, WhatId, Subject, Status, Priority, IsHighPriority, 
                          //Description, Type, AccountId FROM Task where WhoId =:contactId order by createddate Desc limit 10 offset: offst ];
        List<LiveText__Conversation_Header__c> tskList = [select id, NAME,Owner.Name, LiveText__Transcript_Summary_1__c, LiveText__Contact__c from LiveText__Conversation_Header__c
                              where LiveText__Contact__c =:contactId order by createddate Desc limit 10 offset: offst ];
        response.put('hasError',false);
        response.put('chat',tskList);
        return JSON.serializePretty(response);
    }
}