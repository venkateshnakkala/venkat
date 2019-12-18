trigger trg1 on Account(after insert){
 list<Contact> con = new list<Contact>();
 list<Opportunity> opp=new list<Opportunity>();
 list<Case>  cslst=new list<Case>();
 list<Task> tsk = new list<Task>();
 list<Attachment> attach=new list<Attachment>();

for(ACCOUNT a:Trigger.New){
     if(a.id!=null){
         Task t=new Task();
           t.Priority='normal';
           t.Subject=a.Name;
           t.Status='Not Started';
           t.whatId=a.Id;
         tsk.add(t);
         Contact c=new Contact();
           c.lastName=a.Name; 
           c.AccountId=a.id;
         con.add(c);
         Opportunity o=new Opportunity();
             o.Name=a.Name;
             o.StageName='Prospecting';
             o.CloseDate=system.today();
             o.AccountId=a.Id;
         opp.add(o);
         Case cs=new Case();
           cs.AccountId=a.id;
           cs.Status='New';
           cs.Origin='Email';
         cslst.add(cs);
       
         blob b=blob.valueOf('venkat');
         Attachment at=new Attachment();
            at.Name=a.name;
            at.ParentId=a.id;
            at.body=b;
         attach.add(at); 
         }
    }
    if(!con.isEmpty()){
        insert con;
    }
    if(!tsk.isEmpty()){
        insert tsk;
    }
     if(!opp.isEmpty()){
        insert opp;
    }
    if(!cslst.isEmpty()){
       insert cslst;  
    }
    if(!attach.isEmpty()){
       insert attach;  
    }
      
}