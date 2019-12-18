global class TOGReassign implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful 
{
    private string soql{get;set;}
    
    public TOGReassign(){
    }
    
    public TOGReassign(String Query){
        this.soql=Query;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        string soql='';
        if(this.soql==NULL){
            String D30 = String.valueOf(date.today().adddays(-30));
            soql= 'select Id, firstname, lastname, phone, email, other_email__c, lead_source_code__c, Lead_Type__c, Program_Code__c, School_Status__c, Citizenship_Status__c, ownerid, DoNotCall, RecordTypeId from contact where CreatedDate<='+D30+'T00:00:00Z and OwnerId=\'0051a000002tHWnAAM\' and Program_Code__c like \'%-O\'';
        }
        else{
            soql=this.soql;
        }
        if(Test.IsRunningTest()){
          soql=soql+' limit 5';
        }
        
        return Database.getQueryLocator(soql);
    }
    
    global void execute(Database.BatchableContext BC, List<Contact> scope)
    {
        RoundRobin r = new RoundRobin(scope);
        
        for(contact c :scope)
        {
            c.Exclude_TOG__c = true;
            c.ownerid = r.whoIsNext(c);
        }
        update scope;
    }
    
    global void finish(Database.BatchableContext BC){}
}