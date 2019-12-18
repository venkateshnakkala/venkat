Public Class LiveMessageOverDue
{
    Private static Map<Id,Datetime> SessionLastMessage = new Map<Id,Datetime>();
    
    public static void closeAll()
    {
        LiveMessageOverDue.find();
        LiveMessageOverDue.close();
    }
    
    public static void close(){
        Datetime t = datetime.now();
        t=t.addMinutes(-15);
        LiveMessageOverDue.close(t);
    }
            
    Public static void close(Datetime t)
    {
        List<id> activeIds = new List<id>();
        
        for(Id e :SessionLastMessage.keyset())
        {
            Datetime d = SessionLastMessage.get(e);
            
            if(d<t){
                activeIds.add(e);
            }
        }
        
        if(activeIds.size()>0){
            List<LiveText__Conversation_Header__c> a = [select id from LiveText__Conversation_Header__c where id=:activeIds];
            
            for(LiveText__Conversation_Header__c x :a){
                x.LiveText__Status__c='Ended';
            }
            update a;
        }
    }

    Public static void find()
    {
        List<Id> allActiveNumbers = new List<Id>();
        List<Id> allActiveMessages = new List<Id>();

        Map<Id,Id> NumberVSSession = new Map<Id,Id>();
        
        List<LiveText__Conversation_Header__c> activeSessions = [select id, LiveText__Support_Number__r.id from LiveText__Conversation_Header__c where LiveText__Status__c='Active'];
        
        for(LiveText__Conversation_Header__c s :activeSessions)
        {
            allActiveNumbers.add(s.LiveText__Support_Number__r.id);
            NumberVSSession.put(s.LiveText__Support_Number__r.id, s.id);
        }
        
        List<LiveText__LiveText_Number__c> activeNumbers = [select id, (select id, createddate from LiveText__SMS_Messages__r) from LiveText__LiveText_Number__c where id=:allActiveNumbers];
        
        if(activeNumbers.size()>0){
            system.debug(activeNumbers[0]);
        }
        
        for(LiveText__LiveText_Number__c n :activeNumbers)
        {
            for(LiveText__SMS_Message__c m :n.LiveText__SMS_Messages__r)
            {
                allActiveMessages.add(m.id);
                
                if(!SessionLastMessage.containsKey(NumberVSSession.get(n.id))){
                    SessionLastMessage.put(NumberVSSession.get(n.id),m.Createddate);
                }
                else if(SessionLastMessage.get(NumberVSSession.get(n.id))<m.Createddate)
                {
                    SessionLastMessage.put(NumberVSSession.get(n.id),m.Createddate);
                }
            }
        }
        
        for(Id sessionId :SessionLastMessage.keySet())
        {
            system.debug(sessionId+'---'+SessionLastMessage.get(sessionId));
        }
    }
    
}