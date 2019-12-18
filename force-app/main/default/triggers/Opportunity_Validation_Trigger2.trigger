trigger Opportunity_Validation_Trigger2 on Opportunity (before insert) {    
   Map<ID,Integer> dbAccountIdToCountOfOpps = new Map<id,integer>();    
  
  for(Opportunity opp:trigger.new){
       if(opp.AccountId!=null){
           dbAccountIdToCountOfOpps.put( opp.AccountId, NULL );
       }
   }    
  
  for( Account dbAccount : [SELECT ID, ( SELECT ID FROM Opportunities ) FROM Account WHERE ID IN :  dbAccountIdToCountOfOpps.keySet() ] ) {
       dbAccountIdToCountOfOpps.put( dbAccount.Id, dbAccount.Opportunities.size() );
   }        
   
   for( opportunity op:trigger.new ) {        
       if(op.AccountId!=null){
           integer existingCount = dbAccountIdToCountOfOpps.get(op.AccountId); // 3                      
           if( existingCount > 2 ) {
               op.addError('an account should not contain more than 3 opportunities');
           }
           else {
               dbAccountIdToCountOfOpps.put( op.AccountId, existingCount + 1  );
           }
       }  
   }
   
}