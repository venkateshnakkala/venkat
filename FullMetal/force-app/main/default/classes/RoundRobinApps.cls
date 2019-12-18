Public Class RoundRobinApps
{
    public class MyException extends Exception {}

    public static boolean isFirstTimeContact=true;
    public static boolean isFirstTimeApplication=true;

    private static Map<Id,String> roles {get;set;}
    private static Map<String,Map<Id,Integer>> AllUsers{get;set;}
    
    public static void WhoIsNext(List<Contact> cons, Map<Id,Contact> oldMap)
    {
        Map<Id,Application__c> apps = new Map<Id,Application__c>();
        
        List<User> eg1 = new List<User>();
        Integer pos=0;
        
        if(1==1){
            //throw new MyException('Testing::'+cons);
        }
        for(Contact c :cons)
        {
            Contact old = oldmap.get(c.id);
            
            Id random1=NULL;
            Id random2=NULL;
            
            for(Application__c a :c.applications__r) 
            {
                Application__c aa = new Application__c();
                if(c.school_status__c=='Enrolled' || (c.school_status__c=='Enrolled - Trial Period' && a.Enrollment_Reperesentative__c==NULL))
                {
                    if(random1==NULL && a.Enrollment_Reperesentative__c!=NULL){
                        random1 = a.Enrollment_Reperesentative__c;
                    }
                    
                    
                    
                    if(random1!=NULL && a.Enrollment_Reperesentative__c==NULL)
                    {
                        aa.id=a.id;   
                        aa.Enrollment_Reperesentative__c=random1;
                        apps.put(a.id,aa);
                    }
                    else if(random1==NULL && old!=NULL && (old.school_status__c=='Active' || old.school_status__c=='Cancel Enrollment' || old.school_status__c=='Leave of Absence' || old.school_status__c=='Graduate' 
                        || old.school_status__c=='Withdrawn' || old.school_status__c=='Pending Graduate' || old.school_status__c=='Enrolled - Trial Period')){
                          System.debug('Conatct statis is enrolled $$$4');  
                          
                        if(eg1.size()==0){
                            eg1 = [Select id, name, Weight_Value__c, userrole.name from user where name in('Kristyne Melon','Darcee Honnold') order by Weight_Value__c asc];
                        }
                           
                        aa.id=a.id;
                        a.Enrollment_Reperesentative__c=aa.Enrollment_Reperesentative__c=eg1[pos].id; // Kristyne Melon or Darcee Honnold
                        eg1[pos].Weight_Value__c=((eg1[pos].Weight_Value__c==NULL)?0:eg1[pos].Weight_Value__c)+1;
                        if(a.Enrollment_Guide_Team_2__c!=NULL){
                            aa.Enrollment_Guide_Team_2__c='0051a000000aIQrAAM'; // Jose Figueroa 
                        }
                        apps.put(a.id,aa);
                        pos=Math.Mod(pos+1,eg1.size());
                        
                    }
                    else if(random1==NULL && (c.owner.id=='0051a000000c3qPAAQ' || c.owner.id=='0051a000001caeyAAA')){ // Michael Welch or Donita Giles
                        aa.id=a.id;
                        a.Enrollment_Reperesentative__c=aa.Enrollment_Reperesentative__c='0051a000001caf8AAA'; // La Tka Mosby 
                        
                        if(a.Enrollment_Guide_Team_2__c!=NULL){
                            aa.Enrollment_Guide_Team_2__c='0051a000001caf8AAA'; // La Tka Mosby 
                        }
                        apps.put(a.id,aa);
                    }
                    else if(a.Enrollment_Reperesentative__c==NULL)
                    {
                        if(old==NULL || old.school_status__c=='New Lead' || old.school_status__c=='Attempted' || old.school_status__c=='Cultivate' || old.school_status__c=='Appointment Set' || 
                        old.school_status__c=='Appointment Overdue' || old.school_status__c=='Tour Conducted' || old.school_status__c=='Application Submitted' || old.school_status__c=='Cancel Application' || 
                        old.school_status__c=='Applicant' || old.school_status__c=='Do Not Contact' || old.school_status__c=='Invalid' || old.school_status__c=='Denied' || old.school_status__c=='Exhausted' || 
                        old.school_status__c=='No Longer Interested' || old.school_status__c=='Did Not Reschedule' ||  old.school_status__c=='Did Not Apply' || old.school_status__c=='Pre-Applicant' || 
                        old.school_status__c=='Too Young'){
                            
                            aa.id=a.id;
                            if(random1==NULL){
                                random1=GetRandomId('team1');
                            }
                            
                            aa.Enrollment_Reperesentative__c=random1;
                            apps.put(a.id,aa);
                        }
                    }
                    
                }
                
                if(c.school_status__c=='Enrolled - Trial Period')
                {
                    if(apps.containsKey(a.id)){
                        aa=apps.get(a.id);
                    }
                    
                    system.debug(a.Enrollment_Reperesentative__c);
                    
                    if(random1==NULL && a.Enrollment_Reperesentative__c!=NULL){
                        random1 = a.Enrollment_Reperesentative__c;
                    }
                    
                    if(random2==NULL && a.Enrollment_Guide_Team_2__c!=NULL){
                        random2 = a.Enrollment_Guide_Team_2__c;
                    }
                    
                    if(random2!=NULL && a.Enrollment_Guide_Team_2__c==NULL)
                    {
                        aa.id=a.id;
                        if(a.Enrollment_Reperesentative__c==NULL)
                        {
                            aa.Enrollment_Reperesentative__c=random1;
                        }
                        aa.Enrollment_Guide_Team_2__c=random2;
                        apps.put(a.id,aa);
                    }
                    else if(random2==NULL && (a.Enrollment_Reperesentative__c=='0051a000002DULaAAO' || a.Enrollment_Reperesentative__c=='0051a000003AtImAAK')){ // Kristyne Melon or Darcee Honnold
                        aa.id=a.id;
                        aa.Enrollment_Guide_Team_2__c='0051a000000aIQrAAM'; // Jose Figueroa 
                        apps.put(a.id,aa);
                    }
                    else if(random2==NULL && (c.owner.id=='0051a000000c3qPAAQ' || c.owner.id=='0051a000001caeyAAA')){ // Michael Welch or Donita Giles
                        aa.id=a.id;
                        aa.Enrollment_Guide_Team_2__c='0051a000001caf8AAA'; // La Tka Mosby 
                        apps.put(a.id,aa);
                    }
                    else if(a.Enrollment_Guide_Team_2__c==NULL)
                    {
                        if(a.Enrollment_Reperesentative__c!='0051a000002DULaAAO' && a.Enrollment_Reperesentative__c!='0051a000003AtImAAK' && a.Enrollment_Reperesentative__c!='0051a000001caf8AAA'){ // nand Kristyne Melon or Darcee Honnold or La Tka Mosby 
                            aa.id=a.id;
                            
                            if(random1==NULL && a.Enrollment_Reperesentative__c==NULL){
                                random1=GetRandomId('team1');
                                aa.Enrollment_Reperesentative__c=random1;
                            }
                            else if(random1!=NULL && a.Enrollment_Reperesentative__c==NULL){
                                aa.Enrollment_Reperesentative__c=random1;
                            }
                            
                            if(random2==NULL){
                                random2=GetRandomId('team2');
                            }
                            aa.Enrollment_Guide_Team_2__c=random2;
                            apps.put(a.id,aa);
                        }
                    }
                }
                
                
                if(c.school_status__c=='Cancel Enrollment' || c.school_status__c=='Withdrawn')
                {
                    aa.id=a.id;
                    aa.Enrollment_Reperesentative__c=NULL;
                    aa.Enrollment_Guide_Team_2__c=NULL;
                    apps.put(a.id,aa);
                }
                
            }
        }
        
        if(apps.size()>0)
        {
            update apps.values();
            updateUsers();
        }
        
        if(eg1.size()>0){
            update eg1;
        }
    }
    
    
    private static void construct()
    {
        if(AllUsers!=NULL){ return; }
        
        roles = new Map<Id,String>();
        
        roles.put('00E1P000000ih0KUAQ','team1');
        roles.put('00E1a000000YD0lEAG','team2');
        
        AllUsers = new Map<String,Map<Id,Integer>>();
              
        List<User> users = [select id, userrole.id, Weight_Value__c from user where userrole.id in :roles.keySet() and isactive=true and out_of_office__c=false];
        
        Integer userValue;
        
        for(User u :users)
        {
            if(!AllUsers.containsKey(roles.get(u.userrole.id))){
                AllUsers.put(roles.get(u.userrole.id),new Map<Id,Integer>());
            }
            
            userValue=(u.Weight_Value__c==NULL)?0:(integer)u.Weight_Value__c;
            
            AllUsers.get(roles.get(u.userrole.id)).put(u.id, userValue);
        }
    }
    
    private static id GetRandomId(String teamName)
    {
        construct();
        id rtn;
        Map<Id,Integer> Team = AllUsers.get(teamName);

        Map<Integer,Id> revTeam = new Map<Integer,Id>();
        
        for(Id i :team.keySet()){
            revTeam.put(Team.get(i),i);
        }
        List<Integer> nums = new List<Integer>();
        nums.addAll(Team.Values());
        nums.sort();
        
        if(nums[0]>=10){
            reset(teamName);
        }
        rtn=revTeam.values()[0];
        
        Integer n=AllUsers.get(teamName).get(rtn);
        n=(n==NULL)?1:n+1;
        
        AllUsers.get(teamName).put(rtn, n);
        
        return rtn;
    }
    
    public static void updateUser(Id userId, Integer value)
    {
        if(AllUsers==NULL){ return; }
        
        try{
            User u = new User(Id=userId, Weight_Value__c=value);
            update u;
        }
        catch(Exception e){ e=NULL; }
    }
    
    public static void updateUsers()
    {
        if(AllUsers==NULL){ return; }
        
        List<User> users = new List<User>();
        
        for(String teamName :AllUsers.keySet())
        {
            for(Id user :AllUsers.get(teamName).keySet()){
                users.add(new User(Id=user, Weight_Value__c=AllUsers.get(teamName).get(user)));
            }
        }
        try{ update users; } catch(Exception e){ e=NULL;}
           
    }
    
    private static void reset(String teamName)
    {
        Map<Id,Integer> Team = AllUsers.get(teamName);
        
        for(Id u :Team.keySet()){
            AllUsers.get(teamName).put(u,0);
        }
    }
}