public class dashboardController {
    public string test{get;set;}
    
    public integer page_no{get;set;}
    public integer pages{get;private set;}
    
    private AsyncWSCVSF.AsyncLAFSPort port;
    private AsyncWSCVSF.CVAPI_getDataResponseTypeFuture ResultSet{get;set;}
    private WSCVSF.LAFSPort localPort;
    
    public List<DataRow> DataSet {get;private set;}
    
    public List<selectOption> SchoolStatusList{get;set;}
    public List<selectOption> ExpStartDateList{get;set;}
    public List<selectOption> ProgramOptions{get;set;}
    public List<selectOption> salesRep{get;set;}
    
    public string Program{get;set;}
    public string SchoolStatus {get;set;}
    public string StartDate{get;set;}
    public string reps{get;set;}
    
    private List<String> stunum;
    private Map<String,String> lastActivity;

    public string clean(String l){
        if(l==NULL || l=='[]')
            return NULL;
            
        l=l.replace('[','');
        l=l.replace(']','');
        l=l.trim();
        String[] ll = l.split(', ');
        return '\''+String.join(ll,'\',\'')+'\'';
    }
    
    public string cleand(String l){
    
        if(l==NULL || l=='[]')
            return NULL;
            
        l=l.replace('[','');
        l=l.replace(']','');
        String[] ll = l.split(', ');
        
        Date d;
        String nd;
        for(String sd :ll){
            d=date.parse(sd);
            
            if(nd==NULL)
                nd='\''+d.year()+'-'+d.month()+'-'+d.day()+'\'';
            else
                nd+=',\''+d.year()+'-'+d.month()+'-'+d.day()+'\'';
        }
        return nd;
    }
    
    public dashboardController(ApexPages.StandardController controller){
        this.construct();
    }
    
    public dashboardController(){
        this.construct();
    }
    
    public class SchoolStatus{
        public string code{get;set;}
        public string descrip{get;set;}
    }
    
    public class RepData{
        public string amRepId{get;set;}
        public string descrip{get;set;}
    }
    
    public class expStartDate{
        public string expStartDate{get;set;}
    }
    
    public Continuation pre(){
        if(this.page_no!=1)
            this.page_no=this.page_no-1;
            
       return this.readSql();
    }
    
    public Continuation next(){
        if(this.page_no<this.pages)
            this.page_no=this.page_no+1;
            
        return this.readSql();
    }
    
    public Continuation start(){
        this.page_no=1;
        return this.readSql();
    }
    
