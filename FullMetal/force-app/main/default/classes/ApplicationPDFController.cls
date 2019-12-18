public with sharing class ApplicationPDFController {
    
    public string getToday(){
        DateTime today = DateTime.now();
        DateTime local = today-(1/3.0);
        return local.format('M/d/Y');
    }
    
    //student data
    public static string studentId{get;set;}
    public static string studentName{get;set;}
    public static string studentPhone{get;set;}
    public static string studentOtherPhone{get;set;}
    public static string studentMailingStreet{get;set;}
    public static string studentMailingCity{get;set;}
    public static string studentMailingState{get;set;}
    public static Date studentBirthdate{private get; set;}
    
    public string getStudentBirthdate(){
        string rtn;
        
        if(studentBirthdate!=null)
            rtn=studentBirthdate.format();
        else
            rtn=null;
        return rtn;
    }
    
    public static string studentMailingPostalCode{get;set;}
    public static string studentEmail{get;set;}
    public static string studentMailingCountry{get;set;}
    public static string studentSSN{get;set;}
    public static string studentCountry_of_Citizenship{get;set;}      
    public static string studentAlien_Registration_Number{get;set;}
    public static string studentCitizenship_Status{get;set;}
    public static string studentVisa_Type{get;set;}
    public static string studentVisa_School_Name{get;set;}
    public static string studentVisa_School_Address{get;set;}         
    public static string studentVisa_School_City{get;set;}
    public static string studentVisa_School_State{get;set;}
    public static string studentVisa_School_Zip{get;set;}
    public static string studentVisa_School_Country{get;set;}
    public static Date studentVisa_Expiration_Date{private get;set;}
    
    public static string studentReferral_First_Name{get;set;}
    public static string studentReferral_Last_Name{ get;set;}
    public static string studentReferral_Email{ get;set;}
    public static string studentReferral_Phone{ get;set;}
    
    public static string studentGender{get;set;}
    public static string studentEthnicity{get;set;}
    public static string studentNationality{get;set;}
    
    public static string getstudentVisa_Expiration_Date(){
        string rtn;
        
        if(studentVisa_Expiration_Date==null)
            rtn = null;
        else
            rtn=studentVisa_Expiration_Date.format();
        
        return rtn;
    }
    
    public static boolean studentEligible_For_Military_Benefits{private get;set;}
    
    public static string getStudentEligible_For_Military_Benefits(){
        string rtn;
        if(studentEligible_For_Military_Benefits == TRUE ) {
            rtn='Yes';
        }
        else {
            rtn='No';
        }
        // rtn = studentEligible_For_Military_Benefits == TRUE ? 'Yes' : 'No';
        return rtn;
    }
    
    public static string b_studentEligible_For_Military_Benefits{get {return (studentEligible_For_Military_Benefits==true)?'Yes':'No';}}
    public static string studentAffiliation{get;set;}
    public static string studentMilitary_Branch{get;set;}
    public static String studentAuthorize{ get;set;}
    
   /* public static string getStudentAuthorize(){
        string rtn;
        if(studentAuthorize==null)
            rtn=null;
        else
            rtn=(studentAuthorize==true)?'Yes':'No';
        
        return rtn;
    }
    //*/
    public static Date studentStart_Date_of_Service{get;set;}
    public static Date studentEnd_Date_of_Service{get;set;}
    public static String studentCertificate_or_NOBE{ get;set;}
    
   /* public static string getStudentCertificate_or_NOBE(){
        string rtn;
        if(studentCertificate_or_NOBE==true)
            rtn='Yes';
        else
            rtn='No';
        return rtn;
    }
    //*/
      //application data
    public static string applicationId{get;set;}  
    public static string applicationId1{get;set;}  
    public static boolean Academic_Misconduct{private get;set;}
    
    public static string getAcademic_Misconduct(){
        string rtn;
        if(Academic_Misconduct==true){
            rtn=Academic_Misconduct_Explanation;
        }
        else {
            rtn='No';
        }
        
        return rtn;
    }
    
    public static string Academic_Misconduct_Explanation{get;set;}
    public static string College_1_Degree{get;set;}
    public static date College_1_Graduation_Date{private get;set;}
    
    public static string getCollege_1_Graduation_Date(){
        string rtn='';
        if(College_1_Graduation_Date!=NULL){
            rtn=College_1_Graduation_Date.format();
        }
        return rtn;
    }
    
    public static string College_1_Name{get;set;}
    public static string College_2_Degree{get;set;}
    public static date College_2_Graduation_Date{private get;set;}
    
    public static string getCollege_2_Graduation_Date(){
        String rtn='';
        if(College_2_Graduation_Date!=NULL){
            rtn=College_2_Graduation_Date.format();
        }
        return rtn;
    }
    
    public static string College_2_Name{get;set;}
    public static string College_Notes{get;set;}
    public static boolean Criminal_History{private get;set;}
    
    public static string getCriminal_History(){
        string rtn;
        if(Criminal_History==true){
            rtn=Criminal_History_Explanation;
        }
        else {
            rtn='No';
        }
        
        return rtn;
    }
    
    public static string Criminal_History_Explanation{get;set;}
    public static string HS_Degree_Received{get;set;}
    public static boolean Disability_Accomodations{private get;set;}
    public static string Disability_Explanation{get;set;}
    
    public static string getDisability_Accomodations(){
        string rtn;
        if(Disability_Accomodations==true){
            rtn=Disability_Explanation;
        }
        else {
            rtn='No';
        }
        return rtn;
    }
    
    public static date Expected_Start_Date{get;set;}
    public static date Graduation_Date{get;set;}
    public static date HS_Graduation_Date{set; private get;}
    
    public static string getHS_Graduation_Date(){
        string rtn;
        if(HS_Graduation_Date==null)
            rtn=null;
        else
            rtn=HS_Graduation_Date.format();
        return rtn;
    }
    
    public static string High_School_Address{get;set;}
    public static string High_School_Address_2{get;set;}
    public static string High_School_City{get;set;}
    public static string High_School_Name{get;set;}
    public static string High_School_State{get;set;}
    public static string High_School_Zip{get;set;}
    public static string High_School_Country{get;set;}
    public static String Preferred_Start_Date{ get;set;}
   /* 
    public static string getPreferred_Start_Date(){
        string rtn;
        if(Preferred_Start_Date!=null)
            rtn=Preferred_Start_Date.format();
        else
            rtn=null;
        
        return rtn;
    }
    //*/
    public static string Program{get;set;}
    public string ProgramCode{get;set;}
    
    public string getLocation(){
        string rtn;
        if(ProgramCode==null || ProgramCode.length()<2){
            rtn=null;
        }
        else {
            string code=ProgramCode.substring(ProgramCode.length()-2,ProgramCode.length());
            
            if(code=='-O'){
                rtn='Online';
            }
            else{
                rtn='On-Campus';
            }
        }
        return rtn;
    }
    
    public static string Short_Essay{set; get;}
    
    public static string Term{get;set;}
    public static string Transcript_Request{get;set;}
    
    //public static Id studentSignature {get; private set;}
    //emergency contact info
    public static string emContId{get;set;}
    public static string emContactName{get;set;}
    public static string emContactPhone{get;set;}
    public static string emContactRelation{get;set;}
    //parent contact info
    public static string parentName{get; private set;}
    public static string parentEmail{get; private set;}
    public static string parentPhone{get; private set;}
    
    public string getAgeUnder24(){
        String rtn;
        if(studentBirthdate==null){
            rtn=null;
        }
        else 
        {
            Integer age = studentBirthdate.daysBetween(date.ValueOf(datetime.now()-(1/3.0)))/365;
            
            if(age<24){
                rtn='Yes';
            }
            else{
                rtn='No';
            }
        }
        return rtn;
    }
    
    private date studentVatETS{get;set;}
    
    public string getStudentVatETS(){
        string rtn;
        
        if(studentVatETS==null)
            rtn=null;
        else
            rtn=studentVatETS.format();
        return rtn;
    }
    
    public string StudentAdmRep{get; private set;}
    
    public PageReference getData(){
        this.constructor();
        return null;
    }
    
    public ApplicationPDFController(){
        this.constructor();
    }
    
    public void constructor(){
        applicationId = apexpages.currentpage().getparameters().get('aId');
        System.debug('applicationIdasfsaf=='+applicationId);
        //if(applicationId != Null){
        System.debug('applicationId=='+applicationId);
        List<Application__c> appList = new List<Application__c>();
        Application__c app = new Application__c();
        appList =[Select id,student__r.id, Emergency_Contact__c,Parent__c, Name,Academic_Misconduct__c,Academic_Misconduct_Explanation__c,College_1_Degree__c,College_1_Graduation_Date__c,College_1_Name__c,College_2_Degree__c,
                  College_2_Graduation_Date__c,College_2_Name__c,College_Notes__c,Criminal_History__c,Criminal_History_Explanation__c,HS_Degree_Received__c,Disability_Accomodations__c,
                  Disability_Explanation__c,Expected_Start_Date__c,Graduation_Date__c,HS_Graduation_Date__c,High_School_Address__c,High_School_Address_2__c,High_School_City__c,
                  High_School_Name__c,High_School_State__c,High_School_Zip__c,High_School_Country__c,Preferred_Start_Period__c, Program__c, Program_Code__c,Short_Essay__c,Term__c,
                  Transcript_Request__c, Addmission_Representative__c,Military_Branch__c,
                  New_SSN__c,Country_of_Citizenship__c,Alien_Registration_Number__c,Citizenship_Status__c,
                  Visa_Type__c,Visa_School_Name__c,Visa_School_Address__c,Visa_School_City__c,Visa_School_State__c,Visa_School_Zip__c,
                  Visa_School_Country__c,Visa_Expiration_Date__c,Eligible_For_Military_Benefits__c,Affiliation__c,
                  Authorize__c,Certificate_or_NOBE__c,Start_Date_of_Service__c,End_Date_of_Service__c,ETS_EAS__c,
                  Referral_First_Name__c,Referral_Last_Name__c,Referral_Email__c,Referral_Phone__c
                  FROM Application__c WHERE Id =: applicationId];
        if(!appList.isempty())
        {
            app=appList[0];
            System.debug('pdf Student:-\n' + JSON.serialize( app ) );
            studentId = app.student__r.id;
            System.debug('pdf Student id:-\n'  +studentId  );
            emContId = app.Emergency_Contact__c;
            
            Id parentId = app.Parent__c;
            
            Contact student = [SELECT id, accountid, Name,FirstName,LastName,Phone,OtherPhone,MailingStreet,
                               MailingCity,MailingState,Birthdate,MailingPostalCode,Email,MailingCountry,
                               Citizenship_Code__c,SSN__c,Country_of_Citizenship__c,
                               Alien_Registration_Number__c,Citizenship_Status__c,
                               Visa_Type__c,Visa_School_Name__c,Visa_School_Address__c,
                               Visa_School_City__c,Visa_School_State__c,Visa_School_Zip__c,Visa_School_Country__c,
                               Visa_Expiration_Date__c,Eligible_For_Military_Benefits__c,
                               Affiliation__c,Military_Branch__c,Authorize__c,Expected_Start_Date__c,
                               Start_Date_of_Service__c,End_Date_of_Service__c,ETS_EAS__c,Certificate_or_NOBE__c,
                               Nationality__c, Ethnicity__c, Gender__c
                               FROM Contact WHERE Id =:studentId];
            System.debug('pdf Student id:-\n' + student.Nationality__c  );
			System.debug('pdf Student:-\n' + JSON.serialize( student ) );            
            List<Contact> temp2 = [select id, firstname, lastname, email, phone from contact where id=:parentId];
            List<Contact> parent = new List<Contact>();
            if(temp2.size()>0){
                parent = [select id, firstname, lastname, email, phone from contact where accountid=:student.accountid and recordtype.name='Parent' order by CreatedDate  desc limit 1];
            }
            
            if(parent!=null && parent.size()>0){
                parentName=parent[0].firstname+' '+parent[0].lastname;
                parentPhone=parent[0].phone;
                parentEmail=parent[0].email;
            }
            
            studentName = student.Name;
            studentPhone = student.Phone;
            studentOtherPhone = student.OtherPhone;
            studentMailingStreet = student.MailingStreet;
            studentMailingCity = student.MailingCity;
            studentMailingState = student.MailingState;
            studentBirthdate = student.Birthdate;
            studentMailingPostalCode = student.MailingPostalCode;
            studentEmail = student.Email;
            studentMailingCountry = student.MailingCountry;
            
            studentNationality = student.Nationality__c;
			studentEthnicity = student.Ethnicity__c;
			studentGender = student.Gender__c;
            system.debug('==studentNationality=='+studentNationality);
            system.debug('==studentEthnicity=='+studentEthnicity);
            system.debug('==studentGender=='+studentGender);
            StudentAdmRep = app.Addmission_Representative__c;
            Academic_Misconduct = app.Academic_Misconduct__c;
            Academic_Misconduct_Explanation = app.Academic_Misconduct_Explanation__c;
            College_1_Degree = app.College_1_Degree__c;
            College_1_Graduation_Date = app.College_1_Graduation_Date__c;
            College_1_Name = app.College_1_Name__c;
            College_2_Degree = app.College_2_Degree__c;
            College_2_Graduation_Date = app.College_2_Graduation_Date__c;
            College_2_Name = app.College_2_Name__c;
            College_Notes = app.College_Notes__c;
            Criminal_History = app.Criminal_History__c;
            Criminal_History_Explanation = app.Criminal_History_Explanation__c;
            HS_Degree_Received = app.HS_Degree_Received__c;
            Disability_Accomodations = app.Disability_Accomodations__c;
            Disability_Explanation = app.Disability_Explanation__c;
            Expected_Start_Date = app.Expected_Start_Date__c;
            Graduation_Date = app.Graduation_Date__c;
            HS_Graduation_Date = app.HS_Graduation_Date__c;
            High_School_Address = app.High_School_Address__c;
            High_School_Address_2 = app.High_School_Address_2__c;
            High_School_City = app.High_School_City__c;
            High_School_Name= app.High_School_Name__c;
            High_School_State = app.High_School_State__c;
            High_School_Zip = app.High_School_Zip__c;
            High_School_Country = app.High_School_Country__c;
            Short_Essay = app.Short_Essay__c;
            
            Program = app.Program__c;
            ProgramCode = app.Program_Code__c;
            Term = app.Term__c;
            Transcript_Request = app.Transcript_Request__c;
            
            if(ApexPages.currentPage().getParameters().containsKey('ssn') && ApexPages.currentPage().getParameters().get('ssn')!='' && ApexPages.currentPage().getParameters().get('ssn')!=NULL)
                studentSSN=ApexPages.currentPage().getParameters().get('ssn');
            else
                studentSSN = app.New_SSN__c;
            
            studentCountry_of_Citizenship = app.Country_of_Citizenship__c;      
            studentAlien_Registration_Number = app.Alien_Registration_Number__c;
            studentCitizenship_Status = app.Citizenship_Status__c;
            studentVisa_Type = app.Visa_Type__c;
            studentVisa_School_Name = app.Visa_School_Name__c;
            studentVisa_School_Address = app.Visa_School_Address__c;        
            studentVisa_School_City = app.Visa_School_City__c;
            studentVisa_School_State = app.Visa_School_State__c;
            studentVisa_School_Country = app.Visa_School_Country__c;
            studentVisa_School_Zip = app.Visa_School_Zip__c;
            studentVisa_Expiration_Date = app.Visa_Expiration_Date__c;
            studentEligible_For_Military_Benefits = app.Eligible_For_Military_Benefits__c;
            studentAffiliation = app.Affiliation__c;
            studentMilitary_Branch = app.Military_Branch__c;
            studentAuthorize = app.Authorize__c;
            studentStart_Date_of_Service = app.Start_Date_of_Service__c;
            studentEnd_Date_of_Service = app.End_Date_of_Service__c;
            studentCertificate_or_NOBE = app.Certificate_or_NOBE__c;
            Preferred_Start_Date = app.Preferred_Start_Period__c;
			studentVatETS = app.ETS_EAS__c;
            
            studentReferral_First_Name = app.Referral_First_Name__c;
            studentReferral_Last_Name = app.Referral_Last_Name__c;
            studentReferral_Email = app.Referral_Email__c;
            studentReferral_Phone = app.Referral_Phone__c;
            
            List<Contact> temp1 = [Select Emergency_First_Name__c, Emergency_Last_Name__c, Emergency_Contact_Phone__c,
                                    Gender__c,Ethnicity__c,Nationality__c,Emergency_Relationship__c FROM Contact WHERE Id =:studentId];
            Contact emCont = new Contact();
            if(temp1.size()>0){
                emCont = temp1[0];
            }
            
            emContactName = emCont.Emergency_First_Name__c+' '+emCont.Emergency_Last_Name__c;
            emContactPhone = emCont.Emergency_Contact_Phone__c;
            emContactRelation = emCont.Emergency_Relationship__c;
            
           
        }
    }
     
}