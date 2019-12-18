@isTest(SeeAllData=true)
public class ApplicationControllerTest
{

    public class Response implements system.HttpCalloutMock {
        
        public HttpResponse respond(HttpRequest req) 
        {
            HttpResponse res = new HttpResponse();
            res.setBody('<?xml version="1.0" encoding="utf-16"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" '+
                        'xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">'+
                        '<soapenv:Body><ns1:leadAddResponse soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" xmlns:ns1="http://listloader.system.intelliqueue"> '+
                        '<leadAddReturn xsi:type="xsd:string">&lt;?xml version="1.0" encoding="UTF-8"?&gt; &lt;response&gt; &lt;status&gt;OK&lt;/status&gt; '+
                        '&lt;message&gt;&lt;![CDATA[Element LEAD_ADD.METADATA.SECURITY_KEY.XMLTEXT is undefined in XML.]]&gt;&lt;/message&gt; '+
                        '&lt;detail/&gt; &lt;list_id&gt;0&lt;/list_id&gt; &lt;failures&gt; &lt;/failures&gt; &lt;accepted&gt; &lt;/accepted&gt; '+
                        '&lt;/response&gt;</leadAddReturn> </ns1:leadAddResponse> '+
                        '<ns1:leadRemoveResponse soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" xmlns:ns1="http://listloader.system.intelliqueue"> '+
                        '<leadRemoveReturn xsi:type="xsd:string">&lt;?xml version="1.0" encoding="UTF-8"?&gt; &lt;response&gt; &lt;status&gt;OK&lt;/status&gt; '+
                        '&lt;message&gt;&lt;![CDATA[Element LEAD_ADD.METADATA.SECURITY_KEY.XMLTEXT is undefined in XML.]]&gt;&lt;/message&gt; '+
                        '&lt;detail/&gt; &lt;list_id&gt;0&lt;/list_id&gt; &lt;failures&gt; &lt;/failures&gt; &lt;accepted&gt; &lt;/accepted&gt; '+
                        '&lt;/response&gt;</leadRemoveReturn> </ns1:leadRemoveResponse> </soapenv:Body></soapenv:Envelope>');
            res.setStatusCode(200);
            res.setStatus('OK');
            return res;
        }
    }
    
