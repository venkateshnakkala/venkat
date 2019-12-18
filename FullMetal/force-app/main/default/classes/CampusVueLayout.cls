public class CampusVueLayout{
    private final Contact CurrentRecord;
    private AsyncWSCVSF.AsyncLAFSPort port;
    private AsyncWSCVSF.CVAPI_getDataResponseTypeFuture ResultSet{get;set;}
    private AsyncWSCVSF.CVAPI_getDataResponseTypeFuture AttendanceSet{get;set;}
    private AsyncWSCVSF.CVAPI_getDataResponseTypeFuture HoldSet{get;set;}
    
    private List<HoldData> HoldRows{get;set;}
    
    public String Hold{get;set;}
    
    public Map<String,AttRow> Attendance{get; private set;}
    public integer AttSize{get;private set;}
    public DataRow DataSet {get;private set;}
    public List<DataAttend> AttendSet {get;private set;}

    public Id ThisId{get;set;}
    public String StuNum{get;set;}
    public String SyStudentId{get;set;}
    
    public CampusVueLayout(){
        this.ThisId=NULL;
    }
    
    public integer size {get; set;}
    
    public class DataRow{
        public String SchoolStatus{get;set;}
        public Decimal CumGPA{get;set;}
        public String Program{get;set;}
    }
    
    public class DataAttend{
        public String year {get;set;}
        public String month {get;set;}
        public Integer week {get;set;}
        public Integer attend {get;set;}
        public Integer absent {get;set;}
        public Double total {get; set;}
    }
    
    public class AttRow{
        public String week{get;private set;}
        public String attend{get;private set;}
        public String absent{get;private set;}
        public Double total{get;private set;}
        
        public void Week(String value){
            if(value==NULL)
                return;
            if(this.week==NULL){
                this.week=value;
            }
            else {
                this.week+=','+String.valueof(value);
            }
        }
        
        public void Attend(Integer value){
            if(value==NULL)
                return;
            if(this.attend==NULL){
                this.attend=String.valueof(value);
            }
            else {
                this.attend+=','+String.valueof(value);
            }
        }
        
        public void Absent(Integer value){
            if(value==NULL)
                return;
            if(this.absent==NULL){
                this.absent=String.valueof(value);
            }
            else {
                this.absent+=','+String.valueof(value);
            }
        }
        
        public void Total(Double value){
            if(value==NULL)
                this.total=0;
            if(this.total==NULL){
                this.total=value;
            }
            else {
                this.total+=value;
            }
        }
    }
    
    public class HoldData{
        Public String hold{get;set;}
    }
    
    public CampusVueLayout(ApexPages.StandardController controller){
        this.CurrentRecord= (Contact)controller.getRecord();
        this.ThisId=CurrentRecord.id;
        this.AttSize=0;
        if(this.ThisId==NULL)
            return;
        Contact C=[Select StuNum__c, SyStudentId__c FROM Contact where id=:this.ThisId];
        this.StuNum=c.StuNum__c;
        this.SyStudentId=c.SyStudentId__c;
        this.DataSet=NULL;
        this.ResultSet=NULL;
        
        this.Attendance = new Map<String,AttRow>();
        port = new AsyncWSCVSF.AsyncLAFSPort();
    }
    
    public Continuation getData(){
        Continuation con = new Continuation(90);
        if(this.StuNum==NULL)
            return con;
        con.continuationMethod='readData';
        con.timeout=120;
        
        String sqlText='select t.Descrip SchoolStatus, cast(round(CumGPA,2,2) as float) CumGPA, p.Descrip program from systudent s inner join SySchoolStatus t ';
               sqlText+='on (s.SySchoolStatusID=t.SySchoolStatusID) left join AdProgram p on (s.AdProgramId=p.AdProgramId) where syStudentId='+this.SyStudentId;
    
        this.ResultSet= port.beginCVAPI_getData(con,sqlText);
        
        String sql='select substring(cast(year as varchar),3,2) year, isnull(month,\'tot\') month, week, attend, absent, round(cast(sum(total)/60.0 as float),4,2) total ';
               sql+='from (select year(m.date) year, convert(char(3),datename(M,m.date)) month, month(m.date) m, datepart(day, datediff(day, 0, m.Date)/7 * 7)/7 + 1 week, ';
               sql+='case when m.Attend>0 then day(m.Date) else null end attend, case when m.Attend=0 then day(m.Date) else null end absent, sum(m.Attend) total from ';
               sql+='(select e.SyStudentId, cast(a.date as date) date, a.Attend from AdEnroll e inner join AdAttend a on (a.AdEnrollID=e.AdEnrollID)) m inner join ';
               sql+='(select e.SyStudentId, cast(dateadd(dd,-1*datepart(dw,max(a.date))-27,max(a.date))as date) first, cast(dateadd(dd,-1*datepart(dw,max(a.date))+7,max(a.date))as date) last ';
               sql+='from AdEnroll e inner join AdAttend a on (a.AdEnrollID=e.AdEnrollID) where e.SyStudentId='+this.SyStudentId+' group by e.SyStudentId)x on (x.SyStudentId=m.SyStudentId ';
               sql+='and m.date>=x.first and m.date<=x.last) group by year(m.date), month(m.Date), datepart(day, datediff(day, 0, m.Date)/7 * 7)/7 + 1, m.Attend, m.Date)m ';
               sql+='group by grouping sets((year, month, m.m, week, attend, absent),()) order by year desc, m.m desc, week desc, attend, absent';
          
          
        this.AttendanceSet = port.beginCVAPI_getData(con,sql);
        
        String HoldSQL='select g.descrip hold from SyStudGrp t inner join SyGroups g on t.sygroupsid = g.sygroupsid inner join SyHold h ';
               HoldSQL+='on g.sygroupsid = h.sygroupsid where t.dateoff is null and t.systudentid='+this.SyStudentId+' group by g.descrip';
               
        this.HoldSet = port.beginCVAPI_getData(con,HoldSQL);

        return con;
    }
    
    public Object readData(){
        List<DataRow> DataSet;
        DataSet=(List<DataRow>)JSON.deserialize(resultSet.getValue(),List<DataRow>.class);
        this.DataSet=DataSet.get(0);
        this.AttendSet=(List<DataAttend>)JSON.deserialize(AttendanceSet.getValue(),List<DataAttend>.class);
        this.createAttendance();
        
        this.HoldRows=(List<HoldData>)JSON.deserialize(HoldSet.getValue(),List<HoldData>.class);
        
        for(HoldData H :this.HoldRows){
            if(this.Hold==NULL)
                this.Hold=H.Hold;
            else
                This.Hold+=', '+H.Hold;
        }
        return NULL;
    }
    
    public Object createAttendance(){
        
        for(DataAttend row :AttendSet){
            String Key;
            if(row.month=='tot'){
                Key='Total';
            }
            else {
                Key=row.month+' '+row.year+', Week '+row.week;
            }
            
            AttRow Cell;
            
            if(this.Attendance.ContainsKey(Key)){
                Cell = this.Attendance.get(key);
                Cell.attend(row.attend);
                Cell.absent(row.absent);
                cell.total(row.total);
            }
            else {
                Cell = new AttRow();
                Cell.week(Key);
                Cell.attend(row.attend);
                Cell.absent(row.absent);
                Cell.total(row.total);
                this.Attendance.put(Key,Cell); 
                this.AttSize+=1;
            }
        }
        return NULL;
    }
}