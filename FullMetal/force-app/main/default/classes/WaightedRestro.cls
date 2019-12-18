public class WaightedRestro{

    public class Manager{
        public String name {get;set;}
        public Manager(String Name){
            this.name=Name;
        }
    }
    public date t{get;set;}
    public class Rep{
        public String admName {get;set;}
        public Integer day7Apps {get; set;}
        public Integer day7Leads {get; set;}
        public Integer day30Apps {get; set;}
        public Integer day30Leads {get; set;}
        public rep(){}
        public Rep(String AName){
            this.admName=AName;
        }
        public Rep(String AName, Integer d7a, Integer d7l, Integer d30a, Integer d30l){
            this.admName=AName;
            this.day7Apps=d7a;
            this.day7Leads=d7l;
            this.day30Apps=d30a;
            this.day30Leads=d30l;
        }
        public String getWPercent(){
            if(this.day7Leads==0)
                return '0%';
            Decimal round = this.day7Apps/(this.day7Leads*1.0)*100;
            return round.setScale(2)+'%';
        }
        public String getMPercent(){
            if(this.day30Leads==0)
                return '0%';
            Decimal round = this.day30Apps/(this.day30Leads*1.0)*100;
            return round.setScale(2)+'%';
        }
    }
    public date thisDate{get;set;}
    public Map<Id,Manager> Managers{get;set;}
    public Map<Id,Map<Id,Rep>> Reps{get;set;}
    public Map<Id,Rep> total {get;set;}
    public List<selectOption> selectDates {get;private set;}
    
    private void contructor(){
        this.Managers = new Map<Id,Manager>();
        this.Reps = new Map<Id,Map<Id,Rep>>();
        this.thisDate = DateTime.now().date();
        this.selectDates = new List<selectOption>();
        
        Date toDate = this.thisDate.addDays(-90);
        
        for(Date d = this.thisDate; d>=toDate; d=d.addDays(-1)){
            this.selectDates.add(new SelectOption(d.format(),d.format()));
        }
    }
    
    public void createDataSet(){
        List<Id> userRoles = new List<Id>();
        userRoles.add('00E1a000000YD0v');
        userRoles.add('00E1a000000YD0g');
        userRoles.add('00E1a000000YCtB');
        userRoles.add('00E1a000000YHk1');
        
        List<User> allAdmin = [select id, UserRoleid, firstname, lastname, ManagerId from user where UserRoleid in :userRoles and isActive = true and ManagerId !=NULL order by firstname, lastname];
        this.getManagers(allAdmin);
    }
    
    public WaightedRestro(){
        this.contructor();
    }
    
    public WaightedRestro(ApexPages.StandardController controller){
        this.contructor();
    }
    
    private void getManagers(List<User> allUsr){
        Set<Id> Ids = new Set<Id>();
        List<Id> allUsers = new List<Id>();
        
        for(User u :allUsr){
            Map<Id,Rep> row = new Map<Id,Rep>();
            Ids.add(u.ManagerId);
            allUsers.add(u.id);
            
            row.put(u.id,new Rep(u.firstname+' '+u.lastname));
            
            if(!this.Reps.containsKey(u.ManagerId)){
                this.Reps.put(u.ManagerId,row);
            }
            else {
                this.Reps.get(u.ManagerId).putAll(row);
            }
        }

        Map<Id,Map<String,Integer>> userDataSet = new Map<Id,Map<String,Integer>>();
        userDataSet = this.getUserData(allUsers);
        this.total = new Map<Id,Rep>();
        
        if(userDataSet.size()>0)
        {
            for(Id man :this.Reps.keySet()){
                Map<Id,Rep> manGroup = this.Reps.get(man);
                
                For(Id rep :manGroup.keySet()){
                    
                    this.Reps.get(man).get(rep).day7Leads= userDataSet.get(rep).get('Last7Leads');
                    this.Reps.get(man).get(rep).day30Leads= userDataSet.get(rep).get('Last30Leads');
                    this.Reps.get(man).get(rep).day7Apps= userDataSet.get(rep).get('Last7App');
                    this.Reps.get(man).get(rep).day30Apps=userDataSet.get(rep).get('Last30App');
                }
            }
        }
        
        this.total=this.createTotals();
        List<User> Managers = [select id, firstname, lastname from user where id in: ids and isActive = true];
        
        for(User u :Managers){
            this.Managers.put(u.id, new Manager(u.firstname+' '+u.lastname));
        }
    }
    
    private Map<Id,Rep> createTotals(){
        Map<Id,Rep> total = new Map<Id,Rep>();
        Rep totalRow;
        Integer d7l, d30l, d7a, d30a;
        
        for(Id man :this.Reps.keySet()){
            totalRow = new Rep();
            d7l=d30l=d7a=d30a=0;
            
            for(Id rep :this.Reps.get(man).keySet()){
                d7l+=this.Reps.get(man).get(rep).day7Leads;
                d30l+=this.Reps.get(man).get(rep).day30Leads;
                d7a+=this.Reps.get(man).get(rep).day7Apps;
                d30a+=this.Reps.get(man).get(rep).day30Apps;
            }
            
            totalRow.admName='Team Total';
            totalRow.day7Leads=d7l;
            totalRow.day30Leads=d30l;
            totalRow.day7Apps=d7a;
            totalRow.day30Apps=d30a;
            
            total.put(man,totalRow);
        }
        return total;
    }
    
    private List<AggregateResult> runConBatches(List<Id> owners, Date fromDate, Date toDate){
    
        Integer chunkSize=10; // no of rows per batch
        
        if(Test.isRunningTest()){
            chunkSize=2;
        }
        List<AggregateResult> newList = new List<AggregateResult>();
        List<AggregateResult> subList;
        
        if(owners.size()>chunkSize){
            Integer chunks = (Integer)Math.ceil(owners.size()/(chunkSize*1.0));
            
            List<id> newOwners;
            
            for(Integer c=0; c<chunks; c++)
            {
                newOwners = new List<Id>();
                subList = new List<AggregateResult>();
                
                for(Integer x=0; x<chunkSize; x++)
                {
                    
                    Integer cell = x+(c*chunkSize);
                    if(cell>=owners.size())
                        break;

                    newOwners.add(owners[cell]);
                }
                system.debug('From Date: '+fromDate);
                system.debug('To Date: '+toDate);
                system.debug('Owners: '+newOwners);
                
                //subList = [select ownerid id, count(id) total from contact where createdDate>=:toDate and createdDate<:fromDate and ownerid in:newOwners group by ownerid];
                
                newList.addAll(subList);
            }
        }
        else
            newList=[select ownerid id, count(id) total from contact where createdDate>=:toDate and createdDate<:fromDate and ownerid in:owners group by ownerid];
            
        return newList;
    }
    
    private List<AggregateResult> runAppBatches(List<Id> owners, Date fromDate, Date toDate){
    
        Integer chunkSize=30; // no of rows per batch
        
        if(Test.isRunningTest()){
            chunkSize=2;
        }
        List<AggregateResult> newList = new List<AggregateResult>();
        List<AggregateResult> subList;
        
        if(owners.size()>chunkSize){
            Integer chunks = (Integer)Math.ceil(owners.size()/(chunkSize*1.0));
            List<id> newOwners;
            
            for(Integer c=0; c<chunks; c++)
            {
                newOwners = new List<Id>();
                subList = new List<AggregateResult>();
                
                for(Integer x=0; x<chunkSize; x++)
                {
                    Integer cell = x+(c*chunkSize);
                    
                    if(cell>=owners.size())
                        break;
                    newOwners.add(owners[cell]);
                }
                
                subList = [select student__r.ownerid id, count(id) total from Application__c where student__c in (select id from contact where ownerid in:newOwners and createdDate>=:toDate and createdDate<:fromDate) group by student__r.ownerid];
                
                newList.addAll(subList);
            }
        }
        else
            newList=[select student__r.ownerid id, count(id) total from Application__c where student__c in (select id from contact where ownerid in:owners and createdDate>=:toDate and createdDate<:fromDate) group by student__r.ownerid];
            
        return newList;
    }
    
    private Map<Id,Map<String,Integer>> getUserData(List<Id> addAdms){

        Date today = this.thisDate;
        this.t= today;
        Date oneWeekBefore = today.addDays(-7);
        Date oneMonthBefore = today.addDays(-30);
        
        Map<Id,Map<String,Integer>> dataSet = new Map<Id,Map<String,Integer>>();
        
        List<AggregateResult> last7Leads = new List<AggregateResult>();
        List<AggregateResult> last30Leads = new List<AggregateResult>();
        List<AggregateResult> last7app = new List<AggregateResult>();
        List<AggregateResult> last30app = new List<AggregateResult>();
        
        Map<String,Integer> blankRow = new Map<String,Integer>();
        blankRow.put('Last7Leads',0);
        blankRow.put('Last30Leads',0);
        blankRow.put('Last7App',0);
        blankRow.put('Last30App',0);
            
        for(Id d :addAdms){
            dataSet.put(d, blankRow);
        }
        
        if(!Test.isRunningTest())
        {
            last7Leads = this.runConBatches(addAdms,today,oneWeekBefore);
            last30Leads = this.runConBatches(addAdms,today,oneMonthBefore);
            last7app = this.runAppBatches(addAdms,today,oneWeekBefore);
            last30app = this.runAppBatches(addAdms,today,oneMonthBefore);
        }
        else 
        {
            this.runConBatches(addAdms,today,oneWeekBefore);
            this.runAppBatches(addAdms,today,oneWeekBefore);
            last7Leads = [select ownerid Id, count(id) total from contact where ownerid in:addAdms group by ownerid];
            last30Leads = [select ownerid Id, count(id) total from contact where ownerid in:addAdms group by ownerid];
            last7app = [select student__r.ownerid Id, count(id) total from Application__c where student__c in (select id from contact where ownerid in:addAdms) group by student__r.ownerid];
            last30app = [select student__r.ownerid Id, count(id) total from Application__c where student__c in (select id from contact where ownerid in:addAdms) group by student__r.ownerid];
        }
        
        for(AggregateResult r : last7Leads){
            Id userId=(Id)r.get('Id');
            Map<Id,Map<String,Integer>> row = new  Map<Id,Map<String,Integer>>();
            Map<String,Integer> cell = new Map<String,Integer>();
            cell.putAll(dataSet.get(userId));
            cell.put('Last7Leads', (integer)r.get('total'));
            row.put(userId,cell);
            dataSet.putAll(row);
        }

        for(AggregateResult r : last30Leads){

            Id userId=(Id)r.get('Id');
            Map<Id,Map<String,Integer>> row = new  Map<Id,Map<String,Integer>>();
            Map<String,Integer> cell = new Map<String,Integer>();
            cell.putAll(dataSet.get(userId));
            cell.put('Last30Leads', (integer)r.get('total'));
            row.put(userId,cell);
            dataSet.putAll(row);
        }
        
        for(AggregateResult r : last7app){

            Id userId=(Id)r.get('Id');
            Map<Id,Map<String,Integer>> row = new  Map<Id,Map<String,Integer>>();
            Map<String,Integer> cell = new Map<String,Integer>();
            cell.putAll(dataSet.get(userId));
            cell.put('Last7App', (integer)r.get('total'));
            row.put(userId,cell);
            dataSet.putAll(row);
        }
        
        for(AggregateResult r : last30app){

            Id userId=(Id)r.get('Id');
            Map<Id,Map<String,Integer>> row = new  Map<Id,Map<String,Integer>>();
            Map<String,Integer> cell = new Map<String,Integer>();
            cell.putAll(dataSet.get(userId));
            cell.put('Last30App', (integer)r.get('total'));
            row.put(userId,cell);
            dataSet.putAll(row);
        }
        return dataSet;
    }
}