    static testMethod void test1() 
    {
        Test.setMock(HttpCalloutMock.class, new Response());
        try {
            String[] toAddresses = new String[] {'iaraia@lafilm.edu','dcuevas@lafilm.edu','jkottahachchige@lafilm.edu'};
            List<User> uuu =[SELECT Id,Email FROM User WHERE Email IN :toAddresses];
                
            for(User x: uuu){
                x.email='123'+x.email;
            }
            update uuu;
            ApplicationController.emailErrors('test','test');
            
            Map<String,String> toAddress2 = new Map<String,String>();
            toAddress2.put('123iaraia@lafilm.edu','iaraia@lafilm.edu');
            toAddress2.put('123dcuevas@lafilm.edu','dcuevas@lafilm.edu');
            toAddress2.put('123jkottahachchige@lafilm.edu','jkottahachchige@lafilm.edu');
            toAddress2.put('123tp.deshpande07@gmail.com','tp.deshpande07@gmail.com');
            
            List<User> uu =[SELECT Id,Email FROM User WHERE Email IN :toAddress2.keySet()];
                
            for(User x: uu){
                x.email=toAddress2.get(x.email);
            }
            update uu;
            ApplicationController.emailErrors('test','test');
            
            User uuuu = [select id, username, email, contactid from user where usertype like '%guest%' and isActive=true limit 1];
            system.runAs(uuuu){
                User ss =[select id, firstname, lastname, email, phone from user where isActive=true limit 1];
                Map<String,String> o = new Map<String,String>();
                o.put('email',ss.email);
                o.put('firstname',ss.firstname);
                o.put('lastname',ss.lastname);
                o.put('phone',ss.phone);
                ApplicationController.checkIfUserAlreadyExists(o);
                
                contact x = new contact();
                x.email='abcd@abcd.abcd';
                x.firstname='abcd';
                x.lastname='abcd';
                x.phone='123456789';
                insert x;
                o.put('email','abcd@abcd.abcd');
                o.put('firstname','abcd');
                o.put('lastname','abcd');
                o.put('phone','123456789');
                ApplicationController.checkIfUserAlreadyExists(o);
            }
            
            User u = [select id, username, email, contactid from user where profile.name='Application User' and isActive=true and contactid!=NULL limit 1];
            system.runAs(u){
                Test.StartTest();
                ApplicationController app = new ApplicationController();
                
                String leadId = ApplicationController.leadId;
                String attachId = app.attachId;
                String payLater = app.payLater;
                String pageSection = app.pageSection;
                String hsDiploma = app.hsDiploma;
                String collegeTranscript = app.collegeTranscript;
                String computerSpecs = app.computerSpecs;
                String parentsPhotoID = app.parentsPhotoID;
                String masterPromissoryNote = app.masterPromissoryNote;
                String i20 = app.i20;
                String i539 = app.i539;
                String i94 = app.i94;
                String passport = app.passport;
                String toefl = app.toefl;
                String usVisa = app.usVisa;
                String bankStatement = app.bankStatement;
                String dd214 = app.dd214;
                String ccaf = app.ccaf;
                String entranceCounseling = app.entranceCounseling;
                String plusMasterPromissoryNote = app.plusMasterPromissoryNote;
                String parentTaxReturn2017 = app.parentTaxReturn2017;
                String parentTaxTranscripts2016 = app.parentTaxTranscripts2016;
                String spouseTaxReturn2017 = app.spouseTaxReturn2017;
                String spouseTaxTranscript2016 = app.spouseTaxTranscript2016;
                String studentTaxReturn2017 = app.studentTaxReturn2017;
                String studentTaxTranscripts2016 = app.studentTaxTranscripts2016;
                String w2Form = app.w2Form;
                String ISIRCCode030 = app.ISIRCCode030;
                String ISIRCCode146 = app.ISIRCCode146;
                String defaultResolutionLetter = app.defaultResolutionLetter;
                String dependencyOverrideStatement = app.dependencyOverrideStatement;
                String legalGuardianshipDocument = app.legalGuardianshipDocument;
                String wardOfCourtDocument = app.wardOfCourtDocument;
               // app.getEchoSign();
                app.getSignCount();
                
                app.sectionName='test';
                app.applicantUserName='jfkdjf@fskfjs.com';
                app.applicantpassword='abcd1234';
                
                app.selecteduserId=u.id;
                PageReference pageRef = Page.Application;
                pageRef.getParameters().put('sId', '01');
                Test.setCurrentPage(pageRef);
                
                app = new ApplicationController();
                app.studentDetailsJSON='{}';
                app.under24String='test';
                app.saveStudentInfo();
                
                app.checkApplications();
                ApplicationController.emailErrors('test','test');
                
                User s =[select id, username from user where profile.name='Application User' and isactive=true limit 1];
                app.username=s.username;
                app.applicantUserName=s.username;
                app.password='abcd1234';
                app.loginToApplicationTanmay();
                app.forgotPasswordEmail=u.email;
                app.resetPassword();
                app.chkLogIn();
                ApplicationController.getStudentInfo();
                Contact c = [select id, owner.id from contact where id=:u.contactid];
                Application__c a = [select id from application__c limit 1];
                
                ApplicationController.repInfo(c.owner.id);
                app.representativeId=c.owner.id;
                Map<String,String> m = new Map<String,String>();
                //m.put('studentId',c.id);
                m.put('studentDOB','2016-01-01');
                m.put('applicationId',a.id);
                m.put('residentialStatus','I am an international student');
                m.put('visaExpirationDate','2016-01-01');
                m.put('qualifyForBenefits','Yes');
                ApplicationController.sendWelcomeEmail(u.id);
                app.loginToApplicationAfterResettingPassword();
                ApplicationController.studentInfo(m,false);
                
                User g = [select id, name, isactive from user where name like 'application Community Site Guest User' and isActive=true limit 1];
                System.runAs(g){
                    ApplicationController.studentInfo(m,false);
                }
                
                m.put('residentialStatus','I am a citizen of the United States');
                ApplicationController.studentInfo(m,false);
                
                m.put('residentialStatus','I am a legal resident of the United States');
                ApplicationController.studentInfo(m,false);
                
                Map<String,String> r = new Map<String,String>();
                
                ApplicationController.applicationId=a.id;
                r.put('applicationId',a.id);
                r.put('referFriendQuestion','yes');
                r.put('studentId',c.id);
                
                ApplicationController.referFriendInfo(r);
                
                List<SelectOption> l = app.UserList;
                List<String> l2 = app.StartDateOptions;
                ApplicationController.getDocusign((string)a.id);
                
                Map<String,String> ap = new Map<String,String>();
                ApplicationController.getApplicationInfo(ap);
                
                Contact n = new Contact();
                n.firstname='test';
                n.lastname='test';
                n.email='lkjsdkjfkdsjfljsdlfdfskfjlsdkjfsdl@fjdslkfjlksdjflskdjlfksj.eee';
                insert n;
                
                //ApplicationController.createApplicantUser(n.id,'abcd1234');
                
                Map<String,String> setApp = new Map<String,String>();
                setApp.put('studentId',n.id);
                setApp.put('password','abcd1234');
                ApplicationController.setApplicantPassword(setApp);
                
                Map<string, string> parentDetails = new Map<string, string>();
                parentDetails.put('studentId',n.id);
                parentDetails.put('studentParentLastName','jkfjdlks');
                parentDetails.put('studentParentFirstName','jkfjdlks');
                parentDetails.put('studentParentEmail','jkfjdlks@jhgjhghj.cuy');
                parentDetails.put('studentParentPhone','4562357895');
                ApplicationController.parentInfo(parentDetails);
                
                Map<string, string> emContDetails = new Map<string, string>();
                emContDetails.put('studentId',n.id);
                ApplicationController.emContInfo(emContDetails);
                
                Map<string, string> studentDetails = new Map<string, string>();
                studentDetails.put('prefStartPeriod','Jan 1 2016');
                studentDetails.put('studentId',n.id);
                ApplicationController.checkApplication(studentDetails, a.id);
                
                ApplicationController.createApplication(studentDetails, false, a.id);
                
                Map<string, string> programDetails = new Map<string, string>();
                programDetails.put('prefStartPeriod','Jan 01, 2010');
                programDetails.put('studentId',n.id);
                programDetails.put('applicationId',a.id);
                applicationController.programInfo(programDetails, false);
                
                Map<string, string> educationDetails = new Map<string, string>();
                educationDetails.put('graduationDate','2016-01-01');
                educationDetails.put('studentId',(string)c.id);
                educationDetails.put('applicationId',a.id);
                educationDetails.put('highSchoolName','fsdfsd');
                educationDetails.put('degreeReceived','fdsfsd');
                educationDetails.put('highSchoolCity','fsdfsd');
                educationDetails.put('highSchoolCountry','fsgwer');
                
                Test.StopTest();
            }
            
            user s = [select id from user where usertype='guest' and isActive=true and name like '%application%'];
            system.runAs(s){
                Map<String,String> m = new Map<String,String>();
                Application__c a = [select id, student__c from application__c limit 1];
                m.put('studentId',a.student__c);
                m.put('studentDOB','2016-01-01');
                m.put('applicationId',a.id);
                m.put('residentialStatus','I am an international student');
                m.put('visaExpirationDate','2016-01-01');
                m.put('qualifyForBenefits','Yes');
                
                ApplicationController.studentInfo(m,false);
                ApplicationController.savePayLater(a.id,true);
            }
         }
         catch(System.CalloutException e){
             e=NULL;
         }
        
    }

