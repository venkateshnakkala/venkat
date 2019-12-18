global class uplodersRequestController {
    public final Application__c applicationobj{get;set;}
    public static string contactId {get;set;}
    public static string contactName {get;set;}
    
    public list<picklistClass> listOfPicklist{get;set;}
    public List<String> fieldsUpdated =new List<String>();
    public List<String> RejectedfieldsUpdated =new List<String>();
    public List<String> RejectedfieldsUpdatedReason =new List<String>();
    
    public List<String> AcceptedfieldsUpdated =new List<String>();
    
    public Application__c App;
    String [] Docs = new String []{'HS Diploma', 'College Transcript', 'Computer Specs', 'Parents Photo ID','Master Promissory Note','Entrance Counseling','PLUS Master Promissory Note','Parent Tax Return 2017','Parent Tax Transcripts 2016','Spouse Tax Return 2017','Spouse Tax Transcript 2016','Student Tax Return 2017','Student Tax Transcripts 2016','I20','I539','I94','Passport','TOEFL','US Visa','Bank Statement','DD214','CCAF','W-2 Form','ISIR C-Code 030 Selective Service','ISIR C-Code 146 Citizenship','Default Resolution Letter','Dependency Override Statement','Legal Guardianship Document','Ward of Court Document'};
        String [] DocsStatus = new String []{'HS_Diploma_Received__c', 'College_Transcript_Received__c', 'Computer_Specs_Received__c', 'Photo_Id_Received__c','Master_Promissory_Note__c','Entrance_Counseling__c','PLUS_Master_Promissory_Note__c','Parent_Tax_Return2017__c','Parent_Tax_Transcripts2016__c','Spouse_Tax_Return_2017__c','Spouse_Tax_Transcript2016__c','Student_Tax_Return_2017__c','Student_Tax_Transcripts_2016__c','I20_Received__c','I539_Received__c','I94_Received__c','Passport_Received__c','TOEFL_Received__c','US_Visa_Received__c','Bank_Statement_Received__c','DD214_Received__c','CCAF_Recieved__c','W2_Form__c','ISIR_CCode_030_Selective_Service__c','ISIR_CCode_146_Citizenship__c','Default_Resolution_Letter__c','Dependency_Override_Statement__c','Legal_Guardianship_Document__c','Ward_of_Court_Document__c'};
            Application__c updateApplication =new Application__c();
    public uplodersRequestController(ApexPages.StandardController stdCont){
        applicationobj = (Application__c)stdCont.getRecord();
        system.debug(applicationobj.Id);
        App = [SELECT id,Name,Student__c,Student__r.Name,Contact_Email__c,Academic_Misconduct__c,Application_Number__c,Addmission_Representative__c,Academic_Misconduct_Explanation__c,Accepted_Agreement__c,Application_Status__c,Applicant_Age__c,Application_Finalized__c,College_1_Degree__c,
               College_1_Graduation_Date__c,College_1_Name__c,College_2_Degree__c,College_2_Graduation_Date__c,College_2_Name__c,College_Notes__c,Criminal_History__c,Criminal_History_Explanation__c,Preferred_Start_Period__c,
               HS_Degree_Received__c,Disability_Accomodations__c,Disability_Explanation__c,Friend_Referral__c,Graduation_Date__c,HS_Graduation_Date__c,High_School_Address__c,High_School_Address_2__c,
               High_School_City__c,High_School_Country__c,High_School_Name__c,High_School_State__c,High_School_Zip__c,Parent__c,Preferred_Start_Date__c,Program__c,Program_Code__c,Referral__c,Short_Essay__c,Status_Date__c,
               Transcript_Request__c, Student_Info_Complete__c, Parent_Info_Complete__c, Veteran_Info_Complete__c, College_Info_Complete__c, Citizen_Info_Complete__c, Essay_Complete__c,Emergency_Contact__c, Emergency_Contact_Info_Complete__c,
               Program_Info_Complete__c, High_School_Info_Complete__c, Criminal_History_Complete__c,Discipline_Section_Complete__c,Disability_Info_Complete__c, Statistical_Info_Complete__c, Referral_Info_Complete__c,
               Acceptance_Info_Complete__c,I539_Received__c,College_Transcript_Received__c,Photo_Id_Received__c,Computer_Specs_Received__c,HS_Diploma_Received__c,CCAF_Recieved__c,DD214_Received__c,Passport_Received__c,Program_Version__c,  
               I20_Received__c,US_Visa_Received__c,I94_Received__c,TOEFL_Received__c,Bank_Statement_Received__c,Application_Submitted__c,HS_Transcript_Evaluation_Recieved__c, Pay_Later__c, Application_Fee_Paid__c, Payment_Confirmation__c,Master_Promissory_Note__c,Entrance_Counseling__c,PLUS_Master_Promissory_Note__c,
               Parent_Tax_Return2017__c,Parent_Tax_Transcripts2016__c,Spouse_Tax_Return_2017__c,Spouse_Tax_Transcript2016__c,Student_Tax_Return_2017__c,Student_Tax_Transcripts_2016__c,W2_Form__c,ISIR_CCode_030_Selective_Service__c,ISIR_CCode_146_Citizenship__c,Default_Resolution_Letter__c,Dependency_Override_Statement__c,
               Legal_Guardianship_Document__c,Ward_of_Court_Document__c,AM_Docs_Total__c,AM_Docs_Complete__c
               FROM Application__c where id=: applicationobj.Id ];
        
        SObject Apps=(SObject)App;
        listOfPicklist = new list<picklistClass>();
        picklistClass tempPicklist;
        //Add Attachments
        //   // viewfile
        //             applicationobj.id
        
        for(Integer i=0;i<Docs.size();i++){
            tempPicklist = new picklistClass();
            tempPicklist.picklistString =Docs[i];
            tempPicklist.Statuses=(String)Apps.get(DocsStatus[i]);
            //  tempPicklist.viewfile='00P0t000002radL'; // comment this line it is static value(hardcoded)
            /*  To view attachments related to picklist  */
            if(Docs[i]=='HS Diploma'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND (Name LIKE '%hsDiploma%'  OR Name LIKE '%High School Diploma%') ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }
                catch(Exception ex){}
            }
            if(Docs[i]=='College Transcript'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%collegeTranscript%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
                
            }
            if(Docs[i]=='Computer Specs'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%computerSpecs%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='Parents Photo ID'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%parentsPhotoID%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='Master Promissory Note'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%masterPromissoryNote%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='Entrance Counseling'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%EntranceCounseling%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            
            if(Docs[i]=='PLUS Master Promissory Note'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%PLUSMasterPromissory%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='Parent Tax Return 2017'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%parentTaxReturn%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='Parent Tax Transcripts 2016'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%parentTaxTranscripts%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='Spouse Tax Return 2017'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%spouseTaxReturn%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='Spouse Tax Transcript 2016'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%spouseTaxTranscript%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            
            if(Docs[i]=='Student Tax Return 2017'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%studentTaxReturn%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='Student Tax Transcripts 2016'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%studentTaxTranscripts%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='I20'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%i20%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='I539'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%I-539%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='I94'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%I94%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='Passport'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%passport%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            
            if(Docs[i]=='TOEFL'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%TOEFL%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='US Visa'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%USVisa%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            
            if(Docs[i]=='Bank Statement'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%bankStatement%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='DD214'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%DD214%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='CCAF'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%CCAF%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='W-2 Form'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%w2Form%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            
            if(Docs[i]=='ISIR C-Code 030 Selective Service'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%ISIRCCode030%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='ISIR C-Code 146 Citizenship'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%ISIRCCode146%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            
            if(Docs[i]=='Default Resolution Letter'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%defaultResolutionLetter%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='Dependency Override Statement'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%dependencyOverrideStmt%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='Legal Guardianship Document'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%legalGuardianshipDoc%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            if(Docs[i]=='Ward of Court Document'){
                try{
                    Attachment at=[SELECT Id,Name FROM Attachment WHERE ParentId =: applicationobj.Id AND Name LIKE '%wardOfCourtDoc%' ORDER BY CreatedDate DESC Limit 1];
                    if(at!=null)
                        tempPicklist.viewfile=at.id;
                }catch(Exception ex){}
            }
            
            
            
            listOfPicklist.add(tempPicklist);
            
        }
    }
    public void save() {
        system.debug('listOfPicklist '+listOfPicklist);
        system.debug('picklistString'+ listOfPicklist.size());
        system.debug('Application Id'+ applicationobj.id);
        String Studentemail;
        if(listOfPicklist.size()>0){
            if(applicationobj.id!=null){
                Studentemail=App.Contact_Email__c;
                updateApplication=App;
                // updateApplication.id=applicationobj.id;
                contactId = App.Student__c;
                contactName=App.Student__r.Name;
                system.debug('contactName'+ contactName);
                
                for(picklistClass pkclass:listOfPicklist){
                    //call function according to selected, Rejected,Accepted
                    
                    if(pkclass.Accepted==True){
                        Accepted(pkclass);
                    }
                    If(pkclass.Rejected==True){
                        Rejected(pkclass);
                    }
                    If(pkclass.selected==True){
                        Request(pkclass);
                    }
                }
                Update updateApplication;
                if(fieldsUpdated.size()>0){
                    email(fieldsUpdated,Studentemail,updateApplication.id);
                }
                if(AcceptedfieldsUpdated.size()>0){
                    emailAccept(AcceptedfieldsUpdated,Studentemail);
                }
                if(RejectedfieldsUpdated.size()>0 && RejectedfieldsUpdatedReason.Size()>0){
                    emailReject(RejectedfieldsUpdated,RejectedfieldsUpdatedReason,Studentemail,updateApplication.id);
                }
                
                
            }
            
        }
        
        
    }
    public void Request(picklistClass pkclass){
        /// added by Lavanya to check null 
        if(updateApplication.AM_Docs_Total__c== NULL)
        {
            updateApplication.AM_Docs_Total__c=0;
        }
        /// End of changes by Lavanya
        
        if(pkclass.picklistString=='HS Diploma' && pkclass.selected==True){
            updateApplication.HS_Diploma_Received__c='Request';
            if(pkclass.viewfile==null)
                updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='College Transcript' && pkclass.selected==True){
            updateApplication.College_Transcript_Received__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='Computer Specs' && pkclass.selected==True){
            updateApplication.Computer_Specs_Received__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='Parents Photo ID' && pkclass.selected==True){
            updateApplication.Photo_Id_Received__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
        }
        
        if(pkclass.picklistString=='Master Promissory Note' && pkclass.selected==True){
            updateApplication.Master_Promissory_Note__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='Entrance Counseling' && pkclass.selected==True){
            updateApplication.Entrance_Counseling__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='PLUS Master Promissory Note' && pkclass.selected==True){
            updateApplication.PLUS_Master_Promissory_Note__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='Parent Tax Return 2017' && pkclass.selected==True){
            updateApplication.Parent_Tax_Return2017__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='Parent Tax Transcripts 2016' && pkclass.selected==True){
            updateApplication.Parent_Tax_Transcripts2016__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='Spouse Tax Return 2017' && pkclass.selected==True){
            updateApplication.Spouse_Tax_Return_2017__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='Spouse Tax Transcript 2016' && pkclass.selected==True){
            updateApplication.Spouse_Tax_Transcript2016__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='Student Tax Return 2017' && pkclass.selected==True){
            updateApplication.Student_Tax_Return_2017__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='Student Tax Transcripts 2016' && pkclass.selected==True){
            updateApplication.Student_Tax_Transcripts_2016__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='I20' && pkclass.selected==True){
            updateApplication.I20_Received__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='I539' && pkclass.selected==True){
            updateApplication.I539_Received__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='I94' && pkclass.selected==True){
            updateApplication.I94_Received__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='Passport' && pkclass.selected==True){
            updateApplication.Passport_Received__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='TOEFL' && pkclass.selected==True){
            updateApplication.TOEFL_Received__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='US Visa' && pkclass.selected==True){
            updateApplication.US_Visa_Received__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='Bank Statement' && pkclass.selected==True){
            updateApplication.Bank_Statement_Received__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='DD214' && pkclass.selected==True){
            updateApplication.DD214_Received__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='CCAF' && pkclass.selected==True){
            updateApplication.CCAF_Recieved__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='W-2 Form' && pkclass.selected==True){
            updateApplication.W2_Form__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            
            fieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='ISIR C-Code 030 Selective Service' && pkclass.selected==True){
            updateApplication.ISIR_CCode_030_Selective_Service__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='ISIR C-Code 146 Citizenship' && pkclass.selected==True){
            updateApplication.ISIR_CCode_146_Citizenship__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='Default Resolution Letter' && pkclass.selected==True){
            updateApplication.Default_Resolution_Letter__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='Dependency Override Statement' && pkclass.selected==True){
            updateApplication.Dependency_Override_Statement__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='Legal Guardianship Document' && pkclass.selected==True){
            updateApplication.Legal_Guardianship_Document__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='Ward of Court Document' && pkclass.selected==True){
            updateApplication.Ward_of_Court_Document__c='Request';
            if(pkclass.viewfile==null)
            updateApplication.AM_Docs_Total__c+=1;
            fieldsUpdated.add(pkclass.picklistString);
        }
        
    }
    public void Accepted(picklistClass pkclass){
        // added by Lavanya to check null 
        if(updateApplication.AM_Docs_Complete__c== NULL)
        {
            updateApplication.AM_Docs_Complete__c=0;
        }
        /// End of changes by Lavanya 
        
        if(pkclass.picklistString=='HS Diploma' && pkclass.Accepted==True){
            updateApplication.HS_Diploma_Received__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='College Transcript' && pkclass.Accepted==True){
            updateApplication.College_Transcript_Received__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='Computer Specs' && pkclass.Accepted==True){
            updateApplication.Computer_Specs_Received__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='Parents Photo ID' && pkclass.Accepted==True){
            updateApplication.Photo_Id_Received__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
        }
        
        if(pkclass.picklistString=='Master Promissory Note' && pkclass.Accepted==True){
            updateApplication.Master_Promissory_Note__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='Entrance Counseling' && pkclass.Accepted==True){
            updateApplication.Entrance_Counseling__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='PLUS Master Promissory Note' && pkclass.Accepted==True){
            updateApplication.PLUS_Master_Promissory_Note__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='Parent Tax Return 2017' && pkclass.Accepted==True){
            updateApplication.Parent_Tax_Return2017__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='Parent Tax Transcripts 2016' && pkclass.Accepted==True){
            updateApplication.Parent_Tax_Transcripts2016__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='Spouse Tax Return 2017' && pkclass.Accepted==True){
            updateApplication.Spouse_Tax_Return_2017__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='Spouse Tax Transcript 2016' && pkclass.Accepted==True){
            updateApplication.Spouse_Tax_Transcript2016__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='Student Tax Return 2017' && pkclass.Accepted==True){
            updateApplication.Student_Tax_Return_2017__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='Student Tax Transcripts 2016' && pkclass.Accepted==True){
            updateApplication.Student_Tax_Transcripts_2016__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='I20' && pkclass.Accepted==True){
            updateApplication.I20_Received__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='I539' && pkclass.Accepted==True){
            updateApplication.I539_Received__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='I94' && pkclass.Accepted==True){
            updateApplication.I94_Received__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='Passport' && pkclass.Accepted==True){
            updateApplication.Passport_Received__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='TOEFL' && pkclass.Accepted==True){
            updateApplication.TOEFL_Received__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='US Visa' && pkclass.Accepted==True){
            updateApplication.US_Visa_Received__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='Bank Statement' && pkclass.Accepted==True){
            updateApplication.Bank_Statement_Received__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='DD214' && pkclass.Accepted==True){
            updateApplication.DD214_Received__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='CCAF' && pkclass.Accepted==True){
            updateApplication.CCAF_Recieved__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='W-2 Form' && pkclass.Accepted==True){
            updateApplication.W2_Form__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
            
        }
        if(pkclass.picklistString=='ISIR C-Code 030 Selective Service' && pkclass.Accepted==True){
            updateApplication.ISIR_CCode_030_Selective_Service__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='ISIR C-Code 146 Citizenship' && pkclass.Accepted==True){
            updateApplication.ISIR_CCode_146_Citizenship__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='Default Resolution Letter' && pkclass.Accepted==True){
            updateApplication.Default_Resolution_Letter__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='Dependency Override Statement' && pkclass.Accepted==True){
            updateApplication.Dependency_Override_Statement__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='Legal Guardianship Document' && pkclass.Accepted==True){
            updateApplication.Legal_Guardianship_Document__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
        }
        if(pkclass.picklistString=='Ward of Court Document' && pkclass.Accepted==True){
            updateApplication.Ward_of_Court_Document__c='Accepted';
            if(pkclass.Statuses!='Accepted')
            updateApplication.AM_Docs_Complete__c+=1;
            AcceptedfieldsUpdated.add(pkclass.picklistString);
        }
        
    }
    public void Rejected(picklistClass pkclass){
        if(pkclass.picklistString=='HS Diploma' && pkclass.Rejected==True){
            updateApplication.HS_Diploma_Received__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
            
        }
        if(pkclass.picklistString=='College Transcript' && pkclass.Rejected==True){
            updateApplication.College_Transcript_Received__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
            
            
        }
        if(pkclass.picklistString=='Computer Specs' && pkclass.Rejected==True){
            updateApplication.Computer_Specs_Received__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
            
            
        }
        if(pkclass.picklistString=='Parents Photo ID' && pkclass.Rejected==True){
            updateApplication.Photo_Id_Received__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
            
        }
        
        if(pkclass.picklistString=='Master Promissory Note' && pkclass.Rejected==True){
            updateApplication.Master_Promissory_Note__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
            
        }
        if(pkclass.picklistString=='Entrance Counseling' && pkclass.Rejected==True){
            updateApplication.Entrance_Counseling__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
            
            
        }
        if(pkclass.picklistString=='PLUS Master Promissory Note' && pkclass.Rejected==True){
            updateApplication.PLUS_Master_Promissory_Note__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
        }
        if(pkclass.picklistString=='Parent Tax Return 2017' && pkclass.Rejected==True){
            updateApplication.Parent_Tax_Return2017__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
        }
        if(pkclass.picklistString=='Parent Tax Transcripts 2016' && pkclass.Rejected==True){
            updateApplication.Parent_Tax_Transcripts2016__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
        }
        if(pkclass.picklistString=='Spouse Tax Return 2017' && pkclass.Rejected==True){
            updateApplication.Spouse_Tax_Return_2017__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
            
        }
        if(pkclass.picklistString=='Spouse Tax Transcript 2016' && pkclass.Rejected==True){
            updateApplication.Spouse_Tax_Transcript2016__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
            
        }
        if(pkclass.picklistString=='Student Tax Return 2017' && pkclass.Rejected==True){
            updateApplication.Student_Tax_Return_2017__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
            
        }
        if(pkclass.picklistString=='Student Tax Transcripts 2016' && pkclass.Rejected==True){
            updateApplication.Student_Tax_Transcripts_2016__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
        }
        if(pkclass.picklistString=='I20' && pkclass.Rejected==True){
            updateApplication.I20_Received__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
        }
        if(pkclass.picklistString=='I539' && pkclass.Rejected==True){
            updateApplication.I539_Received__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
        }
        if(pkclass.picklistString=='I94' && pkclass.Rejected==True){
            updateApplication.I94_Received__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
        }
        if(pkclass.picklistString=='Passport' && pkclass.Rejected==True){
            updateApplication.Passport_Received__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
        }
        if(pkclass.picklistString=='TOEFL' && pkclass.Rejected==True){
            updateApplication.TOEFL_Received__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
        }
        if(pkclass.picklistString=='US Visa' && pkclass.Rejected==True){
            updateApplication.US_Visa_Received__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
            
        }
        if(pkclass.picklistString=='Bank Statement' && pkclass.Rejected==True){
            updateApplication.Bank_Statement_Received__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
        }
        if(pkclass.picklistString=='DD214' && pkclass.Rejected==True){
            updateApplication.DD214_Received__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
        }
        if(pkclass.picklistString=='CCAF' && pkclass.Rejected==True){
            updateApplication.CCAF_Recieved__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
        }
        if(pkclass.picklistString=='W-2 Form' && pkclass.Rejected==True){
            updateApplication.W2_Form__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
            
        }
        if(pkclass.picklistString=='ISIR C-Code 030 Selective Service' && pkclass.Rejected==True){
            updateApplication.ISIR_CCode_030_Selective_Service__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
        }
        if(pkclass.picklistString=='ISIR C-Code 146 Citizenship' && pkclass.Rejected==True){
            updateApplication.ISIR_CCode_146_Citizenship__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
        }
        if(pkclass.picklistString=='Default Resolution Letter' && pkclass.Rejected==True){
            updateApplication.Default_Resolution_Letter__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
        }
        if(pkclass.picklistString=='Dependency Override Statement' && pkclass.Rejected==True){
            updateApplication.Dependency_Override_Statement__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
        }
        if(pkclass.picklistString=='Legal Guardianship Document' && pkclass.Rejected==True){
            updateApplication.Legal_Guardianship_Document__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
        }
        if(pkclass.picklistString=='Ward of Court Document' && pkclass.Rejected==True){
            updateApplication.Ward_of_Court_Document__c='Rejected';
            RejectedfieldsUpdated.add(pkclass.picklistString);
            RejectedfieldsUpdatedReason.add(pkclass.RejectedReason);
        }
        
    }
    
    public static void email(List<String> listOfPicklists,String Emailadd,string Appid){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<Messaging.SingleEmailMessage> finalMails = new List<Messaging.SingleEmailMessage>();
        List<String> toAddresses = new List<String>(); 
        if(Emailadd!=null){
            toAddresses.add(Emailadd);
            system.debug('==toAddresses===='+toAddresses);
        }
        if(toAddresses.size() > 0){
            system.debug('==toAddresses.size()===='+toAddresses.size());
             Lafilmschool_Application__mdt appFlow = [select Enable_Flow__c,CommunityLink__c  from Lafilmschool_Application__mdt where DeveloperName= 'ApplicationFlow'];
              EmailTemplate newET=[SELECT Body,Description,FolderId,FolderName,HtmlValue,Id,Name,Subject FROM EmailTemplate WHERE Name ='Document Requested New'];
              system.debug('==appFlow.Enable_Flow__c==='+appFlow.Enable_Flow__c);
            EmailTemplate ET=[SELECT Body,Description,FolderId,FolderName,HtmlValue,Id,Name,Subject FROM EmailTemplate WHERE Name = 'Document Requested'];
            Messaging.SingleEmailMessage mailTemp = new Messaging.SingleEmailMessage();
            if(appFlow.Enable_Flow__c =='TRUE'){
                mailTemp.setTemplateID(newET.id);
            }else{
                mailTemp.setTemplateID(ET.id);
            }
              
            mailTemp.setTargetObjectId(contactId);
            mailTemp.setToAddresses(toAddresses);
            mailTemp.setSenderDisplayName('LA Film School');        
            //mailTemp.setSubject(ET.Subject);        
            //mailTemp.setBccSender(false);        
            mailTemp.setUseSignature(false);
            
            //mailTemp.setHtmlBody(EBody);  
            // mailTemp.setSaveAsActivity(True);
            finalMails.add(mailTemp); 
            Savepoint sp = Database.setSavepoint();
            system.debug('==before===');
            Messaging.sendEmail(finalMails);
            system.debug('==after===');
            Database.rollback(sp);
             system.debug('==appFlow.CommunityLink__c==='+appFlow.CommunityLink__c);
            List<Messaging.SingleEmailMessage> lstMsgsToSend = new List<Messaging.SingleEmailMessage>();
            String Communitylink = CommunityLink__c.getValues('CommunityLink').CommunityLink__c;
          
            for (Messaging.SingleEmailMessage email : finalMails) {
                Messaging.SingleEmailMessage emailToSend = new Messaging.SingleEmailMessage();
                emailToSend.setToAddresses(email.getToAddresses());
                //  emailToSend.setPlainTextBody(email.email.getHtmlBody()());
                String EBody = email.getPlainTextBody();
                
                system.debug('EBody'+EBody);
                for(String doc:listOfPicklists){
                    EBody+='<br/>'+doc;
                }
               /*  EBody+='<br/>'+' Please Upload Document To Given Link'+'<br/><br/>';
                EBody+=Communitylink+'/Application?id='+Appid+'&goToSection=uploadDetailsSection';*/
               
              if(appFlow.Enable_Flow__c =='TRUE' ){
                    EBody+='<br/>'+' Please Upload Document To Given Link'+'<br/><br/>';
                //EBody+=appFlow.CommunityLink__c+'/NewApplication?id='+Appid+'&goToSection=uploadDetailsSection';
                   EBody+=appFlow.CommunityLink__c+'/NewSignAndUpload?appId='+Appid;
                    
                }
                else
                {
                    EBody+='<br/>'+' Please Upload Document To Given Link'+'<br/><br/>';
                    EBody+=Communitylink+'/Application?id='+Appid+'&goToSection=uploadDetailsSection';  
                }
                      
                
                emailToSend.setHTMLBody(EBody);
                emailToSend.setSubject(email.getSubject());
                // emailToSend.setBccAddresses(email.getBccAddresses());
                // emailToSend.setCcAddresses(email.getCcAddresses());
                
                
                lstMsgsToSend.add(emailToSend);
            }
            
            if(!Test.isRunningTest())
                Messaging.sendEmail(lstMsgsToSend);
            
            
            
            
            
        }
    }
    public static void emailReject(List<String> listOfPicklists,List<String> RejectedfieldsUpdatedReasons,String Emailadd,string Appid){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<Messaging.SingleEmailMessage> finalMails = new List<Messaging.SingleEmailMessage>();
        List<String> toAddresses = new List<String>(); 
        if(Emailadd!=null){
            toAddresses.add(Emailadd);
        }
        if(toAddresses.size() > 0){
            EmailTemplate ET=[SELECT Body,Description,FolderId,FolderName,HtmlValue,Id,Name,Subject FROM EmailTemplate WHERE Name = 'Document Rejected'];
            Messaging.SingleEmailMessage mailTemp = new Messaging.SingleEmailMessage();
            mailTemp.setTemplateID(ET.id);  
            mailTemp.setTargetObjectId(contactId);
            mailTemp.setToAddresses(toAddresses);
            mailTemp.setSenderDisplayName('LA Film School');        
            //mailTemp.setSubject(ET.Subject);        
            //mailTemp.setBccSender(false);        
            mailTemp.setUseSignature(false);
            
            //mailTemp.setHtmlBody(EBody);  
            // mailTemp.setSaveAsActivity(True);
            finalMails.add(mailTemp); 
            Savepoint sp = Database.setSavepoint();
            Messaging.sendEmail(finalMails);
            Database.rollback(sp);
            String Communitylink = CommunityLink__c.getValues('CommunityLink').CommunityLink__c;
            List<Messaging.SingleEmailMessage> lstMsgsToSend = new List<Messaging.SingleEmailMessage>();
            for (Messaging.SingleEmailMessage email : finalMails) {
                
                Messaging.SingleEmailMessage emailToSend = new Messaging.SingleEmailMessage();
                emailToSend.setToAddresses(email.getToAddresses());
                
                //  emailToSend.setPlainTextBody(email.email.getHtmlBody()());
                String EBody = email.getPlainTextBody();
                
                String htmlBody = '';
                htmlBody = '<br/><br/> <table border="1" style="border-collapse: collapse"><tr><th>Document Name</th><th>Rejection Reason</th></tr>';
                
                
                for(String doc:listOfPicklists){
                    integer i=0;
                    system.debug(RejectedfieldsUpdatedReasons[i] );
                    htmlBody += '<tr><td>' + doc + '</td><td>' + RejectedfieldsUpdatedReasons[i] + '</td></tr>';
                    i++;
                }
                
                htmlBody += '</table>';
                EBody+=htmlBody;
                EBody+='<br/>'+' Please Upload Document To Given Link'+'<br/><br/>';
                EBody+=Communitylink+'/Application?id='+Appid+'&goToSection=uploadDetailsSection';
                
                emailToSend.setHTMLBody(EBody);
                emailToSend.setSubject(email.getSubject());
                // emailToSend.setBccAddresses(email.getBccAddresses());
                // emailToSend.setCcAddresses(email.getCcAddresses());
                
                
                lstMsgsToSend.add(emailToSend);
            }
            
            if(!Test.isRunningTest())
                Messaging.sendEmail(lstMsgsToSend);
            
            
            
            
            
        }
    }
    public static void emailAccept(List<String> listOfPicklists,String Emailadd){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<Messaging.SingleEmailMessage> finalMails = new List<Messaging.SingleEmailMessage>();
        List<String> toAddresses = new List<String>(); 
        if(Emailadd!=null){
            toAddresses.add(Emailadd);
        }
        
        if(toAddresses.size() > 0){
            EmailTemplate ET=[SELECT Body,Description,FolderId,FolderName,HtmlValue,Id,Name,Subject FROM EmailTemplate WHERE Name = 'Document Accepted'];
            Messaging.SingleEmailMessage mailTemp = new Messaging.SingleEmailMessage();
            mailTemp.setTemplateID(ET.id);  
            mailTemp.setTargetObjectId(contactId);
            mailTemp.setToAddresses(toAddresses);
            mailTemp.setSenderDisplayName('LA Film School');        
            //mailTemp.setSubject(ET.Subject);        
            //mailTemp.setBccSender(false);        
            mailTemp.setUseSignature(false);
            
            //mailTemp.setHtmlBody(EBody);  
            // mailTemp.setSaveAsActivity(True);
            finalMails.add(mailTemp); 
            Savepoint sp = Database.setSavepoint();
            Messaging.sendEmail(finalMails);
            Database.rollback(sp);
            
            List<Messaging.SingleEmailMessage> lstMsgsToSend = new List<Messaging.SingleEmailMessage>();
            for (Messaging.SingleEmailMessage email : finalMails) {
                Messaging.SingleEmailMessage emailToSend = new Messaging.SingleEmailMessage();
                emailToSend.setToAddresses(email.getToAddresses());
                //  emailToSend.setPlainTextBody(email.email.getHtmlBody()());
                String EBody = email.getPlainTextBody();
                
                system.debug('EBody'+EBody);
                for(String doc:listOfPicklists){
                    EBody+='<br/>'+doc;
                }
                
                emailToSend.setHTMLBody(EBody);
                emailToSend.setSubject(email.getSubject());
                // emailToSend.setBccAddresses(email.getBccAddresses());
                // emailToSend.setCcAddresses(email.getCcAddresses());
                
                
                lstMsgsToSend.add(emailToSend);
            }
            
            if(!Test.isRunningTest())
                Messaging.sendEmail(lstMsgsToSend);
            
            
            
            
            
        }
    }
    
    
    public class picklistClass{
        public boolean selected{get;set;}
        public boolean Accepted{get;set;}
        public boolean Rejected{get;set;}
        public string picklistString{get;set;}
        public string RejectedReason{get;set;}
        public string Statuses{get;set;}
        public string viewfile{get;set;}
        public Integer counter { get; set; }
        
        
    }
}