@isTest
public class ScanQrTest {
    
    static testMethod void ScanQrTest_1() {
   
       Contact testStudent = new Contact(
        FirstName = 'Bob',
        LastName = 'Jones',
        Phone = '654-654-6548',
        OtherPhone = '654-987-6548',
        MailingStreet = '123 main',
        MailingCity = 'Waukesha',
        MailingState = 'WI',
        //Birthdate = 1986/01/01,
        MailingPostalCode = '53186',
        Email = 'test@mail.com',
        MailingCountry = 'United States',
        SSN__c = '321-65-9874',
        Country_of_Citizenship__c = 'Jamaica',
        Alien_Registration_Number__c = '65',
        Citizenship_Status__c = 'test',
        Visa_Type__c= 'test',
        Visa_School_Name__c= 'test',
        Visa_School_Address__c= 'test',
        Visa_School_City__c= 'test',
        Visa_School_State__c= 'test',
        Visa_School_Country__c= 'test',
        //Visa_Expiration_Date__c= 'test',
        Eligible_For_Military_Benefits__c = true,
        Affiliation__c = 'test',
        Military_Branch__c = 'test',
        Authorize__c = true,
        //Start_Date_of_Service__c = '1986/01/01',
        //End_Date_of_Service__c = '1986/01/01',
        Certificate_or_NOBE__c= true,
        Gender__c = 'test',
        Ethnicity__c = 'test',
        Nationality__c = 'test',
        Student_Info_Complete__c = true
    );
    insert testStudent;
             test.startTest();
            Test.setMock(HttpCalloutMock.class, new WebMock());

        PageReference pageRef = Page.StudentQrCodeInfo;
        Test.setCurrentPage(pageRef);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(testStudent);
        ApexPages.currentPage().getParameters().put('Id',testStudent.id);

          ScanQr ec = new ScanQr (sc);
		test.stoptest();
    }

}