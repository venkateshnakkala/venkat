Trigger ChiliPepper on Event (After Insert, After Update) 
{
    try{
        List<Event> ev = [select id, subject, whoid, owner.name from event where id in :trigger.new and owner.name='LA Film School'];
        List<Id> con = new List<Id>();
        
        for(Event e :ev){
            con.add(e.whoid);
        }
        
        Map<Id, Contact> c = new Map<Id, Contact>([select id, ownerid from contact where id in :con]);
        Contact newC = new Contact();
        
        for(Event e :ev){
            newC = c.get(e.whoid);
            e.ownerid=newC.ownerid;
        }
        
        update ev;
    }catch(Exception e){ e=NULL; }
}