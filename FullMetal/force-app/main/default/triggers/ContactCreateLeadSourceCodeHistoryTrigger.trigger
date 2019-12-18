trigger ContactCreateLeadSourceCodeHistoryTrigger on Contact (after update, after insert) {
    {
        if(trigger.isupdate)
        {
            Map<id,Contact> contactoldmap = trigger.oldmap;
            list<Lead_Source_Code_History__c> leadSourceCodeHistoryList = new list<Lead_Source_Code_History__c>();
            
            for(Contact con : trigger.new) 
            {
                Contact conold = contactoldmap.get(con.id);
                if(con.Lead_Source_Code__c != conold.Lead_Source_Code__c)
                {
                    if(con.Lead_Source_Code__c != null)
                        
                    {
                        Lead_Source_Code_History__c leadSourceCode = new Lead_Source_Code_History__c();
                        leadSourceCode.Lead_Source_Code_Date__c = system.today();
                        leadSourceCode.Name = con.Lead_Source_Code__c;
                        leadSourceCode.Student_Master__c = con.Id;
                        leadSourceCodeHistoryList.add(leadSourceCode);                         
                    }                                         
                    
                }
            }
            insert leadSourceCodeHistoryList;
        }
        
        list<Lead_Source_Code_History__c> leadSourceCodeHistoryList = new list<Lead_Source_Code_History__c>();
        for(Contact con : trigger.new) 
        {
            if(trigger.isInsert) 
            {
                if(con.Lead_Source_Code__c != null)
                    
                    
                {
                    Lead_Source_Code_History__c leadSourceCode = new Lead_Source_Code_History__c();
                    leadSourceCode.Lead_Source_Code_Date__c = system.today();
                    leadSourceCode.Name = con.Lead_Source_Code__c;
                    leadSourceCode.Student_Master__c = con.Id;
                    leadSourceCodeHistoryList.add(leadSourceCode);  
                }                                                                 
            } 
        }
        insert leadSourceCodeHistoryList;
    } 
}