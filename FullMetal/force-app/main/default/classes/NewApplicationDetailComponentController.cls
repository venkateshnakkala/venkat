public class NewApplicationDetailComponentController {
   
    public String pageMessageType { get; set; }
    public String pageMessage { get; set; }
     
    // PROPERTIES TO DEFINE HOW THE FORMS WILL BE DISPLAYED
    public Boolean isNewApplication {get;set;}
    public Boolean isFirstApplication {get; set;}
    public Boolean isgobacktosummary {get; set;}
    public Id existingAppId {get;set;}
    public Boolean isAlreadySubmitted{get;set;}
    public Boolean isCampusCheck{get;set;}
   
    public  List<SelectOption> Countryoptions{get;set;}
    Public List<SelectOption> UsaStateoptions{get; set;}
    public String   selectedVal {get;set;}
   
   
    //public boolean dispSectBool{get;set;}
    public  Attachment attch{get;set;}
    public Integer stage { get; set; }
    public Contact recordContact { get; set; }
   
    public String birthDate { get; set; }
    public String militaryStartDate { get; set; }
    public String militaryEndDate { get; set; }
    public String visaExpDate { get; set; }
    public String estimationDate { get; set; }
    
    public String graduationDate { get; set; }
    public String collegeGraduationDate1 {get; set;}
    public String collegeGraduationDate2 {get; set;}
    
    public String hiddenPhoneFirst{get;set;}
    public String hiddenPhoneAlt{get;set;}
    public String hiddenPhoneFriend{get;set;}
    public String hiddenPhoneEmrg{get;set;}
    
    public String ShortString {get; set;}
    public Boolean std {get;set;}
    public Boolean statePickList{get;set;}
    public Boolean stateInput{get;set;}
    public string frdsinfo{get;set;}
    
    //public Static String hiddenPhone {get;set;}
    public Application__c recordApplication { get; set; }
    public String CampusOption {get;set;}
    
   
    public Boolean checkpgmconsideration {
        get{
            if(Programconsiderations.size() > 0){
                return true;
            }
            else
            {
                if (this.recordApplication != null){
                    this.recordApplication.Program_Version__c = '';
                }
                return false;
            }
        } set;} 
    
    public List<SelectOption> Programoptions {
        
            get {
            List<SelectOption> options = new List<SelectOption>();
            System.debug( 'Programoptions' );
            System.debug( 'before this.CampusOption:-\n' + this.CampusOption );
            System.debug( 'before this.recordContact.Program_Code__c:-\n' + this.recordContact.Program_Code__c );
            System.debug( 'before this.Programconsiderations:-\n' + this.recordContact.Program_Consideration__c );
            System.debug( 'before this.checkpgmconsideration:-\n' + this.checkpgmconsideration );
                try{  
                    if( this.CampusOption != null && this.CampusOption != '' && this.CampusOption != '---None---' )
                    {
                        System.debug('CampusOption==='+CampusOption);
                        this.checkpgmconsideration = false;
                        options.add(new SelectOption('---None---', '---None---'));
                        List<Program_Option__c> prgrmlist = [SELECT Campus_Option__c,Name,Program_Code__c
                                                             FROM Program_Option__c
                                                             WHERE Campus_Option__r.Name = : this.CampusOption order by Name desc
                                                            ];
                        System.debug( 'Program_Option__c:-\n' + JSON.serialize( prgrmlist  ) );
                        if(prgrmlist.size() > 0)
                        {
                            System.debug('test1100'+prgrmlist);
                            for(Program_Option__c prgm : prgrmlist){
                                options.add(new SelectOption(prgm.Program_Code__c, prgm.Name));
                            }
                        }
                        else {
                            this.checkpgmconsideration = false;
                            System.debug( 'prgrmlist-0-this.checkpgmconsideration:-\n' + this.checkpgmconsideration );
                        }
                    }
                    else
                    {
                        options.add(new SelectOption('---None---', '---None---'));  
                        this.checkpgmconsideration = false;
                        System.debug( 'campus invalid-this.checkpgmconsideration:-\n' + this.checkpgmconsideration );
                    }
                    return options;
                }
                catch(Exception e ) {
                    System.debug( 'Exception:-\n' + e.getMessage() );
                    ApexPages.addMessage( new ApexPages.Message( ApexPages.Severity.Error,  System.Label.Newapp_SeverityErrorMsg ) );
                    return null;
                }
           }
        set;
       }
    
      public List<SelectOption> Programconsiderations {
       
          get {
             List<SelectOption> options = new List<SelectOption>();
           try{
             if( this.recordApplication.Program_Code__c  != null && this.recordApplication.Program_Code__c  != ''){
                   List<Program_Concentration__c> prgrmlist = [ SELECT Name,Program_Option__c
                                                                FROM Program_Concentration__c
                                                                WHERE Program_Option__r.Program_Code__c = : this.recordApplication.Program_Code__c
                                                                ORDER BY Name
                                                              ];
                 if(prgrmlist.size() > 0){
                    options.add(new SelectOption('---None---', '---None---'));
                    for(Program_Concentration__c prgm : prgrmlist){
                        options.add(new SelectOption(prgm.Name, prgm.Name));
                    }
                }
                 this.checkpgmconsideration = true;
            }
            else{
                this.checkpgmconsideration = false;
            }
            return options;
           }
             catch(Exception e ) {
                 System.debug( 'Exception:-\n' + e.getMessage() );
                 ApexPages.addMessage( new ApexPages.Message( ApexPages.Severity.Error,  System.Label.Newapp_SeverityErrorMsg ) );
                 return null;
             }
        } set; }
    
    public List<SelectOption> countriesListItems() {
     
        try{ 
          Countryoptions = new List<SelectOption>();
          List<NewApplicationCountries__mdt> newAppCountries = [ SELECT Sr_No__c,MasterLabel,Value__c,Type__c
                                                                FROM NewApplicationCountries__mdt where Type__c = 'Country' 
                                                                ORDER BY Sr_No__c
                                                               ];
          for(NewApplicationCountries__mdt newApp : newAppCountries ){
              Countryoptions.add(new SelectOption(newApp.MasterLabel,newApp.Value__c));
          }
          return Countryoptions;
      }
        catch(Exception e ) {
            System.debug( 'Exception:-\n' + e.getMessage() );
            ApexPages.addMessage( new ApexPages.Message( ApexPages.Severity.Error,  System.Label.Newapp_SeverityErrorMsg ) );
            return new List<SelectOption>();
        }
    } 
    
    public List<SelectOption> UsaStateListItems() {
       try{  
        UsaStateoptions = new List<SelectOption>();
        List<NewApplicationCountries__mdt> newAppCountries = [ SELECT Sr_No__c,MasterLabel,Value__c,Type__c 
                                                               FROM NewApplicationCountries__mdt 
                                                               WHERE Type__c = 'US_State' ORDER BY Sr_No__c
                                                             ];
        for(NewApplicationCountries__mdt newApp : newAppCountries ){
          UsaStateoptions.add(new SelectOption(newApp.MasterLabel,newApp.Value__c));
        }
        return UsaStateoptions;
       }catch(Exception e ) {
           System.debug( 'Exception:-\n' + e.getMessage() );
           ApexPages.addMessage( new ApexPages.Message( ApexPages.Severity.Error,  System.Label.Newapp_SeverityErrorMsg ) );
           return new List<SelectOption>();
        }
    } 
   
    public NewApplicationDetailComponentController() {
        
        System.debug( 'NewApplicationDetailComponentController' );
        ShortString='';
        if (ApexPages.currentPage().getParameters().get('newApplication') == 'true'){
            isNewApplication = true;
            
        }else{
            isNewApplication = false;
        }
        this.isFirstApplication = True;
        this.isAlreadySubmitted = False;
        System.debug('isNewApplication====='+isNewApplication);
        existingAppId = null;
        if (ApexPages.currentPage().getParameters().get('appId') != null){
            existingAppId = (Id) ApexPages.currentPage().getParameters().get('appId');
        }
        System.debug('ExistingApplicationId'+existingAppId);
       
        initializeComponent();
        this.attch=new Attachment();
       }
    
    public NewApplicationDetailComponentController getCommonData() {
        
        return this;
    }
    
    public void changeconsentration(){
        //system.debug('changeconsentra'+recordApplication.Program_Code__c);
        this.recordApplication.Program_Code__c  = '';
        this.Programconsiderations = new List<SelectOption>();
        this.checkpgmconsideration = false;
      
    }
    
    public void checkCampusOptionEnabledOrDisabled(){
       
        System.debug('this.isFirstApplication==='+this.isFirstApplication);
        System.debug('this.isAlreadySubmitted==='+this.isAlreadySubmitted);
        
        if(this.isFirstApplication || this.isAlreadySubmitted ){
            isCampusCheck = false;
            system.debug('======isCampusCheck====');
        }else {
            isCampusCheck = true;
            system.debug('======isCampusCheck1====');
        }
        
  /*    if(this.isFirstApplication && this.isAlreadySubmitted){
            isCampusCheck = false;
            system.debug('======isCampusCheck2====');
          }
          else{
            isCampusCheck = true;
            system.debug('======isCampusCheck3====');
          }  */
                    
        System.debug('===isCampusCheck4==='+this.isCampusCheck);
    }
   
    /* updateContactWithApplication() for Insert/Update the Education And Background Information*/
    public void goNextNoSave(){
       
        this.stage = this.stage + 1;
    }
   
    /* redirect to previous pages with in the application it won't perform any insert/update operations*/
     public void redirectToPreviousPage(){
       
        this.stage=this.stage-1;
        this.pageMessageType = '';
        this.pageMessage = '';
        covertDateFormat();
        
        checkCampusOptionEnabledOrDisabled();
        this.setSupplementPhoneNumbers();
        
            if (this.stage == 1){
                this.countryusUpdates();
            }
         System.Debug(this.stage);
    }
   
    /*redirect to NewTotalApplications page*/
    public PageReference goBackToSumary(){
        
        return new PageReference('/apex/NewTotalApplications'); 
    }
   
    public void updateFrienddetails(){
        
        System.debug( 'updateContact-updateFrienddetails:-\n' + JSON.serialize( this.recordContact ) );
        frdsinfo='No';
    }
   
    public void countryusUpdate() {
       
        this.recordApplication.High_School_State__c = '';
         if(this.recordApplication.High_School_Country__c!=null){
              if(this.recordApplication.High_School_Country__c.equals('United States')){
                statePickList = True;
               }
               else{
                statePickList = False;
               } 
           }
        
     }
       
    public void countryusUpdates() {
         
        //this.recordContact.MailingState='';
        //if(!String.isBlank(this.recordContact.MailingState!=null)){  
             if(this.recordContact.MailingCountry != null && this.recordContact.MailingCountry.equals('United States')){
                stateInput = True;
            }
            else{
                stateInput =False;
            }
         //}
     }
    Public String prefereddate {get; set;}
     public List<SelectOption> StartDateOptions {
         
        get{
            DateTime now = datetime.now(); // GMT time
            now=now-(1/3.0); //local time
            Date beginDate = Date.valueOf(now.format('YYYY-MM-dd'));
            Map<Double,String> opt = new Map<Double,String>();
            
            List<SelectOption> options = new List<SelectOption>();       
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
                    options.add(new SelectOption(''+opt.get(d)+'',''+opt.get(d)+''));
                }
                else if((options.size()==1 && first<=5)){
                    options.add(new SelectOption(''+opt.get(d)+'',''+opt.get(d)+''));
                }
                else if(d==9999){
                    options.add(new SelectOption(''+opt.get(d)+'',''+opt.get(d)+''));
                }
                first=d;
            }
            system.debug('====options==='+options);
             system.debug('====Preferred_Start_Period__c==='+this.recordApplication.Preferred_Start_Period__c);
             return options;
            
            
         }
        set;
     }
    
     public PageReference updateContactWithApplication() {
       
        updateContactAndAppsavenfinish();
        if (this.recordApplication.Stage__c < 4){
            this.recordApplication.Stage__c = this.stage + 1;  
            update this.recordApplication;
        }
        
        this.stage = this.stage + 1;
        PageReference newapp =  Page.NewApplicationDetail;
        newapp.getParameters().put('appId',this.recordApplication.Id);
        newapp.setRedirect(true);
        return newapp;
        
     }
    
     public void updateContactAndAppsavenfinish(){
        
        try {
            System.debug( 'updateContact:-\n' + JSON.serialize( this.recordContact ) );
            System.debug( 'update Application:-\n' + JSON.serialize( this.recordApplication ) );
            System.debug('birthDate:-\n'+ birthDate);
            System.debug('visaExpDate:-\n'+ visaExpDate);
            System.debug('militaryStartDate:-\n'+ militaryStartDate);
            System.debug('militaryEndDate:-\n'+ militaryEndDate);
            System.debug('estimationDate:-\n'+ estimationDate);
            
            System.debug('graduationDate:-\n'+ graduationDate);
            System.debug('collegeGraduationDate1:-\n'+ collegeGraduationDate1);
            System.debug('collegeGraduationDate2:-\n'+ collegeGraduationDate2);
            
            System.debug('before save hiddenPhoneFirst:-\n'+ hiddenPhoneFirst);
            System.debug('before save hiddenPhoneAlt:-\n'+ hiddenPhoneAlt);
            System.debug('before save hiddenPhoneFriend:-\n'+ hiddenPhoneFriend);
            System.debug('before save hiddenPhoneEmrg:-\n'+ hiddenPhoneEmrg);
           
            this.recordContact.BirthDate = this.parseDateFromString( birthDate );
            this.recordApplication.Visa_Expiration_Date__c = this.parseDateFromString( visaExpDate );
            this.recordApplication.Start_Date_of_Service__c = this.parseDateFromString( militaryStartDate );
            this.recordApplication.End_Date_of_Service__c = this.parseDateFromString( militaryEndDate );
            this.recordApplication.ETS_EAS__c = this.parseDateFromString( estimationDate );
           
            System.debug( 'before this.selectedVal:-\n'+ this.selectedVal );
            if( String.isBlank( this.selectedVal ) || this.selectedVal == '[]' ) {
                if( String.isNotBlank( this.recordApplication.Country_of_Citizenship__c ) ) {
                    this.selectedVal = '[' + this.recordApplication.Country_of_Citizenship__c + ']'; 
                    // CLICKS NEXT/PREVIOUS MULTIPLE TIMES WITHOUT TOUCHING THIS FIELD.
                }
            }
            else {
                this.recordApplication.Country_of_Citizenship__c = this.selectedVal;
                this.recordApplication.Country_of_Citizenship__c = this.recordApplication.Country_of_Citizenship__c.replace( '[', '');
                this.recordApplication.Country_of_Citizenship__c = this.recordApplication.Country_of_Citizenship__c.replace( ']', '');
                this.recordApplication.Country_of_Citizenship__c = this.recordApplication.Country_of_Citizenship__c.normalizeSpace();
            } 
            System.debug( 'after this.selectedVal:-\n'+ this.selectedVal );
            
            if( this.recordApplication.Citizenship_Status__c != 'Non-citizen') {
                this.selectedVal = '';
                this.recordApplication.Country_of_Citizenship__c = NULL;
            }
            
            if( this.recordContact.Id != null && stage == 1 && String.isNotBlank( hiddenPhoneAlt ) ) {
                if( String.isNotBlank( this.recordContact.OtherPhone ) && !this.recordContact.OtherPhone.startsWith( '+' ) ) {
                    this.recordContact.OtherPhone= '+' + hiddenPhoneAlt + recordContact.OtherPhone;
                }  
             }
          
            this.setSupplementPhoneNumbers();
           
            if( String.isNotBlank( this.selectedVal ) ) {
                 this.recordApplication.Country_of_Citizenship__c = this.selectedVal;
                 this.recordApplication.Country_of_Citizenship__c = this.recordApplication.Country_of_Citizenship__c.replace( '[', '');
                 this.recordApplication.Country_of_Citizenship__c = this.recordApplication.Country_of_Citizenship__c.replace( ']', '');
                 this.recordApplication.Country_of_Citizenship__c = this.recordApplication.Country_of_Citizenship__c.normalizeSpace();
              }
            System.debug( 'updateContact just before update:-\n' + JSON.serialize( this.recordApplication ) );
             
            UPDATE this.recordContact;
            goBackToSummaryDiplay();
           Application__c app = getApplication();
            
            if ( app.id != NULL ) {
                this.recordApplication.Id = app.Id;  
            }
            System.debug( 'app:-\n' + JSON.serialize( app ) );
           
            if (this.recordApplication.Student__c == null){
                this.recordApplication.Student__c = this.recordContact.Id;
            }
           
            this.recordApplication.HS_Graduation_Date__c  = this.parseDateFromString(graduationDate);
            this.recordApplication.College_1_Graduation_Date__c  = this.parseDateFromString(collegeGraduationDate1);
            this.recordApplication.College_2_Graduation_Date__c  = this.parseDateFromString(collegeGraduationDate2);
            
            system.debug('-ShortString is-'+ShortString);
            if (ShortString!= null && ShortString!= '' && stage==3){
                this.recordApplication.Short_Essay__c= ShortString;
            }
             
            this.setStartDate( this.recordApplication.Preferred_Start_Period__c );
            System.debug( 'update contact this.recordApplication:-\n' + JSON.serialize( this.recordApplication ) );
            UPSERT this.recordApplication;
            this.setMessage( 'success', 'Details were updated successfully.' );
            
            covertDateFormat();
            checkCampusOptionEnabledOrDisabled();
            ApexPages.addMessage( new ApexPages.Message( ApexPages.Severity.Confirm, System.Label.NewApp_SeveritySuccessMsg ) );
           
            
            System.debug('after save hiddenPhoneFirst:-\n'+ hiddenPhoneFirst);
            System.debug('after save hiddenPhoneAlt:-\n'+ hiddenPhoneAlt);
            System.debug('after save hiddenPhoneFriend:-\n'+ hiddenPhoneFriend);
            System.debug('after save hiddenPhoneEmrg:-\n'+ hiddenPhoneEmrg);
            
          }
          catch( DMLException e ) {
             System.debug( 'Exception:-\n' + e.getMessage() );
             ApexPages.addMessage( new ApexPages.Message( ApexPages.Severity.Error,  System.Label.Newapp_SeverityErrorMsg ) );
             this.setMessage( 'error', System.Label.NewApp_SetErrorMsg );
          }
       
     }
     
     public PageReference updateContactAndApponAcceptandSubmit(){
        
        try { 
            System.debug( 'updateContact:-\n' + JSON.serialize( this.recordContact ) );
            if(this.recordApplication.Id != null && frdsinfo=='No' && stage==3){
                
                this.recordApplication.Referral_First_Name__c='';
                this.recordApplication.Referral_Last_Name__c='';
                this.recordApplication.Referral_Email__c='';
                this.recordApplication.Referral_Phone__c='';
            }
            
            if( this.recordContact.Id != null && stage == 1 && String.isNotBlank( hiddenPhoneAlt ) ) {
                if( String.isNotBlank( this.recordContact.OtherPhone ) && !this.recordContact.OtherPhone.startsWith( '+' ) ) {
                    this.recordContact.OtherPhone= '+' + hiddenPhoneAlt + recordContact.OtherPhone;
                }  
            }
            
            this.setSupplementPhoneNumbers();
            System.debug( 'Accept and submit:-\n' + JSON.serialize( this.recordContact ) );
            UPDATE this.recordContact;
            
            Application__c app = getApplication();
            
            System.debug( 'app:-\n' + JSON.serialize( app ) );
            
            if( app != NULL ) {
                if(this.recordApplication.Student__c == null){
                    this.recordApplication.Student__c = this.recordContact.Id;
                }
                this.recordApplication.Id = app.Id;
                if(stage==3 && this.recordApplication.Application_Status__c != 'Submitted'){
                    this.recordApplication.Application_Status__c = 'Submitted';
                    this.recordApplication.App_Finalized_Date__c=Datetime.Now();
                    this.recordApplication.Application_Finalized__c= true;
                    this.recordApplication.HS_Diploma_Received__c= 'Requested';
                }
                system.debug('-ShortString is-'+ShortString);
                if(ShortString!= null && ShortString!= '' && stage==3){
                    this.recordApplication.Short_Essay__c= ShortString;
                }
            }
            
            if (this.recordApplication.Stage__c < 4){
                this.recordApplication.Stage__c = this.recordApplication.Stage__c + 1;  
            }
            
            this.stage = this.stage + 1;
            isAlreadySubmitted = true;
            System.debug( 'update contact this.recordApplication:-\n' + JSON.serialize( this.recordApplication ) );
            UPSERT this.recordApplication;
           this.setMessage( 'success', 'Details were updated successfully.' );
            ApexPages.addMessage( new ApexPages.Message( ApexPages.Severity.Confirm, System.Label.NewApp_SeveritySuccessMsg ) );
            sendPDFToContact( this.recordApplication.Id, this.recordApplication.Name, 
							  this.recordApplication.Student__r.Name, this.recordContact.Email, this.recordApplication.Program_Code__c
						    );
            
        }
        catch( DMLException e ) {
            System.debug('--in catch');
            System.debug( 'Exception:-\n' + e.getMessage() );
            ApexPages.addMessage( new ApexPages.Message( ApexPages.Severity.Error, System.Label.Newapp_SeverityErrorMsg ) );
        }
         return null;
    }
   
    @Future( Callout = TRUE )
	public static void sendPDFToContact( ID applicationId, String strApplicationName, String strContactName, String strContactEmail, String strProgramCode ) {
		
		if( applicationId != NULL && String.isNotBlank( strApplicationName ) && String.isNotBlank( strContactName ) &&
			String.isNotBlank( strContactEmail ) && String.isNotBlank( strProgramCode )
		) {
			Blob b;
			Map<Id,Attachment> MapParentIdByAttchment = new Map<Id,Attachment>();
		
			PageReference pdf =  Page.ApplicationPDF;
			pdf.getParameters().put( 'aId', applicationId );
			
			if( Test.isRunningTest() ) {
				b = Blob.valueOf( 'test' );
			}
			else {
				b = pdf.getContentAsPDF();
				system.debug( '===getcontentPDF==='+ b );
			}
			
			String pdfname = strApplicationName + '.pdf';
			
			List<Attachment> attachments = [ SELECT ID, Name, ParentId FROM Attachment WHERE ParentId =: applicationId AND Name =: pdfname LIMIT 1 ];
			if( !attachments.isEmpty() ) {
				MapParentIdByAttchment.put( attachments[0].ParentId, attachments[0] );
			}
			System.debug( 'MapParentIdByAttchment==' + MapParentIdByAttchment );
			
			if ( !MapParentIdByAttchment.containskey( applicationId ) ) {
				Attachment myAttach = new Attachment();
				myAttach.ParentId = applicationId;
				myAttach.name = pdfname;
				myAttach.body = b;
				INSERT myAttach;
				system.debug('===myAttach===' + myAttach);
			}
			else {
				Attachment myexistingAttach = new Attachment();
				myexistingAttach.id = MapParentIdByAttchment.get( applicationId ).id;
				myexistingAttach.body = b;
				UPDATE myexistingAttach;
				system.debug('===myexistingAttach==='+myexistingAttach);
			}
			// Create the email attachment
			Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
			efa.setContentType( 'application/pdf' );
			efa.setFileName( pdfname );
			efa.setInline( FALSE );
			efa.setBody( b );
			
			OrgWideEmailAddress[] owea = [ SELECT ID FROM OrgWideEmailAddress WHERE Address = 'admissions.support@lafilm.edu' limit 1 ];
			
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			mail.setToAddresses( new String[]{ strContactEmail } );
			
			if ( owea.size() > 0 ) {
				mail.setOrgWideEmailAddressId( owea.get(0).Id );
			}
			
			mail.setSubject( strContactName + '  your Application ' + strApplicationName + ' is Submitted for Program ' + strProgramCode );
			
			mail.plainTextBody = 'Dear ' + strContactName + ',\'\n\n' +
								 'Please find the details of your application '+ strApplicationName +
								 ' in the attched document\n\nRegards\nThe Los Angeles Film School';
			
			mail.setFileAttachments( new Messaging.EmailFileAttachment[] { efa } );
			
			try {
				Messaging.SendEmail(new Messaging.SingleEmailMessage[] {mail});
			}
			catch( Exception e ) {
				
			}
			 sendAutomaticAgreements( applicationId );
		}
    }
    
    
    
    /* initializeComponent() for Insert/Update the Contact Information*/
    public void initializeComponent() {
        
        System.debug( 'initializeComponent' );
        this.pageMessageType = '';
        this.pageMessage = '';
        this.stage = 1;
       
        try {
            System.debug( 'UserInfo.getUserId():-\n' + UserInfo.getUserId() );
            User recordUser = new User();
            if(test.isRunningTest()){
                recordUser = [ SELECT ID, ContactId FROM User WHERE ID =: UserInfo.getUserId()  LIMIT 1 ]; 
            }
            else{
                recordUser = [ SELECT ID, ContactId FROM User WHERE ID =: UserInfo.getUserId() AND IsPortalEnabled = TRUE LIMIT 1 ];
            }
            
            System.debug( 'NewApplicationDetailComponentController-recordUser:-\n' + JSON.serialize( recordUser ) );
           
            this.recordContact = [ SELECT ID, FirstName, LastName, Phone, OtherPhone, Email, Birthdate,Gender__c,Ethnicity__c,Nationality__c,  
                                  MailingCountry, MailingStreet, MailingCity, MailingPostalCode,Citizenship_Status__c,MailingState,
                                  Program_Code__c, Program_Consideration__c, Program_Type__c,Visa_Expiration_Date__c,Visa_Type__c,
                                  Country_of_Citizenship__c,Visa_School_Name__c,Visa_School_Address__c,Visa_School_City__c,
                                  Visa_School_State__c,Visa_School_Country__c,Visa_School_Zip__c,Referral_First_Name__c,Applcation_Submitted_count__c ,
                                  Alien_Registration_Number__c,SSN__c,Eligible_for_Military_Benefits__c,Military_Branch__c,
                                  Affiliation__c,ETS_EAS__c,Certificate_or_NOBE__c,Authorize__c,Start_Date_of_Service__c,
                                  End_Date_of_Service__c,Referral_Last_Name__c,Referral_Email__c,Referral_Phone__c,
                                  Emergency_First_Name__c,Emergency_Last_Name__c,Emergency_Relationship__c,
                                  Emergency_Contact_Phone__c,Student_Survey_Completed__c,Lead_Type__c
                                  FROM Contact
                                  WHERE ID =: recordUser.ContactId
                                 ];
            
            
            if( this.recordContact.Program_Type__c == 'Ground' ) {
                this.CampusOption = 'On Campus';
            }
            else {
                this.CampusOption = this.recordContact.Program_Type__c;
            }
           
            /*displaying goBackToSummary Button Except first application*/ 
            goBackToSummaryDiplay();
             if (ApexPages.currentPage().getParameters().get('newApplication') == 'true'){
                isgobacktosummary=true;
            }
          
          //   this.isFirstApplication = true;
          //  this.isAlreadySubmitted = false;
            this.recordApplication = getApplication();
            
            if(this.recordApplication.Country_of_Citizenship__c!=null){
                this.selectedVal= '[' + this.recordApplication.Country_of_Citizenship__c + ']';
                system.debug( 'server Side Value'+this.selectedVal );
            }
            
            if ( this.recordApplication.id != null && this.recordApplication.Application_Status__c != 'Started' ) {
                isAlreadySubmitted = true;
                this.stage =Integer.valueOf( this.recordApplication.Stage__c );
            }
           
            if ( this.recordApplication.Stage__c == null ) {
                this.recordApplication.Stage__c = 1;
            }
            
            if (!isAlreadySubmitted){
                this.stage = Integer.valueOf( this.recordApplication.Stage__c );
            }
            
            if (this.stage == 0) {
                this.stage = 1;
            }
            
            if (this.stage == 1){
               this.countryusUpdates();
            }
            this.covertDateFormat();
            this.checkCampusOptionEnabledOrDisabled();
            
            if( this.recordApplication.Id == NULL ) {
                this.recordApplication.Student__c = this.recordContact.Id;
                system.debug('===isFirstApplication==='+this.isFirstApplication);
                system.debug('===this.recordContact.Program_Type__c==='+this.recordContact.Program_Type__c);
                system.debug('===this.recordContact.Program_Consideration__c==='+this.recordContact.Program_Consideration__c);
                if (this.isFirstApplication){
                    this.recordApplication.Program_Code__c = this.recordContact.Program_Code__c;
                    if(this.recordContact.Program_Consideration__c != null){
                        this.recordApplication.Program_Version__c = this.recordContact.Program_Consideration__c;
                    }
                    
                    if( this.recordContact.Program_Type__c == 'Ground' ) {
                        this.CampusOption = 'On Campus';
                    }else{
                        this.CampusOption = this.recordContact.Program_Type__c;
                    }
                
                }else{
                    this.recordApplication.Program_Code__c  = '';
                    this.recordApplication.Program_Version__c = '';
                    this.CampusOption = '---None---';
                }
            }else{
                this.recordApplication.Program_Code__c  = this.recordApplication.Program_Code__c;
                    this.recordApplication.Program_Version__c =  this.recordApplication.Program_Version__c;
                   if( this.recordApplication.Program_Type__c == 'Ground' ) {
                        this.CampusOption = 'On Campus';
                    }else{
                        this.CampusOption = this.recordApplication.Program_Type__c;
                    }
            }
            ApexPages.addMessage( new ApexPages.Message( ApexPages.Severity.Confirm, System.Label.NewApp_SeveritySuccessMsg ) );
        
        }
        catch( Exception e ) {
            System.debug( 'Exception:-\n' + e.getMessage() );
            ApexPages.addMessage( new ApexPages.Message( ApexPages.Severity.Error,  System.Label.Newapp_SeverityErrorMsg ) );
        }
        finally {
            countriesListItems(); 
            UsaStateListItems();
            
        }
        System.debug( 'recordContact:-\n' + JSON.serialize( this.recordContact ) );
        System.debug( 'recordApplication:-\n' + JSON.serialize( this.recordApplication ) );
    }
  @TestVisible
    private Application__c getApplication() {
       
      try{
          system.debug('====== getApplication '+ isNewApplication);
          List<Application__c> listOfApplications;
          if (isNewApplication){
             listOfApplications = [ SELECT ID,Name, Stage__c,Student__c, Addmission_Representative__c, Preferred_Start_Period__c,
                                  Graduation_Date__c,College_Notes__c,Exp_Startdate__c,
                                  High_School_Name__c,HS_Diploma_Received__c,High_School_Address__c,HS_Degree_Received__c,
                                  HS_Graduation_Date__c,Program_Version__c,
                                  High_School_Address_2__c, High_School_City__c,High_School_State__c,High_School_Zip__c,Program_Code__c,
                                  College_1_Name__c,Notes__c,College_2_Name__c,High_School_Country__c,College_2_Graduation_Date__c,
                                  College_1_Graduation_Date__c, Disability_Accomodations__c,Disability_Explanation__c,
                                  Criminal_History__c, Criminal_History_Explanation__c,College_1_Degree__c,College_2_Degree__c,
                                  Academic_Misconduct__c, Academic_Misconduct_Explanation__c,Short_Essay__c,Essay_Complete__c,
                                  Statistical_Info_Complete__c,Visa_School_Zip__c,Military_Branch__c,
                                  Referral_Info_Complete__c,Application_Status__c,Contact_Last_Name__c,Contact_Email__c,
                                  Visa_Expiration_Date__c,Visa_Type__c,Visa_School_City__c,Country_of_Citizenship__c, 
                                  Visa_School_Name__c,Visa_School_Address__c,Visa_School_State__c,Visa_School_Country__c,
                                  Alien_Registration_Number__c,New_SSN__c,Eligible_for_Military_Benefits__c,Affiliation__c,Citizenship_Status__c, 
                                  ETS_EAS__c,Certificate_or_NOBE__c,Authorize__c,Start_Date_of_Service__c,End_Date_of_Service__c,
                                  Accepted_Agreement__c,Acceptance_Info_Complete__c,Application_Finalized__c,Program_Type__c,
                                  Referral_First_Name__c,Referral_Last_Name__c,Referral_Email__c,Referral_Phone__c,Friend_Referral__c,
                                  App_Finalized_Date__c,Application_Submitted__c,Student__r.name,Application_Fee_Paid__c,Pay_Later__c
                                  FROM Application__c
                                  WHERE Student__c =: this.recordContact.Id
                                  ORDER BY CreatedDate
                                  LIMIT 1                              
                                 ] ;
             if(listOfApplications.size() < 1){
                isFirstApplication = True;
             }else{
                isFirstApplication = False;
             }
            return new Application__c();
        }
        System.debug('NewApplication'+isNewApplication);
        
        if (existingAppId != null){
            listOfApplications = [ SELECT ID,Name, Stage__c,Student__c, Addmission_Representative__c, Preferred_Start_Period__c,
                                  Graduation_Date__c,College_Notes__c,Exp_Startdate__c,
                                  High_School_Name__c,HS_Diploma_Received__c,High_School_Address__c,HS_Degree_Received__c,
                                  HS_Graduation_Date__c,Program_Version__c,Visa_School_Zip__c,
                                  High_School_Address_2__c, High_School_City__c,High_School_State__c,High_School_Zip__c,Program_Code__c,
                                  College_1_Name__c,Notes__c,College_2_Name__c,High_School_Country__c,College_2_Graduation_Date__c,
                                  College_1_Graduation_Date__c, Disability_Accomodations__c,Disability_Explanation__c,
                                  Criminal_History__c, Criminal_History_Explanation__c,College_1_Degree__c,College_2_Degree__c,
                                  Application_Status__c,Visa_School_Country__c,Military_Branch__c,
                                  Academic_Misconduct__c, Academic_Misconduct_Explanation__c,Short_Essay__c,Essay_Complete__c,
                                  Statistical_Info_Complete__c,
                                  Visa_Expiration_Date__c,Visa_Type__c,Visa_School_City__c,Country_of_Citizenship__c, 
                                  Visa_School_Name__c,Visa_School_Address__c,Visa_School_State__c,
                                  Alien_Registration_Number__c,New_SSN__c,Eligible_for_Military_Benefits__c,Affiliation__c,Citizenship_Status__c, 
                                  ETS_EAS__c,Certificate_or_NOBE__c,Authorize__c,Start_Date_of_Service__c,End_Date_of_Service__c,
                                  Referral_Info_Complete__c,Accepted_Agreement__c,Contact_Last_Name__c,Contact_Email__c,
                                  Referral_First_Name__c,Referral_Last_Name__c,Referral_Email__c,Referral_Phone__c,Friend_Referral__c,
                                  Acceptance_Info_Complete__c,Application_Finalized__c,Program_Type__c,App_Finalized_Date__c,Application_Submitted__c,Student__r.name,Application_Fee_Paid__c,Pay_Later__c
                                  FROM Application__c
                                  WHERE Student__c =: this.recordContact.Id AND id=: existingAppId
                                  ORDER BY CreatedDate
                                  LIMIT 1                                                                        
                                 ] ;
        }else{
            
            listOfApplications = [ SELECT ID,Name, Stage__c,Student__c, Addmission_Representative__c, Preferred_Start_Period__c,
                                  Graduation_Date__c,College_Notes__c,Exp_Startdate__c,
                                  High_School_Name__c,HS_Diploma_Received__c,High_School_Address__c,HS_Degree_Received__c,
                                  HS_Graduation_Date__c,Program_Version__c,Visa_School_Zip__c,Visa_School_Country__c,
                                  High_School_Address_2__c, High_School_City__c,High_School_State__c,High_School_Zip__c,Program_Code__c,
                                  College_1_Name__c,Notes__c,College_2_Name__c,High_School_Country__c,College_2_Graduation_Date__c,
                                  College_1_Graduation_Date__c, Disability_Accomodations__c,Disability_Explanation__c,
                                  Criminal_History__c, Criminal_History_Explanation__c,College_1_Degree__c,College_2_Degree__c,
                                  Academic_Misconduct__c, Academic_Misconduct_Explanation__c,Short_Essay__c,Essay_Complete__c,
                                  Statistical_Info_Complete__c,Student__r.name,Military_Branch__c,
                                  Visa_Expiration_Date__c,Visa_Type__c,Visa_School_City__c,Country_of_Citizenship__c,
                                  Visa_School_Name__c,Visa_School_Address__c,Visa_School_State__c,
                                  Alien_Registration_Number__c,New_SSN__c,Eligible_for_Military_Benefits__c,Affiliation__c,Citizenship_Status__c, 
                                  ETS_EAS__c,Certificate_or_NOBE__c,Authorize__c,Start_Date_of_Service__c,End_Date_of_Service__c,
                                  Referral_Info_Complete__c,Application_Status__c,Contact_Last_Name__c,Contact_Email__c,
                                  Referral_First_Name__c,Referral_Last_Name__c,Referral_Email__c,Referral_Phone__c,Friend_Referral__c,
                                  Accepted_Agreement__c,Acceptance_Info_Complete__c,Program_Type__c,Application_Finalized__c,App_Finalized_Date__c,Application_Submitted__c,Application_Fee_Paid__c,Pay_Later__c
                                  FROM Application__c
                                  WHERE Student__c =: this.recordContact.Id
                                  ORDER BY CreatedDate
                                  LIMIT 1                        
                                 ] ;
        }
        
        System.debug( 'getApplication:-\n' + JSON.serialize( listOfApplications ) );
        if( !listOfApplications.isEmpty() ) {
            if (listOfApplications.size() == 1){
                isFirstApplication = true;
                //isNewApplication = true;
            } 
            return listOfApplications.get( 0 );
        }
        isNewApplication = true;
        isFirstApplication = true;
        
        return new Application__c();
       }
        catch( Exception e ) {
            System.debug( 'Exception:-\n' + e.getMessage() );
            System.debug( 'Exception line number:-\n' + e.getlinenumber() );
            ApexPages.addMessage( new ApexPages.Message( ApexPages.Severity.Error, System.Label.Newapp_SeverityErrorMsg ) );
            return new Application__c();
        }
        
    }
    @TestVisible
    private void setSupplementPhoneNumbers() {
        
        System.debug( 'setSupplementPhoneNumbers:-\n' + this.stage );
        System.debug( 'before this.recordContact.Referral_Phone__c:-\n' + this.recordContact.Referral_Phone__c );
        System.debug( 'before this.recordContact.Emergency_Contact_Phone__c:-\n' + this.recordContact.Emergency_Contact_Phone__c );
        System.debug( 'this.hiddenPhoneFriend:-\n' + this.hiddenPhoneFriend );
        System.debug( 'this.hiddenPhoneEmrg:-\n' + this.hiddenPhoneEmrg );
        
        if( this.recordContact.Id != null ) {
            if( String.isNotBlank( this.hiddenPhoneFriend ) ) {
                if( String.isNotBlank( this.recordApplication.Referral_Phone__c ) && !this.recordApplication.Referral_Phone__c.startsWith( '+' ) ) {
                    this.recordApplication.Referral_Phone__c = '+' + this.hiddenPhoneFriend + recordApplication.Referral_Phone__c;
                }
            }
            if( String.isNotBlank( this.hiddenPhoneEmrg ) ) {
                if( String.isNotBlank( this.recordContact.Emergency_Contact_Phone__c ) && !this.recordContact.Emergency_Contact_Phone__c.startsWith( '+' ) ) {
                    this.recordContact.Emergency_Contact_Phone__c = '+' + this.hiddenPhoneEmrg + recordContact.Emergency_Contact_Phone__c;
                }
            }
        }
        System.debug( 'after this.recordContact.Referral_Phone__c:-\n' + this.recordContact.Referral_Phone__c );
        System.debug( 'after this.recordContact.Emergency_Contact_Phone__c:-\n' + this.recordContact.Emergency_Contact_Phone__c );
    }
   
    public void setMessage( String pageMessageType, String pageMessage ) {
       
        this.pageMessageType = pageMessageType;
        this.pageMessage = pageMessage;
    }
   @TestVisible
    private static void sendAutomaticAgreements(Id appId){
       // System.enqueueJob(new sendOnlineAgreements(appId, true));
        System.enqueueJob(new sendOnlineAgreements(appId, null));
    }
    @TestVisible
    private Date parseDateFromString( String strDate ) {
        
        Date dateValue;
        if( String.isNotBlank( strDate ) && strDate.countMatches( '-' ) == 2  ) {
            if( strDate.indexOf('-') == 4 ) { // 1999-01-22
                dateValue = Date.valueOf( strDate );
            }
            else { // 01-22-1999 ==> 01/22/1999
                strDate = strDate.replaceAll( '-', '/' );
                dateValue = Date.parse( strDate );
            }
        }
        return dateValue;
    }
    
     public void covertDateFormat() {
        
        Datetime dateTimeValue;
        System.debug( 'covertDateFormat recordContact:-\n' + JSON.serialize( this.recordContact ) );
        System.debug( 'covertDateFormat recordApplication:-\n' + JSON.serialize( this.recordApplication ) );
        if( this.recordContact != NULL ) {
            dateTimeValue = (Datetime)this.recordContact.BirthDate;
            if( dateTimeValue != NULL ) {
                this.birthDate=String.valueOf( dateTimeValue.format( 'MM-dd-yyyy' ) );
            }
            
            dateTimeValue = (Datetime)this.recordApplication.Visa_Expiration_Date__c;
            if( dateTimeValue != NULL ) {
                this.visaExpDate=String.valueOf( dateTimeValue.format( 'MM-dd-yyyy' ) );
            }
            
            dateTimeValue = ( Datetime ) this.recordApplication.Start_Date_of_Service__c;
            if( dateTimeValue != NULL ) {
                this.militaryStartDate = String.valueOf( dateTimeValue.format( 'MM-dd-yyyy' ) );
            }
            
            dateTimeValue = ( Datetime ) this.recordApplication.End_Date_of_Service__c;
            if( dateTimeValue != NULL ) {
                this.militaryEndDate = String.valueOf( dateTimeValue.format( 'MM-dd-yyyy' ) );
            }
            
            dateTimeValue = ( Datetime ) this.recordApplication.ETS_EAS__c;
            if( dateTimeValue != NULL ) {
                this.estimationDate = String.valueOf( dateTimeValue.format( 'MM-dd-yyyy' ) );
            }
        }
        
        if( this.recordApplication != NULL ) {
            dateTimeValue = (Datetime)this.recordApplication.HS_Graduation_Date__c;
            if( dateTimeValue != NULL ) {
                this.graduationDate=String.valueOf( dateTimeValue.format( 'MM-dd-yyyy' ) );
            }
            
            dateTimeValue = (Datetime)this.recordApplication.College_1_Graduation_Date__c;
            if( dateTimeValue != NULL ) {
                this.collegeGraduationDate1=String.valueOf( dateTimeValue.format( 'MM-dd-yyyy' ) );
            }
            
            dateTimeValue = (Datetime)this.recordApplication.College_2_Graduation_Date__c;
            if( dateTimeValue != NULL ) {
                this.collegeGraduationDate2=String.valueOf( dateTimeValue.format( 'MM-dd-yyyy' ) );
            }
        }
    } 
  
    public void goBackToSummaryDiplay(){
      // system.debug('reconid:'+recordContact.Id);
       list<contact> Applicationslists = [select id, (SELECT ID,Name FROM Applications__r) FROM contact WHERE id =: this.recordContact.Id];
           // system.debug('===Applications.size====='+Applicationslists.size());
            //system.debug('===Applications.size 123====='+Applicationslists[0].Applications__r.size());
           if(Applicationslists[0].Applications__r.size() > 1){
                
                isgobacktosummary=true;
            }else{
                isgobacktosummary=false;
            }
    }
  
     private static Attachment getAttachment(String attId) {
        
        list<Attachment> attachments = [ SELECT Id, Body
                                         FROM Attachment 
                                         WHERE Id =: attId
                                      ];
        if(attachments.isEmpty()) {
            Attachment a = new Attachment();
            return a;
        } else {
            return attachments[0];
        }
    }
    @TestVisible
     private void setStartDate( String strStartPeriod ) {
        
        if( this.recordApplication == NULL || String.isBlank( strStartPeriod ) ) { // October 19, 2019
            return;
        }
        
        strStartPeriod = strStartPeriod.replace( ',', '' ); // October 19 2019
        List<String> listOfTokens = strStartPeriod.split( ' ' );
        if( listOfTokens == NULL || listOfTokens.isEmpty() || listOfTokens.size() != 3 ) {
            return;
        }
         system.debug('==this.recordApplication.Exp_Startdate__c==='+this.recordApplication.Exp_Startdate__c);
        try {
            this.recordApplication.Exp_Startdate__c = Date.newInstance
                                                       ( 
                                                         Integer.valueOf( listOfTokens[ 2 ] ), // 2019
                                                         this.getMonthNumber( listOfTokens[ 0 ] ), // 10
                                                         Integer.valueOf( listOfTokens[ 1 ] ) // 19
                                                       );
         system.debug('==this.recordApplication.Exp_Startdate__c==='+this.recordApplication.Exp_Startdate__c);            
        }
        catch( Exception e ) {
            System.debug( 'Exception in setStartDate:-\n' + e.getMessage() + '\nLineNumber:-\n' + e.getLineNumber() );
        }
        System.debug( 'this.recordApplication.Exp_Startdate__c:-\n' + this.recordApplication.Exp_Startdate__c );
    }
    @TestVisible
    private Integer getMonthNumber( String strMonthName ) { // October
        
        Integer intMonthNumber;
        System.debug( 'getMonthNumber-strMonthName:-\n' + strMonthName );
        if( String.isBlank( strMonthName ) ) {
            return intMonthNumber;
        }
        strMonthName = strMonthName.toLowerCase();
        
        switch on strMonthName {
            
            when 'january' { 
                intMonthNumber=1;
            }
            when 'february' { 
                intMonthNumber=2;
            }
            when 'march' { 
                intMonthNumber=3;
            }
            when 'april' { 
                intMonthNumber=4;
            }
            when 'may' { 
                intMonthNumber=5;
            }
            when 'june' { 
                intMonthNumber=6;
            }
            when 'july' { 
                intMonthNumber=7;
            }
            when 'august' { 
                intMonthNumber=8;
            }
            when 'september' { 
                intMonthNumber=10;
            }
            when 'october' { 
                intMonthNumber=10;
            }
            when 'november' { 
                intMonthNumber=11;
            }
            when 'december' { 
                intMonthNumber=12;
            }
        }
        System.debug( 'getMonthNumber-intMonthNumber:-\n' + intMonthNumber );
        return intMonthNumber;
    }
    
    /* CONVERT STRING AUGUST 01, 2016 INTO DATE TYPE*/
    public static date strToDate(string dateString){
        try {
            
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
    public static String doUploadAttachment(String appId, String attachmentBody, String attachmentName, String attachmentId) {
     
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
                    Application__c application=[select id,HS_Diploma_Received__c from Application__c where id=:appId];
                    if(application !=null){
                        application.HS_Diploma_Received__c ='Received';
                        update application;
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
    
 }