    static testMethod void test2() {
        Contact d = new Contact();
        d.lastname='test123';
        d.Program_Code__c='ASAP';
        insert d;
        
        Application__c a = new Application__c();
        a.student__c=d.id;
        a.program_code__c='ASAP';
        insert a;
        
        Map<String,String> pdf = new Map<String,String>();
        pdf.put('studentId',d.id);
        pdf.put('applicationId',a.id);
        pdf.put('gender', 'test');
        pdf.put('ethnicity', 'test');
        pdf.put('nationality', 'test');
        pdf.put('friendFirstName', 'test');
        pdf.put('friendLastName', 'test');
        pdf.put('friendEmail', 'test@kjfkjdsfkjsd.cof');
        pdf.put('friendPhone', '3235556666');
        pdf.put('shortEssay', 'test');
        
        ApplicationController.applicationFinalSubmit(pdf);
        ApplicationController.applicationFinalSubmitSave(pdf);
        
        Contact dd = new Contact();
        dd.lastname='test12345';
        dd.Program_Code__c='ASAP';
        insert dd;
        
        Application__c aa = new Application__c();
        aa.student__c=d.id;
        insert aa;
        
        Map<String,String> pdf2 = new Map<String,String>();
        pdf2.put('studentId',dd.id);
        pdf2.put('applicationId',aa.id);
        ApplicationController.savePdf(pdf2);
        
        ApplicationController.updateUploads('I539', a.id);
        ApplicationController.updateUploads('College Transcripts', a.id);
        ApplicationController.updateUploads('Photo Id', a.id);
        ApplicationController.updateUploads('Computer Specs', a.id);
        ApplicationController.updateUploads('High School Diploma', a.id);
        ApplicationController.updateUploads('CCAF', a.id);
        ApplicationController.updateUploads('DD-214', a.id);
        ApplicationController.updateUploads('Passport', a.id);
        ApplicationController.updateUploads('I-20', a.id);
        
        ApplicationController.updateUploads('US Visa', a.id);
        ApplicationController.updateUploads('I-94', a.id);
        ApplicationController.updateUploads('TOEFL Scores', a.id);
        ApplicationController.updateUploads('Bank Statements', a.id);
        
        Map<String,String> mm = new Map<String,String>();
        mm.put('attachmentBody','fkldsjfkljds');
        mm.put('attachmentName','test');
        mm.put('applicationId',a.id);
        
        String fileId=ApplicationController.doUploadAttachment(mm,'NULL');
        ApplicationController.doUploadAttachment(mm,fileId);
        
        Map<string, string> citizenDetails = new Map<string, string>();
        citizenDetails.put('studentId',d.id);
        citizenDetails.put('visaExpirationDate','2016-01-01');
        citizenDetails.put('residentialStatus','I am a citizen of the United States');
            
        ApplicationController.citizenInfo(citizenDetails );
        
        citizenDetails.put('residentialStatus','I am a legal resident of the United States');
            
        ApplicationController.citizenInfo(citizenDetails );
    }
    
