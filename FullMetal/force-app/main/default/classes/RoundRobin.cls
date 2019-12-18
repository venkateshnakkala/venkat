global class RoundRobin 
{

    public class MyException extends Exception {}

    private List<User> user_list{get;set;}
    private Map<Id,User> users{get;set;}
    public Map<String,Map<Integer,List<Id>>> dataSet{get;set;}
    private Map<Id,Id> admRep {get;set;}
    private Map<Id,String> idToLabel{get;set;}
    
    private Map<String,Set<Id>> RoleIds{get;set;}
    
    private Map<String,String> dupEmail{get;set;}
    private Map<String,String> dupPhone{get;set;}
    private Map<Id,DateTime> dupDate{get;set;}
    
    //private Map<Integer,Id> dupNPE{get;set;}
    private Map<Integer,Id> dupNE{get;set;}
    private Map<Integer,Id> dupNP{get;set;}
    private Map<Integer,Id> dupEP{get;set;}
    
    private Map<String,String> leadField{get;set;}
    
    public RoundRobin(List<Contact> c)
    {
        this.constructor();
        this.findDups(c);
    }
    
    public RoundRobin()
    {
        this.constructor();
    }
    
    private void constructor()
    {
        dupEmail = new Map<String,String>();
        dupPhone = new Map<String,String>();
        dupDate = new Map<Id,DateTime>();
        
        dupNP = new Map<Integer,Id>();
        dupNE = new Map<Integer,Id>();
        dupEP = new Map<Integer,Id>();
        
        admRep = new Map<Id,Id>();
        
        dataSet = new Map<String,Map<Integer,List<Id>>>();
        RoleIds = New Map<String, Set<Id>> {
                                            'ground'=> new Set<Id>{'00E1a000000YCtBEAW','00E1a000000YHk1EAG'},
                                            'online'=>new Set<Id>{'00E1a000000YD0gEAG'},
                                            'international'=> new Set<Id>{'00E1a000000YD0vEAG'}
                                            };
        List<Id> allRoles = new List<Id>();
        idToLabel = new Map<Id,String>();
        
        for(String label :RoleIds.keySet())
        {
            allRoles.addAll(RoleIds.get(label));
            
            for(Id i :RoleIds.get(label)){
                idToLabel.put(i,label);
            }
        }
        
        this.user_list=[SELECT Id, UserRole.Name, UserRoleId, Out_of_Office__c, Weight_Value__c FROM User WHERE UserRoleId in :allRoles AND isActive = true order by id];
        this.users = new Map<Id,User>(this.user_list);
        
        for(User u :user_list)
        {
            admRep.put(u.id,u.id);
            if(u.Out_of_Office__c==false)
            {
                Integer leadCount=(Integer)u.Weight_Value__c;
                leadCount=(leadCount==NULL)?0:leadCount;
                
                String label = idToLabel.get(u.UserRoleId);
                if(dataSet.containsKey(label)){
                    if(dataSet.get(label).containsKey(leadCount)){
                        dataSet.get(label).get(leadCount).add(u.id);
                    }
                    else{
                        dataSet.get(label).put(leadCount,new List<Id>{u.id});
                    }
                }
                else{
                    dataSet.put(label,new Map<Integer,List<Id>>{leadCount=>new List<Id>{u.id}});
                }
            }
        }
        
        this.leadField=new Map<String,String>();
        
        leadField.put('LeadSource','Lead_Category_#__c');
        leadField.put('Lead_ID__c','Lead_ID_#__c');
        leadField.put('Lead_Source__c','Lead_Source_#__c');
        leadField.put('Lead_Source_Code__c','Lead_Source_Code_#__c');

    }
    
    public boolean chkLastDate(Id i){
        boolean rtn=false;
        
        if(dupDate.get(i)==null){ rtn=true; }
        
        else if((DateTime.now().getTime() - dupDate.get(i).getTime())/3600000.0 >=24.0){ rtn=true; }
        
        return rtn;
    }
    
    public boolean isAdminRep(Id owner){
        boolean rtn=false;
        if(admRep.containsKey(owner)){ rtn=true; }
        return rtn;
    }
    
    private void addToDataset(String label, Integer leadCount, Id user)
    {
        if(dataSet.containsKey(label))
        {
            Map<Integer,List<Id>> m = dataSet.get(label);
            
            if(m.containsKey(leadCount))
            {
                m.get(leadCount).add(user);
            }
            else{
                m.put(leadCount,new List<Id>{user});
            }
        } else{ dataSet.put(label,new Map<Integer,List<Id>>{leadCount=>new List<Id>{user}}); }
    }
    
    private void reset(String programType)
    {
        Map<String,Map<Integer,List<Id>>> newDataSet = new Map<String,Map<Integer,List<Id>>>();
        newDataSet.put(programType, new Map<Integer,List<Id>>());
        newDataSet.get(programType).put(0, new List<Id>());
        
        List<User> updateUsers = new List<User>();
        
        for(String label :dataSet.KeySet())
        {
            if(label==programType)
            {
                Map<Integer,List<Id>> m = dataSet.get(programType);
                
                for(Integer leadCount :m.keySet())
                {
                    newDataSet.get(programType).get(0).addAll(m.get(leadCount));
                }
            }
            else
            {
                newDataSet.put(label,dataSet.get(label));
            }
        }
        
        for(Id i :newDataSet.get(programType).get(0)){
            updateUsers.add(new User(Id=i, Weight_Value__c=0));
        }
        try{ update updateUsers; }catch(System.DmlException e) { if(e.getMessage().contains('UNABLE_TO_LOCK_ROW')){ e=NULL; } }
        
        this.dataSet=newDataSet;
    }
    
    public id whoIsNext(Contact c)
    {
        Id rtn=NULL;
        String programType=NULL;
        
        if(users.containsKey(c.ownerid)){ rtn=c.ownerid; }
        else if(isDups(c)){ rtn='0051a000000aFEJ'; } // if duplicate found, assign the record to receptionist
        
        else if(c.Affiliation_Code__c !=NULL && c.Affiliation_Code__c.startsWith('INTL')){
            programType='international';
        }
        else if(c.Exclude_TOG__c==false && c.Program_Code__c!=NULL && c.Program_Code__c.endsWith('-O'))
        { 
            if(c.Lead_Source_Code__c!=NULL && ( c.Lead_Source_Code__c=='LARSWEBAPP' || c.Lead_Source_Code__c=='LAFSWEBAPP')){
                rtn='0051a000000aFE8AAM'; // to Chelsie Huffine 
            }
            else if(c.Lead_Source_Code__c=='CENTFLFAIR'){
                rtn='0051a000001oOgSAAU'; // Patrick Triolo
            }
            else{
                rtn='0051a000002tHWnAAM'; // TOG USER - 
            } 
        }
        else if(c.Exclude_TOG__c==true && c.Program_Code__c!=NULL && c.Program_Code__c.endsWith('-O')){ programType='online'; }
        else{ programType='ground'; }
        
        if(rtn==NULL)
        {
            if(dataSet.containsKey(programType) && dataSet.get(programType).containsKey(0) && dataSet.get(programType).get(0).size()>0){
                rtn=dataSet.get(programType).get(0).get(0);
                dataSet.get(programType).get(0).remove(0);
                addToDataset(programType,1,rtn);
                users.get(rtn).Weight_Value__c=1;
            }
            else if(dataSet.containsKey(programType) && (!dataSet.get(programType).containsKey(0) || dataSet.get(programType).get(0).size()==0)){
                reset(programType);
                rtn=whoIsNext(c);
            }
            
            if(rtn!=NULL)
            {
                User u = new User(Id=rtn, Weight_Value__c=1);
                try { update u; }catch(System.DmlException e) { if(e.getMessage().contains('UNABLE_TO_LOCK_ROW')){ e=NULL; } }
            }
        }
        return rtn;
    }
    
    public string phoneFormat(string phone)
    {
        String newPhone= phone.replaceAll('[^0-9]', '');
        
        if(newPhone.length()==10 || (newPhone.length()==11 && newPhone.substring(0,1)=='1')){
            String s=lastTen(phone);
            phone = '(' + s.substring(0, 3) + ') ' + s.substring(3, 6) + '-' + s.substring(6);
        }
        return phone;
    }
    
    public string lastTen(String phone){
        if(phone==NULL){
            return phone;
        }
        String rowNumber = phone.replaceAll('[^0-9]+', '');
        integer len=rowNumber.length();
        
        string rtn='';
        if(len>=10){
            rtn=rowNumber.substring(len-10,len);
        }else{ rtn=rowNumber; }
        return rtn;
    }
    
    private integer hash(String text){
        text=text.tolowerCase();
        return text.hashcode();
    }
    
    private void PutInMap(Map<Integer,Id> M, Integer K, Id V)
    {
        if(!M.containsKey(K) || (M.containsKey(K) && M.get(K)>V)){
            M.put(K,V);
        }
    }
    
    private void PutInMap(Map<Id,DateTime> M, Id K, DateTime V)
    {
        if(!M.containsKey(K) || (M.containsKey(K) && M.get(K)>V)){
            M.put(K,V);
        }
    }
    
    public void findDups(List<Contact> dup)
    {
        Map<Id,Id> ids = new Map<Id,Id>();
        
        Container bucket = new Container();
        
        for(Contact d :dup)
        {
            if(d.phone!=NULL){
                bucket.add(lastTen(d.phone));
            }
            
            if(d.email!=NULL){
                bucket.add(d.email);
            }
            
            if(d.other_email__c!=NULL){
                bucket.add(d.other_email__c);
            }
            
            if(d.id!=NULL){ 
                ids.put(d.Id, d.id); 
            }
        }
        
        String search=bucket.get();
        
        List<List<Contact>> dupList = [FIND :search IN ALL FIELDS RETURNING Contact(Id, Name, Phone, Email, Other_Email__c, Lead_Date__c)];
        
        if(dupList.size()>0)
        {
            if(Test.IsRunningTest()){
                dupList[0]=[select Id, Name, Phone, Email, Other_Email__c, Lead_Date__c from contact limit 100];
            }
            
            for(Contact r :dupList[0])
            {
                if(!ids.containsKey(r.Id))
                {
                    if(r.Lead_Date__c!=NULL){
                        PutInMap(dupDate, r.Id, r.Lead_Date__c);
                    }
                    
                    if(r.Email!=NULL)
                    {
                        String NE = r.Name+'~'+r.Email;
                        PutInMap(dupNE, hash(NE.toLowerCase()), r.Id);
                        dupEmail.put(r.Email.toLowerCase(), r.Email);
                    }
                    
                    if(r.Other_Email__c!=NULL)
                    {
                        String NE = r.Name+'~'+r.Other_Email__c;
                        PutInMap(dupNE, hash(NE.toLowerCase()), r.Id);
                        dupEmail.put(r.Other_Email__c.toLowerCase(), r.Other_Email__c);
                    }
                    
                    if(r.Phone!=NULL)
                    {
                        String pp=lastTen(r.Phone);
                        String NP=r.Name+'~'+pp;
                        PutInMap(dupNP, hash(NP.toLowerCase()), r.Id);
                        dupPhone.put(pp,pp);
                    }
                    
                    if(r.Email!=NULL && r.Phone!=NULL)
                    {
                        String EP=r.Email+'~'+lastTen(r.Phone);
                        PutInMap(dupEP, hash(EP.toLowerCase()), r.Id);
                    }
                    
                    if(r.Other_Email__c!=NULL && r.Phone!=NULL)
                    {
                        String EP=r.Other_Email__c+'~'+lastTen(r.Phone);
                        PutInMap(dupEP, hash(EP.toLowerCase()), r.Id);
                    }
                }
            }
        }
    }
    
    public boolean isDups(Contact c)
    {
        boolean rtn=false;
        
        string NE;
        string NP;
        string EP;
        
        string name;
        if(c.firstname!=null && c.lastname!=null)
        {
            name=c.firstname+' '+c.lastname;
        }
        else{
            name=(c.lastname!=NULL)?c.lastname:c.firstname;
        }
        name=name.toLowerCase();
        
        if(!rtn && c.email!=NULL)
        {
            Integer ne_d = hash(name+'~'+c.email.toLowerCase());
            
            if(dupNE.containsKey(ne_d))
            {               
                if(c.Lead_Source_Code__c!=NULL && c.Lead_Source_Code__c!='LARSWEBAPP' && c.Lead_Source_Code__c!='LAFSWEBAPP')
                {
                    c.DoNotCall=true; // to delete
                    
                    updateLeadSource(dupNE.get(ne_d), c);
                }
                
                rtn=true;
            }
            
            if(!rtn && c.phone!=NULL)
            {
                Integer ep_d1 = hash(c.email.toLowerCase()+'~'+lastTen(c.phone));
                Integer ep_d2 = hash(c.email.toLowerCase()+'~'+phoneFormat(c.phone));
                
                if(dupEP.containsKey(ep_d1) || dupEP.containsKey(ep_d2))
                { 
                    if(c.Lead_Source_Code__c!=NULL && c.Lead_Source_Code__c!='LARSWEBAPP' && c.Lead_Source_Code__c!='LAFSWEBAPP')
                    {
                        c.DoNotCall=true; // to delete
                        
                        if(dupEP.containsKey(ep_d1)){
                            updateLeadSource(dupEP.get(ep_d1), c);
                        }
                        else{
                            updateLeadSource(dupEP.get(ep_d2), c);
                        }
                    }
                    
                    rtn=true;
                }
            }
        }
        
        if(!rtn && c.phone!=NULL)
        {
            Integer np_d1 = hash(name+'~'+lastTen(c.phone));
            Integer np_d2 = hash(name+'~'+phoneFormat(c.phone));
            
            if(dupNP.containsKey(np_d1) || dupNP.containsKey(np_d2))
            {
                if(c.Lead_Source_Code__c!=NULL && c.Lead_Source_Code__c!='LARSWEBAPP' && c.Lead_Source_Code__c!='LAFSWEBAPP'){
                    c.DoNotCall=true; // to delete
                    
                    if(dupNP.containsKey(np_d1)){
                        updateLeadSource(dupNP.get(np_d1), c);
                    }
                    else{
                        updateLeadSource(dupNP.get(np_d2), c);
                    }
                }
                
                rtn=true;
            }
            
            if(!rtn && c.email!=NULL)
            {
                Integer ep_d1 = hash(c.email.toLowerCase()+'~'+lastTen(c.phone));
                Integer ep_d2 = hash(c.email.toLowerCase()+'~'+phoneFormat(c.phone));
                
                if(dupEP.containsKey(ep_d1) || dupEP.containsKey(ep_d2))
                {
                    if(c.Lead_Source_Code__c!=NULL && c.Lead_Source_Code__c!='LARSWEBAPP' && c.Lead_Source_Code__c!='LAFSWEBAPP')
                    { 
                        c.DoNotCall=true; // to delete
                        
                        if(dupEP.containsKey(ep_d1)){
                            updateLeadSource(dupEP.get(ep_d1), c);
                        }
                        else{
                            updateLeadSource(dupEP.get(ep_d2), c);
                        }
                    }
                    rtn=true;
                }
            }
        }

        if(!rtn && dupEmail.containsKey(c.email)){ rtn=true; }
            
        if(!rtn && dupPhone.containsKey(lastTen(c.phone))){ rtn=true; }
        
        return rtn;
    }
    
    public void updateLeadSource(Id originalId, Contact duplicate){
        if(originalId==duplicate.id){ return; }
        
        //Lead_Source__c LeadSource
        if(duplicate.Lead_Source_Code__c!=NULL && (duplicate.Lead_Source__c==NULL || duplicate.LeadSource==NULL))
        {
            List<String> LeadCat = ContactUtilities.getDataSet(duplicate.Lead_Source_Code__c);
            if(LeadCat!=NULL && LeadCat.size()>0)
            {
                duplicate.Lead_Source__c = LeadCat[0];
                duplicate.LeadSource = LeadCat[1];
            }
        }
        
        Set<String> mainFilds = leadField.keySet();
        String mFields=NULL;
        
        for(String s :mainFilds){
            if(mFields==NULL){
                mFields=s;
            }
            else{
                mFields+=', '+s;
            }
        }
        Contact c = database.query('select '+mFields+', Lead_Date__c, Lead_Source_Code_1__c, Lead_Source_Code_2__c, Lead_Source_Code_3__c, Lead_Source_Code_4__c, Program_Code__c, Re_inquiry__c from contact where id=:originalId');

        String fieldNumber='4';
        String lastCode=NULL;
        
        if(duplicate.Program_Code__c!=NULL && c.Program_Code__c!=duplicate.Program_Code__c){
            c.Program_Code__c=duplicate.Program_Code__c;
        }
        
        if(duplicate.RSVP_Event_Type__c!=NULL){
            c.RSVP_Event_Type__c=duplicate.RSVP_Event_Type__c;
        }
        
        if(duplicate.All_Access_Tour_Date__c!=NULL){
            c.All_Access_Tour_Date__c=duplicate.All_Access_Tour_Date__c;
        }
        
        if(duplicate.Evening_Sessions_Date__c!=NULL){
            c.Evening_Sessions_Date__c=duplicate.Evening_Sessions_Date__c;
        }
        
        if(c.Lead_Source_Code_1__c==NULL && c.Lead_Source_Code__c!=NULL){
            c.Lead_Date_1__c=c.Lead_Date__c;
            c.Lead_Source_Code_1__c=c.Lead_Source_Code__c;
            c.Lead_Category_1__c = c.LeadSource;
            c.Lead_ID_1__c=c.Lead_ID__c;
            c.Lead_Source_1__c=c.Lead_Source__c;
        }
        
        if(c.Lead_Source_Code_1__c==NULL){
            fieldNumber='1';
            lastCode=c.Lead_Source_Code__c;
        }
        else if(c.Lead_Source_Code_2__c==NULL)
        {
            fieldNumber='2';
            lastCode=c.Lead_Source_Code_1__c;
        }
        else if(c.Lead_Source_Code_3__c==NULL)
        {
            fieldNumber='3';
            lastCode=c.Lead_Source_Code_2__c;
        }
        else if(c.Lead_Source_Code_4__c==NULL)
        {
            lastCode=c.Lead_Source_Code_3__c;
        }
        else
        {
            lastCode=c.Lead_Source_Code_4__c;
        }
        
        if((lastCode!=duplicate.Lead_Source_Code__c || chkLastDate(originalId)) && (fieldNumber=='1' || (duplicate.Lead_Source_Code__c!='LAFSWEBAPP' && duplicate.Lead_Source_Code__c!='LARSWEBAPP')))
        {
            String ff;
            c.Re_inquiry__c=true;
            
            for(String s :mainFilds)
            {
                ff=leadField.get(s);
                ff=ff.replace('#', fieldNumber);
                c.put(ff,duplicate.get(s));
                c.put(s,duplicate.get(s));
            }
            c.put('Lead_Date__c',system.now());
            String d ='Lead_Date_#__c';
            String dd=d.replace('#', fieldNumber);
            c.put(dd,system.now());
            update c;
            
        }
    }
    
    public boolean isOnlineMilitary(Contact con){
        boolean rtn=false;
        
        if(con.Affiliation_Code__c!=NULL && con.Program_Code__c!=NULL && con.Program_Code__c.endsWith('-O'))
        {
            Map<String,String> codes = new Map<String,String>();
            codes.put('ACT','ACT');
            codes.put('ADAF','ADAF');
            codes.put('ADAR','ADAR');
            codes.put('ADCG','ADCG');
            codes.put('ADMC','ADMC');
            codes.put('ADNV','ADNV');
            codes.put('MDAF','MDAF');
            codes.put('MDAR','MDAR');
            codes.put('MDCG','MDCG');
            codes.put('MDMC','MDMC');
            codes.put('MDNV','MDNV');
            codes.put('MILT','MILT');
            codes.put('MDEP','MDEP');
            codes.put('RESR','RESR');
            codes.put('RVNGAF','RVNGAF');
            codes.put('RVNGAR','RVNGAR');
            codes.put('RVNGCG','RVNGCG');
            codes.put('RVNGMC','RVNGMC');
            codes.put('RVNGNV','RVNGNV');
            codes.put('VET','VET');
            codes.put('VETAF','VETAF');
            codes.put('VETAR','VETAR');
            codes.put('VETCG','VETCG');
            codes.put('VETMC','VETMC');
            codes.put('VETNV','VETNV');
            codes.put('VETNU','VETNU');
            
            if(codes.containsKey(con.Affiliation_Code__c)){
                rtn=true;
            }
        }
        
        return rtn;
    }
    
    class container
    {
        private Map<String,String> db{get;set;}
        
        public container(){
            db = new Map<String,String>();
        }
        
        public void add(String s)
        {
            if(!db.containsKey(s)){
                db.put(s,s);
            }
        }
        
        public string get()
        {
            String rtn=NULL;
            
            for(String s :db.values())
            {
                if(rtn==NULL){
                    rtn=s;
                }
                else{
                    rtn+=' OR '+s;
                }
            }
            return rtn;
        }
    }
}