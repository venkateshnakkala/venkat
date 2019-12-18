trigger CalOpportunitySize on Opportunity (before insert) {
    
    Set<Id> accountIDs=new Set<Id>();
    for(Opportunity opp:Trigger.New){
        accountIDs.add(opp.AccountId);
    }
 
    set<opportunity> morethan2opportunites= new set<opportunity>([SELECT  AccountID FROM Opportunity WHERE AccountID=:accountIDs]);
    
    for(Opportunity op:Trigger.New){
      if(op.AccountId!=null){
             integer calOppSize=morethan2opportunites.size();
        if(calOppSize > 2){
            op.addError('cannot more than 2 opportunities');
        }else{
            op.addError('cannot more than 2 opportunities');
            }
        }
    }
}