trigger TaskUpdateContactTrigger on Task (after insert, after update)
{
    Set<String> contactIds = new Set<String>();
    
    for(Task t : Trigger.new)
    {
        if(t.Student_Update_Value__c != 99 && isContact(t.WhoId))
        {
            contactIds.add(t.WhoId);
        }
    }
    
    Map<String, Contact> contactMap = new Map<String, Contact>();
    
    for(Contact contact : [select Id, School_Status_Seq__c, School_Status__c from Contact where Id in :contactIds])
    {
        contactMap.put(contact.Id, contact);
    }
    
    Map<Id,Contact> contacts = new Map<Id,Contact>();
    
    for(Task t : Trigger.new)
    {
        if(t.Student_Update_Value__c != 99 && isContact(t.WhoId))
        {
            Contact con = contactMap.get(t.WhoId);
            if(t.Student_Update_Value__c == 0)
            {
                if(con.School_Status__c != 'Invalid Lead/Program Not Offered' && con.School_Status__c != 'Do Not Contact' && con.School_Status__c != 'Stop')
                {
                    con.School_Status__c = 'Bad Number';
                    contacts.put(con.id,con);
                }
            }
            else if(t.Student_Update_Value__c > con.School_Status_Seq__c && t.Call_Result__c!='Reassignment to Ground' && t.Call_Result__c!='Reassignment to Online')
            {
                con.School_Status__c = t.Call_Result__c;
                contacts.put(con.id,con);
            }
            else if(t.Call_Result__c=='Reassignment to Ground' || t.Call_Result__c=='Reassignment to Online')
            {
                con.School_Status__c = 'New Lead';
                contacts.put(con.id,con);
            }
        }
    }
    
    if(contacts.size() > 0)
    {
        Database.update(contacts.values(), false);
    }
    
    private Boolean isContact(String Id)
    {
        if(Id != null && Id.left(3) == '003')
        {
            return true;
        }
        return false;
    }
}