    public void construct(){
        try {
        this.page_no=1;
        this.stunum = new List<String>();
        this.lastActivity = new Map<String,String>();
        
        port = new AsyncWSCVSF.AsyncLAFSPort();
        localPort = new WSCVSF.LAFSPort();
        
        string repSql='select amRepId, descrip from amrep where active=1 order by descrip';
        string repData = localPort.CVAPI_getData(repSql);
        List<RepData> rd = new List<RepData>();
        rd=(List<RepData>)JSON.deserialize(RepData,List<RepData>.class);
        
        this.SalesRep = new List<selectOption>();
        this.SalesRep.add(new SelectOption('',''));
        for(RepData r :rd){
            this.SalesRep.add(new SelectOption(r.amRepId,r.descrip));
        }
        
        String SchoolSQL='select ltrim(rtrim(Code)) code, Descrip from SySchoolStatus where Active=1 order by Descrip';
        String SchoolData = localPort.CVAPI_getData(SchoolSQL);
        List<SchoolStatus> st = new List<SchoolStatus>();
        st=(List<SchoolStatus>)JSON.deserialize(SchoolData,List<SchoolStatus>.class);
        
        this.SchoolStatusList = new List<SelectOption>();
        this.SchoolStatusList.add(new SelectOption('',''));
        
        for(SchoolStatus s :st){
            this.SchoolStatusList.add(new SelectOption(s.code,s.descrip));
        }
        
        String DateSQL = 'select top 25 convert(varchar(12),ExpStartDate,101) expStartDate from AdEnroll e where ExpStartDate is not NULL ';
               DateSQL +='group by convert(varchar(20),ExpStartDate,101), ExpStartDate order by e.ExpStartDate desc';
        String DateData = localPort.CVAPI_getData(DateSQL);
        List<expStartDate> dt = new List<expStartDate>();
        dt=(List<expStartDate>)JSON.deserialize(DateData,List<expStartDate>.class);
        
        this.ExpStartDateList = new List<SelectOption>();
        this.ExpStartDateList.add(new SelectOption('',''));
        
        for(expStartDate e :dt){
            this.ExpStartDateList.add(new SelectOption(e.expStartDate,e.expStartDate));
        }
        
        ProgramOptions = new List<selectOption>();
        ProgramOptions.add(new selectOption('',''));
        ProgramOptions.add(new selectOption('12','Associate of Science in Computer Animation'));
        ProgramOptions.add(new selectOption('9','Associate of Science in Film'));
        ProgramOptions.add(new selectOption('11','Associate of Science in Game Production'));
        ProgramOptions.add(new selectOption('41','Associate of Science in Music Production'));
        ProgramOptions.add(new selectOption('10','Associate of Science in Recording Arts'));
        ProgramOptions.add(new selectOption('52','Associate of Science in Audio Production'));
        ProgramOptions.add(new selectOption('42','Bachelor of Science Game Production and Design'));
        ProgramOptions.add(new selectOption('43','Bachelor of Science in Animation and Visual Effects'));
        ProgramOptions.add(new selectOption('37','Bachelor of Science in Entertainment Business'));
        ProgramOptions.add(new selectOption('49','Bachelor of Science in Film Production'));
        ProgramOptions.add(new selectOption('50','O-Associate of Science in Music Production Online '));
        ProgramOptions.add(new selectOption('45','O-Bachelor of Science in Digital Filmmaking Online'));
        ProgramOptions.add(new selectOption('46','O-Bachelor of Science in Entertainment Business Online'));
        ProgramOptions.add(new selectOption('51','O-Bachelor of Science in Graphic Design'));
        ProgramOptions.add(new selectOption('47','UC Riverside Partnership Program'));
        }
        catch(Exception e){
            throw e;
        }
    }
    
    
    public class DataRow{
        public string appno{get;set;}
        public string stunum{get;set;}
        public string name{get;set;}
        public string Descrip{get;set;}
        public string school_status{get;set;}
        public string registration{get;set;}
        public string schedule{get;set;}
        public double first_attend{private get;set;}
        public double second_attend{private get;set;}
        public double third_attend{private get;set;}
        public double fourth_attend{private get;set;}
        public date ExpStartDate{private get; set;}
        public string rep {get;set;}
        public integer total_rows{get;set;}
        
        public date StatusDate{private get;set;}
        public string comments{get;set;}
        
        public string lastActivity{get; set;}
        
        Public String getExpStartDate(){
            if(this.ExpStartDate==NULL)
                return NULL;
            return this.ExpStartDate.format();
        }
        
        Public String getStatusDate(){
            if(this.StatusDate==NULL)
                return NULL;
            return this.StatusDate.format();
        }
        
        public string getFirst_Attend(){
            if(this.first_attend==NULL)
                return null;
            return String.valueOf(this.first_attend)+'%';
        }
        
        public string getSecond_Attend(){
            if(this.second_attend==NULL)
                return null;
            return String.valueOf(this.second_attend)+'%';
        }
        
        public string getThird_Attend(){
            if(this.third_attend==NULL)
                return null;
            return String.valueOf(this.third_attend)+'%';
        }
        
        public string getFourth_Attend(){
            if(this.fourth_attend==NULL)
                return null;
            return String.valueOf(this.fourth_attend)+'%';
        }
    }

    

