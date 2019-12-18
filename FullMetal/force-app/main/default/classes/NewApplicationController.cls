/*
@ DESCRIPTION : CREATES CONTACT AND COMMUNITY USER IF NOT AVAILABLE AND USES EMAIL ADDRESS AS A MATCHING CRITERIA.
@ HISTORY
* STATUS       DATE        USER STORY     AUTHOR    COMPANY
* CREATED     2017-05-09                 CR        LAFS
*/
public without sharing class NewApplicationController {
    public String selectedAgreement{get;set;}
    public Integer completedDocuments{get;set;}
    public Integer totalDocuments{get;set;}
    public String unDecidedVal{get; set;}
    public String searchstring { get; set; }
    public List<User> UserTemp = new List<User>();
    public String password {get;set;}
    public List<Application__c> applicationList {get;set;}
    public List<echosign_dev1__SIGN_Agreement__c> appList {get;set;}
    public Boolean prconsider{get;set;}
    
    public Static String applicationId{get;set;}
    public Id selectedAppId {get;set;}
    public Static String leadId{get;set;}
    public String attachId{get;set;}
    public List<echosign_dev1__SIGN_Agreement__c> echoSign{get;set;}
    public String representativeId {set;get;}
    public String selecteduserId {set;get;}
    
    public List<echoSignListwrapper> echoSignListwrapperList{get;set;}
    
    public String studentId{get;set;}
    public Static String LeadSourceCode{get;set;}
    public Static String SRC{get;set;}
    public Static String LID{get;set;}
    public String schoolId{get;set;}
    public Application__c applicationSelected{get;set;}
    public String username {get;set;}
    public String forgotPasswordEmail {get;set;}
    public String payLater {get;set;}
    public String pageSection{get;set;}
    public String hsDiploma{get;set;}
    public String collegeTranscript{get;set;}
    public String computerSpecs{get;set;}
    public String parentsPhotoID{get;set;}
    public String masterPromissoryNote{get;set;}
    public String i20{get;set;}
    public String i539{get;set;}
    public String i94{get;set;}
    public String passport{get;set;}
    public String toefl{get;set;}
    public String usVisa{get;set;}
    public String bankStatement{get;set;}
    public String dd214{get;set;}
    public String ccaf{get;set;}
    public String entranceCounseling{get;set;}
    public String plusMasterPromissoryNote{get;set;}
    public String parentTaxReturn2017{get;set;}
    public String parentTaxTranscripts2016{get;set;}
    public String spouseTaxReturn2017{get;set;}
    public String spouseTaxTranscript2016{get;set;}
    public String studentTaxReturn2017{get;set;}
    public String studentTaxTranscripts2016{get;set;}
    public String w2Form{get;set;}
    public String ISIRCCode030{get;set;}
    public String ISIRCCode146{get;set;}
    public String defaultResolutionLetter{get;set;}
    public String dependencyOverrideStatement{get;set;}
    public String legalGuardianshipDocument{get;set;}
    public String wardOfCourtDocument{get;set;}
    public string hiddenPhone{get;set;}
    
    
    public String studentFirstName {get;set;}
    public String studentEmail {get;set;}
    public String studentLastName {get;set;}
    public String studentEmailconformation {get;set;}
    public String studentPhone {get;set;}
    public String studentProgram {get;set;}
    public String CampusOption {get;set;}
    public String Programconsideration {get;set;}
    
    public Boolean resetpassmodal {get; set;}
    
    public List<LandingPageSectionsWrapper> LandingPageSections{get{
        List<LandingPageSectionsWrapper> lsections = new List<LandingPageSectionsWrapper>();
        for(Landing_Page_Additional_Section__c lps: [SELECT title__c, content__c from Landing_Page_Additional_Section__c where isActive__c=true order by id desc]){
            lsections.add(new LandingPageSectionsWrapper(lps.title__c, lps.content__c));
        }
        return lsections;
    } set;}
    public List<BannersWrapper> banners{get{
        List<BannersWrapper> bs = new List<BannersWrapper>();
        for(Landing_Page_Banner__c   b: [SELECT Name, content__c, Background_Color__c from Landing_Page_Banner__c     where isActive__c=true order by id asc]){
            bs.add(new BannersWrapper(b.Name, b.content__c, b.Background_Color__c));
        }
        return bs;
    } set;}
    
    
    public Boolean checkpgmconsideration {get
    {
        if(Programconsiderations.size() > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    } set;}
    
    
    public void selectAgreementToSign(){
        selectedAgreement = selectedAgreement;
    }
    
    
    public List<echoSignListwrapper> RequestedDocuments(){
        
        Map<String, Document_Request__c> drs = new Map<String, Document_Request__c>([SELECT Name, Field__c from Document_Request__c]);
        system.debug('drs'+drs);
        String allfields = '';
        for (String key: drs.keySet()){
            allfields = allfields + ', ' + drs.get(key).Field__c;
        }
        system.debug('allfields'+allfields);
        if( allfields.length() > 2 ) {
            allfields = allfields.substring(2);
        }
        
        List<echoSignListwrapper> toReturn = new List<echoSignListwrapper>();
        
        if (!String.isBlank(allfields)){
           Application__c app=new Application__c();
            if(!test.isRunningTest()){
             app = Database.query('select '+allfields+' from Application__c where id=:selectedAppId');
            }
           
            for (String key: drs.keySet()){
                String val = (String)app.get(drs.get(key).Field__c);
                if (!String.isBlank(val)){
                    echoSignListwrapper esLW = new echoSignListwrapper(String.valueOf(selectedAppId), drs.get(key).Name, val, drs.get(key).Field__c);
                    if (!isDuplicate(toReturn, esLW)){
                        toReturn.add(esLW);
                        this.totalDocuments++;
                        if (val == 'Accepted' || val== 'Received'){
                            this.completedDocuments++;
                            
                        }
                    }
                }
            }
        }
        system.debug('toReturn'+toReturn);
        return toReturn;
    }
    
    @TestVisible private Boolean isDuplicate(List<echoSignListwrapper> listWrapper, echoSignListwrapper wr){
        for (echoSignListwrapper l: listWrapper){
            if (l.DocType == wr.DocType && l.Name == wr.Name){
                return true;
            }
        }
        return false;
    }
    
    @TestVisible private echoSignListwrapper getPdfDocumentForApplication( ID applicationId ) {
        
        echoSignListwrapper pdfWrapper;
        if( String.isBlank( applicationId ) ) {
            return pdfWrapper;
        }
        List<Application__c> listOfApplications = [ SELECT Name FROM Application__c 
                                                   WHERE ID =: applicationId
                                                   LIMIT 1
                                                  ];
        System.debug( 'getPdfDocumentForApplication-listOfApplications:-\n' + listOfApplications );
        if( listOfApplications == NULL || listOfApplications.isEmpty() ) {
            return pdfWrapper;
        }
        
        List<Attachment> listOfAttachments = [ SELECT ID, Name, Body FROM Attachment 
                                              WHERE ParentId =: applicationId
                                              AND 
                                              Name =: listOfApplications.get( 0 ).Name + '.pdf'
                                              LIMIT 1
                                             ];
        System.debug( 'getPdfDocumentForApplication-listOfAttachments:-\n' + listOfAttachments );
        
        if( listOfAttachments == NULL || listOfAttachments.isEmpty() ) {
            return pdfWrapper;
        }
        pdfWrapper = new echoSignListwrapper( listOfAttachments.get( 0 ).Id, listOfAttachments.get( 0 ).Name );
        System.debug( 'getPdfDocumentForApplication-pdfWrapper:-\n' + pdfWrapper );
        if (String.isBlank(this.selectedAgreement)){
            this.selectedAgreement = pdfWrapper.Name;
        }
        return pdfWrapper;
    }
    
    public List<echoSignListwrapper> listAgreements{ get{
        
        List<echoSignListwrapper> alist = new List<echoSignListwrapper>();
        this.completedDocuments = 0;
        this.totalDocuments = 0;
        
        echoSignListwrapper pdfWrapper = getPdfDocumentForApplication( selectedAppId );
        if( pdfWrapper != NULL ) {
            alist.add( pdfWrapper );
            this.completedDocuments++;
            this.totalDocuments++;
        }
        
        alist.addAll( RequestedDocuments() );
        system.debug('alist'+alist);
        
        for (echosign_dev1__SIGN_Agreement__c a: [ SELECT Id, Name, echosign_dev1__Status__c, echosign_dev1__Signing_URL__c 
                                                  FROM echosign_dev1__SIGN_Agreement__c 
                                                  WHERE Application__c=:selectedAppId
                                                  ORDER BY CreatedDate DESC
                                                 ] 
            ) {
                echoSignListwrapper b = new echoSignListwrapper
                    (
                        a.Id, a.Name, a.echosign_dev1__Status__c, a.echosign_dev1__Signing_URL__c, System.Today()
                    );
                if (!this.isDuplicate(alist, b)){
                    alist.add(b);
                    if (a.echosign_dev1__Status__c == 'Accepted' || a.echosign_dev1__Status__c == 'Signed'){
                        this.completedDocuments++;
                    }
                    this.totalDocuments++;
                }
            }
        system.debug('alist========'+alist);
        return alist;
    } set;}
    
    public class testException extends Exception {}
    
    public PageReference tryRedirectToLandingPage(){
        
        System.debug( 'tryRedirectToLandingPage-UserInfo:-\n' + UserInfo.getUserId() );
        if( String.isNotBlank( UserInfo.getUserId() ) ) {
            List<User> loggedInUsers = [ SELECT ID, ContactId FROM User 
                                        WHERE ID =: UserInfo.getUserId() AND ContactID != NULL
                                        LIMIT 1
                                       ];
            System.debug( 'tryRedirectToLandingPage-loggedInUsers:-\n' + JSON.serialize( loggedInUsers ) );
            if( loggedInUsers != NULL && !loggedInUsers.isEmpty() ) {
                return new PageReference('/apex/TotalApplications');
            }
        }
        return NULL;
    } 
    
    Public PageReference startapplication() {
        return new PageReference('/apex/NewApplicationForm');
    }
    
    Public PageReference sendtofogotpassword() {
        PageReference forgotPage = new PageReference('/apex/NewApplicationForgotPassword');
        forgotPage.setRedirect(TRUE);
        return forgotPage;
    }
    
    public void changeconsentration(){
        studentProgram  = '';
        Programconsiderations.clear();
        checkpgmconsideration = false;
        prconsider=false;
        system.debug('gtest=='+Programconsiderations.size());
        system.debug('gtest=='+checkpgmconsideration);
    }
    public List<SelectOption> Programoptions {
        
        get {
            List<SelectOption> options = new List<SelectOption>();
            
            if(CampusOption != null && CampusOption != '')
            {
                System.debug('CampusOption==='+CampusOption);
                options.add(new SelectOption('', '---None---'));
                List<Program_Option__c> prgrmlist = [SELECT Campus_Option__c,Name,Program_Code__c FROM Program_Option__c where Campus_Option__r.Name = :CampusOption]; 
                if(prgrmlist.size() > 0)
                {
                    System.debug('test1100'+prgrmlist);
                    for(Program_Option__c prgm : prgrmlist){
                        options.add(new SelectOption(prgm.Program_Code__c, prgm.Name)); 
                    }
                }
            }
            else
            {
                options.add(new SelectOption('', '---None---'));  
            }
            
            //  studentProgram  = '';
            //  checkpgmconsideration = false;
            return options;
        }
        
        set;
        
    }
    
    public List<SelectOption> Programconsiderations {
        
        get {
            List<SelectOption> options = new List<SelectOption>();
            // system.debug('studentProgram  ==' + studentProgram);
            if(studentProgram  != null || studentProgram  != '')
            {
                
                List<Program_Concentration__c> prgrmlist = [SELECT Name,Program_Option__c FROM Program_Concentration__c where Program_Option__r.Program_Code__c = :studentProgram]; 
                if(prgrmlist.size() > 0)
                {
                    options.add(new SelectOption('', '---None---'));
                    
                    for(Program_Concentration__c prgm : prgrmlist){
                        options.add(new SelectOption(prgm.Name, prgm.Name)); 
                    }
                    checkpgmconsideration = true;
                    prconsider=true;
                }
                
                
                
            }
            else{
                checkpgmconsideration = false;
            }
            
            
            return options;
        }
        
        set;
        
    }
    
    public PageReference createsiteuser() {
        try{
            system.debug('entered create user');
            system.debug(studentFirstName+' ' + studentLastName + ' ' +studentEmail + ' ' + studentProgram +' ' + studentPhone );
            if(studentFirstName == '' || studentLastName == '' || studentEmail == '' || studentProgram  == '' || studentPhone == '')
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please enter all the required fields'));
                return null;
            } 
            If(!studentEmail.equals(studentEmailconformation)){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please enter correct email'));
                return null;
                
            }
            List<Contact> conlist = [select id,Name,createddate from contact where email = :studentEmail order by createddate ASC limit 1];
            system.debug('create user conlist.size'+conlist.size());
            if(conlist.size() > 0)
            {
                List<user> userlist = [select id,Name,isActive,createddate from user where email = :studentEmail AND Profile.Name = 'Application User' order by createddate ASC limit 1 ];
                system.debug('create user userlist.size'+userlist.size());
                if(userlist.size() > 0)
                {
                    User u = userList[0];
                    if(!u.isActive)
                    {
                        u.isActive = true;
                        update u;    
                    }
                    Boolean result=Site.forgotPassword(studentEmail);
                    system.debug('==result=='+result);
                    //System.resetPassword(u.Id,true);
                    if(result)
                        return new PageReference('/NewApplication?resetPassword=true');
                    else
                        return new PageReference('/NewApplication?resetPassword=false');
                }
                else
                {
                    system.debug('==else==');
                   // createApplicantUser(conlist[0].id,password);
                   // return Site.login(studentEmail,password,'/apex/NewTotalApplications'); 
                     return createApplicantUser(conlist[0].id, password, true); 
                    
                }
                
            }
            //Create account
            string accountRecordTypeId;         
            RecordType rt = [select Id, Name from RecordType where DeveloperName = 'Student_Account' and SobjectType = 'Account' limit 1];
            accountRecordTypeId = rt.Id;
            Account household = new Account();
            household.RecordTypeId = accountRecordTypeId;
            household.name = studentFirstName + ' ' + studentLastName;
            //household.OwnerId = '0051a000001V8u4';//sandbox 
            
            household.OwnerId = '0051a000000a5Ek';//diana 
            insert household;
            // studentToReturn.AccountId = household.Id;
            system.debug('after insert Account');
            Contact con = New Contact();
            system.debug('Before insert Contact');
            con.FirstName = studentFirstName;
            con.LastName = studentLastName;
            con.Email = studentEmail;
            con.Program_Code__c = studentProgram;
            system.debug('middle insert Contact');
            system.debug('-hiddenPhone is-'+hiddenPhone);
            if(hiddenPhone!=null && hiddenPhone!='')
                con.phone =  '+'+ hiddenPhone + studentPhone;
            
            
            con.AccountId = household.Id;
            con.Program_Consideration__c = Programconsideration;
            
            Insert con;
            system.debug('after insert Contact');
            string BaseURL = ApexPages.currentPage().getHeaders().get('Host');
            string urlvalue=Apexpages.currentPage().getUrl();
            string fullURL = BaseURL + urlvalue;
            system.debug('fullURL'+fullURL);
            system.debug('user'+userinfo.getUserId());
            system.debug('after insert contact'+con.id);
            return createApplicantUser(con.id, password, true);
            //system.debug('after createApplicantUser');
            //  return new PageReference('/apex/NewApplicationDetail'); 
           // return Site.login(studentEmail,password,'/apex/NewApplicationDetail');  
            
        } catch(Exception e){
            System.debug('==getLineNumber=='+e.getLineNumber());
            System.debug('==message=='+e.getMessage());
            return null;
        }
        
    }
    
    public PageReference verifyApplication(){
        try{
            if (ApexPages.currentPage().getParameters().get('appId') != null){
                selectedAppId = (Id) ApexPages.currentPage().getParameters().get('appId');
                User u = [SELECT Id,Name,ContactId FROM User WHERE Id = :userInfo.getUserId()];
                List<Application__c> appList = [SELECT Id, Name FROM Application__c WHERE Student__c = :u.ContactId 
                                                and Id=: selectedAppId and (Application_Status__c= 'Submitted' or Application_Status__c= 'Approved')];
                if (appList.size() == 0){
                    return new PageReference('/apex/NewTotalApplications'); 
                }
            }
        }catch(Exception e){
            return new PageReference('/apex/NewTotalApplications'); 
        }
        return null;
    }
    
    public PageReference checkApplications() {
        applicationList = new List<Application__c>();
        appList =new List<echosign_dev1__SIGN_Agreement__c>();
        User u = [SELECT Id,Name,ContactId FROM User WHERE Id = :userInfo.getUserId()];
        applicationList = [SELECT Id,Name,Program__c,Application_Fee_Paid__c, Exp_Startdate__c, Application_Status__c,Preferred_Start_Period__c,CreatedDate,Start_Date__c,Expected_Start_Date__c,Application_Submitted__c FROM Application__c WHERE Student__c = :u.ContactId ORDER BY CreatedDate DESC ];
        
        //redirect homepage based on the custom meta data value - changes made by CR team on 04-09-2019
        Lafilmschool_Application__mdt appFlow = [select Enable_Flow__c,Days_To_Display_Notifications__c  from Lafilmschool_Application__mdt where DeveloperName= 'ApplicationFlow'];
        if(applicationList.size() > 0 ){
            if(appFlow.Enable_Flow__c!= null && appFlow.Enable_Flow__c.equalsIgnoreCase('TRUE')){ 
                Boolean isSubmitted = false;
                set<id> appids=New set<id>();
                for (Application__c a: applicationList){
                    if (a.Application_Status__c != 'Started'){
                        isSubmitted = true;
                    }
                    appids.add(a.Id);
                }
                
                appList =  [select Id, Name, echosign_dev1__Status__c,Application__c, echosign_dev1__Signing_URL__c from echosign_dev1__SIGN_Agreement__c where Application__c IN:appids ORDER BY LastModifiedDate limit 6];
                
                if (isSubmitted){
                    return null;
                }else{
                    return new PageReference('/apex/NewApplicationDetail');
                }
            }else{
                return null;
            }
        }else{
            if(appFlow.Enable_Flow__c!= null && appFlow.Enable_Flow__c.equalsIgnoreCase('TRUE')){ 
                List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
                String pfName = PROFILE[0].Name;
                system.debug('==== profile = '+ pfName);
                if (pfName == 'Application User'){
                    return new PageReference('/apex/NewApplicationDetail');
                }else{
                    return new PageReference('/apex/NewApplication');
                }
            }
            else{
                return new PageReference('/apex/Application'); 
            }
        }
        
    }
    public PageReference resetPasswordemail(String forgotPasswordEmail)
    {
        List<User> userList = [SELECT Id, Name, isActive FROM User WHERE Username = :forgotPasswordEmail AND Profile.Name = 'Application User'];
        
        if(userList.size() > 0)
        {
            User u = userList[0];
            if(!u.isActive)
            {
                u.isActive = true;
                update u;    
            }
            Boolean result=Site.forgotPassword(forgotPasswordEmail);
            
            //System.resetPassword(u.Id,true);
            if(result)
                return new PageReference('/NewApplication?resetPassword=true');
            else
                return new PageReference('/NewApplication?resetPassword=false');
            
        } 
        else 
        { 
            return new PageReference('/NewApplication?resetPassword=false'); 
        }    
    }
    public Boolean isNewApplicationFlow(){
        //redirect homepage based on the custom meta data value - changes made by CR team on 04-09-2019
        Lafilmschool_Application__mdt appFlow = [select Enable_Flow__c  from Lafilmschool_Application__mdt where DeveloperName= 'ApplicationFlow'];
        
        return appFlow.Enable_Flow__c!= null && appFlow.Enable_Flow__c.equalsIgnoreCase('TRUE');
    }
    
    public static void emailErrors(String errorMessage,String stackTraceString){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<Messaging.SingleEmailMessage> finalMails = new List<Messaging.SingleEmailMessage>();
        String[] toAddresses = new String[] {'jkottahachchige@lafilm.edu'}; /*,'akhilmehra0069@gmail.com','iaraia@lafilm.edu','dcuevas@lafilm.edu'*/
            
            List<User> userList = [SELECT Id,Name,Email FROM User WHERE Email IN :toAddresses];
        
        
        if(userList.size() > 0){
            for(User u : userList){
                Messaging.SingleEmailMessage mailTemp = new Messaging.SingleEmailMessage();
                mailTemp.setTargetObjectId(u.Id);
                mailTemp.setSenderDisplayName('Application Community');        
                mailTemp.setSubject('ATTENTION: Found an Error');        
                mailTemp.setBccSender(false);        
                mailTemp.setUseSignature(false);            
                mailTemp.setHtmlBody('<b>'+errorMessage+'</b><br/><br/>'+stackTraceString);  
                mailTemp.setSaveAsActivity(false);
                finalMails.add(mailTemp);                    
            }
            Messaging.sendEmail(finalMails);  
        }else{
            mail.setToAddresses(toAddresses);
            
            
            mail.setReplyTo('iaraia@lafilm.edu');
            
            mail.setSenderDisplayName('Application Community');
            
            mail.setSubject('ATTENTION: Found an Error');
            
            mail.setBccSender(false);
            
            mail.setUseSignature(false);
            
            mail.setHtmlBody('<b>'+errorMessage+'</b><br/><br/>'+stackTraceString);
            
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
    }
    
    public static void emailErrors(String errorMessage,String stackTraceString,Map<String,String> studentDetails){
        errorMessage += '<br/><br/>'+studentDetails;
        emailErrors(errorMessage,stackTraceString);
    }
    
    public PageReference loginToNewApplication(){
        System.PageReference pgr = new System.PageReference('/apex/NewApplication?userNotFound=true');
        system.debug('username--------------------->>>>'+username);
        system.debug('password--------------------->>>>'+password);
        List<User> userList = [SELECT Id,Name,Username,IsActive,Email FROM User WHERE Username = :username AND ProfileId IN (SELECT Id FROM Profile WHERE Name = 'Application User') ORDER BY CreatedDate DESC LIMIT 1];
        if(userList.size() > 0){
            system.debug('inside method userlist');
            User u = userList[0];
            system.debug('user Info');
            if(!u.isActive){
                system.debug('inside if condition active');
                u.isActive = true;
                update u;    
            }           
            pgr = Site.login(username,password,'/apex/NewTotalApplications');        
        }else{ 
            return new PageReference('/apex/NewApplication?userNotFound=true'); 
        }
        
        if(pgr == null){
            return new PageReference('/apex/NewApplication?userNotFound=true');
        }else{
            return pgr;
        }
    }
    
    
    public PageReference resetPassword(){
        List<User> userList = [SELECT Id, Name, isActive FROM User WHERE Username = :forgotPasswordEmail AND Profile.Name = 'Application User'];
        
        if(userList.size() > 0){
            User u = userList[0];
            if(!u.isActive){
                u.isActive = true;
                update u;    
            }
            Boolean result = Site.forgotPassword(forgotPasswordEmail);
            
            //System.resetPassword(u.Id,true);
            if(result)
                return new PageReference('/NewApplication?resetPassword=true');
            else
                return new PageReference('/NewApplication?resetPassword=false');
            
        }else{ 
            return new PageReference('/NewApplication?resetPassword=false'); 
        }    
    }
    
    public PageReference chkLogIn(){
        PageReference pageRef = null;
        
        List<Profile> p = [Select Id, Name from profile where Id=:UserInfo.getProfileId() LIMIT 1];
        if(p.size()>0){
            
            if(p[0].Name!='Application User'){
                pageRef = new PageReference('/ApplicationLogin');
                pageRef.setRedirect(true);
            }
            else
            {
                Boolean updateRequired=false;
                
                RecordType R = [select id from RecordType where name='Student Master' and SobjectType = 'Contact'];
                Account A = [select id from Account where name='Application Community'];
                User u = [select id, contactid from user where id=:UserInfo.getUserId()];
                Contact c = [select id, RecordTypeId, AccountId, firstname, lastname from Contact Where id=:u.contactid];
                
                if(c.RecordTypeId!=R.id){
                    c.RecordTypeId=R.id;
                    c.Lead_Type__c='Application Started';
                    updateRequired=true;
                }
                
                
                if(updateRequired==true){ update c; } 
            }
        }
        //
        return pageRef;
    }
    
    public NewApplicationController (){
        
        
        DocumentImageCheck();
        String qryString = 'SELECT Id, title, UrlName, LastPublishedDate,LastModifiedById FROM KnowledgeArticleVersion WHERE (PublishStatus = \'online\' and Language = \'en_US\')';
        articleList= Database.query(qryString);
        system.debug('articleList=='+articleList);
        system.debug('articleList=='+articleList.size());
        maxSize = articleList.size() ;
        
        //maxSize = 10 ;
    } 
    
    
    public String sectionName {get;set;}
    public String applicantUserName{get;set;}
    public String applicantpassword{get;set;}
    public Id applicationIdAfterLogin{get;set;}
    
    public PageReference loginToApplicationAfterResettingPassword()
    {
        List<User> userList = [SELECT Id,Name,Username,IsActive,Email FROM User WHERE Username = :applicantUserName AND Profile.Name = 'Application User' ORDER BY CreatedDate DESC LIMIT 1];
        if(userList.size() > 0)
        {
            User u = userList[0];
            
            if(!u.isActive)
            {
                u.isActive = true;
                update u;    
            }           
            String landingUrl = '/apex/Application?Id='+applicationIdAfterLogin+'&pageSection='+sectionName;
            return Site.login(applicantUserName,applicantpassword,landingUrl);        
        }
        else
        {
            return new PageReference('/apex/Application?userNotFound=true');
        }
        
    } 
    
    
    public class LandingPageSectionsWrapper{
        public String Title{get;set;}
        public String content{get;set;}
        
        public LandingPageSectionsWrapper(String Title, String content){
            this.Title = Title;
            this.content = content;
        }
    }
    
    public class BannersWrapper{
        public String Title{get;set;}
        public String content{get;set;}
        public String background{get;set;}
        
        public BannersWrapper(String Title, String content, String background){
            this.Title = Title;
            this.content = content;
            if (String.isBlank(background)){
                this.background = 'background:#ffffff';
            }else{
                
                this.background = 'background:'+background;
            }
        }
    }
    
    public class echoSignListwrapper{
        public String aId{get;set;}
        public String Name{get;set;}
        public String Status{get;set;}
        public String Signurl{get;set;}
        public Date SentDate{get;set;}
        public String DocType{get;set;}
        
        // Wrapper class constructor
        public echoSignListwrapper() {
            
        }
        
        public echoSignListwrapper( Id aId, String Name ) {
            this.aId = aId;
            this.Name = Name;
            this.SignUrl = URL.getSalesforceBaseUrl().toExternalForm() + '/servlet/servlet.FileDownload?file=' + aId;
            this.DocType = 'PDF';
            this.Status = 'Received';
        }
        
        public  echoSignListwrapper(Id aId, String Name, String Status, String Signurl){
            this.aId = aId;
            this.Name = Name;
            this.Status = Status;
            this.SignUrl = Signurl; //name of the field
            this.DocType = 'Document';
        }
        public echoSignListwrapper(Id aId, String Name,String Status,String Signurl,Date SentDate){
            this.aId = aId;
            this.Name=Name;
            this.Status=Status;
            this.DocType = 'Agreement';
            
            //this.Signurl = getSignUrl(Signurl);
            if (Status == 'Out for Signature'){
                try{
                    if (String.isBlank(Signurl)){
                        this.Signurl= echosign_dev1.EchoSignApiService.getSigningUrls(aId)[0].esignUrl;
                    }else{
                        this.SignUrl = Signurl;
                    }
                }catch(Exception e){
                    system.debug('====== '+ e.getStackTraceString());
                }
            }
            this.SentDate=SentDate;
        }
    }
    
    public integer getSignCount(){
        string Uid=UserInfo.getUserId();
        if(Uid!=null){
            User u = [select id, contactid from user where id=:Uid];
            Contact c = [select id, RecordTypeId, AccountId, firstname, lastname from Contact Where id=:u.contactid];
            integer SignCounts = [select count() from echosign_dev1__SIGN_Agreement__c 
                                  where echosign_dev1__Status__c != 'Out for Signature' AND echosign_dev1__Recipient__c =:c.Id];
            return SignCounts;
        }
        return 0;
    }
    
    
    public List<SelectOption> UserList{
        get{
            UserTemp = [SELECT u.LastName, u.Application_Email__c, u.Name,u.IsActive, u.Id, u.FirstName, u.Email, u.Phone From User u WHERE u.Profile.Name = 'Admissions Rep' AND isActive = true];
            UserList = new List<SelectOption>();
            UserList.add(new SelectOption('', 'Admissions Representative(if applicable)'));
            for(User temp : UserTemp){
                UserLIst.add(new SelectOption(temp.Id, temp.Name));
            }
            return UserList;
        }
        set;        
    }
    
    public List<String> StartDateOptions{
        get{
            DateTime now = datetime.now(); // GMT time
            now=now-(1/3.0); //local time
            Date beginDate = Date.valueOf(now.format('YYYY-MM-dd'));
            system.debug(now);
            Map<Double,String> opt = new Map<Double,String>();
            
            List<String> options = new List<String>();       
            Schema.DescribeFieldResult fieldResult =  Application__c.Preferred_Start_Period__c.getDescribe();
            
            
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
            for( Schema.PicklistEntry f : ple)
            {
                if(f.isActive()==true)
                {
                    if(strToDate(f.getValue())!=NULL && beginDate.daysBetween(strToDate(f.getValue()))>=-5)
                    {
                        opt.put(beginDate.daysBetween(strToDate(f.getValue())),f.getValue());
                    }
                    else if(strToDate(f.getValue())==null)
                    {
                        opt.put(9999,f.getValue());
                    }
                }
            }
            
            List<double> ord = new List<double>();
            ord.addAll(opt.keySet());
            ord.sort();
            
            Double first;
            
            for(Double d :ord)
            {
                if(options.size()==0){
                    options.add('"'+opt.get(d)+'"');
                }
                else if((options.size()==1 && first<=5)){
                    options.add('"'+opt.get(d)+'"');
                }
                else if(d==9999){
                    options.add('"'+opt.get(d)+'"');
                }
                first=d;
            }
            return options;
            
        }
        set;
    }
    @RemoteAction
    public static List<Object> getDocusign(string appId){
        List<dsfs__DocuSign_Status__c> docuSignList =[SELECT id, dsfs__Envelope_Status__c, Application__c, dsfs__Subject__c FROM dsfs__DocuSign_Status__c WHERE Application__c =: appId];
        return docuSignList;
    }
    
    
    @RemoteAction
    public static object SaveEducationAndBackgroundInfo(Map<String,String> educationAndBackgroundDetails){
        Map<String,Object> result = new Map<String,Object>();
        Savepoint sp;       
        
        try{
            sp = Database.setSavepoint();
            Date dt,dt2;            
            if(educationAndBackgroundDetails.get('graduationDate') != null && educationAndBackgroundDetails.get('graduationDate') != '' ){
                dt = Date.valueOf(educationAndBackgroundDetails.get('graduationDate'));
            }
            Id studentId = String.valueOf(educationAndBackgroundDetails.get('studentId'));
            //Application__c a =[SELECT id, Name FROM Application__c WHERE Id =: educationAndBackgroundDetails.get('applicationId')];
            Id appId = Id.valueOf(educationAndBackgroundDetails.get('applicationId'));
            Application__c a = new Application__c(Id = appId);       
            a.High_School_Name__c = educationAndBackgroundDetails.get('highSchoolName');
            a.HS_Degree_Received__c = educationAndBackgroundDetails.get('degreeReceived');
            a.High_School_Address__c = educationAndBackgroundDetails.get('highSchoolAddress');
            a.High_School_Address_2__c = educationAndBackgroundDetails.get('highSchoolAddress2');
            a.High_School_City__c = educationAndBackgroundDetails.get('highSchoolCity');
            //a.High_School_State__c = educationAndBackgroundDetails.get('highSchoolState');
            a.High_School_Zip__c = educationAndBackgroundDetails.get('highSchoolZip');
            a.Transcript_Request__c = educationAndBackgroundDetails.get('transcriptRequest');
            a.High_School_Country__c = educationAndBackgroundDetails.get('highSchoolCountry');
            if(educationAndBackgroundDetails.get('highSchoolSelectedUsState') == null){
                a.High_School_State__c = educationAndBackgroundDetails.get('highSchoolSelectedProvince');            
            }
            else{
                a.High_School_State__c = educationAndBackgroundDetails.get('highSchoolSelectedUsState');
            }
            if(dt != null){
                a.HS_Graduation_Date__c = dt;
                
                if(educationAndBackgroundDetails.get('studentId')!= null)
                {
                    Contact cc = new Contact(Id=educationAndBackgroundDetails.get('studentId'));
                    cc.High_School_Graduation_Year__c=dt.year();
                    update cc;
                }
            }
            a.High_School_Info_Complete__c = true;                                              
            /************************** College Info Start*************************/                
            if(educationAndBackgroundDetails.get('college1GraduationDate') == null || educationAndBackgroundDetails.get('college1GraduationDate') == '' || educationAndBackgroundDetails.get('college1GraduationDate') == 'undefined'){
                dt = null;          
            }
            else{
                dt = Date.valueOf(educationAndBackgroundDetails.get('college1GraduationDate'));
            }
            if(educationAndBackgroundDetails.get('college2GraduationDate') == null || educationAndBackgroundDetails.get('college2GraduationDate') == '' || educationAndBackgroundDetails.get('college2GraduationDate') == 'undefined'){
                dt2 = null;         
            }
            else{
                dt2 = Date.valueOf(educationAndBackgroundDetails.get('college2GraduationDate'));
            }                                      
            a.College_1_Name__c = educationAndBackgroundDetails.get('college1Name');
            a.College_1_Degree__c = educationAndBackgroundDetails.get('college1DegreeReceived');
            if(dt != null){
                a.College_1_Graduation_Date__c = dt;
            }
            a.College_2_Name__c = educationAndBackgroundDetails.get('college2Name');
            a.College_2_Degree__c = educationAndBackgroundDetails.get('college2DegreeReceived');                
            if(dt2 != null){
                a.College_2_Graduation_Date__c = dt2;
            }                                                             
            a.College_Notes__c = educationAndBackgroundDetails.get('collegeNotes');
            a.College_Info_Complete__c = true;                                                      
            /************************** College Info End*************************/
            /************************** Disablity Info Start*************************/
            if(educationAndBackgroundDetails.get('disabilityServicesQuestion') == 'Yes, I will be requesting the use of auxiliary aids and/or services as described above.'){
                a.Disability_Accomodations__c = true;
                a.Disability_Explanation__c = educationAndBackgroundDetails.get('disabilityServicesExplanation');
            }
            else{
                a.Disability_Accomodations__c = false;
            }
            a.Disability_Info_Complete__c = true;
            /************************** Disablity Info End*************************/
            /************************** Criminal History Info Start*************************/
            if(educationAndBackgroundDetails.get('criminalHistoryQuestion') == 'Yes'){
                a.Criminal_History__c = true;
                a.Criminal_History_Explanation__c = educationAndBackgroundDetails.get('criminalHistoryExplain');
                a.Criminal_History_Complete__c = true;  
            }else{
                a.Criminal_History__c = false;
                a.Criminal_History_Complete__c = true;
            }        
            if(educationAndBackgroundDetails.get('educationHistoryQuestion') == 'Yes'){
                a.Academic_Misconduct__c = true;
                a.Academic_Misconduct_Explanation__c = educationAndBackgroundDetails.get('educationHistoryExplain');
                a.Discipline_Section_Complete__c = true;
            }else{
                a.Academic_Misconduct__c = false;
                a.Discipline_Section_Complete__c = true;
            }
            /************************** Criminal History Info End*************************/                                  
            update a; 
            Boolean setPassword = Boolean.valueOf(educationAndBackgroundDetails.get('setPassword'));       
            if(setPassword){          
                String password = educationAndBackgroundDetails.get('password');
                createApplicantUser(studentId,password);
                result.put('success',true);
            }                                  
        }catch(Exception e){
            emailErrors(e.getMessage(),e.getStackTraceString(),educationAndBackgroundDetails);            
            system.debug('e.getMessage()----------------->>>>'+e.getMessage());
            system.debug('e.getStackTraceString()----------------->>>>'+e.getStackTraceString());
            if(sp != null){
                Database.rollback(sp);  
            }
            result.put('error',true);
            String[] err=e.getMessage().split(':');
            result.put('success',false);
            result.put('errorMessage',(err.size()>1)?err[1]:err[0]);
            result.put('line number',e.getLineNumber());            
            
        }
        result.put('applicationId',educationAndBackgroundDetails.get('applicationId'));
        result.put('studentId',educationAndBackgroundDetails.get('studentId'));
        return result;              
    }
    @RemoteAction
    public static Map<String,object> getStudentInfo(){  
        Map<String,object> rtn = new Map<String,object>();
        if(userInfo.getUserType() == 'Guest'){
            return null;
        }
        try {
            Map<String,object> result = new Map<String,object>();
            string userId = UserInfo.getUserId();
            
            User u = [SELECT id, Lead_Source__c, contactId FROM User WHERE Id =: userId];
            
            
            List<Contact> student = [SELECT id,CreatedDate,Age__c,Name,AccountId,FirstName,LastName,Phone,OtherPhone, MailingStreet,
                                     MailingCity,MailingState,Birthdate,MailingPostalCode,Email,MailingCountry,Emergency_First_Name__c,Emergency_Last_Name__c,Emergency_Relationship__c,Emergency_Contact_Phone__c,
                                     Citizenship_Code__c,SSN__c,Country_of_Citizenship__c,Lead_Source__c,
                                     Alien_Registration_Number__c,Citizenship_Status__c,
                                     Visa_Type__c,Visa_School_Name__c,Visa_School_Address__c,
                                     Visa_School_City__c,Visa_School_State__c,Visa_School_Country__c,Visa_School_Zip__c,
                                     Visa_Expiration_Date__c,Eligible_For_Military_Benefits__c,
                                     Affiliation__c,Affiliation_Code__c,ETS_EAS__c,Military_Branch__c,Authorize__c,Under_24__c,
                                     Start_Date_of_Service__c,End_Date_of_Service__c,Certificate_or_NOBE__c,
                                     Gender__c,Ethnicity__c,Nationality__c, Student_Info_Complete__c,Lead_Source_Code__c FROM Contact 
                                     WHERE id=:u.ContactId ORDER BY CreatedDate desc Limit 1];                                    
            
            if(student.size()>0)
            {
                List<AggregateResult> appCount = [SELECT Count(Id) FROM Application__c WHERE Student__c = :student[0].Id];
                if(appCount.size() > 0){
                    result.put('ApplicationCount',appCount[0].get('expr0'));
                }
                
                if(student[0].Lead_Source_Code__c == NULL){
                    student[0].Lead_Source_Code__c = u.Lead_Source__c;
                    update student[0];
                }
                result.put('StudentInfo',student[0]);
                rtn = result;
            }
            else
                rtn = NULL;
        }
        catch(Exception e){
            ApplicationController.emailErrors(e.getMessage(),e.getStackTraceString());
        }
        return rtn;
    }
    
    @RemoteAction
    Public Static string getPaymentLink(string selectedApplicationId){
        
        Application__c appToGet = null;
        List<Application__c> appsToGet = [SELECT id,Name,Application_Number__c,Student__r.Name,Student__r.FirstName,
                                          Student__r.LastName,
                                          Student__r.Phone,
                                          Student__r.Email,
                                          Student__r.MailingCountry,
                                          Student__r.MailingPostalCode,
                                          Student__r.MailingStreet,
                                          Student__r.MailingCity,
                                          Student__r.MailingState
                                          
                                          FROM Application__c where Id = :selectedApplicationId  ORDER BY createdDate DESC LIMIT 1];
        // FROM Application__c WHERE Student__c =: studentId AND Id = :selectedApplicationId ORDER BY createdDate DESC LIMIT 1];
        
        
        string payLink = 'https://staging.officialpayments.com/pc_entry_cobrand.jsp?productId=196583491153443887843804494705627227&';
        payLink += 'firstName='+appsToGet[0].Student__r.FirstName+'&';
        payLink += 'lastName='+appsToGet[0].Student__r.LastName+'&';
        payLink += 'address1='+appsToGet[0].Student__r.MailingStreet+'&';
        payLink += 'cityName='+appsToGet[0].Student__r.MailingCity+'&';
        payLink += 'provinceCd='+appsToGet[0].Student__r.MailingState+'&';
        payLink += 'postalCd='+appsToGet[0].Student__r.MailingPostalCode+'&';
        payLink += 'countryCd='+appsToGet[0].Student__r.MailingCountry+'&';
        payLink += 'phoneNum='+appsToGet[0].Student__r.Phone+'&';
        payLink += 'email='+appsToGet[0].Student__r.email+'&';
        payLink += 'cde-StudFirs-2='+appsToGet[0].Student__r.FirstName+'&';
        payLink += 'cde-StudLast-0='+appsToGet[0].Student__r.LastName+'&';
        payLink += 'cde-UniqID-1='+appsToGet[0].Name+'&';
        payLink += 'cde-StudID-3='+appsToGet[0].Application_Number__c+'&';
        payLink += 'paymentAmount=75.00&';
        payLink += 'paymentType=STUSCHED&';
        
        payLink += 'ccType=VI&';
        // payLink += 'postbackUrl=https://sfcindia-lafilmschool.cs53.force.com?goToSection=uploadDetailsSection/Postback&';
        //payLink += 'returnUrl=https://sfcindia-lafilmschool.cs53.force.com?goToSection=uploadDetailsSection&';
        //payLink += 'errorUrl=https://sfcindia-lafilmschool.cs53.force.com?goToSection=uploadDetailsSection&';
        // payLink += 'cancelUrl=https://sfcindia-lafilmschool.cs53.force.com?goToSection=uploadDetailsSection&';
        //string payLink='<html><Body><form method="POST" action="https://staging.officialpayments.com/pc_entry_cobrand.jsp"> <input type="hidden" name="productId" value="196583491153443887843804494705627227"> <input type="text" name="firstName" value="Akhil"> <input type="text" name="middleName" value=""> <input type="text" name="lastName" value="Mehra"> <input type="text" name="suffix" value="Mr"> <input type="text" name="address1" value="test city"> <input type="text" name="address2" value=""> <input type="text" name="cityName" value="Test CIty"> <input type="text" name="provinceCd" value="LA "> <input type="text" name="postalCd" value="90002"> <input type="text" name="phoneNum" value="9779542671"> <input type="text" name="email" value="akhilmehra0069@gmail.com"> <input type="text" name="paymentAmount" value="75"> <input type="Submit" value="Submit"> </form></body></html>';   
        system.debug('payLink==='+payLink);
        return payLink;
    }
    
    @RemoteAction
    public static Map<string,object> getApplicationInfo(Map<string,string>paramMap){
        
        
        String studentId = paramMap.get('studentId');
        Map<String,object> result = new Map<String,object>();
        try{
            String selectedApplicationId = paramMap.get('applicationId');
            system.debug('selectedApplicationId--------------------------------------->>>>'+selectedApplicationId);
            system.debug('studentId--------------------------------------->>>>'+studentId);
            Application__c appToGet = null;
            List<Application__c> appsToGet = [SELECT id,Name,Academic_Misconduct__c,Application_Number__c,Addmission_Representative__c,Academic_Misconduct_Explanation__c,Accepted_Agreement__c,Application_Status__c,Applicant_Age__c,Application_Finalized__c,College_1_Degree__c,
                                              College_1_Graduation_Date__c,College_1_Name__c,College_2_Degree__c,College_2_Graduation_Date__c,College_2_Name__c,College_Notes__c,Criminal_History__c,Criminal_History_Explanation__c,Preferred_Start_Period__c,
                                              HS_Degree_Received__c,Disability_Accomodations__c,Disability_Explanation__c,Friend_Referral__c,Graduation_Date__c,HS_Graduation_Date__c,High_School_Address__c,High_School_Address_2__c,
                                              High_School_City__c,High_School_Country__c,High_School_Name__c,High_School_State__c,High_School_Zip__c,Parent__c,Preferred_Start_Date__c,Program__c,Program_Code__c,Referral__c,Short_Essay__c,Status_Date__c,
                                              Transcript_Request__c, Student_Info_Complete__c, Parent_Info_Complete__c, Veteran_Info_Complete__c, College_Info_Complete__c, Citizen_Info_Complete__c, Essay_Complete__c,Emergency_Contact__c, Emergency_Contact_Info_Complete__c,
                                              Program_Info_Complete__c, High_School_Info_Complete__c, Criminal_History_Complete__c,Discipline_Section_Complete__c,Disability_Info_Complete__c, Statistical_Info_Complete__c, Referral_Info_Complete__c,
                                              Acceptance_Info_Complete__c,I539_Received__c,College_Transcript_Received__c,Photo_Id_Received__c,Computer_Specs_Received__c,HS_Diploma_Received__c,CCAF_Recieved__c,DD214_Received__c,Passport_Received__c,Program_Version__c,  
                                              I20_Received__c,US_Visa_Received__c,I94_Received__c,TOEFL_Received__c,Bank_Statement_Received__c,Application_Submitted__c,HS_Transcript_Evaluation_Recieved__c, Pay_Later__c, Application_Fee_Paid__c, Payment_Confirmation__c,Master_Promissory_Note__c,Entrance_Counseling__c,PLUS_Master_Promissory_Note__c,
                                              Parent_Tax_Return2017__c,Parent_Tax_Transcripts2016__c,Spouse_Tax_Return_2017__c,Spouse_Tax_Transcript2016__c,Student_Tax_Return_2017__c,Student_Tax_Transcripts_2016__c,W2_Form__c,ISIR_CCode_030_Selective_Service__c,ISIR_CCode_146_Citizenship__c,Default_Resolution_Letter__c,Dependency_Override_Statement__c,
                                              Legal_Guardianship_Document__c,Ward_of_Court_Document__c
                                              FROM Application__c WHERE Student__c =: studentId AND Id = :selectedApplicationId ORDER BY createdDate DESC LIMIT 1];
            
            system.debug('appsToGet--------------------------------------->>>>'+appsToGet);
            if(appsToGet != null && appsToGet.size() > 0){
                appToGet = appsToGet[0];
            }
            List<Attachment> applicantSignature = new List<Attachment>();
            if(appToGet != null && (appToGet.Application_Status__c.equalsIgnoreCase('Approved') || appToGet.Application_Status__c.equalsIgnoreCase('Submitted'))){
                applicantSignature = [SELECT Id,Name FROM Attachment WHERE ParentId = :appToGet.Id AND Name = 'Student Signature.png' LIMIT 1];
            }
            
            result.put('Application',appToGet);
            if(applicantSignature.size() > 0){
                system.debug('applicantSignature--------------------------------------->>>>'+applicantSignature[0]);
                result.put('Signature',applicantSignature[0]);
            }
        }catch(Exception e){
            emailErrors(e.getMessage(),e.getStackTraceString(),paramMap);
        }
        return result;
    }
    @RemoteAction
    public static object repInfo(string repId){
        system.debug('**********************************************   IN REp info');
        User rep;
        try{
            rep = [SELECT id, Name, Phone, Application_Email__c, Email FROM User WHERE Id =: repId];
        }catch(Exception e){
            Map<String,String> repIdMap = new Map<String,String>();
            repIdMap.put('repId',repId);
            emailErrors(e.getMessage(),e.getStackTraceString(),repIdMAp);
        }
        return rep;     
    }
    
    private static String rand() {
        Integer len = 6;
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        String randStr = '';
        while (randStr.length() < len) {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            randStr += chars.substring(idx, idx+1);
        }
        return randStr; 
    }
    
    
    public String studentDetailsJSON {get;set;} 
    public String under24String {get;set;}
    public void saveStudentInfo(){
        system.debug('studentDetailsJSON------------------>>>>'+studentDetailsJSON);
        Map<String,String> studentDetailsMap = new Map<String,String>();
        Map<String,object> studentDetailMapTemp =(Map<String,object>)JSON.deserializeUntyped(studentDetailsJSON);
        for(String tempKey : studentDetailMapTemp.keyset()){
            String val = studentDetailMapTemp.get(tempKey)+'';
            studentDetailsMap.put(tempKey,val);
            
        }
        system.debug('studentDetailMap------------------>>>>'+studentDetailsMap);        
        Boolean under24 = Boolean.valueOf(under24String);
        // ApplicationController.studentInfo(studentDetailsMap,under24);
    }
    
    @RemoteAction
    public static Boolean checkIfUserAlreadyExists(Map<String,String> o){
        Boolean rtn=false;
        
        try{
            if(userInfo.getUserType().equalsIgnoreCase('guest'))
            {
                List<User> userList = [SELECT id FROM User WHERE email = :o.get('email') AND IsPortalEnabled = TRUE ];
                if(userList.size() > 0)
                {
                    rtn=true;
                }
                else 
                {
                    FindDuplicatesCtrl f = new FindDuplicatesCtrl();
                    Contact c = f.findDupContact(o.get('email'),o.get('firstname'),o.get('lastname'),o.get('phone'));
                    
                    if(c.id!=NULL)
                    {
                        List<User> uu = [select id from user where contactid=:c.id];
                        if(uu.size()>0){
                            rtn=true;
                        }
                        else
                        {
                            rtn=false;
                        }
                    }
                    else 
                    {
                        rtn=false;
                    }
                }      
            }
        }catch(Exception e){
            emailErrors(e.getMessage(),e.getStackTraceString(),o);
            return null;            
        } 
        return rtn;       
    }
    
    public static string numberOnly(string phone)
    {
        if(phone==NULL){
            return phone;
        }
        
        phone = phone.replaceAll('[^0-9]', '');
        Integer len = phone.length();
        
        if(len==11 && phone.substring(0,1)=='1')
        {
            phone=phone.substring(1,11);
        }
        return phone;
    }
    
    @RemoteAction
    public static object studentInfo(Map<string, string> studentDetails, boolean under24){
        Savepoint sp;
        Map<String,object> result = new Map<String,Object>();
        
        try{
            sp=Database.setSavepoint();   
            FindDuplicatesCtrl ctrl = new FindDuplicatesCtrl();     
            Map<String,String> updatedContactInfo = new Map<String,String>(studentDetails);
            
            Account communityAccount = [select id from account where name='Application Community'];
            String userLeadSource = LeadSourceCode; //'LAFSWEBAPP';
            SRC=((studentDetails.get('src')=='')?NULL:studentDetails.get('src'));
            LID=((studentDetails.get('lid')=='')?NULL:studentDetails.get('lid'));
            Id studentContactId;
            Contact studentContact;
            //Contact studentToUpdate;        
            if(userInfo.getUserType().equalsIgnoreCase('guest') && studentDetails.get('studentId') == null){
                String applicantEmailTemp = studentDetails.get('studentEmail');
                List<User> existingUsers = [SELECT Id,Name,email,username FROM User WHERE username = :applicantEmailTemp AND IsActive = true ];
                
                if(existingUsers.size() > 0){
                    result.put('error','userAlreadyPresent');
                    return result;
                }else{                
                    //List<Contact> contactList = [SELECT Id,Name FROM Contact WHERE Name = 'Dummy Applicant Dummy' LIMIT 1];
                    //Contact dummyContact = new Contact();                
                    
                    String stEmail = studentDetails.get('studentEmail');
                    String stFirstName = studentDetails.get('studentFirstName');
                    String stLastName = studentDetails.get('studentLastName');
                    String stPhone = studentDetails.get('studentPhone');
                    Contact dummyContact = ctrl.findDupContact(stEmail,stFirstName,stLastName,stPhone);
                    dummyContact.LastName = studentDetails.get('studentLastName');
                    dummyContact.RecordTypeId = Schema.SobjectType.Contact.getRecordTypeInfosByName().get('Student Master').getRecordTypeId();
                    /*
Profile p = [SELECT Id,Name FROM Profile WHERE Name = 'System Administrator'];
User u = [SELECT Id,Name FROM User WHERE ProfileId = :p.Id AND UserRoleId != null AND IsActive=true LIMIT 1];
dummyContact.OwnerId = u.Id;
*/
                    dummyContact.AccountId = communityAccount.Id;
                    //insert dummyContact;                    
                    //studentContactId = dummyContact.Id;                                                  
                    studentContact = dummyContact;
                }            
            }else{
                //Account comAcct = [SELECT id, Name FROM Account WHERE Name = 'Application Community' order by LastModifiedDate limit 1];
                string userId = UserInfo.getUserId();
                User u = [SELECT id, Lead_Source__c FROM User WHERE Id =: userId];   
                userLeadSource = u.Lead_Source__c;
                studentContactId = studentDetails.get('studentId');
            }       
            //String school =ApexPages.currentPage().getParameters().get('sId');
            Date dt = Date.valueOf(studentDetails.get('studentDOB'));                   
            // Contact studentToUpdate = [SELECT id,AccountId, Name, Lead_Source_Code__c FROM Contact WHERE Id =: studentContactId];
            Contact studentToReturn;
            List<Contact> studentToReturnList = [SELECT Id,Name,AccountId FROM Contact WHERE Id =: studentContactId];
            if(studentToReturnList.size() > 0){
                studentToReturn = studentToReturnList[0];
            }else{
                studentToReturn = studentContact;
            }
            
            //if still a community account create new account named after the student and move the contact to that account
            
            //if(studentToUpdate.Name.equals('Dummy Applicant')){
            if(studentToReturn.AccountID == communityAccount.Id){
                //create new account
                string accountRecordTypeId;         
                RecordType rt = [select Id, Name from RecordType where DeveloperName = 'Student_Account' and SobjectType = 'Account' limit 1];
                accountRecordTypeId = rt.Id;
                Account household = new Account();
                household.RecordTypeId = accountRecordTypeId;
                household.name = studentDetails.get('studentFirstName') + ' ' + studentDetails.get('studentLastName');
                //household.OwnerId = '0051a000001V8u4';//sandbox 
                
                household.OwnerId = '0051a000000a5Ek';//diana 
                insert household;
                studentToReturn.AccountId = household.Id;               
            }
            
            if(studentDetails.get('studentSelectedUsState') == null){
                studentToReturn.MailingState = studentDetails.get('studentSelectedProvince');           
            }
            else{
                studentToReturn.MailingState = studentDetails.get('studentSelectedUsState');
            }
            studentToReturn.LastName = studentDetails.get('studentLastName');                
            studentToReturn.FirstName = studentDetails.get('studentFirstName');
            studentToReturn.Phone = numberOnly(studentDetails.get('studentPhone'));
            studentToReturn.OtherPhone = numberOnly(studentDetails.get('studentOtherPhone'));
            studentToReturn.Email = studentDetails.get('studentEmail');         
            studentToReturn.MailingStreet = studentDetails.get('studentHomeAddress');       
            studentToReturn.MailingCity = studentDetails.get('studentCity');
            studentToReturn.MailingPostalCode = studentDetails.get('studentZip');
            studentToReturn.MailingCountry = studentDetails.get('studentCountry');
            studentToReturn.Lead_Type__c = 'Application Started';                 
            if(SRC!=NULL)
            {
                studentToReturn.Lead_Source_Code__c = SRC;
            }
            
            studentToReturn.Lead_Id__c = LID;
            
            if(under24 == true){
                studentToReturn.Under_24__c = true;
            }                            
            studentToReturn.BirthDate = dt;             
            //update studentToUpdate;
            if(studentDetails.get('applicationId') != null){
                string appId = studentDetails.get('applicationId');                                                     
                Application__c appToUpdate = [SELECT id, Name FROM Application__c WHERE Id =: appId];                    
                if(studentDetails.get('representativeId') != null){
                    string adminRepId = studentDetails.get('representativeId');                        
                    appToUpdate.Addmission_Representative__c = studentDetails.get('representative');
                    appToUpdate.Student_Info_Complete__c = true;                        
                }                    
                if(under24 != true){
                    appToUpdate.Parent_Info_Complete__c = true;
                }
                appToUpdate.Student_Info_Complete__c = true;
                update appToUpdate;                    
            }
            
            studentToReturn.Emergency_Last_Name__c = studentDetails.get('emContLastName');
            studentToReturn.Emergency_First_Name__c = studentDetails.get('emContFirstName');
            studentToReturn.Emergency_Relationship__c = studentDetails.get('emContRelation');
            studentToReturn.Emergency_Contact_Phone__c = numberOnly(studentDetails.get('emContPhone'));                  
            
            
            Date prefStartPeriodDate = strToDate(studentDetails.get('prefStartPeriod'));
            if(prefStartPeriodDate!=NULL){
                studentToReturn.Expected_Start_Date__c=prefStartPeriodDate;
            }
            String ppCode=studentDetails.get('programCode');
            if(ppCode!=NULL && ppCode.length()>0){
                studentToReturn.Program_Code__c=studentDetails.get('programCode');
            }
            
            if(studentDetails.get('residentialStatus') == 'I am a citizen of the United States'){
                studentToReturn.SSN__c = studentDetails.get('ssNumber');
                studentToReturn.Citizenship_Status__c = 'US Citizen';
                studentToReturn.Country_of_Citizenship__c = 'USA'; 
                studentToReturn.Affiliation_Code__c=null;           
            }
            if(studentDetails.get('residentialStatus') == 'I am a legal resident of the United States'){
                studentToReturn.Citizenship_Status__c = 'Eligible Non-citizen';
                studentToReturn.SSN__c = studentDetails.get('ssNumber');
                studentToReturn.Country_of_Citizenship__c = studentDetails.get('countryOfCitizenship');
                studentToReturn.Alien_Registration_Number__c = studentDetails.get('alienNumber');
                studentToReturn.Affiliation_Code__c=null;
            }
            if(studentDetails.get('residentialStatus') == 'I am an international student'){
                if(studentDetails.get('visaExpirationDate')!=''){
                    Date visaExpirationDateVal = Date.valueOf(studentDetails.get('visaExpirationDate'));
                    studentToReturn.Visa_Expiration_Date__c = visaExpirationDateVal;
                }
                else
                {
                    studentToReturn.Visa_Expiration_Date__c =null;
                }
                
                if(studentDetails.get('visaType')=='None'){
                    studentToReturn.Affiliation_Code__c='INTL2';
                }
                else if(studentDetails.get('visaType')!=null){
                    studentToReturn.Affiliation_Code__c='INTL1';
                }
                else {
                    studentToReturn.Affiliation_Code__c='INTL';
                }
                
                studentToReturn.Citizenship_Status__c = 'Non-citizen';
                studentToReturn.Country_of_Citizenship__c = studentDetails.get('countryOfCitizenship');
                studentToReturn.Visa_Type__c = studentDetails.get('visaType');
                studentToReturn.Visa_School_Name__c = studentDetails.get('visaSchoolName');
                studentToReturn.Visa_School_Address__c = studentDetails.get('visaSchoolAddress');
                studentToReturn.Visa_School_City__c = studentDetails.get('visaSchoolCity');
                studentToReturn.Visa_School_State__c = studentDetails.get('visaSchoolState');
                studentToReturn.Visa_School_Country__c = studentDetails.get('visaSchoolCountry');
                studentToReturn.Visa_School_Zip__c = studentDetails.get('visaSchoolZip');
                
            }
            //update studentToReturn;
            //citizenInfo();
            /*citizenInfo() end*/  
            
            /*militaryInfo() start*/
            if(studentDetails.get('qualifyForBenefits') == 'Yes'){
                Date militaryStartDate;
                Date militaryEndDate;
                if(studentDetails.get('militaryStartDate') == null || studentDetails.get('militaryStartDate') == ''){
                    militaryStartDate = null;
                }
                else{ militaryStartDate = Date.valueOf(studentDetails.get('militaryStartDate')); }
                if(studentDetails.get('militaryEndDate') == null || studentDetails.get('militaryEndDate') == ''){ militaryEndDate = null; }
                else{ militaryEndDate = Date.valueOf(studentDetails.get('militaryEndDate')); }
                studentToReturn.Eligible_For_Military_Benefits__c = true;
                studentToReturn.Affiliation_Code__c = studentDetails.get('militaryAffiliation');
                studentToReturn.Military_Branch__c = studentDetails.get('branchOfService');
                
                if(studentDetails.get('militaryETS')=='' || studentDetails.get('militaryETS')==null){
                    studentToReturn.ETS_EAS__c = null;
                }
                else{
                    Date ets = Date.valueOf(studentDetails.get('militaryETS'));
                    studentToReturn.ETS_EAS__c = ets;
                }
                
                if(studentDetails.get('authorizeTranscript') == 'Yes'){ studentToReturn.Authorize__c = true; } else{ studentToReturn.Authorize__c = false; }
                
                studentToReturn.Start_Date_of_Service__c = militaryStartDate;
                
                studentToReturn.End_Date_of_Service__c = militaryEndDate;
                
                if(studentDetails.get('currentCertificate') == 'Yes'){ studentToReturn.Certificate_or_NOBE__c = true; } else{ studentToReturn.Certificate_or_NOBE__c = false; }           
            }
            else if(studentDetails.get('residentialStatus') != 'I am an international student'){
                studentToReturn.Eligible_For_Military_Benefits__c = false;
                studentToReturn.Affiliation_Code__c = 'NON';
                studentToReturn.Military_Branch__c = null;
            }
            
            studentToReturn.RecordTypeId = Schema.SobjectType.Contact.getRecordTypeInfosByName().get('Student Master').getRecordTypeId();  
            if(studentToReturn.Id != null)
            {
                Integer dateDiff=0;
                
                if(SRC==NULL)
                {
                    Contact rr = [select Lead_Date__c from contact where id=:studentToReturn.Id];
                    Date leadDate = date.newinstance(rr.Lead_Date__c.year(), rr.Lead_Date__c.month(), rr.Lead_Date__c.day());
                    
                    if(leadDate!=NULL){ dateDiff=leadDate.daysBetween(date.today()); }
                    
                    if(dateDiff>=31){ studentToReturn.Lead_Source_Code__c = studentDetails.get('leadSource'); }
                }
                
                update studentToReturn;  
                
                if(SRC!=NULL || dateDiff>=31)
                {
                    /**** Updating Lead Source Code History ****/
                    Contact z = new Contact();
                    z.lastname=studentToReturn.lastname;
                    z.Lead_Source_Code__c=studentToReturn.Lead_Source_Code__c;
                    z.Lead_Id__c=studentToReturn.Lead_Id__c;
                    RoundRobin rob = new RoundRobin();
                    rob.updateLeadSource(studentToReturn.id, z);
                }
            }
            else
            {
                if(SRC==NULL){ studentToReturn.Lead_Source_Code__c = studentDetails.get('leadSource'); }
                insert studentToReturn;
            }
            
            
            Map<String,String> stuDetailsTemp = new Map<String,String>(studentDetails);
            stuDetailsTemp.put('studentId',studentToReturn.Id);
            Id appId = Id.valueOf(checkApplication(stuDetailsTemp,studentDetails.get('appId'))+'');
            result.put('appId',appId);
            
            Application__c appToUpdate;
            if(appId!=NULL){ appToUpdate = new Application__c(Id=appId); } else { appToUpdate = new Application__c(); }
            
            appToUpdate.Emergency_Contact_Info_Complete__c = true;         
            
            
            
            Boolean setPassword = Boolean.valueOf(studentDetails.get('setPassword'));
            String password = String.valueOf(studentDetails.get('password'));
            system.debug('setPassword---------------->>>>'+setPassword);
            if(setPassword){
                // update studentToReturn;
                createApplicantUser(studentToReturn.Id,password);
                result.put('success',true);                
            }
            result.put('studentToReturn',studentToReturn);
            
            appToUpdate.Veteran_Info_Complete__c = true;
            
            String prfStart=studentDetails.get('prefStartPeriod');
            if(prfStart!=NULL && prfStart.length()>0){ appToUpdate.Preferred_Start_Period__c = studentDetails.get('prefStartPeriod'); }
            
            String pCode=studentDetails.get('programCode');
            if(pCode!=NULL && pCode.length()>0){ appToUpdate.Program_Code__c = studentDetails.get('programCode'); }
            appToUpdate.Program_Info_Complete__c = true;
            appToUpdate.Citizen_Info_Complete__c = true;
            appToUpdate.Program_Version__c=studentDetails.get('version');
            
            appToUpdate.Addmission_Representative__c = studentDetails.get('representative');
            appToUpdate.Student_Info_Complete__c = true;
            
            if(under24 != true){ appToUpdate.Parent_Info_Complete__c = true;}           
            /*studentToReturn.School_Status__c = 'New Lead';*/
            List<sobject> listToUpdate = new List<Sobject>();
            //listToUpdate.add(studentToReturn);
            listToUpdate.add(appToUpdate);
            update listToUpdate;
            
            //militaryInfo();
            /*militaryInfo end*/                      
            return result;  
        }catch(exception e){
            system.debug('error Message------------------------------->>>'+e.getStackTraceSTring());
            emailErrors(e.getMessage(),e.getStackTraceString(),studentDetails);
            if(sp != null){
                Database.rollback(sp);  
            }
            result.put('error',true);
            String[] err=e.getMessage().split(':');
            result.put('success',false);
            result.put('errorMessage',(err.size()>1)?err[1]:err[0]);
            result.put('line number',e.getLineNumber());            
            
            return result;
            
        }          
    }
    
    
    public static void sendWelcomeEmail(Id userId){
        List<EmailTemplate> emailTemp = [SELECT Id,Name,DeveloperName FROM EmailTemplate WHERE DeveloperName = 'CommunityWelcomeEmailTemplateV2' LIMIT 1];
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setTemplateId(emailTemp[0].Id);
        message.setTargetObjectId(userId);
        message.setSaveAsActivity(false);
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
            Messaging.sendEmail(messages);
        
    }
    
    
    /*
write a method which creates an applicant user with input parameters as contactId 

1. just create an user 
2. associate the contactId
3. set password 
4. send welcome email
*/
     public static void createApplicantUser(Id applicantId,String userpass){
        createApplicantUser(applicantId, userpass, false);
    }
    
    public static PageReference createApplicantUser(Id applicantId,String userpass,Boolean redirect){
        system.debug('In createApplicantUser applicantId  '+applicantId+''+userpass);
        try {        
            List<User> isDup = [select id from user where contactid=:applicantId];
            
            if(isDup.size()>0)
            {
                system.debug('-----'+isDup.size());
                
                return null;
            }
            else 
            {
                system.debug('--in else---');
                Contact studentDetails = [SELECT Id,Name,Email,FirstName,LastName, Lead_Source_Code__c, account.id FROM Contact WHERE Id = :applicantId];
                User newApplicant = new User();      
                newApplicant.Username = studentDetails.Email;
                newApplicant.Email = studentDetails.Email;
                newApplicant.FirstName = studentDetails.FirstName;
                newApplicant.LastName = studentDetails.LastName;
                newApplicant.CommunityNickname =studentDetails.LastName+''+studentDetails.FirstName;
                if(newApplicant.email.length()>36) { newApplicant.CommunityNickname=newApplicant.email.substring(0,36)+rand().substring(0,4);
                                                   } else { newApplicant.CommunityNickname = newApplicant.email+rand().substring(0,4); }
                
                String alias=newApplicant.lastname+newApplicant.firstname;
                alias.replaceAll(' ','');
                
                if(alias.length()>40){ newApplicant.alias=alias.SubString(0,4); } else { newApplicant.alias=rand().SubString(0,4); }
                newApplicant.TimeZoneSidKey = 'GMT';
                newApplicant.LanguageLocaleKey = 'en_US';
                newApplicant.EmailEncodingKey = 'UTF-8';
                newApplicant.LocaleSidKey = UserInfo.getLocale();
                Profile p =[Select id from Profile where name='Application User'];
                newApplicant.ProfileId=p.id;
                newApplicant.Lead_Source__c = studentDetails.Lead_Source_Code__c; //'LAFSWEBAPP';        
                newApplicant.ContactId = studentDetails.Id;
               // insert newApplicant;
                system.debug('userID ' + newApplicant.ID+ 'password' + userpass);
                
                Id userId=Site.createPortalUser(newApplicant, studentDetails.account.id, userpass, true);   
                system.debug('userId==>'+ userId);    
               // System.setPassword(newApplicant.id,userpass);  
               // sendWelcomeEmail(newApplicant.Id);
               if (redirect){
                    return Site.login( newApplicant.Email, userpass, null);  
                }
            }
        }        
        catch(Exception e){
            //Map<String,String> applicantIdMap = new Map<String,String>();
            //applicantIdMap.put('applicantId',applicantId);
            //emailErrors(e.getMessage(),e.getStackTraceString(),applicantIdMap);
            system.debug('gexception'+ e);
            throw e;
        }
        return null;
    }
    
    @RemoteAction
    public static Map<String,Object> setApplicantPassword(Map<String,String> studentDetails)
    {
        Map<String,Object> result = new Map<String,Object>();
        Id applicantId = studentDetails.get('studentId');
        String password = studentDetails.get('password');
        Savepoint sp;
        sp = Database.setSavepoint();
        
        try{ 
            createApplicantUser(applicantId,password);  
            result.put('success',true);                
            result.put('studentId',applicantId);                
        }
        catch(InvalidParameterValueException i)
        {
            Database.rollback(sp);
            result.put('error',true);
            String[] err=i.getMessage().split(':');
            result.put('success',false);
            result.put('errorMessage',(err.size()>1)?err[1]:err[0]);
        }
        catch(Exception e)
        {
            Database.rollback(sp);
            emailErrors(e.getMessage(),e.getStackTraceString(),studentDetails);
            result.put('error',true);
            result.put('success',false);
            result.put('errorMessage','Something went wrong when creating a user account for you. The system administrator has been notified.');
        } 
        return result;               
    }
    
    @RemoteAction
    public static object parentInfo(Map<string, string> parentDetails){
        Id rtn;
        List<Contact> parent = [select Id, Parent_First_Name__c, Parent_Last_Name__c, Parent_Email__c, Parent_Phone__c from Contact Where Id=:parentDetails.get('studentId')];
        try{
            if(parent.size()>0){
                Contact parentToUpdate = parent[0];
                
                parentToUpdate.Parent_Last_Name__c = parentDetails.get('studentParentLastName');
                parentToUpdate.Parent_First_Name__c = parentDetails.get('studentParentFirstName');
                parentToUpdate.Parent_Email__c = parentDetails.get('studentParentEmail');
                parentToUpdate.Parent_Phone__c = parentDetails.get('studentParentPhone');  
                
                update parentToUpdate;
                
                Application__c appToupdate = [SELECT id, Parent_Info_Complete__c FROM Application__c WHERE Id =: parentDetails.get('applicationId')];
                
                appToUpdate.Parent__c = parentToUpdate.Id;
                appToUpdate.Parent_Info_Complete__c = true;         
                update appToUpdate; 
                rtn=parentToUpdate.id;
            }
        }catch(exception e){
            emailErrors(e.getMessage(),e.getStackTraceString(),parentDetails);
        }
        return rtn;           
    }
    
    @RemoteAction
    public static object emContInfo(Map<string, string> emContDetails){
        Id rtn;
        List<Contact> con= [select Id, Emergency_First_Name__c, Emergency_Last_Name__c, Emergency_Relationship__c, Emergency_Contact_Phone__c from Contact Where Id=:emContDetails.get('studentId')];
        try{
            if(con.size()>0){
                Contact ToUpdate = con[0];
                
                ToUpdate.Emergency_Last_Name__c = emContDetails.get('emContLastName');
                ToUpdate.Emergency_First_Name__c = emContDetails.get('emContFirstName');
                ToUpdate.Emergency_Relationship__c = emContDetails.get('emContRelation');
                ToUpdate.Emergency_Contact_Phone__c = emContDetails.get('emContPhone');  
                
                update ToUpdate;
                
                Application__c appToupdate = [SELECT id, Emergency_Contact_Info_Complete__c FROM Application__c WHERE Id =: emContDetails.get('applicationId')];
                
                appToUpdate.Emergency_Contact_Info_Complete__c = true;         
                update appToUpdate; 
                rtn=ToUpdate.id;
            }
        }catch(exception e){
            emailErrors(e.getMessage(),e.getStackTraceString(),emContDetails);
        }
        return rtn;    
    } 
    @RemoteAction
    public static object checkApplication(Map<string, string> studentDetails,String selectedApplicationId){
        
        string studentId = studentDetails.get('studentId');
        List<Application__c> apps = [select id from application__c where student__c=:studentId AND Id = :selectedApplicationId ORDER BY createdDate DESC];
        Application__c appToUpdate;
        Id appId;
        try{
            if(apps.size()>0){
                appToUpdate=apps[0];
                appId=appToUpdate.id;
            }
            else {
                Application__c newApp = new Application__c();
                newApp.Student__c = studentId;
                
                newApp.Student_Info_Complete__c = true;
                newApp.Program_Code__c = studentDetails.get('programCode'); 
                
                insert newApp;
                appId=newApp.id;
            }
        }catch(exception e){
            emailErrors(e.getMessage(),e.getStackTraceString(),studentDetails);
        } 
        return appId;
        
        
        /*string studentId = studentDetails.get('studentId');
Application__c app = new Application__c();
app.Student__c = studentId;
app.Student_Info_Complete__c = false;
app.Program_Code__c = studentDetails.get('programCode'); 
insert app;
return app.Id;*/
    }
    
    
    
    @RemoteAction
    public static object createApplication(Map<string, string> studentDetails, boolean under24,string selectedApplicationId){
        string studentId = studentDetails.get('studentId');
        system.debug('selectedApplicationId---------------->>>> before'+selectedApplicationId);        
        Id applicationId;
        Application__c appToUpdate;
        try{
            if(String.isNotEmpty(selectedApplicationId)){
                applicationId = selectedApplicationId;
            }else if(String.isNotEmpty(studentDetails.get('applicationId'))){
                applicationId = studentDetails.get('applicationId');
            }else{
                applicationId = (Id)ApplicationController.checkApplication(studentDetails,selectedApplicationId);
            }    
            system.debug('applicationId ---------------->>>> after'+applicationId );
            Date dt = strToDate(studentDetails.get('prefStartPeriod'));
            Contact student = [SELECT id, AccountId, Expected_Start_Date__c, Program_Code__c FROM Contact WHERE Id =: studentDetails.get('studentId')];
            student.Expected_Start_Date__c=dt;
            student.Program_Code__c=studentDetails.get('programCode');
            update student;
            
            appToUpdate = [SELECT id, Name, Preferred_Start_Period__c, Program_Code__c, Addmission_Representative__c, program_version__c FROM Application__c WHERE id =:applicationId ORDER BY createdDate DESC LIMIT 1];                       
            appToUpdate.Preferred_Start_Period__c = studentDetails.get('prefStartPeriod');
            appToUpdate.Program_Code__c = studentDetails.get('programCode');
            appToUpdate.Program_Info_Complete__c = true;
            appToUpdate.Citizen_Info_Complete__c = true;
            appToUpdate.Program_Version__c=studentDetails.get('version');
            
            appToUpdate.Addmission_Representative__c = studentDetails.get('representative');
            appToUpdate.Student_Info_Complete__c = true;
            
            if(under24 != true){ appToUpdate.Parent_Info_Complete__c = true; }
            
            
            update appToUpdate;
        }catch(Exception e){
            emailErrors(e.getMessage(),e.getStackTraceString(),studentDetails);
        }
        
        return appToUpdate;
    }
    
    public static date strToDate(string dateString){
        try {
            /*Convert String August 01, 2016 into Date type*/
            Map<String,Integer> mon = new Map<String,Integer>();
            mon.put('jan',1);
            mon.put('feb',2);
            mon.put('mar',3);
            mon.put('apr',4);
            mon.put('may',5);
            mon.put('jun',6);
            mon.put('jul',7);
            mon.put('aug',8);
            mon.put('sep',9);
            mon.put('oct',10);
            mon.put('nov',11);
            mon.put('dec',12);
            
            dateString=dateString.replace(',','');
            dateString=dateString.trim();
            string[] ds=dateString.split(' ');
            String mm=ds[0];
            mm=mm.Substring(0,3);
            mm=mm.toLowerCase();
            integer m=mon.get(mm);
            
            date d;
            d=Date.parse(m+'/'+ds[1]+'/'+ds[2]);
            return d;
        }
        catch(Exception e){
            return null;
        }
    }
    
    @RemoteAction
    public static object programInfo(Map<string, string> programDetails, boolean hasNoComputer){ 
        Application__c appToReturn;
        try{
            Date dt = strToDate(programDetails.get('prefStartPeriod'));
            Contact student = [SELECT id, AccountId, Expected_Start_Date__c, Program_Code__c FROM Contact WHERE Id =: programDetails.get('studentId')];
            student.Expected_Start_Date__c=dt;
            student.Program_Code__c=programDetails.get('programCode');
            update student;
            
            
            Application__c appToUpdate = [SELECT id, Preferred_Start_Period__c, Program_Code__c FROM Application__c WHERE Id =: programDetails.get('applicationId')];
            appToUpdate.Student_has_no_computer__c = hasNoComputer;         
            //appToUpdate.Preferred_Start_Date__c = dt;
            appToUpdate.Preferred_Start_Period__c = programDetails.get('prefStartPeriod');
            appToUpdate.Program_Code__c = programDetails.get('programCode');
            appToUpdate.Program_Info_Complete__c = true;
            update appToUpdate;
            
            return appToUpdate;
        }catch(Exception e){
            emailErrors(e.getMessage(),e.getStackTraceString(),programDetails);
        }
        return appToReturn;
    }
    
    @RemoteAction
    public static object educationInfo(Map<string, string> educationDetails){
        Map<String,Object> result = new Map<String,Object>();
        Savepoint sp;
        try{
            sp = Database.setSavepoint();
            Date dt;
            if(educationDetails.get('graduationDate') != null && educationDetails.get('graduationDate') != '' ){
                dt = Date.valueOf(educationDetails.get('graduationDate'));
            }
            Id studentId = String.valueOf(educationDetails.get('studentId'));
            Application__c a =[SELECT id, Name FROM Application__c WHERE Id =: educationDetails.get('applicationId')];       
            a.High_School_Name__c = educationDetails.get('highSchoolName');
            a.HS_Degree_Received__c = educationDetails.get('degreeReceived');
            a.High_School_Address__c = educationDetails.get('highSchoolAddress');
            a.High_School_Address_2__c = educationDetails.get('highSchoolAddress2');
            a.High_School_City__c = educationDetails.get('highSchoolCity');
            //a.High_School_State__c = educationDetails.get('highSchoolState');
            a.High_School_Zip__c = educationDetails.get('highSchoolZip');
            a.Transcript_Request__c = educationDetails.get('transcriptRequest');
            a.High_School_Country__c = educationDetails.get('highSchoolCountry');
            if(educationDetails.get('highSchoolSelectedUsState') == null){
                a.High_School_State__c = educationDetails.get('highSchoolSelectedProvince');            
            }
            else{
                a.High_School_State__c = educationDetails.get('highSchoolSelectedUsState');
            }
            if(dt != null){ a.HS_Graduation_Date__c = dt; }
            a.High_School_Info_Complete__c = true;
            Boolean setPassword = Boolean.valueOf(educationDetails.get('setPassword'));       
            if(setPassword){          
                String password = educationDetails.get('password');
                createApplicantUser(studentId,password);
                result.put('success',true);
            }
            
            update a;
            Application__c appToReturn = [SELECT id FROM Application__c WHERE Id =: a.Id];
            result.put('applicationId',appToReturn.Id);
        }catch(Exception e){
            emailErrors(e.getMessage(),e.getStackTraceString(),educationDetails);            
            system.debug('e.getMessage()----------------->>>>'+e.getMessage());
            system.debug('e.getStackTraceString()----------------->>>>'+e.getStackTraceString());
            if(sp != null){
                Database.rollback(sp);  
            }
            result.put('error',true);
            String[] err=e.getMessage().split(':');
            result.put('success',false);
            result.put('errorMessage',(err.size()>1)?err[1]:err[0]);
            result.put('line number',e.getLineNumber());            
            
        }
        result.put('applicationId',educationDetails.get('applicationId'));
        result.put('studentId',educationDetails.get('studentId'));
        return result;
    }
    @RemoteAction
    public static object collegeInfo(Map<string, string> collegeDetails){   
        Date dt;
        Date dt2;
        Application__c appToReturn;
        try{
            system.debug('date1 ====   '   +  collegeDetails.get('college1GraduationDate') +  '   date2=     ' + collegeDetails.get('college2GraduationDate'));
            if(collegeDetails.get('college1GraduationDate') == null || collegeDetails.get('college1GraduationDate') == '' || collegeDetails.get('college1GraduationDate') == 'undefined'){
                dt = null;          
            }
            else{
                dt = Date.valueOf(collegeDetails.get('college1GraduationDate'));
            }
            if(collegeDetails.get('college2GraduationDate') == null || collegeDetails.get('college2GraduationDate') == '' || collegeDetails.get('college2GraduationDate') == 'undefined'){
                dt2 = null;         
            }
            else{ dt2 = Date.valueOf(collegeDetails.get('college2GraduationDate')); }
            
            List<Application__c> app = [SELECT id, Name FROM Application__c WHERE Id =: collegeDetails.get('applicationId')];
            if(app.size()>0)
            {
                Application__c a = app[0];
                a.College_1_Name__c = collegeDetails.get('college1Name');
                a.College_1_Degree__c = collegeDetails.get('college1DegreeReceived');
                if(dt != null){ a.College_1_Graduation_Date__c = dt; }
                a.College_2_Name__c = collegeDetails.get('college2Name');
                a.College_2_Degree__c = collegeDetails.get('college2DegreeReceived');
                
                if(dt2 != null){ a.College_2_Graduation_Date__c = dt2; }
                
                a.College_Notes__c = collegeDetails.get('collegeNotes');
                a.College_Info_Complete__c = true;
                
                update a;
                appToReturn = a;
            }
        }catch(Exception e){
            emailErrors(e.getMessage(),e.getStackTraceString(),collegeDetails);            
        }
        return appToReturn;
    }
    @RemoteAction
    public static object getReferralInfo(string studentId){
        Contact referral = [SELECT Id, Referral_First_Name__c, Referral_Last_Name__c,Lead_Source_Code__c, Referral_Email__c, Referral_Phone__c, Referral_Notes__c FROM Contact WHERE Id =: studentId];
        return referral;
    }
    @RemoteAction
    public static object getEmerContInfo(string studentId){
        Contact emCont = [SELECT id, Emergency_First_Name__c, Emergency_Last_Name__c, Emergency_Relationship__c, Emergency_Contact_Phone__c FROM Contact WHERE Id =:studentId];
        return emCont;
    }
    @RemoteAction
    public static object getParentInfo(string studentId){
        Contact parent = [select Id, Parent_First_Name__c, Parent_Last_Name__c, Parent_Email__c, Parent_Phone__c from Contact WHERE Id =: studentId];
        return parent;
    }
    @RemoteAction
    public static object citizenInfo(Map<string, string> citizenDetails){       
        Contact student = [SELECT id, Name FROM Contact WHERE Id =: citizenDetails.get('studentId')];
        if(citizenDetails.get('residentialStatus') == 'I am a citizen of the United States'){
            student.SSN__c = citizenDetails.get('ssNumber');
            student.Citizenship_Status__c = 'US Citizen';
            student.Country_of_Citizenship__c = 'USA'; 
            student.Affiliation_Code__c=null;           
        }
        if(citizenDetails.get('residentialStatus') == 'I am a legal resident of the United States'){
            student.Citizenship_Status__c = 'Eligible Non-citizen';
            student.SSN__c = citizenDetails.get('ssNumber');
            student.Country_of_Citizenship__c = citizenDetails.get('countryOfCitizenship');
            student.Alien_Registration_Number__c = citizenDetails.get('alienNumber');
            student.Affiliation_Code__c=null;
        }
        if(citizenDetails.get('residentialStatus') == 'I am an international student'){
            if(citizenDetails.get('visaExpirationDate')!=''){
                Date dt = Date.valueOf(citizenDetails.get('visaExpirationDate'));
                student.Visa_Expiration_Date__c = dt;
            }
            else
            {
                student.Visa_Expiration_Date__c =null;
            }
            
            if(citizenDetails.get('visaType')=='None'){
                student.Affiliation_Code__c='INTL2';
            }
            else if(citizenDetails.get('visaType')!=null){ student.Affiliation_Code__c='INTL1'; } else { student.Affiliation_Code__c='INTL'; }
            
            student.Citizenship_Status__c = 'Non-citizen';
            student.Country_of_Citizenship__c = citizenDetails.get('countryOfCitizenship');
            student.Visa_Type__c = citizenDetails.get('visaType');
            student.Visa_School_Name__c = citizenDetails.get('visaSchoolName');
            student.Visa_School_Address__c = citizenDetails.get('visaSchoolAddress');
            student.Visa_School_City__c = citizenDetails.get('visaSchoolCity');
            student.Visa_School_State__c = citizenDetails.get('visaSchoolState');
            student.Visa_School_Country__c = citizenDetails.get('visaSchoolCountry');
            student.Visa_School_Zip__c = citizenDetails.get('visaSchoolZip');
            
        }
        update student;
        return student;
    }
    @RemoteAction
    public static object militaryInfo(Map<string, string> militaryDetails){    
        
        Contact student = [SELECT id, Name FROM Contact WHERE Id =: militaryDetails.get('studentId')];
        if(militaryDetails.get('qualifyForBenefits') == 'Yes'){
            Date dt;
            Date dt2;
            if(militaryDetails.get('militaryStartDate') == null || militaryDetails.get('militaryStartDate') == ''){ dt = null; } else{ dt = Date.valueOf(militaryDetails.get('militaryStartDate')); }
            if(militaryDetails.get('militaryEndDate') == null || militaryDetails.get('militaryEndDate') == ''){ dt2 = null; } else{ dt2 = Date.valueOf(militaryDetails.get('militaryEndDate')); }
            student.Eligible_For_Military_Benefits__c = true;
            student.Affiliation_Code__c = militaryDetails.get('militaryAffiliation');
            student.Military_Branch__c = militaryDetails.get('branchOfService');
            
            if(militaryDetails.get('militaryETS')=='' || militaryDetails.get('militaryETS')==null){
                student.ETS_EAS__c = null;
            }
            else{
                Date ets = Date.valueOf(militaryDetails.get('militaryETS'));
                student.ETS_EAS__c = ets;
            }
            
            if(militaryDetails.get('authorizeTranscript') == 'Yes'){ student.Authorize__c = true; } else{ student.Authorize__c = false; }
            
            student.Start_Date_of_Service__c = dt;
            
            student.End_Date_of_Service__c = dt2;
            
            if(militaryDetails.get('currentCertificate') == 'Yes'){ student.Certificate_or_NOBE__c = true; } else{ student.Certificate_or_NOBE__c = false; }           
        }
        else{
            student.Eligible_For_Military_Benefits__c = false;
            student.Affiliation_Code__c = 'NON';
            student.Military_Branch__c = null;
        }
        update student;
        Application__c appToUpdate = [SELECT id, Name FROM Application__c WHERE Id =: militaryDetails.get('applicationId')];
        appToUpdate.Veteran_Info_Complete__c = true;
        update appToUpdate;
        Contact studentToReturn = [SELECT id, Name FROM Contact WHERE Id =: student.Id];
        return studentToReturn;
    }
    @RemoteAction
    public static object shortEssayInfo(Map<string, string> shortEssayDetails){
        Map<String,object> result = new Map<String,Object> (); 
        Savepoint sp;
        try{       
            sp = Database.setSavepoint();
            Application__c a = [SELECT id, Name FROM Application__c WHERE Id =: shortEssayDetails.get('applicationId')];
            a.Short_Essay__c = shortEssayDetails.get('shortEssay');
            a.Essay_Complete__c = true;
            Boolean setPassword = Boolean.valueOf(shortEssayDetails.get('setPassword'));        
            if(setPassword){
                String password = shortEssayDetails.get('password');
                Id applicantId = Id.valueOf(shortEssayDetails.get('studentId'));
                
                createApplicantUser(applicantId,password);  
                result.put('success',true);      
            }
            update a;
            Application__c aToReturn = [SELECT id, Name FROM Application__c WHERE Id =: a.Id];
            result.put('applicationId',aToReturn.Id);
            return result;
        }catch(Exception e){
            emailErrors(e.getMessage(),e.getStackTraceString(),shortEssayDetails);            
            system.debug('e.getMessage()----------------->>>>'+e.getMessage());
            system.debug('e.getStackTraceString()----------------->>>>'+e.getStackTraceString());
            if(sp != null){ Database.rollback(sp);  }
            result.put('error',true);
            String[] err=e.getMessage().split(':');
            result.put('success',false);
            result.put('errorMessage',(err.size()>1)?err[1]:err[0]);
            result.put('line number',e.getLineNumber()); 
            return result; 
        }
    }
    @RemoteAction
    public static object previousHistoryInfo(Map<string, string> previousHistoryDetails){
        Application__c a = [SELECT id, Name FROM Application__c WHERE Id =: previousHistoryDetails.get('applicationId')];
        if(previousHistoryDetails.get('criminalHistoryQuestion') == 'Yes'){
            a.Criminal_History__c = true;
            a.Criminal_History_Explanation__c = previousHistoryDetails.get('criminalHistoryExplain');
            a.Criminal_History_Complete__c = true;  
        }
        else{
            a.Criminal_History__c = false;
            a.Criminal_History_Complete__c = true;
        }
        
        if(previousHistoryDetails.get('educationHistoryQuestion') == 'Yes'){
            a.Academic_Misconduct__c = true;
            a.Academic_Misconduct_Explanation__c = previousHistoryDetails.get('educationHistoryExplain');
            a.Discipline_Section_Complete__c = true;
        }
        else{
            a.Academic_Misconduct__c = false;
            a.Discipline_Section_Complete__c = true;
        }
        
        update a;
        Application__c aToReturn = [SELECT id, Name FROM Application__c WHERE Id =: a.Id];
        return aToReturn;
    }   
    @RemoteAction
    public static object disabilityServicesInfo(Map<string, string> disabilityServicesDetails){
        Application__c a = [SELECT id, Name FROM Application__c WHERE Id =: disabilityServicesDetails.get('applicationId')];
        if(disabilityServicesDetails.get('disabilityServicesQuestion') == 'Yes, I will be requesting the use of auxiliary aids and/or services as described above.'){
            a.Disability_Accomodations__c = true;
            a.Disability_Explanation__c = disabilityServicesDetails.get('disabilityServicesExplanation');
        } 
        else{ a.Disability_Accomodations__c = false; }
        a.Disability_Info_Complete__c = true;
        update a;
        Application__c aToReturn = [SELECT id, Name FROM Application__c WHERE Id =: a.Id];
        return aToReturn;
    } 
    @RemoteAction
    public static object statisticsInfo(Map<string, string> statisticsDetails){
        Contact student = [SELECT id, Name FROM Contact WHERE Id =: statisticsDetails.get('studentId')];
        if(statisticsDetails.get('gender') == Null){ student.Gender__c = 'Not Provided'; } else{ student.Gender__c = statisticsDetails.get('gender'); }
        if(statisticsDetails.get('ethnicity') == Null){ student.Ethnicity__c = 'Not Provided'; } else{ student.Ethnicity__c = statisticsDetails.get('ethnicity'); }
        if(statisticsDetails.get('nationality') == Null){ student.Nationality__c = 'Not Provided'; } else{ student.Nationality__c = statisticsDetails.get('nationality'); }
        
        update student;
        Application__c appToUpdate = [SELECT id, Name FROM Application__c WHERE Id =: statisticsDetails.get('applicationId')];
        appToUpdate.Statistical_Info_Complete__c = true;
        update appToUpdate;
        return student;
    }
    @RemoteAction
    public static object referFriendInfo(Map<string, string> referFriendDetails){
        Id rtn;
        List<Contact> con =[select Id, Referral_First_Name__c, Referral_Last_Name__c, Referral_Email__c, Referral_Phone__c from contact where id=:referFriendDetails.get('studentId')];
        
        if(con.size()>0){
            Contact toUpdate = con[0];
            
            toUpdate.Referral_First_Name__c = referFriendDetails.get('friendFirstName');
            toUpdate.Referral_Last_Name__c = referFriendDetails.get('friendLastName');
            toUpdate.Referral_Email__c = referFriendDetails.get('friendEmail');
            toUpdate.Referral_Phone__c = referFriendDetails.get('friendPhone');
            rtn = toUpdate.Id;
            update toUpdate;
            
            Application__c app = [SELECT id, Referral_Info_Complete__c, Friend_Referral__c FROM Application__c WHERE Id =: referFriendDetails.get('applicationId')];
            
            if(referFriendDetails.get('referFriendQuestion')=='Yes'){ app.Friend_Referral__c = false; } else { app.Friend_Referral__c = false; }
            app.Referral_Info_Complete__c = true;
            update app;
        }
        return rtn;
    }
    @RemoteAction
    public static void acceptApp(String application){
        
        Application__c a = new Application__c();
        a.id=application;
        a.Accepted_Agreement__c = true;
        a.Acceptance_Info_Complete__c = true;
        update a;
    }
    
    @RemoteAction
    public static void savePayLater(String application,boolean payLaterValue){
        system.debug('values ---payLaterValue -- '+payLaterValue);
        system.debug('values ---application ---'+application);
        Application__c app = new Application__c();
        app.Pay_Later__c = payLaterValue;
        app.ID = application;
        update app;
    }
    
    @RemoteAction
    public static MAP<string, object> applicationFinalSubmit(Map<String,String> dataSet)
    {       
        Map<String,object> result = new Map<String,object>();
        Savepoint sp;
        try{ 
            /* *** */      
            Contact c = new Contact(Id=dataSet.get('studentId'));
            
            if(dataSet.get('gender') == Null){ c.Gender__c = 'Not Provided'; }else{ c.Gender__c = dataSet.get('gender');}
            
            if(dataSet.get('ethnicity') == Null){ c.Ethnicity__c = 'Not Provided'; }else{ c.Ethnicity__c = dataSet.get('ethnicity'); }
            
            if(dataSet.get('nationality') == Null){ c.Nationality__c = 'Not Provided'; }else{ c.Nationality__c = dataSet.get('nationality'); }
            
            c.Referral_First_Name__c = dataSet.get('friendFirstName');
            c.Referral_Last_Name__c = dataSet.get('friendLastName');
            c.Referral_Email__c = dataSet.get('friendEmail');
            c.Referral_Phone__c = dataSet.get('friendPhone');
            c.Lead_Type__c='Application Submitted';
            update c;
            
            Application__c a = new Application__c(Id=dataSet.get('applicationId'));
            a.Short_Essay__c = dataSet.get('shortEssay');
            a.Essay_Complete__c = true;
            a.Statistical_Info_Complete__c = true;
            a.Referral_Info_Complete__c = true;
            a.Accepted_Agreement__c = true;
            a.Acceptance_Info_Complete__c = true;
            a.Application_Finalized__c = true;
            a.Application_Submitted__c = true;
            update a;
            /* *** */
            
            //applicationFinalSubmitSave(dataset); 
            
            List<User> u = [select id from user where contactId=:dataSet.get('studentId') and isActive=true];
            
            savePdf(dataset); 
            
            if(u.isEmpty()){ result.put('community_user',false); } else{ result.put('community_user',true); }
            result.put('success',true);   
        }
        catch(Exception e)
        {
            emailErrors(e.getMessage(),e.getStackTraceString(),dataset);            
            
            if(sp != null){ Database.rollback(sp);  }
            result.put('error',true);
            String[] err=e.getMessage().split(':');
            result.put('success',false);
            result.put('errorMessage',(err.size()>1)?err[1]:err[0]);
            result.put('line number',e.getLineNumber());            
            
        }    
        return result;
    }
    
    public static boolean applicationFinalSubmitSave(Map<String,String> dataSet){
        Contact c = new Contact(Id=dataSet.get('studentId'));
        
        if(dataSet.get('gender') == Null){
            c.Gender__c = 'Not Provided';
        }else{
            c.Gender__c = dataSet.get('gender');
        }
        
        if(dataSet.get('ethnicity') == Null){
            c.Ethnicity__c = 'Not Provided';
        }else{
            c.Ethnicity__c = dataSet.get('ethnicity');
        }
        
        if(dataSet.get('nationality') == Null){
            c.Nationality__c = 'Not Provided';
        }else{
            c.Nationality__c = dataSet.get('nationality');
        }
        
        c.Referral_First_Name__c = dataSet.get('friendFirstName');
        c.Referral_Last_Name__c = dataSet.get('friendLastName');
        c.Referral_Email__c = dataSet.get('friendEmail');
        c.Referral_Phone__c = dataSet.get('friendPhone');
        c.Lead_Type__c='Application Submitted';
        update c;
        
        Application__c a = new Application__c(Id=dataSet.get('applicationId'));
        a.Short_Essay__c = dataSet.get('shortEssay');
        a.Essay_Complete__c = true;
        a.Statistical_Info_Complete__c = true;
        a.Referral_Info_Complete__c = true;
        a.Accepted_Agreement__c = true;
        a.Acceptance_Info_Complete__c = true;
        a.Application_Finalized__c = true;
        a.Application_Submitted__c = true;
        update a;
        return true;
    }
    
    @RemoteAction
    public static void savePdf(Map<string, string> applicationInfo){
        
        
        PageReference pdf = Page.ApplicationPDF;
        // add parent id to the parameters for standardcontroller
        string appId= applicationInfo.get('applicationId');
        string ssn= applicationInfo.get('ssn');
        
        pdf.getParameters().put('aId',appId);
        pdf.getParameters().put('ssn',ssn);
    
        if(applicationInfo.containsKey('gender')){pdf.getParameters().put('gender',applicationInfo.get('gender'));}
        if(applicationInfo.containsKey('ethnicity')){pdf.getParameters().put('ethnicity',applicationInfo.get('ethnicity'));}
        if(applicationInfo.containsKey('nationality')){pdf.getParameters().put('nationality',applicationInfo.get('nationality'));}
        if(applicationInfo.containsKey('shortEssay')){pdf.getParameters().put('shortessay',applicationInfo.get('shortEssay'));}
        
        
        // create the new attachment
        Attachment attach = new Attachment();
        
        // the contents of the attachment from the pdf
        Blob body;
        
        try {   
            // returns the output of the page as a PDF
            body = pdf.getContent();    
            // need to pass unit test -- current bug    
        } catch (VisualforceException e) {
            body = Blob.valueOf('Some Text');
        }
        
        attach.Body = body;
        // add the user entered name
        DateTime today = DateTime.now();
        DateTime local = today-(1/3.0);
        String day= local.format('Y-M-d H:m:s');
        
        attach.Name = applicationInfo.get('studentFirstName') + ' ' + applicationInfo.get('studentLastName') +' '+ day + '.pdf';
        attach.IsPrivate = false;
        // attach the pdf to the account
        attach.ParentId = appId;
        insert attach;  
    } 
    
    @RemoteAction
    public static String doUploadAttachment(MAP<string, string> fileData, String fileId) {   
        string rtn;
        
        if(fileId=='NULL'){
            Attachment att = new Attachment();
            att.body = EncodingUtil.base64Decode(fileData.get('attachmentBody'));
            att.Name = fileData.get('attachmentName');
            att.parentId = fileData.get('applicationId');
            att.ContentType = fileData.get('fileType');
            upsert att;
            rtn= att.id;
        }
        else {
            Attachment att = [select id, body from attachment where id=:fileId];
            String newBody=EncodingUtil.base64encode(att.body);
            newBody+=fileData.get('attachmentBody');
            att.body=EncodingUtil.base64Decode(newBody);
            update att;
            rtn=att.id;
        }
        return rtn;
    }             
    private static Attachment getAttachment(String attId) {
        list<Attachment> attachments = [SELECT Id, Body FROM Attachment WHERE Id =: attId];
        if(attachments.isEmpty()) {
            Attachment a = new Attachment();
            return a;
        } else {
            return attachments[0];
        }
    }
    
    @RemoteAction
    public static String doUploadAttachment1(String appId, String attachmentBody, String attachmentName, String attachmentId) {
        
        try{ 
            if(appId != null) {
                
                
                if(attachmentBody != null) {
                    Attachment att = getAttachment(attachmentId);
                    String newBody = '';
                    if(att.Body != null) {
                        newBody = EncodingUtil.base64Encode(att.Body);
                    }
                    newBody += attachmentBody;
                    att.Body = EncodingUtil.base64Decode(newBody);
                    if(attachmentId == null) {
                        att.Name = attachmentName;
                        att.parentId = appId;
                    }
                    upsert att;
                    
                    Map<String, Document_Request__c> drs = new Map<String, Document_Request__c>([SELECT Name, Field__c from Document_Request__c where Name=:attachmentName]);
                    
                    String allfields = '';
                    for (String key: drs.keySet()){
                        allfields = allfields + ', ' + drs.get(key).Field__c;
                    }
                    
                    allfields = allfields.substring(2);
                    if (!String.isBlank(allfields)){
                        Application__c app = Database.query('select id, '+allfields+' from Application__c where id=:appId');
                        for (String key: drs.keySet()){
                            app.put(drs.get(key).Field__c, 'Received'); 
                        }
                        upsert app;
                    }
                    return att.Id;
                } else {
                    return System.Label.NewApp_AttachmentBodyWasNull;
                }
            } else {
                return System.Label.NewApp_ApplicationCouldNotBeFound;
            }
            
        }
        catch( Exception e ) {
            System.debug( 'Exception:-\n' + e.getMessage() );
            System.debug( 'Exception line number:-\n' + e.getlinenumber() );
            ApexPages.addMessage( new ApexPages.Message( ApexPages.Severity.Error, System.Label.Newapp_SeverityErrorMsg ) );
            return null;
        }
    }
    
    @RemoteAction
    public static void updateUploads(string attachmentName, string applicId){
        Application__c appToUpdate = [SELECT id, Name FROM Application__c WHERE Id =: applicId];
        
        Boolean locked= false;
        if(Approval.isLocked(applicId)){
            Approval.unLock(appToUpdate ,true);
            locked=true;
        }
        
        if(attachmentName == 'I539'){
            appToUpdate.I539_Received__c = 'Received';
        }
        if(attachmentName == 'College Transcripts'){
            appToUpdate.College_Transcript_Received__c = 'Received';
        }
        if(attachmentName == 'Photo Id'){
            appToUpdate.Photo_Id_Received__c = 'Received';
        }
        if(attachmentName == 'Computer Specs'){
            appToUpdate.Computer_Specs_Received__c = 'Received';
        }
        if(attachmentName == 'High School Diploma'){
            appToUpdate.HS_Diploma_Received__c = 'Received';
        }
        if(attachmentName == 'CCAF'){
            appToUpdate.CCAF_Recieved__c = 'Received';
        }
        if(attachmentName == 'DD-214'){
            appToUpdate.DD214_Received__c = 'Received';
        }
        if(attachmentName == 'Passport'){
            appToUpdate.Passport_Received__c = 'Received';
        }
        if(attachmentName == 'I-20'){
            appToUpdate.I20_Received__c = 'Received';
        }
        if(attachmentName == 'US Visa'){
            appToUpdate.US_Visa_Received__c = 'Received';
        }
        if(attachmentName == 'I-94'){
            appToUpdate.I94_Received__c = 'Received';
        }
        if(attachmentName == 'TOEFL Scores'){
            appToUpdate.TOEFL_Received__c = 'Received';
        }
        if(attachmentName == 'Bank Statements'){
            appToUpdate.Bank_Statement_Received__c = 'Received';
        }
        if(attachmentName == 'HSTransriptEvaluation'){
            appToUpdate.HS_Transcript_Evaluation_Recieved__c = 'Received';
        }
        if(attachmentName == 'hsDiploma'){
            appToUpdate.HS_Diploma_Received__c = 'Received';
        }
        if(attachmentName == 'collegeTranscript'){
            appToUpdate.College_Transcript_Received__c = 'Received';
        }
        if(attachmentName == 'computerSpecs'){
            appToUpdate.Computer_Specs_Received__c = 'Received';
        }
        if(attachmentName == 'parentsPhotoID'){
            appToUpdate.Photo_Id_Received__c = 'Received';
        }
        if(attachmentName == 'masterPromissoryNote'){
            appToUpdate.Master_Promissory_Note__c = 'Received';
        }
        if(attachmentName == 'i20'){
            appToUpdate.I20_Received__c = 'Received';
        }
        if(attachmentName == 'I-539'){
            appToUpdate.I539_Received__c = 'Received';
        }
        if(attachmentName == 'I94'){
            appToUpdate.I94_Received__c = 'Received';
        }
        if(attachmentName == 'passport'){
            appToUpdate.Passport_Received__c = 'Received';
        }
        if(attachmentName == 'TOEFL'){
            appToUpdate.TOEFL_Received__c = 'Received';
        }
        if(attachmentName == 'USVisa'){
            appToUpdate.US_Visa_Received__c = 'Received';
        }
        if(attachmentName == 'bankStatementS'){
            appToUpdate.Bank_Statement_Received__c = 'Received';
        }
        if(attachmentName == 'DD214'){
            appToUpdate.DD214_Received__c = 'Received';
        }
        if(attachmentName == 'CCAF'){
            appToUpdate.CCAF_Recieved__c = 'Received';
        }
        if(attachmentName == 'EntranceCounseling'){
            appToUpdate.Entrance_Counseling__c = 'Received';
        }
        if(attachmentName == 'PLUSMasterPromissory'){
            appToUpdate.PLUS_Master_Promissory_Note__c = 'Received';
        }
        if(attachmentName == 'parentTaxReturn'){
            appToUpdate.Parent_Tax_Return2017__c = 'Received';
        }
        if(attachmentName == 'parentTaxTranscripts'){
            appToUpdate.Parent_Tax_Transcripts2016__c = 'Received';
        }
        if(attachmentName == 'spouseTaxReturn'){
            appToUpdate.Spouse_Tax_Return_2017__c = 'Received';
        }
        if(attachmentName == 'spouseTaxTranscript'){
            appToUpdate.Spouse_Tax_Transcript2016__c = 'Received';
        }
        if(attachmentName == 'studentTaxReturn'){
            appToUpdate.Student_Tax_Return_2017__c = 'Received';
        }
        if(attachmentName == 'studentTaxTranscripts'){
            appToUpdate.Student_Tax_Transcripts_2016__c = 'Received';
        }
        if(attachmentName == 'w2Form'){
            appToUpdate.W2_Form__c = 'Received';
        }
        if(attachmentName == 'ISIRCCode030'){
            appToUpdate.ISIR_CCode_030_Selective_Service__c = 'Received';
        }
        if(attachmentName == 'ISIRCCode146'){
            appToUpdate.ISIR_CCode_146_Citizenship__c = 'Received';
        }
        if(attachmentName == 'defaultResolutionLetter'){
            appToUpdate.Default_Resolution_Letter__c = 'Received';
        }
        if(attachmentName == 'dependencyOverrideStmt'){
            appToUpdate.Dependency_Override_Statement__c = 'Received';
        }
        if(attachmentName == 'legalGuardianshipDoc'){
            appToUpdate.Legal_Guardianship_Document__c = 'Received';
        }
        if(attachmentName == 'wardOfCourtDoc'){
            appToUpdate.Ward_of_Court_Document__c = 'Received';
        }
        
        
        
        update appToUpdate;
        
        if(locked){
            Approval.lock(appToUpdate ,true);
        }
    }  
    
    
    public String myimageurl{get;set;}
    
    public void DocumentImageCheck()
    {
        myimageurl = '/servlet/servlet.FileDownload?file=';
        List<document> documentList = [select Id,name from document where 
                                       Name = 'Landing_page_Image'];
        
        if(documentList != null && documentList.size() > 0)
        {
            myimageurl = myimageurl + documentList[0].id;
            //  myimageurl = 'https://thelafilmschool--Banana.cs1.my.salesforce.com/sfc/p/S0000003PDWv/a/S000000007tm/RAErMGRDHVDcrAEdAxyib40pcZ_2uJafmfncassb_Ew';
            System.debug(LoggingLevel.INFO, '//// imageURL modified now ' + myimageurl);
        }
    }
    //Returns current page number 
    public Decimal getCurrentPageNumber() {
        return this.currentPage;
    }
    
    //action for next click
    public PageReference next() {
        if(maxSize > this.currentPage * PAGE_NUMBER) {
            this.currentPage = this.currentPage + 1;
        }
        return null;
    }    
    private Static Final Integer PAGE_NUMBER = 25;
    //Keeps track of current page & max size of article list
    Integer currentPage = 1;
    Integer maxSize = 1;
    public List<KnowledgeArticleVersion> articleList{get;set;}
    //action for previous click
    public PageReference previous() {        
        if(this.currentPage > 1)
            this.currentPage = this.currentPage - 1;
        return null;
    }
    // Returns whether we need to see previous button or not
    public boolean getPrevRequired() {
        return currentPage > 1;
    }
    
    // Returns whether we need to see next button or not
    public boolean getNextRequired() {
        return currentPage * PAGE_NUMBER < maxSize;
    }
}