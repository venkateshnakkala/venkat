@isTest(seealldata=true)
public class TestApplicationPDFController { 
        string studentId{get;set;}
        string studentName{get;set;}
        string studentPhone{get;set;}
        string studentMailingStreet{get;set;}
        string studentMailingCity{get;set;}
        string studentMailingState{get;set;}
        Date studentBirthdate{get;set;}
        string studentMailingPostalCode{get;set;}
        string studentEmail{get;set;}
        string studentMailingCountry{get;set;}
        string studentSSN{get;set;}
        string studentCountry_of_Citizenship{get;set;}      
        string studentAlien_Registration_Number{get;set;}
        string studentCitizenship_Status{get;set;}
        string studentVisa_Type{get;set;}
        string studentVisa_School_Name{get;set;}
        string studentVisa_School_Address{get;set;}         
        string studentVisa_School_City{get;set;}
        string studentVisa_School_State{get;set;}
        string studentVisa_School_Country{get;set;}
        Date studentVisa_Expiration_Date{get;set;}
        boolean studentEligible_For_Military_Benefits{get;set;}
        string studentAffiliation{get;set;}
        public string studentMilitary_Branch{get;set;}
        public boolean studentAuthorize{get;set;}
        public Date studentStart_Date_of_Service{get;set;}
        public Date studentEnd_Date_of_Service{get;set;}
        public boolean studentCertificate_or_NOBE{get;set;}
        public string studentGender{get;set;}
        public string studentEthnicity{get;set;}
        public string studentNationality{get;set;}
        public String b_studentEligible_For_Military_Benefits{get;set;}
    
    @isTest
    public static void testPDF() {
        /*
        Contact testStudent = new Contact(
            FirstName = 'Bob',
            LastName = 'Jones',
            Phone = '654-654-6548',           
            Email = 'test@mail.com'
        );
        insert testStudent;
        Application__c testApp = new Application__c(
            student__c = testStudent.Id           
        ); 
        insert testApp;
        Contact emCont = new Contact(
            LastName = 'Jones',
            FirstName = 'Jack',
            Email= 'emcon@mail.com'
        );
        insert emCont;
        */
        Application__c app = [select id, student__c from application__c limit 1];
        string appId = string.valueof(app.Id);        
        string studentId = string.valueof(app.student__c);
        string emContId = string.valueOf(app.student__c);

        PageReference pref = Page.ApplicationPDF;
        pref.getParameters().put('sId', studentId);
        pref.getParameters().put('aId', appId);
        pref.getParameters().put('eId', studentId);
        Test.setCurrentPageReference(pref);
                
        Test.startTest();
        ApplicationPDFController applicationPDF = new ApplicationPDFController(); 
        applicationPDF.getToday();
        applicationPDF.getStudentBirthdate();
        applicationPDF.getLocation();
        applicationPDF.getAgeUnder24();
        applicationPDF.getStudentVatETS();
        applicationPDF.getData();
        
       // ApplicationPDFController.getStudentAuthorize();
        ApplicationPDFController.getstudentVisa_Expiration_Date();
        ApplicationPDFController.parentName='test';
        ApplicationPDFController.parentEmail='testuser@123.com';
        ApplicationPDFController.parentPhone='12345678888';
        ApplicationPDFController.getStudentEligible_For_Military_Benefits();
     //   ApplicationPDFController.getStudentCertificate_or_NOBE();
        ApplicationPDFController.getAcademic_Misconduct();
        ApplicationPDFController.getCollege_1_Graduation_Date();
        ApplicationPDFController.getCollege_2_Graduation_Date();
        ApplicationPDFController.getCriminal_History();
        ApplicationPDFController.getDisability_Accomodations();
        ApplicationPDFController.getHS_Graduation_Date();
     //   ApplicationPDFController.getPreferred_Start_Date();
        
        Test.stopTest();
    }
}