    Public Continuation readSql(){
        try {
            String sqlText ='SELECT e.comment appno, ltrim(rtrim(s.stunum)) stunum, concat(isnull(s.lastname,\'\'),\', \',isnull(s.firstname,\'\')) name, '+
                            'p.Descrip, sc.Descrip school_status, case when sum(case when cs.code like \'%otam%\' then 1 else 0 end)>0 '+
                            'then \'Yes\' else \'No\' end registration, case when count(cs.code)>1 then \'Yes\' else \'No\' end schedule, '+
                            'round(cast(case when a.first_week_all=0 then 0 else a.first_week/(a.first_week_all*1.0)*100 end as float),2) first_attend, '+
                            'round(cast(case when a.second_week_all=0 then 0 else a.second_week/(a.second_week_all*1.0)*100 end as float),2) second_attend, '+
                            'round(cast(case when a.third_week_all=0 then 0 else a.third_week/(a.third_week_all*1.0)*100 end as float),2) third_attend, '+
                            'round(cast(case when a.fourth_week_all=0 then 0 else a.fourth_week/(a.fourth_week_all*1.0)*100 end as float),2) fourth_attend, '+
                            'cast(st.effectivedate as date) StatusDate, case when ISNUMERIC(st.comment)=1 then NULL else st.comment end comments, '+
                            'cast(e.ExpStartDate as date) ExpStartDate, rep.descrip rep, count(*) over() total_rows FROM [CampusVue_Live].[dbo].[syStudent] s left join '+
                            '[CampusVue_Live].[dbo].[AdEnroll] e on (s.SyStudentId=e.SyStudentID) left join [CampusVue_Live].[dbo].[AdProgram] p on '+
                            '(p.AdProgramID=e.AdProgramID) left join [CampusVue_Live].[dbo].[AdEnrollSched] es on (es.SyStudentID=s.SyStudentId '+
                            'AND es.AdEnrollID=e.AdEnrollID) left join [CampusVue_Live].[dbo].[AdClassSched] cs on (cs.AdClassSchedID = es.AdClassSchedID) '+
                            'left join [CampusVue_Live].[dbo].[SySchoolStatus] sc on(s.SySchoolStatusID=sc.SySchoolStatusID) left join (SELECT '+
                            's1.SyStudentID, s1.EffectiveDate, s1.NewSySchoolStatusID, s1.comment FROM [CampusVue_Live].[dbo].[SyStatChange] s1 '+
                            'inner join (SELECT SyStudentID, max(EffectiveDate) maxDate FROM [CampusVue_Live].[dbo].[SyStatChange] WHERE '+
                            'ModFlag=\'A\' GROUP BY SyStudentID)s2 on (s1.SyStudentID=s2.SyStudentID and s1.EffectiveDate=s2.maxDate)) st on '+
                            '(st.SyStudentID=s.SyStudentId and st.NewSySchoolStatusID=s.SySchoolStatusID) left join (SELECT b.SyStudentID, a.AdEnrollID, '+
                            'sum(case when a.Date>=b.fs AND a.Date<b.sc then isnull(a.Attend,0) END) first_week, sum(case when a.Date>=b.fs AND a.Date<b.sc '+
                            'then isnull(a.Attend,0)+isnull(a.Absent,0) END) first_week_all, sum(CASE WHEN a.Date>=b.sc AND a.Date<b.th THEN isnull(a.Attend,0) END) second_week, '+
                            'sum(CASE WHEN a.Date>=b.sc AND a.Date<b.th THEN isnull(a.Attend,0)+isnull(a.Absent,0) END) second_week_all, sum(CASE WHEN a.Date>=b.th '+
                            'AND a.Date<b.fo THEN isnull(a.Attend,0) END) third_week, sum(CASE WHEN a.Date>=b.th AND a.Date<b.fo THEN isnull(a.Attend,0)+isnull(a.Absent,0) END) '+
                            'third_week_all, sum(CASE WHEN a.Date>=b.fo AND a.Date<b.lw THEN isnull(a.Attend,0) END) fourth_week, sum(CASE WHEN a.Date>=b.fo AND a.Date<b.lw THEN '+
                            'isnull(a.Attend,0)+isnull(a.Absent,0) END) fourth_week_all FROM (SELECT s.SyStudentID, s.AdEnrollID, min(s.StartDate) fs, '+
                            'dateadd(dd,8-datepart(dw,min(s.StartDate)), min(s.StartDate)) sc, dateadd(dd,15-datepart(dw,min(s.StartDate)),min(s.StartDate)) th, '+
                            'dateadd(dd,22-datepart(dw,min(s.StartDate)),min(s.StartDate)) fo, dateadd(dd,29-datepart(dw,min(s.StartDate)), min(s.StartDate)) lw '+
                            'FROM AdEnrollSched s left join AdAttend a ON (s.AdEnrollID=a.AdEnrollID and s.AdEnrollSchedID=a.AdEnrollSchedID and s.StartDate = a.Date) '+
                            'GROUP By s.SyStudentID, s.AdEnrollID)b left join AdAttend a ON (a.AdEnrollID=b.AdEnrollID) GROUP BY b.SyStudentID, a.AdEnrollID) a '+
                            'on (e.AdEnrollID=a.AdEnrollID and s.SyStudentID=a.SyStudentID) left join amrep rep on (s.AmRepID=rep.amRepID) WHERE e.ExpStartDate>\'2000-01-01\'  ';
                        
                if(cleand(this.StartDate)!=NULL){
                    sqlText +=' AND cast(e.ExpStartDate as date) in ('+cleand(this.StartDate)+')';
                }
                
                if(clean(this.SchoolStatus)!=NULL){
                    sqlText +=' AND sc.Code in ('+ clean(this.SchoolStatus) +') ';
                }
                
                if(clean(this.Program)!=NULL){
                    sqlText +=' AND e.AdProgramID in ('+ clean(this.Program) +') ';
                }
                
                if(clean(this.reps)!=NULL){
                    sqlText +=' AND s.AmRepId in ('+ clean(this.reps) +') ';
                }
                
            sqlText +=' GROUP BY s.stunum, s.lastname, s.firstname, p.Descrip, cast(e.ExpStartDate as date), a.first_week, '+
                      'a.first_week_all, a.second_week, a.second_week_all, a.third_week, a.third_week_all, a.fourth_week, '+
                      'a.fourth_week_all, sc.Descrip, rep.descrip, e.comment, st.effectivedate, st.comment ORDER BY cast(e.ExpStartDate as date) '+
                      'DESC OFFSET '+((this.page_no-1)*200) + ' ROWS FETCH NEXT 200 ROWS ONLY';
            this.test=sqlText;
                        
            Continuation con = new Continuation(30);
            con.continuationMethod='renderData';
            con.timeout=60;
    
            this.ResultSet= port.beginCVAPI_getData(con,sqlText);

            return con;
        }
        catch(Exception e){
            throw e;
        }
    }
    
