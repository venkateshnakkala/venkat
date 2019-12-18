@isTest(SeeAllData=True)
public class uplodersRequestController_Test {
    static testMethod void test()
    {
        test.startTest();
        Application__c c = [select id,Contact_Email__c from Application__c limit 1];
        
        ApexPages.StandardController sc = new ApexPages.StandardController(c);
        uplodersRequestController t = new uplodersRequestController(sc); 
      //  uplodersRequestController.picklistClass testWrap=new uplodersRequestController.picklistClass(); 
        List<uplodersRequestController.picklistClass> dc =new List<uplodersRequestController.picklistClass>();
      
        //ApexPages.currentPage().getParameters().put('testWrap',testWrap);
        String [] Docs = new String []{'HS Diploma', 'College Transcript', 'Computer Specs', 'Parents Photo ID','Master Promissory Note','Entrance Counseling','PLUS Master Promissory Note','Parent Tax Return 2017','Parent Tax Transcripts 2016','Spouse Tax Return 2017','Spouse Tax Transcript 2016','Student Tax Return 2017','Student Tax Transcripts 2016','I20','I539','I94','Passport','TOEFL','US Visa','Bank Statement','DD214','CCAF','W-2 Form','ISIR C-Code 030 Selective Service','ISIR C-Code 146 Citizenship','Default Resolution Letter','Dependency Override Statement','Legal Guardianship Document','Ward of Court Document'};
            for(String st :Docs){
                uplodersRequestController.picklistClass testWrap=new uplodersRequestController.picklistClass(); 
                testWrap.picklistString=st;
                testWrap.selected=True;
                testWrap.Accepted=False;
                testWrap.Rejected=False;
                t.Request(testWrap);
               // t.save();
                
            }
         for(String st :Docs){
                uplodersRequestController.picklistClass testWrap=new uplodersRequestController.picklistClass(); 
                testWrap.picklistString=st;
                testWrap.selected=False;
                testWrap.Accepted=True;
                testWrap.Rejected=False;
         		t.Accepted(testWrap);
              //  t.save();
                
            }
         for(String st :Docs){
                uplodersRequestController.picklistClass testWrap=new uplodersRequestController.picklistClass(); 
                testWrap.picklistString=st;
                testWrap.selected=False;
                testWrap.Accepted=False;
                testWrap.Rejected=True;
                t.Rejected(testWrap);
              //  t.save();
                
            }
        t.save();
        test.stopTest();
    }
}