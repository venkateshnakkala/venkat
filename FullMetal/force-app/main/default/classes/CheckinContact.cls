public class CheckinContact{
    public Id id{get;set;}
    public id owner{get; set;}
    public boolean ownerlock{get;set;}
    public string email{get;set;}
    public string firstName{get;set;}
    public string lastName{get;set;}
    public string phone{get;set;}
    public string country{get;set;}
    
    public List<SelectOption> countries{get;set;}
    
    public string program{get;set;}
    public List<SelectOption> programs{get;set;}
    
    public string preEducation{get;set;}
    public List<SelectOption> preEducations{get;set;}
    
    public string military{get;set;}
    public List<SelectOption> militarys{get;set;}
    
    public string street{get;set;}
    public string zipCode{get;set;}
    public List<SelectOption> rep{get;set;}
    
    public boolean ready{get;set;}
    public boolean found{get;set;}
    public string message{get;set;}
    
    public PageReference chkLogIn(){
        PageReference pageRef = null;
        
        List<Profile> p = [Select Id, Name from profile where Id=:UserInfo.getProfileId() LIMIT 1];
        if(p.size()>0){
            
            if(p[0].Name!='Checkin Page User'){
                pageRef = new PageReference('/CheckinLogin');
                pageRef.setRedirect(true);
            }
         }
         return pageRef;
    }
    
    public CheckinContact(){
        this.email='';
        this.firstName='';
        this.lastName='';
        this.rep = new List<SelectOption>();
        this.ownerlock=false;
        List<User> u =[select id, firstname, lastname from user where profile.name='Admissions Rep' and isActive=true order by firstname, lastname];
        rep.add(new SelectOption('','Unassigned'));
        for(User s: u){
            rep.add(new SelectOption(s.id,s.firstname+' '+s.lastname));
        }
        
        this.countries = new List<SelectOption>();
        this.countries.add(new SelectOption('United States','United States'));
        this.countries.add(new SelectOption('Afghanistan','Afghanistan'));
        this.countries.add(new SelectOption('Aland Islands','Aland Islands'));
        this.countries.add(new SelectOption('Albania','Albania'));
        this.countries.add(new SelectOption('Algeria','Algeria'));
        this.countries.add(new SelectOption('American Samoa','American Samoa'));
        this.countries.add(new SelectOption('Andorra','Andorra'));
        this.countries.add(new SelectOption('Angola','Angola'));
        this.countries.add(new SelectOption('Anguilla','Anguilla'));
        this.countries.add(new SelectOption('Antarctica','Antarctica'));
        this.countries.add(new SelectOption('Antigua and Barbuda','Antigua and Barbuda'));
        this.countries.add(new SelectOption('Argentina','Argentina'));
        this.countries.add(new SelectOption('Armenia','Armenia'));
        this.countries.add(new SelectOption('Aruba','Aruba'));
        this.countries.add(new SelectOption('Australia','Australia'));
        this.countries.add(new SelectOption('Austria','Austria'));
        this.countries.add(new SelectOption('Azerbaijan','Azerbaijan'));
        this.countries.add(new SelectOption('Bahamas','Bahamas'));
        this.countries.add(new SelectOption('Bahrain','Bahrain'));
        this.countries.add(new SelectOption('Bangladesh','Bangladesh'));
        this.countries.add(new SelectOption('Barbados','Barbados'));
        this.countries.add(new SelectOption('Belarus','Belarus'));
        this.countries.add(new SelectOption('Belgium','Belgium'));
        this.countries.add(new SelectOption('Belize','Belize'));
        this.countries.add(new SelectOption('Benin','Benin'));
        this.countries.add(new SelectOption('Bermuda','Bermuda'));
        this.countries.add(new SelectOption('Bhutan','Bhutan'));
        this.countries.add(new SelectOption('Bolivia, Plurinational State of','Bolivia, Plurinational State of'));
        this.countries.add(new SelectOption('Bonaire, Sint Eustatius nd Saba','Bonaire, Sint Eustatius nd Saba'));
        this.countries.add(new SelectOption('Bosnia and Herzegovina','Bosnia and Herzegovina'));
        this.countries.add(new SelectOption('Botswana','Botswana'));
        this.countries.add(new SelectOption('Bouvet Island','Bouvet Island'));
        this.countries.add(new SelectOption('Brazil','Brazil'));
        this.countries.add(new SelectOption('British Indian Ocean Territory','British Indian Ocean Territory'));
        this.countries.add(new SelectOption('Brunei Darussalam','Brunei Darussalam'));
        this.countries.add(new SelectOption('Bulgaria','Bulgaria'));
        this.countries.add(new SelectOption('Burkina Faso','Burkina Faso'));
        this.countries.add(new SelectOption('Burundi','Burundi'));
        this.countries.add(new SelectOption('Cambodia','Cambodia'));
        this.countries.add(new SelectOption('Cameroon','Cameroon'));
        this.countries.add(new SelectOption('Canada','Canada'));
        this.countries.add(new SelectOption('Cape Verde','Cape Verde'));
        this.countries.add(new SelectOption('Cayman Islands','Cayman Islands'));
        this.countries.add(new SelectOption('Central African Republic','Central African Republic'));
        this.countries.add(new SelectOption('Chad','Chad'));
        this.countries.add(new SelectOption('Chile','Chile'));
        this.countries.add(new SelectOption('China','China'));
        this.countries.add(new SelectOption('Christmas Island','Christmas Island'));
        this.countries.add(new SelectOption('Cocos (Keeling) Islands','Cocos (Keeling) Islands'));
        this.countries.add(new SelectOption('Colombia','Colombia'));
        this.countries.add(new SelectOption('Comoros','Comoros'));
        this.countries.add(new SelectOption('Congo','Congo'));
        this.countries.add(new SelectOption('Congo, the Democratic Republic of the','Congo, the Democratic Republic of the'));
        this.countries.add(new SelectOption('Cook Islands','Cook Islands'));
        this.countries.add(new SelectOption('Costa Rica','Costa Rica'));
        this.countries.add(new SelectOption('Côte d\'Ivoire','Côte d\'Ivoire'));
        this.countries.add(new SelectOption('Croatia','Croatia'));
        this.countries.add(new SelectOption('Cuba','Cuba'));
        this.countries.add(new SelectOption('Curaçao','Curaçao'));
        this.countries.add(new SelectOption('Cyprus','Cyprus'));
        this.countries.add(new SelectOption('Czech Republic','Czech Republic'));
        this.countries.add(new SelectOption('Denmark','Denmark'));
        this.countries.add(new SelectOption('Djibouti','Djibouti'));
        this.countries.add(new SelectOption('Dominica','Dominica'));
        this.countries.add(new SelectOption('Dominican Republic','Dominican Republic'));
        this.countries.add(new SelectOption('Ecuador','Ecuador'));
        this.countries.add(new SelectOption('Egypt','Egypt'));
        this.countries.add(new SelectOption('El Salvador','El Salvador'));
        this.countries.add(new SelectOption('Equatorial Guinea','Equatorial Guinea'));
        this.countries.add(new SelectOption('Eritrea','Eritrea'));
        this.countries.add(new SelectOption('Estonia','Estonia'));
        this.countries.add(new SelectOption('Ethiopia','Ethiopia'));
        this.countries.add(new SelectOption('Falkland Islands (Malvinas)','Falkland Islands (Malvinas)'));
        this.countries.add(new SelectOption('Faroe Islands','Faroe Islands'));
        this.countries.add(new SelectOption('Fiji','Fiji'));
        this.countries.add(new SelectOption('Finland','Finland'));
        this.countries.add(new SelectOption('France','France'));
        this.countries.add(new SelectOption('French Guiana','French Guiana'));
        this.countries.add(new SelectOption('French Polynesia','French Polynesia'));
        this.countries.add(new SelectOption('French Southern Territories','French Southern Territories'));
        this.countries.add(new SelectOption('Gabon','Gabon'));
        this.countries.add(new SelectOption('Gambia','Gambia'));
        this.countries.add(new SelectOption('Georgia','Georgia'));
        this.countries.add(new SelectOption('Germany','Germany'));
        this.countries.add(new SelectOption('Ghana','Ghana'));
        this.countries.add(new SelectOption('Gibraltar','Gibraltar'));
        this.countries.add(new SelectOption('Greece','Greece'));
        this.countries.add(new SelectOption('Greenland','Greenland'));
        this.countries.add(new SelectOption('Grenada','Grenada'));
        this.countries.add(new SelectOption('Guadeloupe','Guadeloupe'));
        this.countries.add(new SelectOption('Guam','Guam'));
        this.countries.add(new SelectOption('Guatemala','Guatemala'));
        this.countries.add(new SelectOption('Guernsey','Guernsey'));
        this.countries.add(new SelectOption('Guinea','Guinea'));
        this.countries.add(new SelectOption('Guinea-Bissau','Guinea-Bissau'));
        this.countries.add(new SelectOption('Guyana','Guyana'));
        this.countries.add(new SelectOption('Haiti','Haiti'));
        this.countries.add(new SelectOption('Heard Island and McDonald Islands','Heard Island and McDonald Islands'));
        this.countries.add(new SelectOption('Holy See (atican City State)','Holy See (atican City State)'));
        this.countries.add(new SelectOption('Honduras','Honduras'));
        this.countries.add(new SelectOption('Hong Kong','Hong Kong'));
        this.countries.add(new SelectOption('Hungary','Hungary'));
        this.countries.add(new SelectOption('Iceland','Iceland'));
        this.countries.add(new SelectOption('India','India'));
        this.countries.add(new SelectOption('Indonesia','Indonesia'));
        this.countries.add(new SelectOption('Iran, Islamic Republic of','Iran, Islamic Republic of'));
        this.countries.add(new SelectOption('Iraq','Iraq'));
        this.countries.add(new SelectOption('Ireland','Ireland'));
        this.countries.add(new SelectOption('Isle of Man','Isle of Man'));
        this.countries.add(new SelectOption('Israel','Israel'));
        this.countries.add(new SelectOption('Italy','Italy'));
        this.countries.add(new SelectOption('Jamaica','Jamaica'));
        this.countries.add(new SelectOption('Japan','Japan'));
        this.countries.add(new SelectOption('Jersey','Jersey'));
        this.countries.add(new SelectOption('Jordan','Jordan'));
        this.countries.add(new SelectOption('Kazakhstan','Kazakhstan'));
        this.countries.add(new SelectOption('Kenya','Kenya'));
        this.countries.add(new SelectOption('Kiribati','Kiribati'));
        this.countries.add(new SelectOption('Korea, Democratic People\'s Republic of','Korea, Democratic People\'s Republic of'));
        this.countries.add(new SelectOption('Korea, Republic of','Korea, Republic of'));
        this.countries.add(new SelectOption('Kuwait','Kuwait'));
        this.countries.add(new SelectOption('Kyrgyzstan','Kyrgyzstan'));
        this.countries.add(new SelectOption('Lao People\'s Democratic Republic','Lao People\'s Democratic Republic'));
        this.countries.add(new SelectOption('Latvia','Latvia'));
        this.countries.add(new SelectOption('Lebanon','Lebanon'));
        this.countries.add(new SelectOption('Lesotho','Lesotho'));
        this.countries.add(new SelectOption('Liberia','Liberia'));
        this.countries.add(new SelectOption('Libya','Libya'));
        this.countries.add(new SelectOption('Liechtenstein','Liechtenstein'));
        this.countries.add(new SelectOption('Lithuania','Lithuania'));
        this.countries.add(new SelectOption('Luxembourg','Luxembourg'));
        this.countries.add(new SelectOption('Macao','Macao'));
        this.countries.add(new SelectOption('Macedonia, the former ugoslav Republic of','Macedonia, the former ugoslav Republic of'));
        this.countries.add(new SelectOption('Madagascar','Madagascar'));
        this.countries.add(new SelectOption('Malawi','Malawi'));
        this.countries.add(new SelectOption('Malaysia','Malaysia'));
        this.countries.add(new SelectOption('Maldives','Maldives'));
        this.countries.add(new SelectOption('Mali','Mali'));
        this.countries.add(new SelectOption('Malta','Malta'));
        this.countries.add(new SelectOption('Marshall Islands','Marshall Islands'));
        this.countries.add(new SelectOption('Martinique','Martinique'));
        this.countries.add(new SelectOption('Mauritania','Mauritania'));
        this.countries.add(new SelectOption('Mauritius','Mauritius'));
        this.countries.add(new SelectOption('Mayotte','Mayotte'));
        this.countries.add(new SelectOption('Mexico','Mexico'));
        this.countries.add(new SelectOption('Micronesia, Federated States of','Micronesia, Federated States of'));
        this.countries.add(new SelectOption('Moldova, Republic of','Moldova, Republic of'));
        this.countries.add(new SelectOption('Monaco','Monaco'));
        this.countries.add(new SelectOption('Mongolia','Mongolia'));
        this.countries.add(new SelectOption('Montenegro','Montenegro'));
        this.countries.add(new SelectOption('Montserrat','Montserrat'));
        this.countries.add(new SelectOption('Morocco','Morocco'));
        this.countries.add(new SelectOption('Mozambique','Mozambique'));
        this.countries.add(new SelectOption('Myanmar','Myanmar'));
        this.countries.add(new SelectOption('Namibia','Namibia'));
        this.countries.add(new SelectOption('Nauru','Nauru'));
        this.countries.add(new SelectOption('Nepal','Nepal'));
        this.countries.add(new SelectOption('Netherlands','Netherlands'));
        this.countries.add(new SelectOption('New Caledonia','New Caledonia'));
        this.countries.add(new SelectOption('New Zealand','New Zealand'));
        this.countries.add(new SelectOption('Nicaragua','Nicaragua'));
        this.countries.add(new SelectOption('Niger','Niger'));
        this.countries.add(new SelectOption('Nigeria','Nigeria'));
        this.countries.add(new SelectOption('Niue','Niue'));
        this.countries.add(new SelectOption('Norfolk Island','Norfolk Island'));
        this.countries.add(new SelectOption('Northern Mariana Islands','Northern Mariana Islands'));
        this.countries.add(new SelectOption('Norway','Norway'));
        this.countries.add(new SelectOption('Oman','Oman'));
        this.countries.add(new SelectOption('Pakistan','Pakistan'));
        this.countries.add(new SelectOption('Palau','Palau'));
        this.countries.add(new SelectOption('Palestinian Territory, Occupied','Palestinian Territory, Occupied'));
        this.countries.add(new SelectOption('Panama','Panama'));
        this.countries.add(new SelectOption('Papua New Guinea','Papua New Guinea'));
        this.countries.add(new SelectOption('Paraguay','Paraguay'));
        this.countries.add(new SelectOption('Peru','Peru'));
        this.countries.add(new SelectOption('Philippines','Philippines'));
        this.countries.add(new SelectOption('Pitcairn','Pitcairn'));
        this.countries.add(new SelectOption('Poland','Poland'));
        this.countries.add(new SelectOption('Portugal','Portugal'));
        this.countries.add(new SelectOption('Puerto Rico','Puerto Rico'));
        this.countries.add(new SelectOption('Qatar','Qatar'));
        this.countries.add(new SelectOption('Réunion','Réunion'));
        this.countries.add(new SelectOption('Romania','Romania'));
        this.countries.add(new SelectOption('Russian Federation','Russian Federation'));
        this.countries.add(new SelectOption('Rwanda','Rwanda'));
        this.countries.add(new SelectOption('Saint Barthélemy','Saint Barthélemy'));
        this.countries.add(new SelectOption('Saint Helena, Ascension and Tristan da Cunha','Saint Helena, Ascension and Tristan da Cunha'));
        this.countries.add(new SelectOption('Saint Kitts and Nevis','Saint Kitts and Nevis'));
        this.countries.add(new SelectOption('Saint Lucia','Saint Lucia'));
        this.countries.add(new SelectOption('Saint Martin (French part)','Saint Martin (French part)'));
        this.countries.add(new SelectOption('Saint Pierre and Miquelon','Saint Pierre and Miquelon'));
        this.countries.add(new SelectOption('Saint Vincent and the Grenadines','Saint Vincent and the Grenadines'));
        this.countries.add(new SelectOption('Samoa','Samoa'));
        this.countries.add(new SelectOption('San arino','San arino'));
        this.countries.add(new SelectOption('Sao Tome and Principe','Sao Tome and Principe'));
        this.countries.add(new SelectOption('Saudi Arabia','Saudi Arabia'));
        this.countries.add(new SelectOption('Senegal','Senegal'));
        this.countries.add(new SelectOption('Serbia','Serbia'));
        this.countries.add(new SelectOption('Seychelles','Seychelles'));
        this.countries.add(new SelectOption('Sierra Leone','Sierra Leone'));
        this.countries.add(new SelectOption('Singapore','Singapore'));
        this.countries.add(new SelectOption('Sint Maarten (Dutch part)','Sint Maarten (Dutch part)'));
        this.countries.add(new SelectOption('Slovakia','Slovakia'));
        this.countries.add(new SelectOption('Slovenia','Slovenia'));
        this.countries.add(new SelectOption('Solomon Islands','Solomon Islands'));
        this.countries.add(new SelectOption('Somalia','Somalia'));
        this.countries.add(new SelectOption('South Africa','South Africa'));
        this.countries.add(new SelectOption('South Georgia and the South Sandwich slands','South Georgia and the South Sandwich slands'));
        this.countries.add(new SelectOption('South Sudan','South Sudan'));
        this.countries.add(new SelectOption('Spain','Spain'));
        this.countries.add(new SelectOption('Sri Lanka','Sri Lanka'));
        this.countries.add(new SelectOption('Sudan','Sudan'));
        this.countries.add(new SelectOption('Suriname','Suriname'));
        this.countries.add(new SelectOption('Svalbard and Jan Mayen','Svalbard and Jan Mayen'));
        this.countries.add(new SelectOption('Swaziland','Swaziland'));
        this.countries.add(new SelectOption('Sweden','Sweden'));
        this.countries.add(new SelectOption('Switzerland','Switzerland'));
        this.countries.add(new SelectOption('Syrian Arab Republic','Syrian Arab Republic'));
        this.countries.add(new SelectOption('Taiwan, Province of China','Taiwan, Province of China'));
        this.countries.add(new SelectOption('Tajikistan','Tajikistan'));
        this.countries.add(new SelectOption('Tanzania, United Republic of','Tanzania, United Republic of'));
        this.countries.add(new SelectOption('Thailand','Thailand'));
        this.countries.add(new SelectOption('Timor-este','Timor-este'));
        this.countries.add(new SelectOption('Togo','Togo'));
        this.countries.add(new SelectOption('Tokelau','Tokelau'));
        this.countries.add(new SelectOption('Tonga','Tonga'));
        this.countries.add(new SelectOption('Trinidad and Tobago','Trinidad and Tobago'));
        this.countries.add(new SelectOption('Tunisia','Tunisia'));
        this.countries.add(new SelectOption('Turkey','Turkey'));
        this.countries.add(new SelectOption('Turkmenistan','Turkmenistan'));
        this.countries.add(new SelectOption('Turks and Caicos Islands','Turks and Caicos Islands'));
        this.countries.add(new SelectOption('Tuvalu','Tuvalu'));
        this.countries.add(new SelectOption('Uganda','Uganda'));
        this.countries.add(new SelectOption('Ukraine','Ukraine'));
        this.countries.add(new SelectOption('United Arab Emirates','United Arab Emirates'));
        this.countries.add(new SelectOption('United Kingdom','United Kingdom'));
        this.countries.add(new SelectOption('United States Minor Outlying Islands','United States Minor Outlying Islands'));
        this.countries.add(new SelectOption('Uruguay','Uruguay'));
        this.countries.add(new SelectOption('Uzbekistan','Uzbekistan'));
        this.countries.add(new SelectOption('Vanuatu','Vanuatu'));
        this.countries.add(new SelectOption('Venezuela, Bolivarian Republic of','Venezuela, Bolivarian Republic of'));
        this.countries.add(new SelectOption('Viet Nam','Viet Nam'));
        this.countries.add(new SelectOption('Virgin Islands, British','Virgin Islands, British'));
        this.countries.add(new SelectOption('Virgin Islands, U.S.','Virgin Islands, U.S.'));
        this.countries.add(new SelectOption('Wallis and Futuna','Wallis and Futuna'));
        this.countries.add(new SelectOption('Western Sahara','Western Sahara'));
        this.countries.add(new SelectOption('Yemen','Yemen'));
        this.countries.add(new SelectOption('Zambia','Zambia'));
        this.countries.add(new SelectOption('Zimbabwe','Zimbabwe'));
        
        this.programs = new List<SelectOption>();
        this.programs.add(new SelectOption('',''));
        this.programs.add(new SelectOption('BSAVE','Bachelor of Science in Animation and Visual Effects'));
        this.programs.add(new SelectOption('BSFP','Bachelor of Science in Film Production'));
        this.programs.add(new SelectOption('BSEB','Bachelor of Science in Entertainment Business '));
        this.programs.add(new SelectOption('ASF','Associate of Science in Film'));
        this.programs.add(new SelectOption('ASAP','Associate of Science in Audio Production'));
        this.programs.add(new SelectOption('BSAP','Bachelor of Science in Audio Production'));
        this.programs.add(new SelectOption('ASCA','Associate of Science in Computer Animation'));
        this.programs.add(new SelectOption('ASMP','Associate of Science in Music Production'));
        this.programs.add(new SelectOption('BSDF-O','(Online) Bachelor of Science in Digital Filmmaking'));
        this.programs.add(new SelectOption('BSEB-O','(Online) Bachelor of Science in Entertainment Business'));
        this.programs.add(new SelectOption('BSGD-O','(Online) Bachelor of Science in Graphic Design'));
        this.programs.add(new SelectOption('ASMP-O','(Online) Associate of Science in Music Production'));
        this.programs.add(new SelectOption('BSA-O','(Online) Bachelor of Science in Animation '));
        
        this.preEducations = new List<SelectOption>();
        this.preEducations.add(new SelectOption('',''));
        this.preEducations.add(new SelectOption('AA/AS','Associate\'s Degree Completed'));
        this.preEducations.add(new SelectOption('COL','Attending College'));
        this.preEducations.add(new SelectOption('BA/BS','Bachelor\'s Degree Completed'));
        this.preEducations.add(new SelectOption('GED','High School – GED'));
        this.preEducations.add(new SelectOption('HS','High School Diploma'));
        this.preEducations.add(new SelectOption('INHS','High School Student'));
        this.preEducations.add(new SelectOption('MS','Master\'s Degree Completed'));
        
        this.militarys = new List<SelectOption>();
        this.militarys.add(new SelectOption('',''));
        this.militarys.add(new SelectOption('NON','US citizen or resident with no military affiliation'));
        this.militarys.add(new SelectOption('ACT','Active duty, US Armed Forces'));
        this.militarys.add(new SelectOption('VET','Veteran of US Armed Forces'));
        this.militarys.add(new SelectOption('MDEP','Military dependent using benefits, US Armed Forces'));
        this.militarys.add(new SelectOption('RESR','Reservist or National Guard'));
        this.militarys.add(new SelectOption('INTL1','Non-US citizen with student VISA'));
        this.militarys.add(new SelectOption('INTL2','Non-US citizen without student VISA'));
    }
    
    public void cheakEmails(){
    
        if(!Pattern.matches('[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+.[a-zA-Z]{2,4}', this.email)){
            this.message='Please enter a valid email address';
            this.ready=false;
            return;
        }
        
        List<Contact> c =[select id, owner.name, firstname, lastname, email, phone, MailingCountry, MailingStreet, Program_Code__c, Previous_Education_Codes__c, Affiliation_Code__c, MailingPostalCode, Lead_Source_Code__c, Lead_Date__c, LeadSource, Lead_ID__c, Lead_Source__c, Lead_Source_Code_1__c, lead_type__c from contact where email=:this.email or other_email__c=:this.email order by createddate asc];
        
        if(c.size()>0){
            this.message='This email already in the system.';
            
            Contact con=c[0];
            
            this.id=con.id;
            this.firstName=con.firstname;
            this.lastName=con.lastname;
            this.email=con.email;
            this.phone=con.phone;
            this.country=con.mailingCountry;
            this.street=con.MailingStreet;
            this.zipcode=con.MailingPostalCode;
            this.preEducation=con.Previous_Education_Codes__c;
            this.military=con.Affiliation_Code__c;
            this.program=con.Program_Code__c;
            this.owner=con.owner.id;
            this.ownerlock=true;
            ready=true;
        }
        else{
            this.message='Add new record.';
            this.id=null;
            this.firstName='';
            this.lastName='';
            this.phone='';
            this.country='';
            this.street='';
            this.zipcode='';
            this.owner=NULL;
            this.preEducation='';
            this.military='';
            this.program='';
            ready=true;
            this.ownerlock=false;
        }
    }
    
    public void save(){
        try {
         Contact c = new Contact();
         
         c.firstname=this.firstName;
         c.lastname=this.lastName;
         c.email=this.email;
         c.phone=this.phone;
         c.MailingCountry=this.country;
         c.MailingPostalCode=this.zipcode;
         c.MailingStreet=this.street;
         c.Affiliation_Code__c=this.military;
         c.Program_Code__c=this.program;
         c.Previous_Education_Codes__c=this.preEducation;
         
         if(this.id!=NULL){
            c.id=this.id;

            c.Lead_Date__c=system.now();
            c.Lead_Source_Code__c='JETSPRNG';
            c.re_inquiry__c=true;
            update c;
            
            Contact newC = new Contact();
            newC.lastname=c.lastname;
            newC.Lead_Source_Code__c='JETSPRNG';
            RoundRobin r = new RoundRobin();
            r.updateLeadSource(c.id, newC);
             
         }
         else {
             c.Lead_Source_Code__c='JETSPRNG';
             if(this.owner==NULL){
                 RoundRobin r = new RoundRobin(New List<Contact>{c});
                 c.ownerId=r.whoIsNext(c);
             }
             insert c;
             if(this.owner!=NULL){
                 c.ownerid=this.owner;
             }
             update c;
         }
         
         this.id=null;
         this.firstName='';
         this.lastName='';
         this.email='';
         this.phone='';
         this.country='';
         this.street='';
         this.zipcode='';
         this.preEducation='';
         this.military='';
         this.program='';
         this.owner=NULL;
         ready=false;
         this.message='Record saved successfully';
        }
        catch(Exception e){
            this.message=e.getMessage();
        }
    }
}