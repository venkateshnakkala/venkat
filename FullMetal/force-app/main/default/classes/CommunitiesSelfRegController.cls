/**
 * An apex page controller that supports self registration of users in communities that allow self registration
 */
public class CommunitiesSelfRegController {

    public String firstName {get; set;}
    public String lastName {get; set;}
    public String email {get; set;}
    public String password {get; set {password = value == null ? value : value.trim(); } }
    public String confirmPassword {get; set { confirmPassword = value == null ? value : value.trim(); } }
    public String ValidCode {get; set;}
    public boolean codeSet {get; private set;}
    private Id contactId {get;set;}
    public String schoolId{get;set;}
    public String paras{get;set;}
        
    public CommunitiesSelfRegController() 
    {
       if(ApexPages.currentPage().getParameters().get('sId') != null){         
           schoolId =ApexPages.currentPage().getParameters().get('sId');
           paras='?sId='+ ApexPages.currentPage().getParameters().get('sId');
       }
       else
       {
            schoolId = '01';
            paras='?sId=01';
       } 
       
       if(ApexPages.currentPage().getParameters().get('src')!=null){
           paras=paras+'&src='+ ApexPages.currentPage().getParameters().get('src');
       }
       
       if(ApexPages.currentPage().getParameters().get('lid')!=null){
           paras=paras+'&lid='+ ApexPages.currentPage().getParameters().get('lid');
       }
       
       if(ApexPages.currentPage().getParameters().containsKey('code'))
       {
            String paraCode = ApexPages.currentPage().getParameters().get('code');
            Blob myCode = EncodingUtil.base64Decode(paraCode);
            String enCode= myCode.toString();
            
            List<String> parts = enCode.split('~');
            
            if(parts.size()==3){
               contactId = parts[0];
               email = parts[1];
               ValidCode = parts[2];
               
               List<Contact> c1 = [select id, firstname, lastname from contact where id=:contactId];
               if(c1.size()>0){
                   firstname=c1[0].firstname;
                   lastname=c1[0].lastname;
               }
               codeSet=true;
            }
           else {
               ValidCode=null;
               codeSet=false;
           }
       }
       else {
           ValidCode=null;
           codeSet=false;
       }
       
    }
    
    private boolean isValidPassword() {
        return password == confirmPassword;
    }

    public PageReference forwardToForgotPassPage() {
        String communityUrl = Site.getPathPrefix();
        return new PageReference(communityUrl + '/ApplicationForgotPassword' + paras);
    }

