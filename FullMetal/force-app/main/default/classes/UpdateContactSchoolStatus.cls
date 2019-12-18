global class UpdateContactSchoolStatus implements Database.Batchable<sObject>
{
    public String query;
    
    global Database.queryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope)
    {   
        List<Contact> contacts = new List<Contact>();
        for(sObject s : scope)
        {
            Contact con = (Contact)s;
            Date t1 = Date.newInstance(2015, 12, 10);
            Integer schoolStatus = 0;
            for(ContactHistory conHis : [select Id, ContactId, OldValue, NewValue, Field from ContactHistory where Field = 'School_Status__c' and ContactId = :con.Id and CreatedDate > :t1 order by CreatedDate asc])
            {
                Integer validSchoolStatusVal = validSchoolStatus(String.valueOf(conHis.NewValue));
                if(validSchoolStatusVal != 0)
                {
                    if(schoolStatus == 0)
                    {
                        schoolStatus = validSchoolStatusVal;
                    }
                    else
                    {
                        if(validSchoolStatusVal < schoolStatus)
                        {
                            con.School_Status__c = String.valueOf(conHis.OldValue);
                            contacts.add(con);
                            break;
                        }
                        else
                        {
                            schoolStatus = validSchoolStatusVal;
                        }
                    }
                }
            }
        }
        if(contacts.size() > 0)
        {
            update contacts;
        }
    }
    
    public Integer validSchoolStatus(String newStatus)
    {
        Map<String, Integer> schoolStatus = new Map<String, Integer>();
        schoolStatus.put('New Lead', 1);
        schoolStatus.put('Attempted', 2);
        schoolStatus.put('Connected', 3);
        schoolStatus.put('Appointment Set', 4);
        schoolStatus.put('Interviewed', 5);
        schoolStatus.put('Application Submitted', 6);
        schoolStatus.put('Applicant', 7);
        schoolStatus.put('Enrolled', 8);
        schoolStatus.put('Enrolled-RTA', 9);
        schoolStatus.put('Active', 10);
        schoolStatus.put('Pending Graduate', 11);
        schoolStatus.put('Graduate', 12);
        if(schoolStatus.containsKey(newStatus))
        {
            return schoolStatus.get(newStatus);
        }
        else
        {
            return 0;
        }
    }
    
    global void finish(Database.BatchableContext BC)
    {
    }
}