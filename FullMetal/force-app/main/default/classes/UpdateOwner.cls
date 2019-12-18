global class UpdateOwner implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful
{
    private List<Id> ids {get;set;}
    
    public UpdateOwner(List<Id> updateIds){
        this.Ids=updateIds;
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator([select Id, owner.email, SyStudentId__c from contact where Id in:ids and SyStudentId__c!=NULL]);
    }
    
    public void execute(Database.BatchableContext BC, List<Contact> con)
    {
        for(Contact c :con){
            UpdateOwner(c);
        }
    }
    
    public void finish(Database.BatchableContext BC){}

    public void UpdateOwner(Contact c)
    {
        try
        {
            if(Test.isRunningTest()){
                 Test.setMock(WebServiceMock.class, new CVAPI_Test.CV_Foundation_Impl());
            }
                 
            CVAPI API= new CVAPI();
            
            Integer SyStudentId = Integer.valueOf(c.SyStudentId__c);
            
            CV_Student_Definition.GetStudentOutMsg student = new CV_Student_Definition.GetStudentOutMsg();
            student = API.getStudentInfo(SyStudentId);
            
            if(student!=NULL && (student.SchoolStatusId==56 || student.SchoolStatusId==12)){
                throw new CVAPI.newException('This student has Denied status in Campus!');
            }
            
            if(Test.isRunningTest()){
                student = new CV_Student_Definition.GetStudentOutMsg();
            }
            
            CV_Student_Definition.UpdateStudentLeadInMsg NewStudent = new CV_Student_Definition.UpdateStudentLeadInMsg();
            
            NewStudent.StudentId=SyStudentId;
            NewStudent.UpdateFields = new List<CV_Student_Definition.UpdateField>();
            
            Integer adminId=API.getAdminRep(c.owner.email);

            if(adminId>0){
                NewStudent.UpdateFields.add(new CV_Student_Definition.UpdateField('AdmissionsOfficerId',String.ValueOf(adminId)));
                API.updateStudentInfo(NewStudent);
            }
        }
        catch(Exception e){
            throw e;
        }
    }
}