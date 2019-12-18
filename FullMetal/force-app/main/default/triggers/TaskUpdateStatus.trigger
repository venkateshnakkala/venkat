trigger TaskUpdateStatus on Task(After insert, After update)
{
    Set<Id> contactIdSet = new Set<Id>();
    List<Contact> conUpdateList = new List<Contact>();
    Map<Id,Contact> contactMap = new Map<Id,Contact>();
    
    for(Task e : trigger.new)
    {    
        {
            contactIdSet.add(e.WhoId); 
        }   
    }
    
    for (Contact con : [SELECT Id, school_status__c FROM Contact WHERE Id IN : contactIdSet]) 
    { 
        contactMap.put(con.Id, con);
    }
    
    for(Task e : trigger.new){
        Contact con = new Contact(); 
        con = contactMap.get(e.WhoId);
        
        if(con != null)
        {
            Boolean isUpdate = false;
            if(e.Event_Subject__c == 'Daily Tour' || e.Event_Subject__c == 'Office Visit' || e.Event_Subject__c == 'Phone Interview' || e.Event_Subject__c == 'All Access Tour')
            {
                if(validSchoolStatus(con.school_status__c, 'Appointment Set'))
                {
                    con.school_status__c ='Appointment Set';
                    isUpdate = true;
                }
            }
            if(e.Event_Results__c == 'Conducted')
            {
                if(validSchoolStatus(con.school_status__c, 'Interviewed'))
                {
                    con.school_status__c ='Interviewed';
                    isUpdate = true;
                }
            }
            /*if(!isUpdate)
            {
                if(validSchoolStatus(con.school_status__c, 'Attempted'))
                {
                    con.school_status__c ='Attempted';
                }
            }*/
            Boolean isFlag = false;
            for(Contact conProxy : conUpdateList)
            {
                if(conProxy.Id == con.Id)
                {
                    isFlag = true;
                }
            }
            if(!isFlag)
            {
                conUpdateList.add(con);
            }
        }
    }
    if(conUpdateList.size() > 0)
    {
        update conUpdateList;
    }
    
    private boolean validSchoolStatus(String oldStatus, String newStatus)
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
        if(schoolStatus.containsKey(oldStatus) && schoolStatus.containsKey(newStatus))
        {
            Integer oldVal = schoolStatus.get(oldStatus);
            Integer newVal = schoolStatus.get(newStatus);
            if(newVal > oldVal)
            {
                return true;
            }
        }
        else
        {
            return true;
        }
        return false;
    }
}