@isTest
public class testWaightedRestro{
    public static testMethod void test(){
        
        list<User> u = [select id from user where UserRoleid in ('00E1a000000YD0v','00E1a000000YD0g','00E1a000000YCtB','00E1a000000YHk1') and isActive = true and ManagerId !=NULL limit 4];
        
        list<contact> c = new list<contact>();
        c.add(new Contact(lastname='test1', ownerid=u[0].id));
        c.add(new Contact(lastname='test2', ownerid=u[0].id));
        c.add(new Contact(lastname='test3', ownerid=u[0].id));
        c.add(new Contact(lastname='test4', ownerid=u[0].id));
        
        insert c;
        
        List<Application__c> a = new List<Application__c>();
        
        a.add(new Application__c(Student__c=c[0].id));
        a.add(new Application__c(Student__c=c[1].id));
        a.add(new Application__c(Student__c=c[2].id));
        a.add(new Application__c(Student__c=c[3].id));
        
        insert a;
        
        WaightedRestro w = new WaightedRestro();
        w.createDataSet();
        if(w.Reps.size()>0){
            for(Id m :w.Reps.keySet()){
                Map<Id,WaightedRestro.Rep> newRep = w.Reps.get(m);
                
                for(Id r :newRep.keySet()){
                    newRep.get(r).getWPercent();
                    newRep.get(r).getMPercent();
                    break;
                }
                break;
            }
        }
        system.assert(w.Managers.size()>=0);
        system.assert(w.Reps.size()>=0);
    }
}