    public PageReference forwardToLoginPage() {
        String startUrl = System.currentPageReference().getParameters().get('startURL');
        return new PageReference(Site.getPathPrefix() + '/ApplicationLogin' + paras);
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
    
    public void resend(){
        Contact c=[select id, validation_code__c from contact where email=:email or other_email__c=:email];
        this.sendEmail(c, email);
    }
    
    private boolean sendEmail(Contact c, string email){
        c.validation_code__c=rand();
        update c;
        
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        
        message.setSenderDisplayName('LA Film School');
        message.setSubject('Verification Code');
        message.toAddresses = new String[]{email};
        message.setTargetObjectId(c.id);
        
        Blob data = Blob.valueOf(c.id+'~'+email+'~'+c.validation_code__c);
        
        String enData= EncodingUtil.base64Encode(data);
        String link= 'https://lafilmschool.force.com/ApplicationSelfRegister?sId='+schoolId+'&code='+EncodingUtil.urlEncode(enData,'UTF-8');

        String bodyText='';
        
        bodyText+='<p style="font-family:Arial; font-size:12px">Hello,<p>';
        bodyText+='<p style="font-family:Arial; font-size:12px">You recently attempted to apply to The Los Angeles Film School, but it looks like we may already have your email in the system.';
        bodyText+='To ensure your account\'s security, please verify your email by clicking the link below:</p>';
        bodyText+='<p style="font-family:Arial; font-size:12px"><a href="'+link+'">'+link+'</a></p>';
        bodyText+='<p style="font-family:Arial; font-size:12px;">Verification Code: <strong>'+c.validation_code__c+'</strong></p>';
        bodyText+='<p style="font-family:Arial; font-size:12px;font-weight:bold">Los Angeles Film School<br/>Admissions Department</p>';
        
        message.setHtmlBody(bodyText);
        
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {message});       

        return true;
    }
    
    
    public PageReference registerUser(){
        List<String> errors = new List<String>();
        PageReference url=null;  
        Id UserId;
        
        if (!isValidPassword()) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, Label.site.passwords_dont_match);
            ApexPages.addMessage(msg);
            return null;
        } 
        
        try {
            List<User> u =[select id from user where email=:email];
            

            String profileId = null; // To be filled in by customer.
            String roleEnum = null; // To be filled in by customer.
            String userName = email;
            
            if(u.size()>0){
                throw new CalloutException('This user already exists! If you forgot your password, press the link below');
            }
            else {
                // user is not exists

                User uu = new User();
                        
                uu.Username = email;
                uu.Email = email;
                uu.FirstName = firstName;
                uu.LastName = lastName;
                if(email.length()>40){
                    uu.CommunityNickname=email.substring(0,36)+rand().substring(0,4);
                }
                else {
                    uu.CommunityNickname = email;
                }
                
                String alias=uu.lastname+uu.firstname;
                alias.replaceAll(' ','');
                
                if(alias.length()>40){
                    uu.alias=alias.SubString(0,4);
                }
                else
                {
                    uu.alias=rand().SubString(0,4);
                }
                uu.TimeZoneSidKey = 'GMT';
                uu.LanguageLocaleKey = 'en_US';
                uu.EmailEncodingKey = 'UTF-8';
                uu.LocaleSidKey = UserInfo.getLocale();
            
                Profile p =[Select id from Profile where name='Application User'];
                uu.profileId=p.id;
                      
                
                if(ApexPages.currentPage().getParameters().get('src') != null){
                    uu.Lead_Source__c=ApexPages.currentPage().getParameters().get('src');
                }
                else 
                {
                    if(schoolId == '01'){
                        uu.Lead_Source__c = 'LAFSWEBAPP';
                    }
                    else if(schoolId == '02'){
                        uu.Lead_Source__c = 'LARSWEBAPP';
                    }
                    else{
                        uu.Lead_Source__c = 'LAFSWEBAPP';
                    }
                }
                List<Contact> c = [select id, validation_code__c, ownerid, accountid from contact where email=:email or other_email__c=:email order by createddate desc];
                
                if(c.size()>0){
                    // no user but contact is exists
                    // round robin has to be checked here
                    
                    List<String> remail = new List<String>();
                    remail.add('reception=lafilm.edu@example.com'); // in sandbox only
                    remail.add('reception@lafilm.edu');
                        
                    List<user> receptionist =[select id from user where email=:remail];
                    
                    Contact selectedContact;
                    boolean found=false;
                    
                    if(c.size()>1){
                        for(Contact con: c){
                            if(con.ownerId!=receptionist[0].id){
                                selectedContact=con;
                                found=true;
                                break;
                            }
                        } 
                    }
                    if(c.size()==1 || found==false){
                        selectedContact = c.get(0);
                    }                    
                    
                    List<User> dp =[select id from User where contactid=:selectedContact.id];
                    if(dp.size()>0){
                        throw new CalloutException('This user already exists! If you forgot your password, press the link below');
                    }
                    
                    if(validCode!=null && codeSet==false){
                        codeSet=true;
                    }
                    
                    if(selectedContact.validation_code__c==null){
                        sendEmail(selectedContact, email);
                        codeSet=true;
                        return null;
                    }
                    else if(codeSet==false && validCode==null && selectedContact.validation_code__c!=null){
                        codeSet=true;
                        return null;
                    }
                    else if(codeSet==true && validCode.tolowercase()!=selectedContact.validation_code__c.tolowercase()){
                        codeSet=true;
                        throw new CalloutException('Invalid Validation Code!');
                    }
                    else if(codeSet==true && validCode.tolowercase()==selectedContact.validation_code__c.tolowercase())
                    {
                        Account aa = [select id, ownerid from Account where id=:selectedContact.accountid];
                        User ss = [select id, userRoleId from user where id=:aa.ownerid];
                        if(ss.userRoleId==NULL){
                            aa.ownerId='0051a000000a5Ek';
                            update aa;
                        }
                        uu.contactId=selectedContact.id;
                        insert uu;
                        System.setPassword(uu.id,password);
                        
                        userId=uu.id;
                        
                        selectedContact.validation_code__c=null;
                        
                        if(selectedContact.ownerid==receptionist[0].id){
                            List<Contact> l = new List<Contact>();
                            l.add(selectedContact);
                            RoundRobin R = new RoundRobin(l);
                            selectedContact.ownerId=R.whoIsNext(selectedContact);
                        }

                        // redistribute - end
                        
                        codeSet=false;
                        update selectedContact;
                    }
                }
                else {
                    // no both user and contact
                    User admin =[select id from user where firstname='diana' and lastname='cuevas' and userroleid!=null];
                    Account communityAccount = [select id from account where name='Application Community'];
                    userId = Site.createExternalUser(uu, communityAccount.id, password);
                    
                    User ss = [select id, contactid from user where id=:userid];
                    Contact nn =[select id from contact where id=:ss.contactid];
                    nn.Lead_Source_Code__c=uu.Lead_Source__c;
                    
                    if(ApexPages.currentPage().getParameters().containsKey('lid'))
                    {
                        nn.Lead_Id__c=ApexPages.currentPage().getParameters().get('lid');
                        nn.Lead_Id_1__c=ApexPages.currentPage().getParameters().get('lid');
                    }
                    update nn;
                }
            }
            
            if (userId!= null) {               
                if (password != null && password.length() > 1) {
                    String startUrl = ApexPages.currentPage().getParameters().get('startURL') + paras;
                    
                    
                    url=Site.login(userName, password, startUrl);

                }
                else {
                    String communityUrl = 'https://lafilmschool.force.com/';
                    url= new PageReference(communityUrl + '/Application' + paras);
                }
            }
        }
        catch(Site.ExternalUserCreateException ex) 
        {
            errors.addAll(ex.getDisplayMessages());
            if(ex.getMessage() == '[User already exists.]' || ex.getMessage() == '[There was an error in registering a user in site application. The error message is: portal user already exists for contact]' ||
                ex.getMessage() == '[That nickname already exists. Enter a unique nickname.]'){
                system.debug('User already exists');
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'User Already Exists. Click on the "Forgot your password?" link below to reset it or the "Login to application" link to login'));
            }
        }
        catch(Exception e){
            errors.add(e.getMessage());
            system.debug(e.getMessage());
        }
        for (String error : errors)  {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, error));
            system.debug(error);
        }
        
        return url;
    }

}