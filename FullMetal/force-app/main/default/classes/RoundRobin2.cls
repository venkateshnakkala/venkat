public class RoundRobin2{
	
    private Set<String> duplicates;
    private List<User> intlUsers;
    private List<User> onlineUsers;
    private List<User> campusUsers;
    
    public RoundRobin2(List<Contact> all){
        List<String> Emails = new List<String>();
        List<Id> Ids = new List<Id>();
        for(Contact c :all){
            if(c.Email!=NULL){
                Emails.add(c.Email);
            }
            if(c.id!=NULL){
            	Ids.add(c.id);
            }
        }
        this.duplicates =this.getDuplicates(Emails,Ids);
        this.intlUsers = new List<User>();
    	this.onlineUsers = new List<User>();
    	this.campusUsers = new List<User>();
    	
        this.allCorrection();
    }
    
    public id whoIsNext(Contact con){
        
        id rtn;
        if(this.duplicates.contains(con.email)==true){
            rtn='0051a000000aFEJ';
        }
        else if((con.ownerId == '0051a000000aFEH' || con.ownerId =='0051a000000ZHO6') 
        && (con.School_Status__c == 'Connected' || con.School_Status__c =='Appointment Set' || con.School_Status__c == 'Interviewed' 
            || con.School_Status__c == 'Application Submitted' || con.School_Status__c == 'Applicant'))
        {
            con.OwnerId = userinfo.getUserId();
        }
        else if(con.owner_id__c != null){ 
            rtn = con.owner_id__c;
        }
        else if (con.Affiliation_Code__c == 'INTL' || con.Affiliation_Code__c == 'INTL1' || con.Affiliation_Code__c == 'INTL2'){
            rtn=this.nextInternational();
        }
        else if (con.Program_Code__c == 'ASMP-O' || con.Program_Code__c == 'BSDF-O' || con.Program_Code__c == 'BSDP-O' || con.Program_Code__c == 'BSEB-O'
                || con.Program_Code__c == 'BSFP-O' || con.Program_Code__c == 'BSGD-O' || con.Program_Code__c == 'EBBS-O' || con.Program_Code__c == 'GSGD-O'){
             rtn=this.nextOnline();
        }
        else {
            rtn=this.nextOnCampus();
        }
        
        if(rtn==NULL && con.ownerId!=NULL){
        	rtn=con.ownerId;
        }
        
        return rtn;
    }
    
    private Set<String> getDuplicates(List<String> dup, List<String> Ids)
    {
        List<Contact> dupList = [select id, email from Contact WHERE (email In:dup  or other_email__c In:dup) and Id not in :Ids order by email];

        Set<String> dupSet = new set<String>();
        
        for(Contact c :dupList)
        {
            dupSet.add(c.email);
        }
        
        return dupSet;
    }
    
    private id nextInternational(){
        // international users
        if(this.intlUsers.size()==0){
        	this.interCorrection();
        	this.intlUsers= [select Id, Weight_Value__c, RoundRobin__c, Distribution_Weight__c, Alloted_Leads_Differ__c  from User where RoundRobin__c < 5 and  UserRoleid = '00E1a000000YD0v' and isActive = true and Out_of_Office__c = false Order By Alloted_Leads_Differ__c desc, LastName limit 200];
        }
        
        User intuser= this.intlUsers[0];

        decimal temp = intuser.Weight_Value__c;
        intuser.Weight_Value__c =temp+1;
        decimal Wtemp = intuser.Weight_Value__c;
        Decimal Dtemp = intuser.Distribution_Weight__c;
        intuser.Alloted_Leads_Differ__c = Dtemp - Wtemp;
        
        if (Wtemp >= Dtemp) 
        {
            intuser.RoundRobin__c = 10;
            intuser.Alloted_Leads_Differ__c = Dtemp;
            intuser.Weight_Value__c = 0;
        }

        update intuser;
        this.intlUsers.remove(0);
        return intuser.Id;
    }
    
    private id nextOnline(){
        // online users
        if(onlineUsers.size()==0){
	        this.onlineCorrection();
	        this.onlineUsers = [select Id, Weight_Value__c, RoundRobin__c, Distribution_Weight__c, Alloted_Leads_Differ__c from User where RoundRobin__c < 5 and  UserRoleid = '00E1a000000YD0g' and isActive = true and Out_of_Office__c = false Order By Alloted_Leads_Differ__c desc, LastName limit 200]; 
        }
        User intuser = this.onlineUsers[0];

        decimal temp = intuser.Weight_Value__c;
        intuser.Weight_Value__c =temp+1;
        decimal Wtemp = intuser.Weight_Value__c;
        Decimal Dtemp = intuser.Distribution_Weight__c;
        intuser.Alloted_Leads_Differ__c = Dtemp - Wtemp;
        
        if (Wtemp >= Dtemp) 
        {
            intuser.RoundRobin__c = 10;
            intuser.Alloted_Leads_Differ__c = Dtemp;
            intuser.Weight_Value__c = 0;
        }

        update intuser;
        this.onlineUsers.remove(0);
        return intuser.Id;
    }
    
    private id nextOnCampus(){
        // on-campus users
        if(this.campusUsers.size()==0)
        {
	        this.campusCorrection();
	        this.campusUsers = [select Id, Weight_Value__c, RoundRobin__c, Distribution_Weight__c, Alloted_Leads_Differ__c from User where RoundRobin__c < 5 and  (UserRoleid = '00E1a000000YCtB' or UserRoleid = '00E1a000000YHk1') and isActive = true and Out_of_Office__c = false Order By Alloted_Leads_Differ__c desc, LastName limit 200]; 
        }
        
        User intuser = this.campusUsers[0];
            
        decimal temp = intuser.Weight_Value__c;
        intuser.Weight_Value__c =temp+1;
        decimal Wtemp = intuser.Weight_Value__c;
        Decimal Dtemp = intuser.Distribution_Weight__c;
        intuser.Alloted_Leads_Differ__c = Dtemp - Wtemp;
    
        if ( Wtemp >= Dtemp) 
        {
            intuser.RoundRobin__c = 10;
            intuser.Alloted_Leads_Differ__c = Dtemp;
            intuser.Weight_Value__c = 0;
        }

    	update intuser;
    	this.campusUsers.remove(0);
    	return intuser.id;
    }
    
    private void interCorrection(){
                           
        List<User> internationalusersingle = [select Id, Distribution_Weight__c from User where RoundRobin__c < 5 and  UserRoleid = '00E1a000000YD0v' and isActive = true and Out_of_Office__c = false ];
        if (internationalusersingle.size() < 1) 
        {
        	List<User> userFieldUpdateIntr = new List<User>();
        	List<User> allinternationalusers = [select Id, Distribution_Weight__c from User where  UserRoleid = '00E1a000000YD0v' and isActive = true and Out_of_Office__c = false];
            for (user intuser: allinternationalusers){ 
                intuser.RoundRobin__c = 4;
                intuser.Alloted_Leads_Differ__c = intuser.Distribution_Weight__c; 
                intuser.weight_Value__c = 0;
                userFieldUpdateIntr.add(intuser);
            }
            update userFieldUpdateIntr;              
        }
    }
    
    private void onlineCorrection(){
                                  
        List<User> onlineusersingle = [select Id, Distribution_Weight__c from User where RoundRobin__c < 5 and  UserRoleid = '00E1a000000YD0g'and isActive = true and Out_of_Office__c = false];
        if (onlineusersingle.size() < 1) {
        	List<User> userFieldUpdateOnline = new List<User>();
        	List<User> allonlineusers = [ select Id, Distribution_Weight__c from User where  UserRoleid = '00E1a000000YD0g' and isActive = true and Out_of_Office__c = false ]; 
        	for (user intuser: allonlineusers){ 
                intuser.RoundRobin__c = 4; 
                intuser.Alloted_Leads_Differ__c = intuser.Distribution_Weight__c; 
                intuser.weight_Value__c = 0;
                userFieldUpdateOnline.add(intuser);
            }
            update userFieldUpdateOnline;            
        }
    }
    
    private void campusCorrection(){
        
        List<User> campususersingle = [select Id, Distribution_Weight__c from User where RoundRobin__c < 5 and  (UserRoleid = '00E1a000000YCtB' or UserRoleid = '00E1a000000YHk1') and isActive = true and Out_of_Office__c = false];
        if (campususersingle.size() < 1) {
        	List<User> userFieldUpdateOnCampus = new List<User>();
        	List<User> allcampususers = [ select Id, Distribution_Weight__c from User where   (UserRoleid = '00E1a000000YCtB' or UserRoleid = '00E1a000000YHk1') and isActive = true and Out_of_Office__c = false]; 
            for (user intuser: allcampususers){ 
                intuser.RoundRobin__c = 4; 
                intuser.Alloted_Leads_Differ__c = intuser.Distribution_Weight__c; 
                intuser.weight_Value__c = 0;
                userFieldUpdateOnCampus.add(intuser);
            }
            update userFieldUpdateOnCampus;        
        }
    }
    
    private void allCorrection(){
        
        //for new users created do not have value.
        List<Id> roleIds = new List<Id>();
        roleIds.add('00E1a000000YD0v'); // internation users
        roleIds.add('00E1a000000YD0g'); // online users
        roleIds.add('00E1a000000YCtB'); // campus users
        roleIds.add('00E1a000000YHk1'); // campus users
        
        List<User> allusers = [select Id, Distribution_Weight__c, weight_Value__c, Alloted_Leads_Differ__c from User where UserRoleid in :roleIds and isActive = true and (Distribution_Weight__c = null or Weight_Value__c = null or Alloted_Leads_Differ__c =null)];
        if(allusers.size()>0)
        {
        	List<User> userFieldUpdateall = new List<User>();
	        for (User userToUpdate: allusers)
	        { 
				if (userToUpdate.Distribution_Weight__c == NULL) {userToUpdate.Distribution_Weight__c = 1;}  
				if (userToUpdate.Weight_Value__c == NULL) {userToUpdate.Weight_Value__c = 0;} 
				if (userToUpdate.Alloted_Leads_Differ__c == NULL) {userToUpdate.Alloted_Leads_Differ__c = 1;} 
	           
	           userFieldUpdateall.add(userToUpdate);
	        }
	        update userFieldUpdateall;
    	}
    }
}