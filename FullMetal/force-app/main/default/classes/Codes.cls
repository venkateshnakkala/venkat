public class Codes{
    public static string getCountryCodes(String countryName){
        if(countryName==null){
            return 'USA';
        }
        Map<String,String> codes = new Map<String,String> ();
        codes.put('usa','USA');
        codes.put('ar','AR');
        codes.put('au','AU');
        codes.put('at','AT');
        codes.put('be','BE');
        codes.put('br','BR');
        codes.put('can','CAN');
        codes.put('cl','CL');
        codes.put('cn','CN');
        codes.put('cr','CR');
        codes.put('dk','DK');
        codes.put('do','DO');
        codes.put('eg','EG');
        codes.put('uk','UK');
        codes.put('fr','FR');
        codes.put('de','DE');
        codes.put('gt','GT');
        codes.put('in','IN');
        codes.put('id','ID');
        codes.put('il','IL');
        codes.put('it','IT');
        codes.put('jp','JP');
        codes.put('kp','KP');
        codes.put('my','MY');
        codes.put('mx','MX');
        codes.put('np','NP');
        codes.put('nl','NL');
        codes.put('ng','NG');
        codes.put('ph','PH');
        codes.put('pl','PL');
        codes.put('pt','PT');
        codes.put('za','ZA');
        codes.put('es','ES');
        codes.put('lk','LK');
        codes.put('se','SE');
        codes.put('ch','CH');
        codes.put('tr','TR');
        codes.put('ve','VE');
        codes.put('ie','IE');
        codes.put('sv','SV');
        codes.put('bo','BO');
        codes.put('bs','BS');
        codes.put('kr','KR');
        codes.put('an','AN');
        codes.put('al','AL');
        codes.put('bz','BZ');
        codes.put('af','AF');
        codes.put('dz','DZ');
        codes.put('as','AS');
        codes.put('ad','AD');
        codes.put('ao','AO');
        codes.put('ai','AI');
        codes.put('aq','AQ');
        codes.put('ag','AG');
        codes.put('am','AM');
        codes.put('aw','AW');
        codes.put('az','AZ');
        codes.put('bh','BH');
        codes.put('bd','BD');
        codes.put('bb','BB');
        codes.put('by','BY');
        codes.put('bj','BJ');
        codes.put('bm','BM');
        codes.put('tw','TW');
        codes.put('bt','BT');
        codes.put('ba','BA');
        codes.put('bw','BW');
        codes.put('bv','BV');
        codes.put('io','IO');
        codes.put('bg','BG');
        codes.put('kh','KH');
        codes.put('cm','CM');
        codes.put('ky','KY');
        codes.put('td','TD');
        codes.put('co','CO');
        codes.put('cg','CG');
        codes.put('ck','CK');
        codes.put('hr','HR');
        codes.put('cu','CU');
        codes.put('cy','CY');
        codes.put('cz','CZ');
        codes.put('ec','EC');
        codes.put('ee','EE');
        codes.put('et','ET');
        codes.put('fk','FK');
        codes.put('fj','FJ');
        codes.put('fi','FI');
        codes.put('gf','GF');
        codes.put('pf','PF');
        codes.put('gm','GM');
        codes.put('gh','GH');
        codes.put('gi','GI');
        codes.put('gr','GR');
        codes.put('gl','GL');
        codes.put('gd','GD');
        codes.put('gp','GP');
        codes.put('gu','GU');
        codes.put('gn','GN');
        codes.put('ht','HT');
        codes.put('hn','HN');
        codes.put('hk','HK');
        codes.put('hu','HU');
        codes.put('is','IS');
        codes.put('ir','IR');
        codes.put('iq','IQ');
        codes.put('jm','JM');
        codes.put('jo','JO');
        codes.put('kz','KZ');
        codes.put('ke','KE');
        codes.put('kw','KW');
        codes.put('lv','LV');
        codes.put('lb','LB');
        codes.put('lr','LR');
        codes.put('ly','LY');
        codes.put('lt','LT');
        codes.put('mk','MK');
        codes.put('mt','MT');
        codes.put('nz','NZ');
        codes.put('ne','NE');
        codes.put('ni','NI');
        codes.put('no','NO');
        codes.put('pa','PA');
        codes.put('pe','PE');
        codes.put('pr','PR');
        codes.put('ro','RO');
        codes.put('sa','SA');
        codes.put('sg','SG');
        codes.put('sk','SK');
        codes.put('si','SI');
        codes.put('so','SO');
        codes.put('su','SU');
        codes.put('sy','SY');
        codes.put('tz','TZ');
        codes.put('th','TH');
        codes.put('to','TO');
        codes.put('tt','TT');
        codes.put('tn','TN');
        codes.put('ug','UG');
        codes.put('ua','UA');
        codes.put('ae','AE');
        codes.put('uy','UY');
        codes.put('vn','VN');
        codes.put('vg','VG');
        codes.put('vi','VI');
        codes.put('ye','YE');
        codes.put('yu','YU');
        codes.put('zr','ZR');
        codes.put('zm','ZM');
        codes.put('la','LA');
        codes.put('ge','GE');
        codes.put('pk','PK');
        codes.put('lu','LU');
        codes.put('na','NA');
        codes.put('sco','SCO');
        codes.put('mm','MM');
        codes.put('sz','SZ');
        codes.put('ru','RU');
        codes.put('ci','CI');
        codes.put('sn','SN');
        codes.put('qa','QA');
        codes.put('ma','MA');
        codes.put('mn','MN');
        codes.put('bn','BN');
        codes.put('bf','BF');
        codes.put('bi','BI');
        codes.put('cv','CV');
        codes.put('cf','CF');
        codes.put('cx','CX');
        codes.put('cc','CC');
        codes.put('km','KM');
        codes.put('cd','CD');
        codes.put('cs','CS');
        codes.put('dj','DJ');
        codes.put('dm','DM');
        codes.put('tp','TP');
        codes.put('gq','GQ');
        codes.put('er','ER');
        codes.put('fo','FO');
        codes.put('fx','FX');
        codes.put('tf','TF');
        codes.put('ga','GA');
        codes.put('gb','GB');
        codes.put('gw','GW');
        codes.put('gy','GY');
        codes.put('hm','HM');
        codes.put('ki','KI');
        codes.put('kg','KG');
        codes.put('ls','LS');
        codes.put('li','LI');
        codes.put('mg','MG');
        codes.put('mw','MW');
        codes.put('mv','MV');
        codes.put('ml','ML');
        codes.put('mh','MH');
        codes.put('mq','MQ');
        codes.put('mr','MR');
        codes.put('mu','MU');
        codes.put('yt','YT');
        codes.put('md','MD');
        codes.put('mp','MP');
        codes.put('mc','MC');
        codes.put('ms','MS');
        codes.put('mz','MZ');
        codes.put('nr','NR');
        codes.put('nt','NT');
        codes.put('nc','NC');
        codes.put('nu','NU');
        codes.put('nf','NF');
        codes.put('om','OM');
        codes.put('pg','PG');
        codes.put('py','PY');
        codes.put('pn','PN');
        codes.put('re','RE');
        codes.put('rw','RW');
        codes.put('gs','GS');
        codes.put('kn','KN');
        codes.put('lc','LC');
        codes.put('vc','VC');
        codes.put('ws','WS');
        codes.put('sm','SM');
        codes.put('st','ST');
        codes.put('sc','SC');
        codes.put('sl','SL');
        codes.put('sj','SJ');
        codes.put('sh','SH');
        codes.put('pm','PM');
        codes.put('sd','SD');
        codes.put('tj','TJ');
        codes.put('tg','TG');
        codes.put('tk','TK');
        codes.put('tm','TM');
        codes.put('tc','TC');
        codes.put('tv','TV');
        codes.put('um','UM');
        codes.put('uz','UZ');
        codes.put('vu','VU');
        codes.put('va','VA');
        codes.put('wf','WF');
        codes.put('eh','EH');
        codes.put('wi','WI');
        codes.put('mo','MO');
        codes.put('fm','FM');
        codes.put('zw','ZW');
        codes.put('united states','USA');
        codes.put('argentina','AR');
        codes.put('australia','AU');
        codes.put('austria','AT');
        codes.put('belgium','BE');
        codes.put('brazil','BR');
        codes.put('canada','CAN');
        codes.put('chile','CL');
        codes.put('china','CN');
        codes.put('costa rica','CR');
        codes.put('denmark','DK');
        codes.put('dominican republic','DO');
        codes.put('egypt','EG');
        codes.put('united kingdom','UK');
        codes.put('france','FR');
        codes.put('germany','DE');
        codes.put('guatemala','GT');
        codes.put('india','IN');
        codes.put('indonesia','ID');
        codes.put('israel','IL');
        codes.put('italy','IT');
        codes.put('japan','JP');
        codes.put('korea (north)','KP');
        codes.put('malaysia','MY');
        codes.put('mexico','MX');
        codes.put('nepal','NP');
        codes.put('netherlands','NL');
        codes.put('nigeria','NG');
        codes.put('philippines','PH');
        codes.put('poland','PL');
        codes.put('portugal','PT');
        codes.put('south africa','ZA');
        codes.put('spain','ES');
        codes.put('sri lanka','LK');
        codes.put('sweden','SE');
        codes.put('switzerland','CH');
        codes.put('turkey','TR');
        codes.put('venezuela','VE');
        codes.put('ireland','IE');
        codes.put('el salvador','SV');
        codes.put('bolivia','BO');
        codes.put('bahamas','BS');
        codes.put('korea (south)','KR');
        codes.put('netherlands antilles','AN');
        codes.put('albania','AL');
        codes.put('belize','BZ');
        codes.put('afghanistan','AF');
        codes.put('algeria','DZ');
        codes.put('american samoa','AS');
        codes.put('andorra','AD');
        codes.put('angola','AO');
        codes.put('anguilla','AI');
        codes.put('antarctica','AQ');
        codes.put('antigua/barbuda','AG');
        codes.put('armenia','AM');
        codes.put('aruba','AW');
        codes.put('azerbaijan','AZ');
        codes.put('bahrain','BH');
        codes.put('bangladesh','BD');
        codes.put('barbados','BB');
        codes.put('belarus','BY');
        codes.put('benin','BJ');
        codes.put('bermuda','BM');
        codes.put('taiwan','TW');
        codes.put('bhutan','BT');
        codes.put('bosnia / herzegovina','BA');
        codes.put('botswana','BW');
        codes.put('bouvet island','BV');
        codes.put('british indian ocean territory','IO');
        codes.put('bulgaria','BG');
        codes.put('cambodia','KH');
        codes.put('cameroon','CM');
        codes.put('cayman islands','KY');
        codes.put('chad','TD');
        codes.put('colombia','CO');
        codes.put('congo','CG');
        codes.put('cook islands','CK');
        codes.put('croatia','HR');
        codes.put('cuba','CU');
        codes.put('cyprus','CY');
        codes.put('czech republic','CZ');
        codes.put('ecuador','EC');
        codes.put('estonia','EE');
        codes.put('ethiopia','ET');
        codes.put('falkland islands','FK');
        codes.put('fiji','FJ');
        codes.put('finland','FI');
        codes.put('french guiana','GF');
        codes.put('french polynesia','PF');
        codes.put('gambia','GM');
        codes.put('ghana','GH');
        codes.put('gibraltar','GI');
        codes.put('greece','GR');
        codes.put('greenland','GL');
        codes.put('grenada','GD');
        codes.put('guadeloupe','GP');
        codes.put('guam','GU');
        codes.put('guinea','GN');
        codes.put('haiti','HT');
        codes.put('honduras','HN');
        codes.put('hong kong','HK');
        codes.put('hungary','HU');
        codes.put('iceland','IS');
        codes.put('iran','IR');
        codes.put('iraq','IQ');
        codes.put('jamaica','JM');
        codes.put('jordan','JO');
        codes.put('kazakhstan','KZ');
        codes.put('kenya','KE');
        codes.put('kuwait','KW');
        codes.put('latvia','LV');
        codes.put('lebanon','LB');
        codes.put('liberia','LR');
        codes.put('libya','LY');
        codes.put('lithuania','LT');
        codes.put('f.y.r.o.m. (macedonia)','MK');
        codes.put('malta','MT');
        codes.put('new zealand','NZ');
        codes.put('niger','NE');
        codes.put('nicaragua','NI');
        codes.put('norway','NO');
        codes.put('panama','PA');
        codes.put('peru','PE');
        codes.put('puerto rico','PR');
        codes.put('romania','RO');
        codes.put('saudi arabia','SA');
        codes.put('singapore','SG');
        codes.put('slovakia','SK');
        codes.put('slovenia','SI');
        codes.put('somalia','SO');
        codes.put('soviet union (former)','SU');
        codes.put('syria','SY');
        codes.put('tanzania','TZ');
        codes.put('thailand','TH');
        codes.put('tonga','TO');
        codes.put('trinidad / tobago','TT');
        codes.put('tunisia','TN');
        codes.put('uganda','UG');
        codes.put('ukraine','UA');
        codes.put('united arab emirates','AE');
        codes.put('uruguay','UY');
        codes.put('vietnam','VN');
        codes.put('virgin islands (british)','VG');
        codes.put('virgin islands (us)','VI');
        codes.put('yemen','YE');
        codes.put('yugoslavia (serbia)','YU');
        codes.put('zaire','ZR');
        codes.put('zambia','ZM');
        codes.put('laos','LA');
        codes.put('georgia (soviet)','GE');
        codes.put('pakistan','PK');
        codes.put('luxembourg','LU');
        codes.put('namibia','NA');
        codes.put('scotland','SCO');
        codes.put('myanmar','MM');
        codes.put('swaziland','SZ');
        codes.put('russia','RU');
        codes.put('cote d\'ivoire (ivory coast)','CI');
        codes.put('suriname','SN');
        codes.put('qatar','QA');
        codes.put('morocco','MA');
        codes.put('mongolia','MN');
        codes.put('brunei darussalam','BN');
        codes.put('burkina faso','BF');
        codes.put('burundi','BI');
        codes.put('cape verde','CV');
        codes.put('central african republic','CF');
        codes.put('christmas island','CX');
        codes.put('cocos (keeling) islands','CC');
        codes.put('comoros','KM');
        codes.put('congo, democratic republic','CD');
        codes.put('czechoslovakia (former)','CS');
        codes.put('djibouti','DJ');
        codes.put('dominica','DM');
        codes.put('east timor','TP');
        codes.put('equatorial guinea','GQ');
        codes.put('eritrea','ER');
        codes.put('faroe islands','FO');
        codes.put('france, metropolitan','FX');
        codes.put('french southern territories','TF');
        codes.put('gabon','GA');
        codes.put('great britain (uk)','GB');
        codes.put('guinea-bissau','GW');
        codes.put('guyana','GY');
        codes.put('heard and mcdonald islands','HM');
        codes.put('kiribati','KI');
        codes.put('kyrgzstan','KG');
        codes.put('lesotho','LS');
        codes.put('liechtenstein','LI');
        codes.put('madagascar','MG');
        codes.put('malawi','MW');
        codes.put('maldives','MV');
        codes.put('mali','ML');
        codes.put('marshall islands','MH');
        codes.put('martinique','MQ');
        codes.put('mauritania','MR');
        codes.put('mauritius','MU');
        codes.put('mayotte','YT');
        codes.put('moldova','MD');
        codes.put('northern mariana islands','MP');
        codes.put('monaco','MC');
        codes.put('montserrat','MS');
        codes.put('mozambique','MZ');
        codes.put('nauru','NR');
        codes.put('neutral zone','NT');
        codes.put('new caledonia','NC');
        codes.put('niue','NU');
        codes.put('norfolk island','NF');
        codes.put('oman','OM');
        codes.put('papua new guinea','PG');
        codes.put('paraguay','PY');
        codes.put('pitcairn','PN');
        codes.put('reunion','RE');
        codes.put('rwanda','RW');
        codes.put('s. georgia and s. sandwich isls.','GS');
        codes.put('saint kitts and nevis','KN');
        codes.put('saint lucia','LC');
        codes.put('saint vincent & the grenadines','VC');
        codes.put('samoa','WS');
        codes.put('san marino','SM');
        codes.put('sao tome and principe','ST');
        codes.put('seychelles','SC');
        codes.put('sierra leone','SL');
        codes.put('svalbard & jan mayen islands','SJ');
        codes.put('st. helena','SH');
        codes.put('st. pierre and miquelon','PM');
        codes.put('sudan','SD');
        codes.put('tajikistan','TJ');
        codes.put('togo','TG');
        codes.put('tokelau','TK');
        codes.put('turkmenistan','TM');
        codes.put('turks and caicos islands','TC');
        codes.put('tuvalu','TV');
        codes.put('us minor outlying islands','UM');
        codes.put('uzbekistan','UZ');
        codes.put('vanuatu','VU');
        codes.put('vatican city state (holy sea)','VA');
        codes.put('wallis and futuna islands','WF');
        codes.put('western sahara','EH');
        codes.put('west indies','WI');
        codes.put('macau','MO');
        codes.put('micronesia','FM');
        codes.put('zimbabwe','ZW');
        
        string countryCode=codes.get(countryName.trim().toLowerCase());
        
        if(countryCode!=NULL)
            return countryCode;
        else
            return 'USA';
    }
    
    public static string getPrevEduCodes(String text){
        if(text==null){
            return 'HS';
        }
        Map<String,String> codes = new Map<String,String> ();
        codes.put('high school diploma','HS');
        codes.put('high school - ged','GED');
        codes.put('attending college','COL');
        codes.put('home school student','HOMESCH');
        codes.put('college - bs/ba','COLBS');
        codes.put('college - master','COLM');
        codes.put('still in high school','SIHS');
        codes.put('associate\'s degree completed','AA/AS');
        codes.put('bachelor\'s degree completed','BA/BS');
        codes.put('master\'s degree completed','MS');
        codes.put('high school student','INHS');
        codes.put('home school graduate','HOMEGRAD');
        codes.put('some college','SOMECOL');
        codes.put('hs','HS');
        codes.put('ged','GED');
        codes.put('col','COL');
        codes.put('homesch','HOMESCH');
        codes.put('colbs','COLBS');
        codes.put('colm','COLM');
        codes.put('sihs','SIHS');
        codes.put('aa/as','AA/AS');
        codes.put('ba/bs','BA/BS');
        codes.put('ms','MS');
        codes.put('inhs','INHS');
        codes.put('homegrad','HOMEGRAD');
        codes.put('somecol','SOMECOL');
        
        string edu=codes.get(text.trim().toLowerCase());
         
        if(edu!=NULL)
            return edu;
        else
            return 'HS';
    }
    
    public static string checkIn(string text){
        string returnText;
        
        if(text==NULL)
        {
            returnText='';
        }
        else 
        {
            returnText=EncodingUtil.URLENCODE(text,'UTF-8');
        }
            
        return returnText;
    }
    
    public static string getAffilicationCodes(string text){
        if(text==null){
            return 'NON';
        }
        Map<String,String> codes = new Map<String,String> ();
        codes.put('milt','Military');
        codes.put('adnv','Active Duty - Navy');
        codes.put('adar','Active Duty - Army');
        codes.put('adaf','Active Duty - Air Force');
        codes.put('adcg','Active Duty - Coast Guard');
        codes.put('admc','Active Duty - Marine Corps');
        codes.put('mdnv','Mil Dep using Benefits - Navy');
        codes.put('mdar','Mil Dep using Benefits - Army');
        codes.put('mdaf','Mil Dep using Benefits - Air Force');
        codes.put('mdcg','Mil Dep using Benefits - Coast Guard');
        codes.put('mdmc','Mil Dep using Benefits - Marine Corps');
        codes.put('rvngnv','Reservist/National Guard - Navy');
        codes.put('rvngar','Reservist/National Guard - Army');
        codes.put('rvngaf','Reservist/National Guard - Air Force');
        codes.put('rvngcg','Reservist/National Guard - Coast Guard');
        codes.put('rvngmc','Reservist/National Guard - Marine Corps');
        codes.put('vetnv','Veteran - Navy');
        codes.put('vetar','Veteran - Army');
        codes.put('vetaf','Veteran - Air Force');
        codes.put('vetcg','Veteran - Coast Guard');
        codes.put('vetmc','Veteran - Marine Corps');
        codes.put('vetnu','Veteran - Not using benefits');
        codes.put('nonelig','Not Eligible for Military Benefits');
        codes.put('act','Active Duty');
        codes.put('mdep','Military Dependant using benefits');
        codes.put('non','No Military Affiliation');
        codes.put('resr','Reservist/National Guard');
        codes.put('vet','Veteran');
        codes.put('int\'l','Needs docs to attend ground campus');
        codes.put('hs','Actively attending HS or pursuing GED');
        codes.put('online','Online Req., unable to attend campus');
        codes.put('highsch','High School');
        codes.put('comcoll','Community College');
        codes.put('intlesl','International - ESL');
        codes.put('intchina','International - China');
        codes.put('intlmex','International - Mexico');
        codes.put('intbrzl','International - Brazil');
        codes.put('intl2','Non-US citizen without student VISA');
        codes.put('amfunds','American Trust Fund');
        codes.put('gcip','GIFT COLLEGE INVESTING PLAN');
        codes.put('intl1','Non-US citizen with student VISA');
        codes.put('mesp','MICHIGAN EDUCATION SAVINGS PROGRAM');
        codes.put('intl','Non-US Citizen');
        codes.put('sscsp','ScholarShare College Savings Plan');
        codes.put('blkroc','BLACK ROCK - COLLEGE ADVANTAGE');
        codes.put('hea','HIGHER EDUCATION ACCOUNT');
        codes.put('flpcp','FLORIDA PREPAID COLLEGE PROGRAM');
        codes.put('npcp','NEVADA PREPAID COLLEGE PLAN');
        codes.put('jpl','Jet Propultion Laboratory');
        codes.put('vocrehab','VOCATIONAL REHABILITATION');
        codes.put('milt','MILT');
        codes.put('adnv','ADNV');
        codes.put('adar','ADAR');
        codes.put('adaf','ADAF');
        codes.put('adcg','ADCG');
        codes.put('admc','ADMC');
        codes.put('mdnv','MDNV');
        codes.put('mdar','MDAR');
        codes.put('mdaf','MDAF');
        codes.put('mdcg','MDCG');
        codes.put('mdmc','MDMC');
        codes.put('rvngnv','RVNGNV');
        codes.put('rvngar','RVNGAR');
        codes.put('rvngaf','RVNGAF');
        codes.put('rvngcg','RVNGCG');
        codes.put('rvngmc','RVNGMC');
        codes.put('vetnv','VETNV');
        codes.put('vetar','VETAR');
        codes.put('vetaf','VETAF');
        codes.put('vetcg','VETCG');
        codes.put('vetmc','VETMC');
        codes.put('vetnu','VETNU');
        codes.put('nonelig','NONELIG');
        codes.put('act','ACT');
        codes.put('mdep','MDEP');
        codes.put('non','NON');
        codes.put('resr','RESR');
        codes.put('vet','VET');
        codes.put('int\'l','INT\'L');
        codes.put('hs','HS');
        codes.put('online','ONLINE');
        codes.put('highsch','HIGHSCH');
        codes.put('comcoll','COMCOLL');
        codes.put('intlesl','INTLESL');
        codes.put('intchina','INTCHINA');
        codes.put('intlmex','INTLMEX');
        codes.put('intbrzl','INTBRZL');
        codes.put('intl2','INTL2');
        codes.put('amfunds','AMFUNDS');
        codes.put('gcip','GCIP');
        codes.put('intl1','INTL1');
        codes.put('mesp','MESP');
        codes.put('intl','INTL');
        codes.put('sscsp','SSCSP');
        codes.put('blkroc','BLKROC');
        codes.put('hea','HEA');
        codes.put('flpcp','FLPCP');
        codes.put('npcp','NPCP');
        codes.put('jpl','JPL');
        codes.put('vocrehab','VOCREHAB');
        
        string aff=codes.get(text.trim().toLowerCase());
         
        if(aff!=NULL)
            return aff;
        else
            return 'NON';
    }
    
    public static string getState(String text){
        if(text==null){
            return 'CA';
        }
        Map<String,String> codes = new Map<String,String> ();
        codes.put('fl','FL');
        codes.put('ga','GA');
        codes.put('ny','NY');
        codes.put('nj','NJ');
        codes.put('nc','NC');
        codes.put('sd','SD');
        codes.put('tx','TX');
        codes.put('ca','CA');
        codes.put('pr','PR');
        codes.put('me','ME');
        codes.put('vt','VT');
        codes.put('nh','NH');
        codes.put('ri','RI');
        codes.put('ma','MA');
        codes.put('ct','CT');
        codes.put('pa','PA');
        codes.put('de','DE');
        codes.put('md','MD');
        codes.put('va','VA');
        codes.put('wv','WV');
        codes.put('sc','SC');
        codes.put('ms','MS');
        codes.put('la','LA');
        codes.put('ar','AR');
        codes.put('tn','TN');
        codes.put('ky','KY');
        codes.put('oh','OH');
        codes.put('in','IN');
        codes.put('il','IL');
        codes.put('mi','MI');
        codes.put('wi','WI');
        codes.put('mn','MN');
        codes.put('nd','ND');
        codes.put('ne','NE');
        codes.put('ks','KS');
        codes.put('ok','OK');
        codes.put('nm','NM');
        codes.put('az','AZ');
        codes.put('co','CO');
        codes.put('ut','UT');
        codes.put('mt','MT');
        codes.put('wy','WY');
        codes.put('wa','WA');
        codes.put('dc','DC');
        codes.put('or','OR');
        codes.put('ak','AK');
        codes.put('hi','HI');
        codes.put('mo','MO');
        codes.put('vi','VI');
        codes.put('ia','IA');
        codes.put('id','ID');
        codes.put('nv','NV');
        codes.put('al','AL');
        codes.put('gu','GU');
        codes.put('fc','FC');
        codes.put('mh','MH');
        codes.put('as','AS');
        codes.put('on','ON');
        codes.put('qc','QC');
        codes.put('ab','AB');
        codes.put('bc','BC');
        codes.put('florida','FL');
        codes.put('georgia','GA');
        codes.put('new york','NY');
        codes.put('new jersey','NJ');
        codes.put('north carolina','NC');
        codes.put('south dakota','SD');
        codes.put('texas','TX');
        codes.put('california','CA');
        codes.put('puerto rico','PR');
        codes.put('maine','ME');
        codes.put('vermont','VT');
        codes.put('new hampshire','NH');
        codes.put('rhode island','RI');
        codes.put('massachusettes','MA');
        codes.put('connecticut','CT');
        codes.put('pennsylvania','PA');
        codes.put('delaware','DE');
        codes.put('maryland','MD');
        codes.put('virginia','VA');
        codes.put('west virginia','WV');
        codes.put('south carolina','SC');
        codes.put('mississippi','MS');
        codes.put('louisiana','LA');
        codes.put('arkansas','AR');
        codes.put('tennesee','TN');
        codes.put('kentucky','KY');
        codes.put('ohio','OH');
        codes.put('indiana','IN');
        codes.put('illinois','IL');
        codes.put('michigan','MI');
        codes.put('wisconsin','WI');
        codes.put('minnesota','MN');
        codes.put('north dakota','ND');
        codes.put('nebraska','NE');
        codes.put('kansas','KS');
        codes.put('oklahoma','OK');
        codes.put('new mexico','NM');
        codes.put('arizona','AZ');
        codes.put('colorado','CO');
        codes.put('utah','UT');
        codes.put('montana','MT');
        codes.put('wyoming','WY');
        codes.put('washington','WA');
        codes.put('district of columbia','DC');
        codes.put('oregon','OR');
        codes.put('alaska','AK');
        codes.put('hawaii','HI');
        codes.put('missouri','MO');
        codes.put('virgin islands','VI');
        codes.put('iowa','IA');
        codes.put('idaho','ID');
        codes.put('nevada','NV');
        codes.put('alabama','AL');
        codes.put('guam','GU');
        codes.put('foreign country','FC');
        codes.put('marshall islands','MH');
        codes.put('american samoa','AS');
        codes.put('ontario','ON');
        codes.put('quebec','QC');
        codes.put('alberta','AB');
        codes.put('british columba','BC');

        string state=codes.get(text.trim().toLowerCase());
         
        if(state!=NULL)
            return state;
        else
            return 'CA';
    }
    
    public static void reRun(Id appId){
        List<String> SFid = new List<String>(); 
        String SFaPPStuNum;
        String Program_Code;
        
        Application__c app = [select student__c, Application_Number__c, Program_Code__c from application__c where id=:appId];

        SFid.add(app.Student__c);
        SFaPPStuNum = app.Application_Number__c;
        Program_Code = app.Program_Code__c;

        List<Contact> cont = [select Id, lead_source_code__c, FirstName, LastName, MailingStreet, MailingCity, MailingState, MailingCountry, 
            MailingPostalCode, Email, Phone, OtherPhone, Program_Code__c, Previous_Education_Codes__c, Affiliation_Code__c from Contact WHERE Id in :SFid];
            
        for (Contact c: cont){
            
            if(Program_Code=='Unknown'){
                Program_Code='';
            }
            
            if(c.lead_source_code__c==null || c.lead_source_code__c=='null'){
                c.lead_source_code__c='OTH6008';
            }
            
            String LeadSource = Codes.checkIn(c.lead_source_code__c);
            String FirstName = Codes.checkIn(c.FirstName);
            String LastName = Codes.checkIn(c.LastName);
            String MailingStreet = Codes.checkIn(c.MailingStreet); 
            String MailingCity = Codes.checkIn(c.MailingCity);
            String MailingState =  Codes.getState(c.MailingState);
            String MailingPostalCode = Codes.checkIn(c.MailingPostalCode);
            String MailingCountry = Codes.getCountryCodes(c.MailingCountry);
            String Email = Codes.checkIn(c.Email);
            String Phone;
            if(c.Phone== null){
                Phone = '0000000000';
            }
            else {
                Phone = Codes.checkIn(c.Phone);
            }
            String OtherPhone = Codes.checkIn(c.OtherPhone);
            String Previous_Education = Codes.getPrevEduCodes(c.Previous_Education_Codes__c);
            String Affiliation_Code = Codes.getAffilicationCodes(c.Affiliation_Code__c);
            String SalesForceID = c.id;
            
            String url = 'http://eleads.lafilm.com:8088/Cmc.Integration.LeadImport.HttpPost/ImportLeadProcessor.aspx?Format=CollegeDirectories&leadsource='
                   + LeadSource + '&Firstname=' + FirstName + '&Lastname=' + LastName + '&Address1=' + MailingStreet + '&Address2=&City='
                   + MailingCity + '&State=' + MailingState + '&Postalcodeorzip=' + MailingPostalCode + '&Country='
                   + MailingCountry + '&Email=' + Email + '&Phone=' + Phone + '&WorkPhone=' + OtherPhone + '&Program='
                   + Program_Code + '&Campus=MAIN&PreviousEducation=' + Previous_Education + '&Agency='
                   + Affiliation_Code + '&ZSalesForceID=' + SalesForceID + '&ZSFaPPStuNum=' + SFaPPStuNum;
            
            sendHttpPostToCV.sendHttpRequest(url);
            
        }
    }
}