    public Object renderData(){
        this.DataSet=(List<DataRow>)JSON.deserialize(resultSet.getValue(),List<DataRow>.class);
        if(this.DataSet.size()>0){
            this.pages=(Integer)Math.ceil(this.DataSet[0].total_rows/200.0);
            
            for(DataRow r :DataSet){
                this.stunum.add(r.stunum);
            }
            
            this.lastActivity=this.getLastActivity(this.stunum);
            
            for(DataRow r :DataSet){
                r.lastActivity=this.lastActivity.get(r.stunum);
            }
            
            Map<string, string> onCampusReg = new Map<string, string>();
            onCampusReg = this.getOnCampusReg(this.stunum);
            
            for(DataRow r :DataSet){
                String rs = onCampusReg.get(r.stunum);
                
                if(rs!=NULL)
                    r.registration=rs;
            }
        }else
            this.pages=1;
        /*
        List<String> AppNos = new List<String>();
        for(String r :this.DataSet.KeySet()){
            AppNos.add(this.DataSet.get(r).AppNo);
        }
        getStudentIds(AppNos);
        */

        return NULL;
    }
    
    private Map<string, string> getOnCampusReg(List<String> stunum){
        Map<string, string> rtnList = new Map<string, string>();
        
        List<Contact> con =[select stunum__c, (select status from tasks where subject ='Reg Session' order by lastmodifieddate desc limit 1) from contact where stunum__c in :stunum];
        
        for(Contact c :con)
        {
            String studentNumber = c.stunum__c;
            String status=NULL;
            
            if(c.tasks.size()>0){
                Task t = new Task();
                t=c.tasks;
                
                if(t.status!=NULL){
                    if(t.status=='Completed'){
                        status='Yes';
                    }
                    else if(t.status=='Pending'){
                        status='Pending';
                    }
                }
            }
            if(status!=NULL){
                rtnList.put(studentNumber, status);
            }
        }
        
        return rtnList;
    }
    
    private Map<String,String> getLastActivity(List<String> stunum){
        Map<String,String> result = new Map<String,String>();
        
        List<Contact> lastAction = [SELECT stunum__c, (SELECT Subject, ActivityDate FROM ActivityHistories order by lastmodifieddate desc limit 1) FROM Contact WHERE stunum__c in :stunum];
        
        for(Contact c :lastAction){
        
            if(c.ActivityHistories.size()>0){
                ActivityHistory a = c.ActivityHistories;
                
                if(a.subject!=NULL && a.ActivityDate!=NULL){
                    result.put(c.stunum__c, a.subject+' '+a.ActivityDate.format() );
                }
            }
        }
        
        return result;
    }
    
    private void getStudentIds(List<String> AppNos){
        List<Application__c> ListApp = [SELECT Application_Number__c, student__c FROM Application__c WHERE Application_Number__c!='' AND Application_Number__c = :AppNos];
        Map<String, Id> app = new Map<String, Id>();
        for(Application__c a :ListApp){
            app.put(a.Application_Number__c,a.student__c);
        }
    }
}