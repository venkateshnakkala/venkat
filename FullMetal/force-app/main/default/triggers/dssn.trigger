trigger dssn on Contact (before insert, before update) {
    for(Contact c :trigger.new){
        if(c.dSSN__c!=c.SSN__c)
        {
            c.dSSN__c=c.SSN__c;
        }
    }
}