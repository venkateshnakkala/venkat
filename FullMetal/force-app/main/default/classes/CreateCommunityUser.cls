public class CreateCommunityUser implements Database.Batchable<sObject>, Database.Stateful{

    public class customException extends Exception {}
    public static boolean isFirstTime=true;
    private List<Id> ids{get;set;}
    private List<Id> addedUsers{get;set;}
    private Profile userProfile{get;set;}

    public CreateCommunityUser (List<Id> Contactids)
    {
        this.ids = Contactids;
        this.addedUsers= new List<Id>();
        this.userProfile=[Select id from Profile where name='Application User'];
    }

    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator([select id, ownerid, firstname, lastname, email, other_email__c, phone, School_Status__c, Lead_Source_Code__c, systudentid__c, stunum__c, program_code__c, affiliation_code__c from contact where id in :ids]);
    }

    public void execute(Database.BatchableContext BC, List<Contact> contacts)
    {
        try {
            Map<String,Id> emailToContact = new Map<String,Id>();
            Map<Id,Id> contactToUser= new Map<Id,Id>();
            Map<Id,String> emails = new Map<Id,String>();
            List<User> newUsers = new List<User>();
            
            for(Contact c :contacts)
            {
                if(c.email!=NULL && !c.email.toLowerCase().contains('@lafilm.'))
                {
                    emails.put(c.id, c.email.toLowerCase());
                }
                else if(c.other_email__c!=NULL && !c.other_email__c.toLowerCase().contains('@lafilm.'))
                {
                    emails.put(c.id, c.other_email__c.toLowerCase());
                }
            }
            
            Map<Id,User> users= new Map<Id, User>([select id, username, email, contactid from user where contactid in :ids or username in:emails.values()]);
            
            for(User u :users.values())
            {
                emailToContact.put(u.username.toLowerCase(), u.contactid);
                contactToUser.put(u.contactid, u.id);
            }
            
            for(Contact c :contacts)
            {
                if(!contactToUser.containsKey(c.id) && ((emails.containsKey(c.id) && !emailToContact.containsKey(emails.get(c.id))) || !emails.containsKey(c.id)))
                {
                    // if no user exists, create a new one
                    User thisUser = createNewUser(c, emails.get(c.id));
                    system.debug(thisUser);
                    newUsers.add(thisUser);
                }
                else if(emails.containsKey(c.id) && emailToContact.containsKey(emails.get(c.id)) && emailToContact.get(emails.get(c.id))!=c.Id)
                {
                    // if an user exists but with a different contact record, merge contacts
                    Contact original = [select id, systudentid__c, stunum__c from contact where id =:emailToContact.get(emails.get(c.id))];
                    original.firstname=c.firstname;
                    original.lastname=c.lastname;
                    original.ownerid=c.ownerid;
                    original.school_status__c=c.school_status__c;
                    original.program_code__c=c.program_code__c;
                    original.phone=c.phone;
                    original.email=c.email;
                    original.other_email__c=c.other_email__c;
                    original.affiliation_code__c=c.affiliation_code__c;
                    original.lead_source_code__c=c.lead_source_code__c;
                    original.systudentid__c=(original.systudentid__c==NULL)?c.systudentid__c:original.systudentid__c;
                    original.stunum__c=(original.stunum__c==NULL)?c.stunum__c:original.stunum__c;
                    
                    Database.merge(original, c);
                }
            }
            
            if(newUsers.size()>0)
            {
                insert newUsers;
                
                for(User u :newUsers){
                    addedUsers.add(u.id);
                }
            }
        }catch(Exception e){ throw new customException(e.getMessage()+' @ '+e.getLineNumber()); }
    }

    public void finish(Database.BatchableContext BC)
    {
        try{
            if(addedUsers.size()>0)
            {
                for(Id u :addedUsers)
                {
                    System.resetPasswordWithEmailTemplate(u, true, 'CreateNewUsers');
                }
            }
        }catch(Exception e){ throw new customException(e.getMessage()+' @ '+e.getLineNumber()); }
    }
    
    private User createNewUser(Contact c, String email)
    {
        User u= new User();
        u.ContactId = c.Id;  
        u.Username = email;
        u.Email = email;
        u.FirstName = c.FirstName;
        u.LastName = c.LastName;
        if(u.email.length()>36){ u.CommunityNickname=email.substring(0,36)+rand().substring(0,4); } else { u.CommunityNickname=email+rand().substring(0,4); }
        String alias=u.lastname+u.firstname;
        alias.replaceAll(' ','');
        if(alias.length()>40){ u.alias=alias.SubString(0,4); } else{ u.alias=rand().SubString(0,4); }
        u.TimeZoneSidKey = 'GMT';
        u.LanguageLocaleKey = 'en_US';
        u.EmailEncodingKey = 'UTF-8';
        u.LocaleSidKey = UserInfo.getLocale();
        u.ProfileId=userProfile.id;
        u.Lead_Source__c = c.Lead_Source_Code__c;      
        u.isActive = true;
        
        return u;
    }

    private String rand()
    {
        Integer len = 6;
        String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        String randStr = '';
        while (randStr.length() < len)
        {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            randStr += chars.substring(idx, idx+1);
        }
        return randStr; 
    }
}