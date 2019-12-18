public class RoundRobinInBatches implements Database.Batchable<sObject>, Database.Stateful
{
    public class customException extends Exception {}
    public List<Contact> Contacts{get;private set;}
    
    public RoundRobinInBatches(List<Contact> con){
        this.Contacts=con;
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator([select id, firstname, lastname, email, other_email__c, phone, ownerid, Affiliation_Code__c, Program_Code__c from contact where id in:this.Contacts]);
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> con)
    {
        try {
            RoundRobin r = new RoundRobin(con);
            
            for(Contact c :con)
            {
                if(r.isOnlineMilitary(c))
                {
                    c.ownerid = '0051a000001caeyAAA'; // Donita Giles
                }
                else
                {
                    c.Exclude_TOG__c=true;
                    c.ownerid = r.whoIsNext(c);
                }
            }
            update con;
        }
        catch(Exception e){
             throw new customException(e.getMessage()+' @ Line Number '+e.getLineNumber());
        }
    }
    
    public void finish(Database.BatchableContext bc) { }
}