    static testmethod void test3()
    {
        User u = [select id, username, email, contactid from user where profile.name='Application User' and isActive=true and contactid!=NULL limit 1];
        system.runAs(u){
            Test.StartTest();
            
            Contact c = [select id, owner.id from contact where id=:u.contactid];
            Application__c a = [select id from application__c limit 1];
            
            Map<string, string> educationDetails = new Map<string, string>();
            educationDetails.put('graduationDate','2016-01-01');
            educationDetails.put('studentId',(string)c.id);
            educationDetails.put('applicationId',a.id);
            educationDetails.put('highSchoolName','fsdfsd');
            educationDetails.put('degreeReceived','fdsfsd');
            educationDetails.put('highSchoolCity','fsdfsd');
            educationDetails.put('highSchoolCountry','fsgwer');
            
            applicationController.educationInfo(educationDetails);
            applicationController.SaveEducationAndBackgroundInfo(educationDetails);
            
            Map<string, string> collegeDetails = new Map<string, string>();
            collegeDetails.put('applicationId',a.id);
            
            ApplicationController.collegeInfo(collegeDetails);
            
            ApplicationController.getReferralInfo(c.id);
            ApplicationController.getEmerContInfo(c.id);
            ApplicationController.getParentInfo(c.id);
            
            Map<string, string> citizenDetails = new Map<string, string>();
            citizenDetails.put('studentId',c.id);
            citizenDetails.put('visaExpirationDate','2016-01-01');
            citizenDetails.put('residentialStatus','I am an international student');
            
            ApplicationController.citizenInfo(citizenDetails );
            
            Map<string, string> militaryDetails = new Map<string, string>();
            militaryDetails.put('studentId',c.id);
            militaryDetails.put('qualifyForBenefits','Yes');
            militaryDetails.put('applicationId',a.id);
            
            ApplicationController.militaryInfo(militaryDetails);
            
            Map<string, string> shortEssayDetails = new Map<string, string>();
            shortEssayDetails.put('applicationId',a.id);
            shortEssayDetails.put('shortEssay','fsdfsdfds');
            shortEssayDetails.put('password','abcd1234');
            shortEssayDetails.put('setPassword','false');
            shortEssayDetails.put('studentId',c.id);
            
            ApplicationController.shortEssayInfo(shortEssayDetails);
            
            Map<string, string> previousHistoryDetails = new Map<string, string>();
            previousHistoryDetails.put('applicationId',a.id);
            previousHistoryDetails.put('criminalHistoryQuestion','Yes');
            previousHistoryDetails.put('educationHistoryQuestion','Yes');
            
            ApplicationController.previousHistoryInfo(previousHistoryDetails);
            
            Map<string, string> disabilityServicesDetails = new Map<string, string>();
            disabilityServicesDetails.put('applicationId',a.id);
            disabilityServicesDetails.put('disabilityServicesQuestion','Yes, I will be requesting the use of auxiliary aids and/or services as described above.');
            
            ApplicationController.disabilityServicesInfo(disabilityServicesDetails);
            
            Map<string, string> statisticsDetails = new Map<string, string>();
            statisticsDetails.put('studentId',c.id);
            statisticsDetails.put('gender','Male');
            statisticsDetails.put('ethnicity','test');
            statisticsDetails.put('nationality','test');
            statisticsDetails.put('applicationId',a.id);
            ApplicationController.statisticsInfo(statisticsDetails);
            
            ApplicationController.acceptApp(a.id);
            
            Test.StopTest();
        }
    }
}