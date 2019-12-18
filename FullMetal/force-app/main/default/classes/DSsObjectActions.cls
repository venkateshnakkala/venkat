public class DSsObjectActions
{
    @future 
    public static void DSUpdateLead(Map<Id, String> Disposition, Map<Id, String> callList)
    {
        //Create a list of recently dispositioned Leads according to the list of Ids
        List<Lead> Leads = new List<Lead>([SELECT Id, dialforce__DS_Date_of_Last_Dispo__c, DS_Last_Call_List_Name__c, dialforce__DS_Last_Disposition__c, dialforce__DS_Total_Call_Count__c FROM Lead WHERE Id IN: Disposition.keySet()]);
        List<Lead> UpdateLeads = new List<Lead>();
        
        for(Lead l : Leads)
        {
            if(l == null) continue;
            
            // Update the Call Count when the trigger fires
            if(l.dialforce__DS_Total_Call_Count__c == null) l.dialforce__DS_Total_Call_Count__c = 1;
            else l.dialforce__DS_Total_Call_Count__c += 1;
            
            //Updates DS Last Dispo
            l.dialforce__DS_Last_Disposition__c = Disposition.get(l.Id);
            
            //Update DS Last Call List Name
            l.DS_Last_Call_List_Name__c = callList.get(l.Id); 
            
            //Update DS date of last dispo
            l.dialforce__DS_Date_of_Last_Dispo__c = system.today();
            
            //Add lead to final list
            UpdateLeads.add(l);
        }   
        //update leads 
        try
        {
            if(!UpdateLeads.isEmpty())
            update UpdateLeads;
        }
        catch(DMLException e)
        {
            system.debug('Leads were not all properly updated. Error: '+e);
        }
    }
    public static void DSUpdateLeadNotFuture(Map<Id, String> Disposition, Map<Id, String> callList)
    {
        //Create a list of recently dispositioned Leads according to the list of Ids
        List<Lead> Leads = new List<Lead>([SELECT Id, dialforce__DS_Date_of_Last_Dispo__c, DS_Last_Call_List_Name__c, dialforce__DS_Last_Disposition__c, dialforce__DS_Total_Call_Count__c FROM Lead WHERE Id IN: Disposition.keySet()]);
        List<Lead> UpdateLeads = new List<Lead>();
        
        for(Lead l : Leads)
        {
            if(l == null) continue;
            
            // Update the Call Count when the trigger fires
            if(l.dialforce__DS_Total_Call_Count__c == null) l.dialforce__DS_Total_Call_Count__c = 1;
            else l.dialforce__DS_Total_Call_Count__c += 1;
            
            //Updates DS Last Dispo
            l.dialforce__DS_Last_Disposition__c = Disposition.get(l.Id);
            
            //Update DS Last Call List
            l.DS_Last_Call_List_Name__c = callList.get(l.Id);
            
            //Update DS date of last dispo
            l.dialforce__DS_Date_of_Last_Dispo__c = system.today();
            
            //Add lead to final list
            UpdateLeads.add(l);
        }   
        //update leads 
        try
        {
            if(!UpdateLeads.isEmpty())
            update UpdateLeads;
        }
        catch(DMLException e)
        {
            system.debug('Leads were not all properly updated. Error: '+e);
        }
    }
        
    @future 
    public static void DSUpdateContact(Map<Id, String> Disposition, Map<Id, String> callList)
    {
        
        //Create a list of recently dispositioned Contacts according to the list of Ids
        List<Contact> Contacts = new List<Contact>([SELECT Id, DS_Last_Call_List_Name__c, dialforce__DS_Date_of_Last_Dispo__c, dialforce__DS_Last_Disposition__c, dialforce__DS_Total_Call_Count__c FROM Contact WHERE Id IN: Disposition.keySet()]);
        List<Contact> UpdateContacts = new List<Contact>();
        
        for(Contact c : Contacts)
        {
            if(c == null) continue;
            
            // Update the Call Count when the trigger fires
            if(c.dialforce__DS_Total_Call_Count__c == null) c.dialforce__DS_Total_Call_Count__c = 1;
            else c.dialforce__DS_Total_Call_Count__c += 1;
            
            //Updates DS Last Dispo
            c.dialforce__DS_Last_Disposition__c = Disposition.get(c.Id);
            
            //Update DS Last Call List Name
            c.DS_Last_Call_List_Name__c = callList.get(c.Id);
            
            //Update DS date of last dispo
            c.dialforce__DS_Date_of_Last_Dispo__c = system.today();
            
            //Add contact to final list
            UpdateContacts.add(c);
        }   
        //update Contacts
        try
        {
            if(!UpdateContacts.isEmpty())
            update UpdateContacts;
        }
        catch(DMLException e)
        {
            system.debug('Contacts were not all properly updated. Error: '+e);
        }
    }
    public static void DSUpdateContactNotFuture(Map<Id, String> Disposition, Map<Id, String> callList)
    {
        
        //Create a list of recently dispositioned Contacts according to the list of Ids
        List<Contact> Contacts = new List<Contact>([SELECT Id, DS_Last_Call_List_Name__c, dialforce__DS_Date_of_Last_Dispo__c, dialforce__DS_Last_Disposition__c, dialforce__DS_Total_Call_Count__c FROM Contact WHERE Id IN: Disposition.keySet()]);
        List<Contact> UpdateContacts = new List<Contact>();
        
        for(Contact c : Contacts)
        {
            if(c == null) continue;
            
            // Update the Call Count when the trigger fires
            if(c.dialforce__DS_Total_Call_Count__c == null) c.dialforce__DS_Total_Call_Count__c = 1;
            else c.dialforce__DS_Total_Call_Count__c += 1;
            
            //Updates DS Last Dispo
            c.dialforce__DS_Last_Disposition__c = Disposition.get(c.Id);
            
            //Update DS Last Call List Name
            c.DS_Last_Call_List_Name__c = callList.get(c.Id);
            
            //Update DS date of last dispo
            c.dialforce__DS_Date_of_Last_Dispo__c = system.today();
            
            //Add contact to final list
            UpdateContacts.add(c);
        }   
        //update Contacts
        try
        {
            if(!UpdateContacts.isEmpty())
            {
                update UpdateContacts;
            }
        }
        catch(DMLException e)
        {
            system.debug('Contacts were not all properly updated. Error: '+e);
        }
    }
    
    
    
    @future 
    public static void DSUpdateAccount(Map<Id, String> Disposition, Map<Id, String> callList)
    {
        
        //Create a list of recently dispositioned Contacts according to the list of Ids
        List<Account> Accounts = new List<Account>([SELECT Id, dialforce__DS_Date_of_Last_Dispo__c, DS_Last_Call_List_Name__c, dialforce__DS_Last_Disposition__c, dialforce__DS_Total_Call_Count__c FROM Account WHERE Id IN: Disposition.keySet()]);
        List<Account> UpdateAccounts = new List<Account>();
        
        for(Account a : Accounts)
        {
            if(a == null) continue;
            
            // Update the Call Count when the trigger fires
            if(a.dialforce__DS_Total_Call_Count__c == null) a.dialforce__DS_Total_Call_Count__c = 1;
            else a.dialforce__DS_Total_Call_Count__c += 1;
            
            //Updates DS Last Dispo
            a.dialforce__DS_Last_Disposition__c = Disposition.get(a.Id);
            
            //Update DS date of last dispo
            a.dialforce__DS_Date_of_Last_Dispo__c = system.today();
            
            //Updated DS Last Call List
            a.DS_Last_Call_List_Name__c = callList.get(a.Id);
            
            //Add account to final list
            UpdateAccounts.add(a);
        }   
        //update accounts 
        try
        {
            if(!UpdateAccounts.isEmpty())
            update UpdateAccounts;
        }
        catch(DMLException e)
        {
            system.debug('Accounts were not all properly updated. Error: '+e);
        }
    }
    public static void DSUpdateAccountNotFuture(Map<Id, String> Disposition, Map<Id, String> callList)
    {
        
        //Create a list of recently dispositioned Contacts according to the list of Ids
        List<Account> Accounts = new List<Account>([SELECT Id, dialforce__DS_Date_of_Last_Dispo__c, dialforce__DS_Last_Disposition__c, dialforce__DS_Total_Call_Count__c FROM Account WHERE Id IN: Disposition.keySet()]);
        List<Account> UpdateAccounts = new List<Account>();
        
        for(Account a : Accounts)
        {
            if(a == null) continue;
            
            // Update the Call Count when the trigger fires
            if(a.dialforce__DS_Total_Call_Count__c == null) a.dialforce__DS_Total_Call_Count__c = 1;
            else a.dialforce__DS_Total_Call_Count__c += 1;
            
            //Updates DS Last Dispo
            a.dialforce__DS_Last_Disposition__c = Disposition.get(a.Id);
            
            //Update DS date of last dispo
            a.dialforce__DS_Date_of_Last_Dispo__c = system.today();
            
            //Update DS Last Call List
            a.DS_Last_Call_List_Name__c = callList.get(a.Id);
            
            //Add account to final list
            UpdateAccounts.add(a);
        }   
        //update accounts 
        try
        {
            if(!UpdateAccounts.isEmpty())
            update UpdateAccounts;
        }
        catch(DMLException e)
        {
            system.debug('Accounts were not all properly updated. Error: '+e);
        }
    }
    
    
    @future 
    public static void DSUpdateOpportunity(Map<Id, String> Disposition, Map<Id, String> callList)
    {
        
        //Create a list of recently dispositioned Opportunities according to the list of Ids
        List<Opportunity> Opportunities = new List<Opportunity>([SELECT Id, DS_Last_Call_List_Name__c, dialforce__DS_Date_of_Last_Dispo__c, dialforce__DS_Last_Disposition__c, dialforce__DS_Total_Call_Count__c FROM Opportunity WHERE Id IN: Disposition.keySet()]);
        List<Opportunity> UpdateOpportunities = new List<Opportunity>();
        
        for(Opportunity o : Opportunities)
        {
            if(o == null) continue;
            
            // Update the Call Count when the trigger fires
            if(o.dialforce__DS_Total_Call_Count__c == null) o.dialforce__DS_Total_Call_Count__c = 1;
            else o.dialforce__DS_Total_Call_Count__c += 1;
            
            //Updates DS Last Dispo
            o.dialforce__DS_Last_Disposition__c = Disposition.get(o.Id);
            
            //Update DS date of last dispo
            o.dialforce__DS_Date_of_Last_Dispo__c = system.today();
            
            //Update DS Last Call List Name
            o.DS_Last_Call_List_Name__c = callList.get(o.Id);
            
            //Add Opportunity to final list
            UpdateOpportunities.add(o);
        }   
        //update Opportunities
        try
        {
            if(!UpdateOpportunities.isEmpty())
            update UpdateOpportunities;
        }
        catch(DMLException e)
        {
            system.debug('Opportunities were not all properly updated. Error: '+e);
        }
    }
    public static void DSUpdateOpportunityNotFuture(Map<Id, String> Disposition, Map<Id, String> callList)
    {
        
        //Create a list of recently dispositioned Opportunities according to the list of Ids
        List<Opportunity> Opportunities = new List<Opportunity>([SELECT Id, DS_Last_Call_List_Name__c, dialforce__DS_Date_of_Last_Dispo__c, dialforce__DS_Last_Disposition__c, dialforce__DS_Total_Call_Count__c FROM Opportunity WHERE Id IN: Disposition.keySet()]);
        List<Opportunity> UpdateOpportunities = new List<Opportunity>();
        
        for(Opportunity o : Opportunities)
        {
            if(o == null) continue;
            
            // Update the Call Count when the trigger fires
            if(o.dialforce__DS_Total_Call_Count__c == null) o.dialforce__DS_Total_Call_Count__c = 1;
            else o.dialforce__DS_Total_Call_Count__c += 1;
            
            //Updates DS Last Dispo
            o.dialforce__DS_Last_Disposition__c = Disposition.get(o.Id);
            
            //Update DS Last Call List Name
            o.DS_Last_Call_List_Name__c = callList.get(o.Id);
            
            //Update DS date of last dispo
            o.dialforce__DS_Date_of_Last_Dispo__c = system.today();
            
            //Add Opportunity to final list
            UpdateOpportunities.add(o);
        }   
        //update Opportunities
        try
        {
            if(!UpdateOpportunities.isEmpty())
            update UpdateOpportunities;
        }
        catch(DMLException e)
        {
            system.debug('Opportunities were not all properly updated. Error: '+e);
        }
    }
}