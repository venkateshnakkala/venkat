public class ContactUtilities {

    Private static Map<String,List<String>> dataSet;
    
    public static List<String> GetDataSet(String key){
        ContactUtilities.getdataSet();
        return dataSet.get(key);
    }
    
    public static Map<String,List<String>> GetDataSet(){
        dataSet = new Map<String,List<String>>();
        dataSet.put('ARIZONA',new List<String>{'Arizona Western College','College Outreach'});
        dataSet.put('COLBNDS',new List<String>{'College Bound Selection Service','College Outreach'});
        dataSet.put('COR1000',new List<String>{'College Outreach Fair-California','College Outreach'});
        dataSet.put('COR1001',new List<String>{'College Outreach Fair-National','College Outreach'});
        dataSet.put('COR1003',new List<String>{'College Outreach Teach In','College Outreach'});
        dataSet.put('ISRAELSF',new List<String>{'Israel School Fair','College Outreach'});
        dataSet.put('KROGERUP',new List<String>{'Krogerup - Denmark','College Outreach'});
        dataSet.put('LAVCFESTMOKH',new List<String>{'L.A. Valley College Fest','College Outreach'});
        dataSet.put('LAMC',new List<String>{'LA Mission College','College Outreach'});
        dataSet.put('NACAC-LAPVAF',new List<String>{'NACAC LA Performance & Visual Arts Fair','College Outreach'});
        dataSet.put('NACAC-SFPVAF',new List<String>{'NACAC San Fran Perf & Visual Arts Fair','College Outreach'});
        dataSet.put('NACAC-VPVAF',new List<String>{'NACAC Vegas Performance & Visual Fair','College Outreach'});
        dataSet.put('NHCFOC14',new List<String>{'National Hispanic College Fair- OC','College Outreach'});
        dataSet.put('SMCINTL',new List<String>{'Santa Monica College - International','College Outreach'});
        dataSet.put('TIERRA-DEL-S',new List<String>{'Valley College','College Outreach'});
        dataSet.put('BAY FRONT SD',new List<String>{'Bay Front San Diego HS Tour','High School Outreach'});
        dataSet.put('BOYLEHEIGHTS',new List<String>{'Boyle Heights Youth Centers','High School Outreach'});
        dataSet.put('SSMFGDM',new List<String>{'Summer Sunset Music Festival GDM Live','Outreach'});
        dataSet.put('B&G CLUB-BAY',new List<String>{'Boys and Girls Club-Bay Area','High School Outreach'});
        dataSet.put('CHULA VISTA',new List<String>{'Chula Vista HS','High School Outreach'});
        dataSet.put('HSO3007',new List<String>{'College Guide Listings','High School Outreach'});
        dataSet.put('DTMAGNETHS-A',new List<String>{'Downtown Magnet HS Career Fair','High School Outreach'});
        dataSet.put('DRHSCF',new List<String>{'DRHS Senior College Fair','High School Outreach'});
        dataSet.put('ECHS',new List<String>{'El Camino High School','High School Outreach'});
        dataSet.put('FFHIGH',new List<String>{'Fairfield High School','High School Outreach'});
        dataSet.put('FERIA14',new List<String>{'Feria De Educacion 2014','High School Outreach'});
        dataSet.put('HS-FIRE',new List<String>{'Firebaugh High School','High School Outreach'});
        dataSet.put('GLENDORAHS',new List<String>{'Glendora High School College Fair','High School Outreach'});
        dataSet.put('HSO3013',new List<String>{'High School Poster','High School Outreach'});
        dataSet.put('HSO-ZK',new List<String>{'HS Outreach - Zak Kawamleh','High School Outreach'});
        dataSet.put('HSO3014',new List<String>{'HS Outreach College Fair-California','High School Outreach'});
        dataSet.put('HSO3010',new List<String>{'HS Outreach College Fairs-National','High School Outreach'});
        dataSet.put('HSO3006',new List<String>{'HS Outreach Reply Card','High School Outreach'});
        dataSet.put('HSO3002A',new List<String>{'HS Outreach Tour/Visit','High School Outreach'});
        dataSet.put('HSO3001',new List<String>{'HS Teach In','High School Outreach'});
        dataSet.put('HSO3002',new List<String>{'HS Tour/Visit','High School Outreach'});
        dataSet.put('JBHIGH',new List<String>{'Jesse Bethel High School','High School Outreach'});
        dataSet.put('KAUAIHS',new List<String>{'Kauai High School','High School Outreach'});
        dataSet.put('KEITH',new List<String>{'Keith - LAFS High School Tour','High School Outreach'});
        dataSet.put('LAHI',new List<String>{'LA High School','High School Outreach'});
        dataSet.put('MSHS-OS',new List<String>{'Mount Si High School','High School Outreach'});
        dataSet.put('NHCFSJ14',new List<String>{'National Hispanic College Fair - SJ','High School Outreach'});
        dataSet.put('NHCFST14',new List<String>{'National Hispanic College Fair - ST','High School Outreach'});
        dataSet.put('NHCFSD14',new List<String>{'National Hispanic College Fair- SD','High School Outreach'});
        dataSet.put('NHCFLA14',new List<String>{'National Hispanic College Fair-LA','High School Outreach'});
        dataSet.put('NVHSCOVINA',new List<String>{'Northview High School','High School Outreach'});
        dataSet.put('ODYSSEYHSKHB',new List<String>{'Odyssey HS College and Career Fair KHB','High School Outreach'});
        dataSet.put('ONTARIO',new List<String>{'Ontario College Fair','High School Outreach'});
        dataSet.put('OTRECHEMAIL',new List<String>{'Outreach Email','High School Outreach'});
        dataSet.put('OMHS-TX',new List<String>{'Ozen Magnet HS Belmont, Texas','High School Outreach'});
        dataSet.put('RANCHO-CU-HS',new List<String>{'Rancho Cucamonga HS Fair','High School Outreach'});
        dataSet.put('SAN DIMAS HS',new List<String>{'San Dimas High School','High School Outreach'});
        dataSet.put('SJHIGH',new List<String>{'San Jose High School','High School Outreach'});
        dataSet.put('SMCOLFAIR',new List<String>{'Santa Monica College Fair','High School Outreach'});
        dataSet.put('SANTIAGOHS',new List<String>{'Santiago High School College Fair','High School Outreach'});
        dataSet.put('SNOWFLAKE HS',new List<String>{'SnowFlake HS','High School Outreach'});
        dataSet.put('SOCALPOMONA',new List<String>{'SoCal College Fair','High School Outreach'});
        dataSet.put('YUCCA VALLEY',new List<String>{'Yucca Valley HS','High School Outreach'});
        dataSet.put('SOTOMAYO',new List<String>{'Sotomayor Learing Academy','High School Outreach'});
        dataSet.put('SYLMARHS',new List<String>{'Sylmar HS Int. Arts Media College/Career','High School Outreach'});
        dataSet.put('WCHSCF',new List<String>{'West Covina High School College Fair','High School Outreach'});
        dataSet.put('WHS_LBC',new List<String>{'Wilson High School Long Beach','High School Outreach'});
        dataSet.put('ABEINDIA',new List<String>{'Abe Thomas - India','International Outreach'});
        dataSet.put('BEIJING',new List<String>{'Beijing Fair Leads','International Outreach'});
        dataSet.put('BFACHINA',new List<String>{'Beijing Film Academy - China','International Outreach'});
        dataSet.put('BMIMARCH',new List<String>{'Brazil Fair','International Outreach'});
        dataSet.put('BRAZILOCT',new List<String>{'Brazil Fair','International Outreach'});
        dataSet.put('BRAZILSEP',new List<String>{'Brazil Fair','International Outreach'});
        dataSet.put('CALPLYPOM',new List<String>{'Cal Poly English Language Institute','International Outreach'});
        dataSet.put('CANFAIRMV',new List<String>{'Canada Fair','International Outreach'});
        dataSet.put('CANINTL',new List<String>{'Canadian Intl Academic Serv - Canada','International Outreach'});
        dataSet.put('CANINDIA',new List<String>{'Canadian Intl Academic Serv - India','International Outreach'});
        dataSet.put('CARINDIA',new List<String>{'Career Mosaic Pvt. Ltd. India - India','International Outreach'});
        dataSet.put('CHINEDSRV',new List<String>{'China Edu Center Serv (Hubei) - China','International Outreach'});
        dataSet.put('CINECHINA',new List<String>{'CineMagic - China','International Outreach'});
        dataSet.put('CITRUS',new List<String>{'Citrus College','International Outreach'});
        dataSet.put('COLLEGEWK',new List<String>{'College Week Live','International Outreach'});
        dataSet.put('SAOPAULO',new List<String>{'Education USA - Sao Paulo','International Outreach'});
        dataSet.put('EDUFINDME',new List<String>{'EduFindMe.com','International Outreach'});
        dataSet.put('ELSCORP',new List<String>{'ELS Corporate','International Outreach'});
        dataSet.put('FULLSAIL',new List<String>{'Full Sail University','International Outreach'});
        dataSet.put('GUAD2014',new List<String>{'Guadalajara Ed Fair 2014','International Outreach'});
        dataSet.put('GUADALAJARA',new List<String>{'Guadalajara School Fair','International Outreach'});
        dataSet.put('INDIA15',new List<String>{'India Tour 2015','International Outreach'});
        dataSet.put('INTLOR',new List<String>{'International Outreach','International Outreach'});
        dataSet.put('JOAQINMXCO',new List<String>{'Joaquin Fernandez - Mexico','International Outreach'});
        dataSet.put('KAPLAN',new List<String>{'Kaplan International','International Outreach'});
        dataSet.put('KAPSLSBRY',new List<String>{'Kaplan Intl - Salisbury, England','International Outreach'});
        dataSet.put('KAPSINGPRE',new List<String>{'Kaplan Intl - Singapore, Singapore','International Outreach'});
        dataSet.put('KAPCAMBRG',new List<String>{'Kaplan Intl- Cambridge, England','International Outreach'});
        dataSet.put('KEDECHINA',new List<String>{'Kede College - China','International Outreach'});
        dataSet.put('KINGHLYWD',new List<String>{'Kings College','International Outreach'});
        dataSet.put('LATFF - MM',new List<String>{'LA Turkish FF','International Outreach'});
        dataSet.put('LSYILA',new List<String>{'Lang Systems Intl - Los Angeles, CA','International Outreach'});
        dataSet.put('LSI_DT_ LA',new List<String>{'Language Systems Institute - Downtown LA','International Outreach'});
        dataSet.put('MARSHALIU',new List<String>{'Marsha Liu - China','International Outreach'});
        dataSet.put('MLIBH',new List<String>{'Mentor Language Inst - Beverly Hills, CA','International Outreach'});
        dataSet.put('BLIHLYWD',new List<String>{'Mentor Language Inst - Hollywood, CA','International Outreach'});
        dataSet.put('MLIBEVHILLS',new List<String>{'Mentor Language Institute - Beverly Hill','International Outreach'});
        dataSet.put('MONTINST',new List<String>{'Monterey Inst of Intl Studies','International Outreach'});
        dataSet.put('MLIHLYWD',new List<String>{'Mentor Language Institute - Hollywod','International Outreach'});
        dataSet.put('MEXICO2014',new List<String>{'Mexico City Ed Fair 2014','International Outreach'});
        dataSet.put('MONTRY2014',new List<String>{'Monterrey Ed Fair 2014','International Outreach'});
        dataSet.put('GOGLOBE_MONT',new List<String>{'Montreal_GoGlobal2014','International Outreach'});
        dataSet.put('OLWCHINA',new List<String>{'Oriental LongWen - China','International Outreach'});
        dataSet.put('OVRSEACHNA',new List<String>{'Overseas Interview & Test Center - China','International Outreach'});
        dataSet.put('OXBDGCHNA',new List<String>{'OxBridge Consulting - China','International Outreach'});
        dataSet.put('PFLASIA',new List<String>{'PFL Group International Ltd - Asia','International Outreach'});
        dataSet.put('PFLMDLEAST',new List<String>{'PFL Group Intl Ltd - Middle East','International Outreach'});
        dataSet.put('PFLUK',new List<String>{'PFL Group Intl Ltd - United Kingdom','International Outreach'});
        dataSet.put('PLYLA',new List<String>{'Poly Lang Inst - Los Angeles, CA','International Outreach'});
        dataSet.put('RDLFOBRZL',new List<String>{'Rodolfo Rocha - Brazil','International Outreach'});
        dataSet.put('RODRODGUAD',new List<String>{'Rodrigo Rodriguez','International Outreach'});
        dataSet.put('SBARBCC',new List<String>{'Santa Barbara City College','International Outreach'});
        dataSet.put('SMONCC',new List<String>{'Santa Monica College','International Outreach'});
        dataSet.put('SDSTATE',new List<String>{'SD State University American Lang Inst','International Outreach'});
        dataSet.put('SHANGHAI',new List<String>{'Shanghai Leads','International Outreach'});
        dataSet.put('SHGIXCHNA',new List<String>{'Shanghai OvEdu Consulting - China','International Outreach'});
        dataSet.put('SIASCHINA',new List<String>{'Sias University - China','International Outreach'});
        dataSet.put('STBGATE',new List<String>{'STB GATE Fair - Brazil','International Outreach'});
        dataSet.put('TECMXCO',new List<String>{'Technologico de Monterrey - Mexico','International Outreach'});
        dataSet.put('ECREXT',new List<String>{'UC Riverside Ext Intl Education Program','International Outreach'});
        dataSet.put('UCSD',new List<String>{'UC San Diego Extension','International Outreach'});
        dataSet.put('UCLAEXT',new List<String>{'UCLA Extension American Language Center','International Outreach'});
        dataSet.put('WAYNECHNA',new List<String>{'Wayne Chu - China','International Outreach'});
        dataSet.put('WELTAIWN',new List<String>{'Welcome Consulting Co - Taiwan','International Outreach'});
        dataSet.put('XIANCHINA',new List<String>{'Xian University - China','International Outreach'});
        dataSet.put('YTHCTRCHNA',new List<String>{'Youth in Concern Intl Edu Center - China','International Outreach'});
        dataSet.put('29PALMS',new List<String>{'29 Palms','Military Outreach'});
        dataSet.put('63YRRP',new List<String>{'63rd RSC YRRP','Military Outreach'});
        dataSet.put('63YR - AN',new List<String>{'63rd Yellow Ribbon','Military Outreach'});
        dataSet.put('ARMYTIMES',new List<String>{'Army Times','Military Outreach'});
        dataSet.put('ARMYNAVY',new List<String>{'Army vs Navy Program','Military Outreach'});
        dataSet.put('CAMPLEJEUNE',new List<String>{'Camp Lejeune','Military Outreach'});
        dataSet.put('PENDLETON',new List<String>{'Camp Pendleton','Military Outreach'});
        dataSet.put('CCME',new List<String>{'CCME','Military Outreach'});
        dataSet.put('CHERRYPT',new List<String>{'Cherry Point','Military Outreach'});
        dataSet.put('CONAP',new List<String>{'Conap','Military Outreach'});
        dataSet.put('EANGUS',new List<String>{'EANGUS','Military Outreach'});
        dataSet.put('EDWARDSAFB',new List<String>{'Edwards AFB','Military Outreach'});
        dataSet.put('FTIRWIN',new List<String>{'Fort Irwin','Military Outreach'});
        dataSet.put('FTBENNING',new List<String>{'Ft. Benning','Military Outreach'});
        dataSet.put('FTBLISS',new List<String>{'Ft. Bliss','Military Outreach'});
        dataSet.put('FTBRAGG',new List<String>{'Ft. Bragg','Military Outreach'});
        dataSet.put('FTHOOD',new List<String>{'Ft. Hood','Military Outreach'});
        dataSet.put('FTSHAFTER',new List<String>{'Ft. Shafter','Military Outreach'});
        dataSet.put('HICKAM',new List<String>{'Hickam AFB','Military Outreach'});
        dataSet.put('HUNTERAA',new List<String>{'Hunter Army Airfield','Military Outreach'});
        dataSet.put('JBPHH-AN',new List<String>{'Jems Military Expo JBPHH','Military Outreach'});
        dataSet.put('AFBHI_MO',new List<String>{'Joint Base Hickam Air Force Base MO','Military Outreach'});
        dataSet.put('LACKLAND',new List<String>{'Lackland AFB','Military Outreach'});
        dataSet.put('LOSALAMITOS',new List<String>{'Los Alamitos','Military Outreach'});
        dataSet.put('LAAFB',new List<String>{'Los Angeles AFB/LAAFB','Military Outreach'});
        dataSet.put('MARCHARB',new List<String>{'March ARB','Military Outreach'});
        dataSet.put('MCBHI',new List<String>{'Marine Corps Base Hawaii','Military Outreach'});
        dataSet.put('MARINESOUTH',new List<String>{'Marine South Expo','Military Outreach'});
        dataSet.put('MARINEWEST',new List<String>{'Marine West Expo','Military Outreach'});
        dataSet.put('MIRAMAR',new List<String>{'MCAS Miramar','Military Outreach'});
        dataSet.put('CAMPSMITH',new List<String>{'MCBH-Camp Smith','Military Outreach'});
        dataSet.put('MIRAMARFAIR',new List<String>{'Mirama Ed Fair','Military Outreach'});
        dataSet.put('NBPH',new List<String>{'Naval Base Pearl Harbor','Military Outreach'});
        dataSet.put('NAVHOSEDFAIR',new List<String>{'Naval Hospital Camp Pen. Ed Fair','Military Outreach'});
        dataSet.put('NBSANDIEGO',new List<String>{'NB Sandiego/32nd Street','Military Outreach'});
        dataSet.put('NCOA_CP_MO',new List<String>{'NCOA Camp Pendleton','Military Outreach'});
        dataSet.put('SCHOFIELD-AN',new List<String>{'Schofield Barracks','Military Outreach'});
        dataSet.put('USMCIRR',new List<String>{'USMC Annual IRR Muster','Military Outreach'});
        dataSet.put('IRRHAWAII',new List<String>{'USMC-IRR-Hawaii','Military Outreach'});
        dataSet.put('TRIBEUNITY',new List<String>{'Tribe Unity Producers Battle','Outreach'});
        dataSet.put('MAOF-COMM',new List<String>{'Annual MAOF Latina Conference','Outreach'});
        dataSet.put('BOMPOPRADIO',new List<String>{'BomPopRadio HMMA Launch HOB','Outreach'});
        dataSet.put('MUSICOLOGY',new List<String>{'Musicology Panel','Outreach'});
        dataSet.put('SIERRAVISTA',new List<String>{'Sierra Vista HS College and Career Fair','Outreach'});
        dataSet.put('WIZWORLD',new List<String>{'Wizard World Conference','Outreach'});
        dataSet.put('TRANS',new List<String>{'Transition','AFLABASE'});
        dataSet.put('DIR1407',new List<String>{'ASCA Competition Dec 08','Direct Marketing'});
        dataSet.put('CBSEMAIL',new List<String>{'CBS Email','Direct Marketing'});
        dataSet.put('DIR1304',new List<String>{'CollegeOptions','Direct Marketing'});
        dataSet.put('DIR1212',new List<String>{'Direct Email Fs Lex','Direct Marketing'});
        dataSet.put('DIR1100',new List<String>{'Direct Mail - Datamark','Direct Marketing'});
        dataSet.put('DIR1213',new List<String>{'Direct Mail - Lars','Direct Marketing'});
        dataSet.put('DIR1204',new List<String>{'Direct Mail - Q1 2005','Direct Marketing'});
        dataSet.put('DIR1214',new List<String>{'Direct Mail 2007','Direct Marketing'});
        dataSet.put('DIR1306',new List<String>{'DIRECT MAIL 2008','Direct Marketing'});
        dataSet.put('DIR1210',new List<String>{'Direct Mail Fall 2006','Direct Marketing'});
        dataSet.put('DIR1206',new List<String>{'Direct Mail FS_LEX06','Direct Marketing'});
        dataSet.put('DIR1211',new List<String>{'Direct Mail FS_LEX07','Direct Marketing'});
        dataSet.put('DIR1208',new List<String>{'Direct Mail Fs0505','Direct Marketing'});
        dataSet.put('DIR1205',new List<String>{'Direct Mail Q2 2005','Direct Marketing'});
        dataSet.put('DIR1305',new List<String>{'DIRECT MAIL_FS_LEX08','Direct Marketing'});
        dataSet.put('DIR1403',new List<String>{'Dm_apr08_cbss','Direct Marketing'});
        dataSet.put('DIR1309',new List<String>{'Dm_fall2007','Direct Marketing'});
        dataSet.put('DIR1207',new List<String>{'DMTimes2006','Direct Marketing'});
        dataSet.put('EBBSPRESS',new List<String>{'EBBS Press','Direct Marketing'});
        dataSet.put('EBBSCARD',new List<String>{'Entertainment Business BS Card','Direct Marketing'});
        dataSet.put('DIR1404',new List<String>{'FS_LEX New Degree Announcement','Direct Marketing'});
        dataSet.put('DIR1408',new List<String>{'Graduate Outreach','Direct Marketing'});
        dataSet.put('LAFSTHEATRE',new List<String>{'LAFS Theatre Slides','Direct Marketing'});
        dataSet.put('MRKTEMAIL',new List<String>{'Marketing Email','Direct Marketing'});
        dataSet.put('MILHPC',new List<String>{'Military Holiday Postcard','Direct Marketing'});
        dataSet.put('MPEMAIL',new List<String>{'Music Production Email','Direct Marketing'});
        dataSet.put('DIR1405',new List<String>{'NWE June08 - LADBase','Direct Marketing'});
        dataSet.put('DIR1406',new List<String>{'NWE June08 - NRCCUA','Direct Marketing'});
        dataSet.put('PSTCRD',new List<String>{'Open House Postcard','Direct Marketing'});
        dataSet.put('OHTICKET',new List<String>{'Open House Ticket','Direct Marketing'});
        dataSet.put('AAHSFFNYC',new List<String>{'All American High School Film Festival','Event'});
        dataSet.put('CASH4COLLEGE',new List<String>{'Cash for College - LA Chamber Event','Event'});
        dataSet.put('COMICCON',new List<String>{'ComicCon','Event'});
        dataSet.put('DJSKEE',new List<String>{'DJ SKEE','Event'});
        dataSet.put('EVE2030',new List<String>{'Dynamic Producers','Event'});
        dataSet.put('LACOSPLAYCON',new List<String>{'LA Cosplay Con','Event'});
        dataSet.put('DJCAMP',new List<String>{'Oakenfold DJ Camp','Event'});
        dataSet.put('OTH6011',new List<String>{'Full Sail Lead Exchange','Full Sail Lead Exchange'});
        dataSet.put('FSEX50',new List<String>{'Full Sail Lead Exchange 50','Full Sail Lead Exchange'});
        dataSet.put('FSLXLIVE',new List<String>{'Full Sail LIVE Lead Exchange','Full Sail Lead Exchange'});
        dataSet.put('FULLSAILLEAD',new List<String>{'Full Sail Online Leads','Full Sail Lead Exchange'});
        dataSet.put('INA4412',new List<String>{'Xxlmag.com','Internet Advertising'});
        dataSet.put('INA4140',new List<String>{'931Jackfm.com','Internet Advertising'});
        dataSet.put('INA4114',new List<String>{'944.com LA','Internet Advertising'});
        dataSet.put('INA4205',new List<String>{'991KGGIfm.com','Internet Advertising'});
        dataSet.put('ADROLL',new List<String>{'AdRoll','Internet Advertising'});
        dataSet.put('ADROLLANI',new List<String>{'AdRoll','Internet Advertising'});
        dataSet.put('ADROLLDF',new List<String>{'AdRoll','Internet Advertising'});
        dataSet.put('ADROLLEBC',new List<String>{'AdRoll','Internet Advertising'});
        dataSet.put('ADROLLEBO',new List<String>{'AdRoll','Internet Advertising'});
        dataSet.put('ADROLLFM',new List<String>{'AdRoll','Internet Advertising'});
        dataSet.put('ADROLLGP',new List<String>{'AdRoll','Internet Advertising'});
        dataSet.put('ADROLLINTL',new List<String>{'AdRoll','Internet Advertising'});
        dataSet.put('ADROLLMILI',new List<String>{'AdRoll','Internet Advertising'});
        dataSet.put('ADROLLMP',new List<String>{'AdRoll','Internet Advertising'});
        dataSet.put('ADROLLOMNI',new List<String>{'AdRoll','Internet Advertising'});
        dataSet.put('ADROLLRA',new List<String>{'AdRoll','Internet Advertising'});
        dataSet.put('INA4075',new List<String>{'Aintitcoolnews.com','Internet Advertising'});
        dataSet.put('INA4110',new List<String>{'Allhiphop.com','Internet Advertising'});
        dataSet.put('INA4124',new List<String>{'Alternativepress.com','Internet Advertising'});
        dataSet.put('INA4178',new List<String>{'AmericanIdol.com LAFS','Internet Advertising'});
        dataSet.put('INA4635',new List<String>{'Ampradio.com','Internet Advertising'});
        dataSet.put('INA4333',new List<String>{'Animation World Network','Internet Advertising'});
        dataSet.put('INA4125',new List<String>{'Backstage.com','Internet Advertising'});
        dataSet.put('INA4221',new List<String>{'Ballerstatus.com','Internet Advertising'});
        dataSet.put('INA4166',new List<String>{'Bossip.com','Internet Advertising'});
        dataSet.put('INA4063',new List<String>{'Boxofficemojo.com','Internet Advertising'});
        dataSet.put('INA4108',new List<String>{'Calendarlive.com','Internet Advertising'});
        dataSet.put('INA4163',new List<String>{'Campuscircle.com','Internet Advertising'});
        dataSet.put('INA4127',new List<String>{'Careersandeducation.com','Internet Advertising'});
        dataSet.put('INA4338',new List<String>{'CG.com','Internet Advertising'});
        dataSet.put('INA4326',new List<String>{'Cgchannel','Internet Advertising'});
        dataSet.put('INA4335',new List<String>{'CgSociety','Internet Advertising'});
        dataSet.put('INA4229',new List<String>{'Chud.com','Internet Advertising'});
        dataSet.put('INA4204',new List<String>{'Cinemablend.com','Internet Advertising'});
        dataSet.put('CITYSEARCH',new List<String>{'Citysearch Ad','Internet Advertising'});
        dataSet.put('INA4106',new List<String>{'Citysearch.com','Internet Advertising'});
        dataSet.put('INA4231',new List<String>{'Cliffnotes.com','Internet Advertising'});
        dataSet.put('INA4064',new List<String>{'Comingsoon.net','Internet Advertising'});
        dataSet.put('INA4066',new List<String>{'Darkhorizons.com','Internet Advertising'});
        dataSet.put('INA4328',new List<String>{'Deviant Art','Internet Advertising'});
        dataSet.put('INA4107',new List<String>{'Dubpublishing.com','Internet Advertising'});
        dataSet.put('EDGETHEORY',new List<String>{'Edge Theory','Internet Advertising'});
        dataSet.put('ENGAGEADROID',new List<String>{'Engage Adroid Ad','Internet Advertising'});
        dataSet.put('ENGAGE',new List<String>{'Engage Display','Internet Advertising'});
        dataSet.put('INA4073',new List<String>{'Ew.com (entertainment Weekly)','Internet Advertising'});
        dataSet.put('INA4126',new List<String>{'Film.com','Internet Advertising'});
        dataSet.put('INA4105',new List<String>{'Friendster.com LA-Local','Internet Advertising'});
        dataSet.put('INA4179',new List<String>{'Funnyordie.com','Internet Advertising'});
        dataSet.put('INA4342',new List<String>{'Gamasutra.com','Internet Advertising'});
        dataSet.put('INA4341',new List<String>{'Gamecareerguide.com','Internet Advertising'});
        dataSet.put('INA4324',new List<String>{'gameinformer.com','Internet Advertising'});
        dataSet.put('INA4340',new List<String>{'GamerDNA','Internet Advertising'});
        dataSet.put('INA4331',new List<String>{'Gamespy.com','Internet Advertising'});
        dataSet.put('INA4336',new List<String>{'GamesRadar','Internet Advertising'});
        dataSet.put('GENLANDING',new List<String>{'Generic Landing Page','Internet Advertising'});
        dataSet.put('GIJOBS',new List<String>{'GI Jobs','Internet Advertising'});
        dataSet.put('GOOGLEVIDRA',new List<String>{'Google Video Ad','Internet Advertising'});
        dataSet.put('GOOGVIDAVFX',new List<String>{'Google Video Ad','Internet Advertising'});
        dataSet.put('GOOGVIDGP',new List<String>{'Google Video Ad','Internet Advertising'});
        dataSet.put('INA4098',new List<String>{'Hollywood.com','Internet Advertising'});
        dataSet.put('HYPEM',new List<String>{'Hypem.com','Internet Advertising'});
        dataSet.put('HYPEMCA',new List<String>{'Hypem.com Computer Animation','Internet Advertising'});
        dataSet.put('HYPEMEB',new List<String>{'Hypem.com Entertainment Business','Internet Advertising'});
        dataSet.put('HYPEMF',new List<String>{'Hypem.com Film','Internet Advertising'});
        dataSet.put('HYPEMGP',new List<String>{'Hypem.com Game Production','Internet Advertising'});
        dataSet.put('HYPEMRA',new List<String>{'Hypem.com Recording Arts','Internet Advertising'});
        dataSet.put('INA4332',new List<String>{'IGN.com','Internet Advertising'});
        dataSet.put('INA4053',new List<String>{'IMDB.com','Internet Advertising'});
        dataSet.put('INA4161',new List<String>{'Imeem.com','Internet Advertising'});
        dataSet.put('INA4117',new List<String>{'Indie103.com','Internet Advertising'});
        dataSet.put('INA4102',new List<String>{'Internetdj.com','Internet Advertising'});
        dataSet.put('INA4065',new List<String>{'Joblo.com','Internet Advertising'});
        dataSet.put('INA4115',new List<String>{'KROQ.com 106.7','Internet Advertising'});
        dataSet.put('INA4222',new List<String>{'Krsone.com','Internet Advertising'});
        dataSet.put('INA4112',new List<String>{'LA.com','Internet Advertising'});
        dataSet.put('INA4173',new List<String>{'Latino963.com','Internet Advertising'});
        dataSet.put('INA4564',new List<String>{'militaryfriendlyschools','Internet Advertising'});
        dataSet.put('INA4101',new List<String>{'Mixtapeking.com','Internet Advertising'});
        dataSet.put('MOB1',new List<String>{'MOB Media 1','Internet Advertising'});
        dataSet.put('MOB2',new List<String>{'MOB Media 2','Internet Advertising'});
        dataSet.put('MOB3',new List<String>{'MOB Media 3','Internet Advertising'});
        dataSet.put('MOB4',new List<String>{'MOB Media 4','Internet Advertising'});
        dataSet.put('INA4103',new List<String>{'Monsters&critics.com','Internet Advertising'});
        dataSet.put('INA4142',new List<String>{'Movieweb.com','Internet Advertising'});
        dataSet.put('INA4198',new List<String>{'Movin939.FM','Internet Advertising'});
        dataSet.put('INA4054',new List<String>{'Myspace.com','Internet Advertising'});
        dataSet.put('INA4330',new List<String>{'pennyarcade.com','Internet Advertising'});
        dataSet.put('PETERSONS',new List<String>{'Petersons','Internet Advertising'});
        dataSet.put('INA4077',new List<String>{'Purevolume.com','Internet Advertising'});
        dataSet.put('INA4081',new List<String>{'Rhapsody.com','Internet Advertising'});
        dataSet.put('INA4096',new List<String>{'Rock.com','Internet Advertising'});
        dataSet.put('INA4020',new List<String>{'Rollingstone.com','Internet Advertising'});
        dataSet.put('INA4039',new List<String>{'Rottentomatoes.com','Internet Advertising'});
        dataSet.put('INA4162',new List<String>{'Saturdaynightmagazine.com','Internet Advertising'});
        dataSet.put('SHIKSHA',new List<String>{'Shiksha.com','Internet Advertising'});
        dataSet.put('INA4123',new List<String>{'Skinniemagazine.com','Internet Advertising'});
        dataSet.put('INA4111',new List<String>{'Sohh.com','Internet Advertising'});
        dataSet.put('INA4191',new List<String>{'Star987.com','Internet Advertising'});
        dataSet.put('INA4139',new List<String>{'Superdeluxe.com','Internet Advertising'});
        dataSet.put('INA4199',new List<String>{'Thedistrictweekly.com','Internet Advertising'});
        dataSet.put('INA4113',new List<String>{'Thelot.com','Internet Advertising'});
        dataSet.put('INA4009',new List<String>{'Tribal Fusion','Internet Advertising'});
        dataSet.put('INA4097',new List<String>{'Ultimateguitar.com','Internet Advertising'});
        dataSet.put('INA4121',new List<String>{'Urb.com','Internet Advertising'});
        dataSet.put('VIVAMUNDO',new List<String>{'Viva Mundo','Internet Advertising'});
        dataSet.put('INA4196',new List<String>{'Worstpreviews.com','Internet Advertising'});
        dataSet.put('INC4221',new List<String>{'Quin Street AS/BS','Internet College Directories'});
        dataSet.put('INC4331',new List<String>{'Banner Edge','Internet College Directories'});
        dataSet.put('INC4303',new List<String>{'Campus explorer','Internet College Directories'});
        dataSet.put('INC4235',new List<String>{'USIM','Internet College Directories'});
        dataSet.put('INC4335',new List<String>{'Generation Z','Internet College Directories'});
        dataSet.put('INC4220',new List<String>{'Keypath','Internet College Directories'});
        dataSet.put('INC_DTSP',new List<String>{'Quin Street DTSP','Internet College Directories'});
        dataSet.put('INC4221WC',new List<String>{'Quin Street WCT','Internet College Directories'});
        dataSet.put('INC4330',new List<String>{'Ronin Revenue','Internet College Directories'});
        dataSet.put('INC4243',new List<String>{'Underground Elephant','Internet College Directories'});
        dataSet.put('INC4030',new List<String>{'University Mission','Internet College Directories'});
        dataSet.put('INC4336',new List<String>{'Zeta Interactive Call Ver.','Internet College Directories'});
        dataSet.put('INC4337',new List<String>{'Zeta Interactive dis portal','Internet College Directories'});
        dataSet.put('INC4338',new List<String>{'Zeta Interactive edu portal','Internet College Directories'});
        dataSet.put('INT4506',new List<String>{'Email Newsletter','Internet General'});
        dataSet.put('INT4511',new List<String>{'Get Exposed RSVP','Internet General'});
        dataSet.put('INT4513',new List<String>{'Legendarypictures.com','Internet General'});
        dataSet.put('PCGAMER',new List<String>{'PC Gamer','Internet General'});
        dataSet.put('INT4516',new List<String>{'Raytelevision.com','Internet General'});
        dataSet.put('INL4130',new List<String>{'LACityBeat.com','Internet Local'});
        dataSet.put('INL4135',new List<String>{'LADowntownNews.com','Internet Local'});
        dataSet.put('INL4120',new List<String>{'LAWeekly.com','Internet Local'});
        dataSet.put('INL4128',new List<String>{'LAWeekly.com Edu Ad','Internet Local'});
        dataSet.put('INL4152',new List<String>{'Metromix.com LA','Internet Local'});
        dataSet.put('INL4054',new List<String>{'MySpace.com - LOCAL','Internet Local'});
        dataSet.put('INS4626',new List<String>{'Abcsearch.com','Internet Search'});
        dataSet.put('INS4623',new List<String>{'Ask.com','Internet Search'});
        dataSet.put('INS4613',new List<String>{'Business.com','Internet Search'});
        dataSet.put('INS4610',new List<String>{'Industrybrains.com','Internet Search'});
        dataSet.put('INT4500A',new List<String>{'Internet Default','Internet Search'});
        dataSet.put('INT4501',new List<String>{'Internet-Confirmed','Internet Search'});
        dataSet.put('INS4614',new List<String>{'Miva.com','Internet Search'});
        dataSet.put('LAFSCTOLX',new List<String>{'LAFS Campus-to-Online Lead Exchange','LAFS Campus-Online Exchange'});
        dataSet.put('JETSPRNG',new List<String>{'Jet Spring Chat','LAFS Website'});
        dataSet.put('LAFSWEB',new List<String>{'lafilm.edu','LAFS Website'});
        dataSet.put('INA4322',new List<String>{'lafilm.edu','LAFS Website'});
        dataSet.put('AFLWEBLEAD',new List<String>{'lafilm.edu/military1','LAFS Website'});
        dataSet.put('WBSITE',new List<String>{'lafilm.edu','LAFS Website'});
        dataSet.put('ONLINEAPP',new List<String>{'lafilm.edu','LAFS Website'});
        dataSet.put('WEBAPP',new List<String>{'Unassigned Web App','LAFS Website'});
        dataSet.put('LAFSWEBA',new List<String>{'Web Leads','LAFS Website'});
        dataSet.put('INA4323A',new List<String>{'LARecordingSchool.com Web','LARS Website'});
        dataSet.put('INL4173A',new List<String>{'Latino963.com','LM-HS'});
        dataSet.put('LM-HS',new List<String>{'LM-HS','LM-HS'});
        dataSet.put('Test',new List<String>{'test','Magazine'});
        dataSet.put('MAG5533',new List<String>{'944 Magazine LA','Magazine'});
        dataSet.put('MAG5626',new List<String>{'Acoustic-Guitar World','Magazine'});
        dataSet.put('MAG5702',new List<String>{'Alt Press Insert 08','Magazine'});
        dataSet.put('MAG5600',new List<String>{'Alternative Press Magazine','Magazine'});
        dataSet.put('MAG5300',new List<String>{'American Cinematographer','Magazine'});
        dataSet.put('INA4337',new List<String>{'AnimationMagazine.net','Magazine'});
        dataSet.put('MAG5535',new List<String>{'Backstage West Magazine','Magazine'});
        dataSet.put('MAG5520',new List<String>{'College Outlook Recruitment Magazine','Magazine'});
        dataSet.put('MAG5514',new List<String>{'Daily Variety','Magazine'});
        dataSet.put('MAG5643',new List<String>{'Dub Magazine','Magazine'});
        dataSet.put('MAG5310',new List<String>{'DV (Digital Video Magazine)','Magazine'});
        dataSet.put('MAG5606',new List<String>{'Electronic Musician','Magazine'});
        dataSet.put('MAG5302',new List<String>{'Entertainment Weekly','Magazine'});
        dataSet.put('MAG5607',new List<String>{'Eq Magazine','Magazine'});
        dataSet.put('MAG5314',new List<String>{'Fade In','Magazine'});
        dataSet.put('MAG5312',new List<String>{'Film & Video Magazine','Magazine'});
        dataSet.put('MAG5315',new List<String>{'Film Comment','Magazine'});
        dataSet.put('MAG5303',new List<String>{'Filmmaker Magazine','Magazine'});
        dataSet.put('INA4069',new List<String>{'Friendsterblogs.com','Magazine'});
        dataSet.put('MAG5316',new List<String>{'Giant Magazine','Magazine'});
        dataSet.put('MAG5609',new List<String>{'Guitar Player','Magazine'});
        dataSet.put('MAG5610',new List<String>{'Guitar World','Magazine'});
        dataSet.put('MAG5703',new List<String>{'Guitar World Insert 08','Magazine'});
        dataSet.put('INA4563',new List<String>{'Guitaretab.com','Magazine'});
        dataSet.put('MAG5515',new List<String>{'Hollywood Reporter','Magazine'});
        dataSet.put('INA4612',new List<String>{'IFanBoy.com','Magazine'});
        dataSet.put('MAG5317',new List<String>{'Independent Film & Video','Magazine'});
        dataSet.put('MAG5318',new List<String>{'Indie Slate','Magazine'});
        dataSet.put('MAG5536',new List<String>{'Job Link Magazine','Magazine'});
        dataSet.put('MAG5612',new List<String>{'Keyboard Mag','Magazine'});
        dataSet.put('MAG5633',new List<String>{'LA Magazine','Magazine'});
        dataSet.put('INA4120A',new List<String>{'LAWeekly.com','Magazine'});
        dataSet.put('MAG5505',new List<String>{'Magazine - General','Magazine'});
        dataSet.put('MAG5613',new List<String>{'Mix Magazine','Magazine'});
        dataSet.put('MAG5614',new List<String>{'Modern Drummer Magazine','Magazine'});
        dataSet.put('MAG5304',new List<String>{'Moviemaker','Magazine'});
        dataSet.put('ARC9087',new List<String>{'Musicians Magazine','Magazine'});
        dataSet.put('MILLMEDIA',new List<String>{'Millenial Media','Mobile'});
        dataSet.put('INA4054A',new List<String>{'Myspace.com','Magazine'});
        dataSet.put('MAG5632',new List<String>{'Paste Magazine','Magazine'});
        dataSet.put('MAG5307',new List<String>{'Premiere Magazine','Magazine'});
        dataSet.put('MAG5615',new List<String>{'Recording Magazine','Magazine'});
        dataSet.put('MAG5616',new List<String>{'Remix Magazine','Magazine'});
        dataSet.put('MAG5308',new List<String>{'Res Magazine','Magazine'});
        dataSet.put('MAG5617',new List<String>{'Revolver Magazine','Magazine'});
        dataSet.put('MAG5618',new List<String>{'Rolling Stone Magazine','Magazine'});
        dataSet.put('MAG5624',new List<String>{'Scratch  Magazine','Magazine'});
        dataSet.put('MAG5534',new List<String>{'Skinnie Magazine','Magazine'});
        dataSet.put('MAG5619',new List<String>{'Spin','Magazine'});
        dataSet.put('MAG5322',new List<String>{'Student Filmmakers','Magazine'});
        dataSet.put('MAG5627',new List<String>{'Threat Magazine','Magazine'});
        dataSet.put('MAG5621',new List<String>{'Urb Magazine','Magazine'});
        dataSet.put('MAG5622',new List<String>{'Vibe','Magazine'});
        dataSet.put('MAG5623',new List<String>{'Xxl','Magazine'});
        dataSet.put('PAGEWOO',new List<String>{'Pagewoo','Mobile'});
        dataSet.put('TRUMPIA',new List<String>{'Trumpia Text Message','Mobile'});
        dataSet.put('NEW5917',new List<String>{'LA City Beat','Newspaper'});
        dataSet.put('NEW5923',new List<String>{'LA Downtown News','Newspaper'});
        dataSet.put('NEW5916',new List<String>{'LA Opinion','Newspaper'});
        dataSet.put('NEW5915',new List<String>{'LA Times','Newspaper'});
        dataSet.put('NEW5922',new List<String>{'LA Times Insert','Newspaper'});
        dataSet.put('NEW5925',new List<String>{'La Weekly Insert V2','Newspaper'});
        dataSet.put('NEW5924',new List<String>{'La Weekly Inserts V1','Newspaper'});
        dataSet.put('NEW5909',new List<String>{'Newspaper-General','Newspaper'});
        dataSet.put('NEW5921',new List<String>{'Pasadena City Beat','Newspaper'});
        dataSet.put('NEW5918',new List<String>{'San Diego City Beat','Newspaper'});
        dataSet.put('NEW5919',new List<String>{'SF Weekly','Newspaper'});
        dataSet.put('NEW5920',new List<String>{'Valley City Reader','Newspaper'});
        dataSet.put('ACAVA',new List<String>{'Annie Cavanaugh','Other'});
        dataSet.put('EVE2016',new List<String>{'Community Outreach Program','Other'});
        dataSet.put('DATAENTRY',new List<String>{'Data Entry','Other'});
        dataSet.put('DLUU-CP',new List<String>{'DLUU-CP','Other'});
        dataSet.put('DLUU-HS',new List<String>{'DLUU-HS','Other'});
        dataSet.put('OTH6007',new List<String>{'I.s.i.r.','Other'});
        dataSet.put('OTH6004',new List<String>{'Incoming Mail','Other'});
        dataSet.put('ARC9162',new List<String>{'Isir','Other'});
        dataSet.put('ARC9163',new List<String>{'Isir Archive','Other'});
        dataSet.put('OTH6012',new List<String>{'LAFS Theater','Other'});
        dataSet.put('MIL-MO-29P',new List<String>{'MO-29 Palms','Other'});
        dataSet.put('OTH6008',new List<String>{'Not Defined','Other'});
        dataSet.put('OTH6000',new List<String>{'Phonebook - Yellow Pages','Other'});
        dataSet.put('UMISIR',new List<String>{'Unmatched ISIRs','Other'});
        dataSet.put('Test',new List<String>{'Test','Other'});
        dataSet.put('LBCC',new List<String>{'Long Beach City College','Outdoor'});
        dataSet.put('OTH6010',new List<String>{'Billboard Sign','Outdoor'});
        dataSet.put('OTH6009',new List<String>{'Casting Call','Outdoor'});
        dataSet.put('GOOGLEDF',new List<String>{'Google','Paid Search'});
        dataSet.put('GOOGLEEBO',new List<String>{'Google','Paid Search'});
        dataSet.put('GOOGLEMILI',new List<String>{'Google','Paid Search'});
        dataSet.put('GOOGLEMPO',new List<String>{'Google','Paid Search'});
        dataSet.put('GOOGLEPRS',new List<String>{'Google','Paid Search'});
        dataSet.put('GOOGLEPRSCA',new List<String>{'Google','Paid Search'});
        dataSet.put('GOOGLEPRSEB',new List<String>{'Google','Paid Search'});
        dataSet.put('GOOGLEPRSFM',new List<String>{'Google','Paid Search'});
        dataSet.put('GOOGLEPRSGP',new List<String>{'Google','Paid Search'});
        dataSet.put('GOOGLEPRSINT',new List<String>{'Google','Paid Search'});
        dataSet.put('GOOGLEPRSMIL',new List<String>{'Google','Paid Search'});
        dataSet.put('GOOGLEPRSMP',new List<String>{'Google','Paid Search'});
        dataSet.put('GOOGLEPRSRA',new List<String>{'Google','Paid Search'});
        dataSet.put('YAHOODF',new List<String>{'Yahoo','Paid Search'});
        dataSet.put('YAHOOEBO',new List<String>{'Yahoo','Paid Search'});
        dataSet.put('YAHOOMILI',new List<String>{'Yahoo','Paid Search'});
        dataSet.put('YAHOOPRS',new List<String>{'Yahoo','Paid Search'});
        dataSet.put('YAHOOPRSCA',new List<String>{'Yahoo','Paid Search'});
        dataSet.put('YAHOOPRSEB',new List<String>{'Yahoo','Paid Search'});
        dataSet.put('YAHOOPRSFM',new List<String>{'Yahoo','Paid Search'});
        dataSet.put('YAHOOPRSGP',new List<String>{'Yahoo','Paid Search'});
        dataSet.put('YAHOOPRSINT',new List<String>{'Yahoo','Paid Search'});
        dataSet.put('YAHOOPRSMIL',new List<String>{'Yahoo','Paid Search'});
        dataSet.put('YAHOOPRSMP',new List<String>{'Yahoo','Paid Search'});
        dataSet.put('YAHOOPRSMPO',new List<String>{'Yahoo','Paid Search'});
        dataSet.put('YAHOOPRSRA',new List<String>{'Yahoo','Paid Search'});
        dataSet.put('PRE3900',new List<String>{'Press/Public Relations','Press'});
        dataSet.put('BEVTIMES',new List<String>{'Beverly Hills Times','Print'});
        dataSet.put('CULTUREMON',new List<String>{'Culture Monster - LA Times','Print'});
        dataSet.put('EMPLYGD',new List<String>{'Employment Guide','Print'});
        dataSet.put('INA4339',new List<String>{'Game Developer','Print'});
        dataSet.put('GIJOBSAG',new List<String>{'GI Jobs Annual Guide','Print'});
        dataSet.put('GIJOBSPRINT',new List<String>{'GI Jobs-Print','Print'});
        dataSet.put('LACANVAS',new List<String>{'LA Canvas','Print'});
        dataSet.put('NEW5911',new List<String>{'LA Weekly Ad','Print'});
        dataSet.put('MILADVEDU',new List<String>{'Military Advanced Education','Print'});
        dataSet.put('MILBASEPRINT',new List<String>{'Military Bases Print','Print'});
        dataSet.put('NTNLVETGD',new List<String>{'National Veterans Guide','Print'});
        dataSet.put('NCOA',new List<String>{'NCOA','Print'});
        dataSet.put('NEW5914',new List<String>{'OC Weekly Ad','Print'});
        dataSet.put('PENNYSAVER',new List<String>{'PENNYSAVER','Print'});
        dataSet.put('PWR106XMAS',new List<String>{'POWER106 Cali Christmas','Print'});
        dataSet.put('LAKERCLIPPY',new List<String>{'TSP Lakers','Print'});
        dataSet.put('TSPMAG',new List<String>{'TSP','Print'});
        dataSet.put('WRKINGWRLD',new List<String>{'WorkingWorld','Print'});
        dataSet.put('AMPRADIO',new List<String>{'AMP Radio 97.1FM','Radio'});
        dataSet.put('RAD7017',new List<String>{'Indie 103.1 Radio','Radio'});
        dataSet.put('RAD7018',new List<String>{'KCRW (NPR)','Radio'});
        dataSet.put('RAD7023',new List<String>{'KDAY 93.5','Radio'});
        dataSet.put('KIIS',new List<String>{'KIIS 102.7 Radio','Radio'});
        dataSet.put('INA4129',new List<String>{'KIISFM.com 102.7','Radio'});
        dataSet.put('KJLH',new List<String>{'KJLH - 102.3 FM','Radio'});
        dataSet.put('RAD7019',new List<String>{'KLSX 97.1','Radio'});
        dataSet.put('RAD7022',new List<String>{'KPWR Power 106','Radio'});
        dataSet.put('KROQ',new List<String>{'KROQ 106.7 Radio','Radio'});
        dataSet.put('KSPN',new List<String>{'KSPN - ESPN Radio','Radio'});
        dataSet.put('KSWD',new List<String>{'KSWD - The Sound','Radio'});
        dataSet.put('KXCM',new List<String>{'KXCM Radio','Radio'});
        dataSet.put('KXOL',new List<String>{'KXOL Radio','Radio'});
        dataSet.put('KYSR',new List<String>{'KYSR Radio','Radio'});
        dataSet.put('RAD7013',new List<String>{'Radio - General','Radio'});
        dataSet.put('STAR98.7',new List<String>{'STAR 98.7 FM','Radio'});
        dataSet.put('RAD7024',new List<String>{'Super Estrella 107.1','Radio'});
        dataSet.put('DWEST',new List<String>{'D West','Referral'});
        dataSet.put('DGA',new List<String>{'Directors Guild of America','Referral'});
        dataSet.put('HSO3000',new List<String>{'Education Referral','Referral'});
        dataSet.put('EDMG-OHAN',new List<String>{'Eight Delta Marktg','Referral'});
        dataSet.put('MAG5607A',new List<String>{'EQ Magazine','Referral'});
        dataSet.put('ARC9141',new List<String>{'Faculty Referral','Referral'});
        dataSet.put('REF8005',new List<String>{'Family Referral','Referral'});
        dataSet.put('REF8002',new List<String>{'Friend Referral','Referral'});
        dataSet.put('REF8010',new List<String>{'Full Sail Referral','Referral'});
        dataSet.put('REF8004',new List<String>{'General Referral','Referral'});
        dataSet.put('REF8000',new List<String>{'Graduate Referral','Referral'});
        dataSet.put('MAG5608A',new List<String>{'Guitar One','Referral'});
        dataSet.put('MAG5609A',new List<String>{'Guitar Player','Referral'});
        dataSet.put('MAG5610A',new List<String>{'Guitar World','Referral'});
        dataSet.put('REF8009',new List<String>{'La Film School Referral','Referral'});
        dataSet.put('REF8011',new List<String>{'LA Recording School Referral','Referral'});
        dataSet.put('MAG5613A',new List<String>{'Mix Magazine','Referral'});
        dataSet.put('COR1002',new List<String>{'Other College Referral','Referral'});
        dataSet.put('REF8001',new List<String>{'Professional Referral','Referral'});
        dataSet.put('MAG5616A',new List<String>{'Remix Magazine','Referral'});
        dataSet.put('RMCAD-EX',new List<String>{'RMCAD Lead Exchange','Referral'});
        dataSet.put('MAG5624A',new List<String>{'Scratch Magazine','Referral'});
        dataSet.put('REF8003',new List<String>{'Self Generated Lead','Referral'});
        dataSet.put('MAG5620A',new List<String>{'Spin','Referral'});
        dataSet.put('REF8007',new List<String>{'Staff Referral','Referral'});
        dataSet.put('REF8008',new List<String>{'Student Referral','Referral'});
        dataSet.put('OTH6013',new List<String>{'Sign On Building','Sign on Building'});
        dataSet.put('BRAIN',new List<String>{'Brain Blog','Social Media'});
        dataSet.put('FACEBOOKCA',new List<String>{'Facebook','Social Media'});
        dataSet.put('FACEBOOKDF',new List<String>{'Facebook','Social Media'});
        dataSet.put('FACEBOOKEB',new List<String>{'Facebook','Social Media'});
        dataSet.put('FACEBOOKEBO',new List<String>{'Facebook','Social Media'});
        dataSet.put('FACEBOOKFM',new List<String>{'Facebook','Social Media'});
        dataSet.put('FACEBOOKGP',new List<String>{'Facebook','Social Media'});
        dataSet.put('FACEBOOKMP',new List<String>{'Facebook','Social Media'});
        dataSet.put('FACEBOOKMPO',new List<String>{'Facebook','Social Media'});
        dataSet.put('FACEBOOKRA',new List<String>{'Facebook','Social Media'});
        dataSet.put('FBHIGHSCHOOL',new List<String>{'Facebook','Social Media'});
        dataSet.put('FBOH101814',new List<String>{'Facebook','Social Media'});
        dataSet.put('FBOH111514',new List<String>{'Facebook','Social Media'});
        dataSet.put('FBOMNIOCT14',new List<String>{'Facebook','Social Media'});
        dataSet.put('FBRADEC14',new List<String>{'Facebook','Social Media'});
        dataSet.put('FBRAOCT14',new List<String>{'Facebook','Social Media'});
        dataSet.put('FBREJECTS',new List<String>{'Facebook','Social Media'});
        dataSet.put('FACEBOOKORG',new List<String>{'Facebook','Social Media'});
        dataSet.put('INDIEGOGO',new List<String>{'Indie Go Go','Social Media'});
        dataSet.put('INSTAGRAM',new List<String>{'Instagram','Social Media'});
        dataSet.put('INSTGRMORG',new List<String>{'Instagram','Social Media'});
        dataSet.put('KEVINSMITH',new List<String>{'Kevin Smith Website','Social Media'});
        dataSet.put('LINKEDINCA',new List<String>{'Linkedin Ad','Social Media'});
        dataSet.put('LINKEDINORG',new List<String>{'Linkedin Ad','Social Media'});
        dataSet.put('LINKEDINRA',new List<String>{'Linkedin Ad','Social Media'});
        dataSet.put('MYSPACEORG',new List<String>{'Myspace','Social Media'});
        dataSet.put('PINTEREST',new List<String>{'Pinterest','Social Media'});
        dataSet.put('PINTERESTORG',new List<String>{'Pinterest','Social Media'});
        dataSet.put('TMBLRORG',new List<String>{'Tumblr','Social Media'});
        dataSet.put('TUMBLR',new List<String>{'Tumblr','Social Media'});
        dataSet.put('TWITTER2',new List<String>{'Twitter','Social Media'});
        dataSet.put('TWITTERDF',new List<String>{'Twitter','Social Media'});
        dataSet.put('TWITTEREBO',new List<String>{'Twitter','Social Media'});
        dataSet.put('TWITTER',new List<String>{'Twitter Ad','Social Media'});
        dataSet.put('TWITTERERS',new List<String>{'Twitter LAFS Website','Social Media'});
        dataSet.put('TWITTERORG',new List<String>{'Twitter Organic','Social Media'});
        dataSet.put('YELP',new List<String>{'Yelp Ad','Social Media'});
        dataSet.put('YOUTUBE',new List<String>{'YouTube','Social Media'});
        dataSet.put('BOIDYFILMS 1',new List<String>{'BoidyFilms-1','Televison'});
        dataSet.put('BOIDYFILMS 2',new List<String>{'BoidyFilms-2','Televison'});
        dataSet.put('KCALTV',new List<String>{'KCAL TV','Televison'});
        dataSet.put('KDOCTV',new List<String>{'KDOC TV','Televison'});
        dataSet.put('KTLATV',new List<String>{'KTLA TV','Televison'});
        dataSet.put('TCLTHEATRE',new List<String>{'TCL Theatre Ad','Televison'});
        dataSet.put('TEL7500',new List<String>{'TV - General','Televison'});
        dataSet.put('GOOGLEGRD',new List<String>{'Google - PRS','Paid Search'});
        dataSet.put('YAHOOGRD',new List<String>{'Yahoo','Paid Search'});
        dataSet.put('FACEBOOKGRD',new List<String>{'Facebook','Social Media'});
        dataSet.put('LINKEDINEB',new List<String>{'Linkedin Ad','Social Media'});
        dataSet.put('CHINAJOY',new List<String>{'China Joy Digital Ent. Expo & Conference','International Outreach'});
        dataSet.put('GAMESCOM',new List<String>{'GAMESCOM GERMANY','International Outreach'});
        dataSet.put('TOKYOGAME',new List<String>{'TOKYO GAME FAIR','International Outreach'});
        dataSet.put('PAXAUSTRALIA',new List<String>{'PAX AUSTRALIA','International Outreach'});
        dataSet.put('EXPOCANADA',new List<String>{'EXPO CANADA','International Outreach'});
        dataSet.put('180FUSIONLAR',new List<String>{'Google','Paid Search'});
        dataSet.put('FACEBOOK',new List<String>{'Facebook','Social Media'});
        dataSet.put('ARTOFRAPFEST',new List<String>{'Art of Rap Festival','Outreach'});
        dataSet.put('INC4332',new List<String>{'Degree Search Now','Internet College Directories'});
        dataSet.put('180FUSION',new List<String>{'Google','Paid Search'});
        dataSet.put('SUNSETDINE',new List<String>{'Sunset and Dine','Outreach'});
        dataSet.put('SALPOINTE',new List<String>{'SALPOINTE HIGH SCHOOL COLLEGE FAIR','Outreach'});
        dataSet.put('BALDWIN',new List<String>{'Baldwin Park College Fair','Outreach'});
        dataSet.put('TASTEOFSOUL',new List<String>{'Taste of Soul','Outreach'});
        dataSet.put('SAHIPHOP-KH',new List<String>{'Santa Ana Hip Hop','Outreach'});
        dataSet.put('180MUSIC',new List<String>{'Google','Paid Search'});
        dataSet.put('180MPONLINE',new List<String>{'Google','Paid Search'});
        dataSet.put('180GDONLINE',new List<String>{'Google','Paid Search'});
        dataSet.put('180RADISP',new List<String>{'Google','Internet Advertising'});
        dataSet.put('180MPDISP',new List<String>{'Google','Internet Advertising'});
        dataSet.put('180MPODISP',new List<String>{'Google','Internet Advertising'});
        dataSet.put('180EBDISP',new List<String>{'Google','Internet Advertising'});
        dataSet.put('180GDODISP',new List<String>{'Google','Internet Advertising'});
        dataSet.put('SCSMARSHA',new List<String>{'Southlands Christian Schools Fair','International Outreach'});
        dataSet.put('FAFSA',new List<String>{'Fafsa Referral','Referral'});
        dataSet.put('180EBINTL',new List<String>{'Google','Paid Search'});
        dataSet.put('180MPINTL',new List<String>{'Google','Paid Search'});
        dataSet.put('INC4031',new List<String>{'Lead Pulse Media','Internet College Directories'});
        dataSet.put('GGLOMNIDISP',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLFMDISP',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLEBODISP',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLDFDISP',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLCADISP',new List<String>{'Google','Internet Advertising'});
        dataSet.put('QSFILM',new List<String>{'Quin Street','Internet Advertising'});
        dataSet.put('QSMUSIC',new List<String>{'Quin Street','Internet Advertising'});
        dataSet.put('QSAUDIO',new List<String>{'Quin Street','Internet Advertising'});
        dataSet.put('QSEB',new List<String>{'Quin Street','Internet Advertising'});
        dataSet.put('QSANIM',new List<String>{'Quin Street','Internet Advertising'});
        dataSet.put('QSOFILM',new List<String>{'Quin Street','Internet Advertising'});
        dataSet.put('QSOGRAPHIC',new List<String>{'Quin Street','Internet Advertising'});
        dataSet.put('QSOMUSIC',new List<String>{'Quin Street','Internet Advertising'});
        dataSet.put('QSOEB',new List<String>{'Quin Street','Internet Advertising'});
        dataSet.put('INC4331',new List<String>{'Banner Edge','Internet College Directories'});
        dataSet.put('INC4331WCT',new List<String>{'Banner Edge','Internet College Directories'});
        dataSet.put('INC4219',new List<String>{'HigherEdGrowth','Internet College Directories'});
        dataSet.put('QSOMNI',new List<String>{'Quin Street','Internet Advertising'});
        dataSet.put('180EBCDISP',new List<String>{'Google','Internet Advertising'});
        dataSet.put('INDIA16',new List<String>{'India Tour 2016','International Outreach'});
        dataSet.put('FPP',new List<String>{'FPP Student Fair','International Outreach'});
        dataSet.put('USTUDY',new List<String>{'UStudy ','International Outreach'});
        dataSet.put('COLBNDLEAD',new List<String>{'College Bound Selection Service','College Outreach'});
        dataSet.put('INC4032',new List<String>{'Niche','Internet College Directories'});
        dataSet.put('ELAC',new List<String>{'East Los Angeles College','College Outreach'});
        dataSet.put('AMPLIFY',new List<String>{'AMPLIFY','Outreach'});
        dataSet.put('FBVIDEB',new List<String>{'Facebook','Social Media'});
        dataSet.put('FBVIDMP',new List<String>{'Facebook','Social Media'});
        dataSet.put('FBVIDRA',new List<String>{'Facebook','Social Media'});
        dataSet.put('FBVIDFM',new List<String>{'Facebook','Social Media'});
        dataSet.put('FBVIDGRD',new List<String>{'Facebook','Social Media'});
        dataSet.put('FBVIDMPO',new List<String>{'Facebook','Social Media'});
        dataSet.put('FBVIDEBO',new List<String>{'Facebook','Social Media'});
        dataSet.put('FBVIDDF',new List<String>{'Facebook','Social Media'});
        dataSet.put('UKTOUR',new List<String>{'UK Tour','International Outreach'});
        dataSet.put('INC4211',new List<String>{'MyMajors.com','Internet College Directories'});
        dataSet.put('FBVIDLAFS',new List<String>{'Facebook','Social Media'});
        dataSet.put('FBVIDLARS',new List<String>{'Facebook','Social Media'});
        dataSet.put('FBVIDCA',new List<String>{'Facebook','Social Media'});
        dataSet.put('INSTAANI',new List<String>{'Instagram','Social Media'});
        dataSet.put('INSTADFO',new List<String>{'Instagram','Social Media'});
        dataSet.put('INSTAEB',new List<String>{'Instagram','Social Media'});
        dataSet.put('INSTAEBO',new List<String>{'Instagram','Social Media'});
        dataSet.put('INSTAFM',new List<String>{'Instagram','Social Media'});
        dataSet.put('INSTAGDO',new List<String>{'Instagram','Social Media'});
        dataSet.put('INSTALAFS',new List<String>{'Instagram','Social Media'});
        dataSet.put('INSTAMP',new List<String>{'Instagram','Social Media'});
        dataSet.put('INSTAMPO',new List<String>{'Instagram','Social Media'});
        dataSet.put('INSTARA',new List<String>{'Instagram','Social Media'});
        dataSet.put('INSTALARS',new List<String>{'Instagram','Social Media'});
        dataSet.put('FPPBOGOTA',new List<String>{'FPP Bogota','International Outreach'});
        dataSet.put('INC4031CV',new List<String>{'Lead Pulse Media','Internet College Directories'});
        dataSet.put('VAPAFAIR',new List<String>{'VAPA College Fair','College Outreach'});
        dataSet.put('FPPCHILE',new List<String>{'FPPCHILE','International Outreach'});
        dataSet.put('FPPECUADOR',new List<String>{'FPPEcuador','International Outreach'});
        dataSet.put('FPPPERU',new List<String>{'FPPPeru','International Outreach'});
        dataSet.put('NACAC-GO-AN',new List<String>{'NACAC Greater LA ','High School Outreach'});
        dataSet.put('USCANEXPO',new List<String>{'US College Expo-Canada','International Outreach'});
        dataSet.put('INC4330CV',new List<String>{'Ronin Revenue','Internet College Directories'});
        dataSet.put('LAFSWEBAPP',new List<String>{'lafilm.edu','LAFS Website'});
        dataSet.put('LARSWEBAPP',new List<String>{'LARecordingSchool.com Web','LARS Website'});
        dataSet.put('INC4033',new List<String>{'Cloud Control Edu','Internet College Directories'});
        dataSet.put('MYMAJORS',new List<String>{'MyMajors.com','College Outreach'});
        dataSet.put('MYMAJORSLEAD',new List<String>{'MyMajors.com','College Outreach'});
        dataSet.put('FACEBOOKOH',new List<String>{'Facebook','Social Media'});
        dataSet.put('INSTAGRAMOH',new List<String>{'Instagram','Social Media'});
        dataSet.put('KSCARY',new List<String>{'Knott\'s Scary Farm','Televison'});
        dataSet.put('INC4036',new List<String>{'Higher Level Edu','Internet College Directories'});
        dataSet.put('CURSE',new List<String>{'Curse Media','Internet Advertising'});
        dataSet.put('INC4339',new List<String>{'Zeta Interactive','Internet College Directories'});
        dataSet.put('YAHOOCADISP',new List<String>{'Yahoo','Internet Advertising'});
        dataSet.put('YAHOODFDISP',new List<String>{'Yahoo','Internet Advertising'});
        dataSet.put('YAHOOEBDISP',new List<String>{'Yahoo','Internet Advertising'});
        dataSet.put('YAHOOEBODISP',new List<String>{'Yahoo','Internet Advertising'});
        dataSet.put('YAHOOFMDISP',new List<String>{'Yahoo','Internet Advertising'});
        dataSet.put('YAHOOGRDDISP',new List<String>{'Yahoo','Internet Advertising'});
        dataSet.put('YAHOODISP',new List<String>{'Yahoo','Internet Advertising'});
        dataSet.put('YAHOOMPDISP',new List<String>{'Yahoo','Internet Advertising'});
        dataSet.put('YAHOOMPODISP',new List<String>{'Yahoo','Internet Advertising'});
        dataSet.put('YAHOORADISP',new List<String>{'Yahoo','Internet Advertising'});
        dataSet.put('BINGCA',new List<String>{'Bing','Paid Search'});
        dataSet.put('BINGDF',new List<String>{'Bing','Paid Search'});
        dataSet.put('BINGEB',new List<String>{'Bing','Paid Search'});
        dataSet.put('BINGEBO',new List<String>{'Bing','Paid Search'});
        dataSet.put('BINGFM',new List<String>{'Bing','Paid Search'});
        dataSet.put('BINGGRD',new List<String>{'Bing','Paid Search'});
        dataSet.put('BING',new List<String>{'Bing','Paid Search'});
        dataSet.put('BINGMP',new List<String>{'Bing','Paid Search'});
        dataSet.put('BINGMPO',new List<String>{'Bing','Paid Search'});
        dataSet.put('BINGRA',new List<String>{'Bing','Paid Search'});
        dataSet.put('BINGCADISP',new List<String>{'Bing','Internet Advertising'});
        dataSet.put('BINGDFDISP',new List<String>{'Bing','Internet Advertising'});
        dataSet.put('BINGEBDISP',new List<String>{'Bing','Internet Advertising'});
        dataSet.put('BINGEBODISP',new List<String>{'Bing','Internet Advertising'});
        dataSet.put('BINGFMDISP',new List<String>{'Bing','Internet Advertising'});
        dataSet.put('BINGGRDDISP',new List<String>{'Bing','Internet Advertising'});
        dataSet.put('BINGDISP',new List<String>{'Bing','Internet Advertising'});
        dataSet.put('BINGMPDISP',new List<String>{'Bing','Internet Advertising'});
        dataSet.put('BINGMPODISP',new List<String>{'Bing','Internet Advertising'});
        dataSet.put('BINGRADISP',new List<String>{'Bing','Internet Advertising'});
        dataSet.put('GGLVIDFILM',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLVIDRA',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLVIDMP',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLVIDANI',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLVIDEB',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLVIDGDO',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLVIDDFO',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLVIDMPO',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLVIDEBO',new List<String>{'Google','Internet Advertising'});
        dataSet.put('BINGTOUR',new List<String>{'Google','Internet Advertising'});
        dataSet.put('TIMEOUTMAG',new List<String>{'Time Out','Print'});
        dataSet.put('TIMEOUTDISP',new List<String>{'Time Out','Internet Advertising'});
        dataSet.put('GGLTEXT',new List<String>{'Google','Paid Search'});
        dataSet.put('PASCF',new List<String>{'Pasadena College Fair','Outreach'});
        dataSet.put('TIMEWARNERTV',new List<String>{'Time Warner TV','Television'});
        dataSet.put('GGLCOMPGDO',new List<String>{'Google','Paid Search'});
        dataSet.put('GGLCOMPMPO',new List<String>{'Google','Paid Search'});
        dataSet.put('GGLCALL',new List<String>{'Google','Paid Search'});
        dataSet.put('GGLCOMP',new List<String>{'Google','Paid Search'});
        dataSet.put('GGLCOMPFM',new List<String>{'Google','Paid Search'});
        dataSet.put('GGLCOMPMP',new List<String>{'Google','Paid Search'});
        dataSet.put('GGLCOMPRA',new List<String>{'Google','Paid Search'});
        dataSet.put('GGLCOMPANI',new List<String>{'Google','Paid Search'});
        dataSet.put('GGLCOMPEB',new List<String>{'Google','Paid Search'});
        dataSet.put('GGLTEST',new List<String>{'Google','Paid Search'});
        dataSet.put('AWFF',new List<String>{'Asian World Film Festival','Outreach'});
        dataSet.put('SLIVED',new List<String>{'Stories Lived','Internet Advertising'});
        dataSet.put('NCMDISP',new List<String>{'NCM','Internet Advertising'});
        dataSet.put('ADROLLGDO',new List<String>{'AdRoll','Internet Advertising'});
        dataSet.put('ADROLLMPO',new List<String>{'AdRoll','Internet Advertising'});
        dataSet.put('INC4035',new List<String>{'My Choice Degrees','Internet College Directories'});
        dataSet.put('HRDISP',new List<String>{'Hollywood Reporter','Internet Advertising'});
        dataSet.put('PANDORA',new List<String>{'Pandora.com','Internet Advertising'});
        dataSet.put('KSTONE',new List<String>{'Keystone','Internet College Directories'});
        dataSet.put('BDEX',new List<String>{'BDEX','Internet Advertising'});
        dataSet.put('INC4220WC',new List<String>{'Keypath','Internet College Directories'});
        dataSet.put('INC4330WC',new List<String>{'Ronin Revenue','Internet College Directories'});
        dataSet.put('INC4336WC',new List<String>{'Zeta Interactive','Internet College Directories'});
        dataSet.put('FIGHT',new List<String>{'The Fight','Print'});
        dataSet.put('NCMTHEATRE',new List<String>{'NCM','Television'});
        dataSet.put('APPREF',new List<String>{'Student Referral from Online Application','Referral'});
        dataSet.put('YOUTUBEORG',new List<String>{'YouTube','Social Media'});
        dataSet.put('BINGMILI',new List<String>{'Bing','Paid Search'});
        dataSet.put('UKEAS',new List<String>{'UKEAS Study World fair','International Outreach'});
        dataSet.put('FACEBOOKMILB',new List<String>{'Facebook','Social Media'});
        dataSet.put('FACEBOOKMILA',new List<String>{'Facebook','Social Media'});
        dataSet.put('FACEBOOKINTL',new List<String>{'Facebook','Social Media'});
        dataSet.put('RALLYPOINT',new List<String>{'RallyPoint','Internet Advertising'});
        dataSet.put('LINKEDINEB',new List<String>{'Linked In','Social Media'});
        dataSet.put('LINKEDINEBO',new List<String>{'Linked In','Social Media'});
        dataSet.put('INC4330RR',new List<String>{'Ronin Revenue','Internet College Directories'});
        dataSet.put('COLBNDSWEB',new List<String>{'College Bound Selection Service','College Outreach'});
        dataSet.put('AMOEBA',new List<String>{'Amoeba Music','Print'});
        dataSet.put('FACEBOOK2',new List<String>{'Facebook','Social Media'});
        dataSet.put('USEXPO2017',new List<String>{'US College Expo – Canada','International Outreach'});
        dataSet.put('LACHSA2017',new List<String>{'LA County HS for the Arts','High School Outreach'});
        dataSet.put('EMAIL0001',new List<String>{'Email Campaign','Direct Marketing'});
        dataSet.put('BMIVN17',new List<String>{'Vietnam Edu Fair','International Outreach'});
        dataSet.put('DUBAI17',new List<String>{'Dubai Edu Fair','International Outreach'});
        dataSet.put('SATREF',new List<String>{'SAT Referral','Referral'});
        dataSet.put('QUANTCASTAP',new List<String>{'Quantcast','Internet Advertising'});
        dataSet.put('CBSDIGITAL',new List<String>{'CBS','Internet Advertising'});
        dataSet.put('CILADIGITAL',new List<String>{'Chinese In LA','Internet Advertising'});
        dataSet.put('AGENT1',new List<String>{'Universal Placement Program','International Outreach'});
        dataSet.put('AGENT2',new List<String>{'American-Sino Educational Exchange Association','International Outreach'});
        dataSet.put('AGENT3',new List<String>{'Ustudy','International Outreach'});
        dataSet.put('AGENT4',new List<String>{'CHINELO CREATIVE','International Outreach'});
        dataSet.put('AGENT5',new List<String>{'UHAK Company','International Outreach'});
        dataSet.put('AGENT6',new List<String>{'AMS Bridge Blue','International Outreach'});
        dataSet.put('AGENT7',new List<String>{'We apply, INC','International Outreach'});
        dataSet.put('AGENT8',new List<String>{'Hollywood College','International Outreach'});
        dataSet.put('AGENT9',new List<String>{'New USA Group','International Outreach'});
        dataSet.put('AGENT10',new List<String>{'Imperial School & Study Centre','International Outreach'});
        dataSet.put('AGENT11',new List<String>{'HY Internaitonal Consulting','International Outreach'});
        dataSet.put('AGENT12',new List<String>{'Career Mosaic','International Outreach'});
        dataSet.put('AGENT13',new List<String>{'Kanan International','International Outreach'});
        dataSet.put('AGENT14',new List<String>{'Global Reach','International Outreach'});
        dataSet.put('AGENT15',new List<String>{'Global Opportunities','International Outreach'});
        dataSet.put('AGENT16',new List<String>{'EEC - Enbee Educaiton Centre','International Outreach'});
        dataSet.put('AGENT17',new List<String>{'Nawart Link EnterpriseCo','International Outreach'});
        dataSet.put('AGENT18',new List<String>{'Blue Consultants Group','International Outreach'});
        dataSet.put('AGENT19',new List<String>{'WhoileRen Education','International Outreach'});
        dataSet.put('AGENT20',new List<String>{'Global Gate Study Abroad','International Outreach'});
        dataSet.put('AGENT21',new List<String>{'Alfa Beta Institute','International Outreach'});
        dataSet.put('AGENT',new List<String>{'Agent Referral','International Outreach'});
        dataSet.put('AGENT22',new List<String>{'Last Resort Corporation','International Outreach'});
        dataSet.put('AGENT23',new List<String>{'Global Tree Careers','International Outreach'});
        dataSet.put('AGENT24',new List<String>{'GoStudy Education Institute','International Outreach'});
        dataSet.put('FSLXINTL',new List<String>{'Full Sail Lead Exchange','Full Sail Lead Exchange'});
        dataSet.put('INC4036WCT',new List<String>{'Higher Level Edu','Internet College Directories'});
        dataSet.put('INC4340',new List<String>{'Degree Search Now','Internet College Directories'});
        dataSet.put('INC4340WCT',new List<String>{'Degree Search Now','Internet College Directories'});
        dataSet.put('INC4340C2C',new List<String>{'Degree Search Now','Internet College Directories'});
        dataSet.put('INC4340CPC',new List<String>{'Degree Search Now','Internet College Directories'});
        dataSet.put('AGENT25',new List<String>{'Bear Education Consultant Group','International Outreach'});
        dataSet.put('LAWKLYCALL',new List<String>{'LA Weekly','Print'});
        dataSet.put('FBCALL',new List<String>{'Facebook','Social Media'});
        dataSet.put('BINGCALL',new List<String>{'Bing','Paid Search'});
        dataSet.put('PANDORACALL',new List<String>{'Pandora','Internet Advertising'});
        dataSet.put('AMPCALL',new List<String>{'97.1FM','Radio'});
        dataSet.put('PWRCALL',new List<String>{'Power106','Radio'});
        dataSet.put('KROQCALL',new List<String>{'KROQ','Radio'});
        dataSet.put('NPC',new List<String>{'Net Price Calculator','Referral'});
        dataSet.put('INC4345',new List<String>{'Generation Z','Internet College Directories'});
        dataSet.put('FACEBOOKAO',new List<String>{'Facebook','Social Media'});
        dataSet.put('INSTAAO',new List<String>{'Facebook','Social Media'});
        dataSet.put('GOOGLEAO',new List<String>{'Google','Paid Search'});
        dataSet.put('BINGAO',new List<String>{'Bing','Paid Search'});
        dataSet.put('ADROLLAO',new List<String>{'Adroll','Internet Advertising'});
        dataSet.put('GGLVIDAO',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLAODISP',new List<String>{'Google','Internet Advertising'});
        dataSet.put('FBKREM',new List<String>{'Facebook','Social Media'});
        dataSet.put('INSTAREM',new List<String>{'Instagram','Social Media'});
        dataSet.put('FBKREMOL',new List<String>{'Facebook','Social Media'});
        dataSet.put('INSTAREMOL',new List<String>{'Instagram','Social Media'});
        dataSet.put('TOGREF',new List<String>{'TOG Referral','Referral'});
        dataSet.put('INC4340CV',new List<String>{'Degree Search Now','Internet College Directories'});
        dataSet.put('INC4350',new List<String>{'Animation Career Review','Internet College Directories'});
        dataSet.put('GLEN-AN-GO',new List<String>{'Glendale High School','High School Outreach'});
        dataSet.put('THEWRAP',new List<String>{'The Wrap','Print'}); 
        dataSet.put('GGLAPPRET',new List<String>{'Google','Internet Advertising'}); 
        dataSet.put('GGLAPPRETOL',new List<String>{'Google','Internet Advertising'});
        dataSet.put('OUTREACHHS',new List<String>{'Outreach Event','High School Outreach'});    
        dataSet.put('OUTREACHCOL',new List<String>{'Outreach Event','College Outreach'});        
        dataSet.put('INC4360',new List<String>{'Weboganic','Internet College Directories'});
        dataSet.put('ARTINSTITUTE',new List<String>{'Art Institute Referral','Referral'}); 
        dataSet.put('SPOTIFY',new List<String>{'Spotify','Streaming'});
        dataSet.put('FACEBOOKCT',new List<String>{'Facebook','Social Media'});
        dataSet.put('EDMODO',new List<String>{'Edmodo','Internet Advertising'});  
        dataSet.put('YOUTUBECT',new List<String>{'YouTube','Internet Advertising'});    
        dataSet.put('INC4330T1',new List<String>{'Ronin Revenue','Internet College Directories'});  
        dataSet.put('INC4370EX',new List<String>{'Belmont Media','Internet College Directories'}); 
        dataSet.put('INC4370SH',new List<String>{'Belmont Media','Internet College Directories'}); 
        dataSet.put('GOVFAIR',new List<String>{'Governor’s Fair','Outreach'});
        dataSet.put('CENTFLFAIR',new List<String>{'Central Florida Fair','Outreach'});
        dataSet.put('MTSIERRA',new List<String>{'Mt. Sierra Referral','Referral'});
        dataSet.put('GGLADISC',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLFMDISC',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLMPDISC',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLAPDISC',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLEBDISC',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLDFODISC',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLMPODISC',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLEBODISC',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLGDODISC',new List<String>{'Google','Internet Advertising'});
        dataSet.put('GGLAODISC',new List<String>{'Google','Internet Advertising'});
        return dataset;
    }
    
    //Sets the value of LeadSoruce and Lead Catagory used by ContactUdpateCodesTrigger
    public static void setLeadSourceCode(Contact con) 
    {
        ContactUtilities.getDataSet();
        
        if(dataSet.containsKey(con.Lead_Source_Code__c))
        {
            
            List<String> data = ContactUtilities.getDataSet(con.Lead_Source_Code__c);
            con.lead_source__C =data[0];
            con.LeadSource = data[1];
            
            if(con.Lead_Source_1__c==NULL || con.Lead_Category_1__c==NULL){
                con.Lead_Source_Code_1__c = con.Lead_Source_Code__c;
                con.Lead_Source_1__c = data[0];
                con.Lead_Category_1__c = data[1];
            }
        }
    }
    public static void setPreviousEducationCodes(Contact con)
    {
        if(con.Previous_Education_Codes__c == 'AA/AS') {con.Previous_Education__c ='Associates Degree completed' ;}  
        else if(con.Previous_Education_Codes__c == 'COL') {con.Previous_Education__c ='Attending College' ;} 
        else if(con.Previous_Education_Codes__c == 'BA/BS') {con.Previous_Education__c ='Bachelors degree completed' ;} 
        else if(con.Previous_Education_Codes__c == 'GED') {con.Previous_Education__c ='High School - GED' ;} 
        else if(con.Previous_Education_Codes__c == 'HS') {con.Previous_Education__c ='High School Diploma' ;} 
        else if(con.Previous_Education_Codes__c == 'INHS') {con.Previous_Education__c ='High School Student' ;} 
        else if(con.Previous_Education_Codes__c == 'MS') {con.Previous_Education__c ='Masters Degree Completed' ;}  
    }
    public static void setAffliationCodes(Contact con){
        //Sets the value of Afflication used by ContactUdpateCodesTrigger
        if(con.Affiliation_Code__c == 'ACT') {con.Affiliation__c ='Active Duty'; con.Military_Branch__c = 'Military'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'ADAF') {con.Affiliation__c ='Active Duty - Air Force'; con.Military_Branch__c = 'Air Force'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'ADAR') {con.Affiliation__c ='Active Duty - Army'; con.Military_Branch__c = 'Army'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'ADCG') {con.Affiliation__c ='Active Duty - Coast Guard'; con.Military_Branch__c = 'Coast Guard'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'ADMC') {con.Affiliation__c ='Active Duty - Marine Corps'; con.Military_Branch__c = 'Marine Corps'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'ADNV') {con.Affiliation__c ='Active Duty - Navy'; con.Military_Branch__c = 'Navy'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'BLKROC') {con.Affiliation__c ='BLACK ROCK - COLLEGE ADVANTAGE'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'Domestic';}
        else if(con.Affiliation_Code__c == 'FLPCP') {con.Affiliation__c ='FLORIDA PREPAID COLLEGE PROGRAM'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'Domestic';}
        else if(con.Affiliation_Code__c == 'GCIP') {con.Affiliation__c ='GIFT COLLEGE INVESTING PLAN'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'Domestic';}
        else if(con.Affiliation_Code__c == 'HEA') {con.Affiliation__c ='HIGHER EDUCATION ACCOUNT'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'Domestic';}
        else if(con.Affiliation_Code__c == 'HIGHSCH') {con.Affiliation__c ='High School'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'Domestic';}
        else if(con.Affiliation_Code__c == 'HS') {con.Affiliation__c ='Actively attending HS or pursuing GED'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'Domestic';}
        else if(con.Affiliation_Code__c == 'INT\'L') {con.Affiliation__c ='Needs docs to attend ground campus'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'International';}
        else if(con.Affiliation_Code__c == 'INTBRZL') {con.Affiliation__c ='International - Brazil'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'International';}
        else if(con.Affiliation_Code__c == 'INTCHINA') {con.Affiliation__c ='International - China'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'International';}
        else if(con.Affiliation_Code__c == 'INTL') {con.Affiliation__c ='Non-US Citizen'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'International';}
        else if(con.Affiliation_Code__c == 'INTL1') {con.Affiliation__c ='Non-US citizen with student VISA'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'International';}
        else if(con.Affiliation_Code__c == 'INTL2') {con.Affiliation__c ='Non-US citizen without student VISA'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'International';}
        else if(con.Affiliation_Code__c == 'INTLESL') {con.Affiliation__c ='International - ESL'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'International';}
        else if(con.Affiliation_Code__c == 'INTLMEX') {con.Affiliation__c ='International - Mexico'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'International';}
        else if(con.Affiliation_Code__c == 'JPL') {con.Affiliation__c ='Jet Propultion Laboratory'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'Domestic';}
        else if(con.Affiliation_Code__c == 'MDAF') {con.Affiliation__c ='Mil Dep using Benefits - Air Force'; con.Military_Branch__c = 'Air Force'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'MDAR') {con.Affiliation__c ='Mil Dep using Benefits - Army'; con.Military_Branch__c = 'Army'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'MDCG') {con.Affiliation__c ='Mil Dep using Benefits - Coast Guard'; con.Military_Branch__c = 'Coast Guard'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'MDEP') {con.Affiliation__c ='Military Dependant using benefits'; con.Military_Branch__c = 'Military'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'MDMC') {con.Affiliation__c ='Mil Dep using Benefits - Marine Corps'; con.Military_Branch__c = 'Marine Corps'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'MDNV') {con.Affiliation__c ='Mil Dep using Benefits - Navy'; con.Military_Branch__c = 'Navy'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'MESP') {con.Affiliation__c ='MICHIGAN EDUCATION SAVINGS PROGRAM'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'Domestic';}
        else if(con.Affiliation_Code__c == 'NON') {con.Affiliation__c ='No Military Affiliation'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'Domestic';}
        else if(con.Affiliation_Code__c == 'NONELIG') {con.Affiliation__c ='Not Eligible for Military Benefits'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'Domestic';}
        else if(con.Affiliation_Code__c == 'NPCP') {con.Affiliation__c ='NEVADA PREPAID COLLEGE PLAN'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'Domestic';}
        else if(con.Affiliation_Code__c == 'ONLINE') {con.Affiliation__c ='Online Req., unable to attend campus'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'Domestic';}
        else if(con.Affiliation_Code__c == 'PERMRES') {con.Affiliation__c ='Permanent Resident'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'Domestic';}
        else if(con.Affiliation_Code__c == 'RESR') {con.Affiliation__c ='Reservist/National Guard'; con.Military_Branch__c = 'Military'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'RVNGAF') {con.Affiliation__c ='Reservist/National Guard - Air Force'; con.Military_Branch__c = 'Air Force'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'RVNGAR') {con.Affiliation__c ='Reservist/National Guard - Army'; con.Military_Branch__c = 'Army'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'RVNGCG') {con.Affiliation__c ='Reservist/National Guard - Coast Guard'; con.Military_Branch__c = 'Coast Guard'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'RVNGMC') {con.Affiliation__c ='Reservist/National Guard - Marine Corps'; con.Military_Branch__c = 'Marine Corps'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'RVNGNV') {con.Affiliation__c ='Reservist/National Guard - Navy'; con.Military_Branch__c = 'Navy'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'SSCSP') {con.Affiliation__c ='ScholarShare College Savings Plan'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'Domestic';}
        else if(con.Affiliation_Code__c == 'VET') {con.Affiliation__c ='Veteran'; con.Military_Branch__c = 'Military'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'VETAF') {con.Affiliation__c ='Veteran - Air Force'; con.Military_Branch__c = 'Air Force'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'VETAR') {con.Affiliation__c ='Veteran - Army'; con.Military_Branch__c = 'Army'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'VETCG') {con.Affiliation__c ='Veteran - Coast Guard'; con.Military_Branch__c = 'Coast Guard'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'VETMC') {con.Affiliation__c ='Veteran - Marine Corps'; con.Military_Branch__c = 'Marine Corps'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'VETNU') {con.Affiliation__c ='Veteran - Not using benefits'; con.Military_Branch__c = 'Military'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'VETNV') {con.Affiliation__c ='Veteran - Navy'; con.Military_Branch__c = 'Navy'; con.Dom_Mil_Int_l__c = 'Military';}
        else if(con.Affiliation_Code__c == 'VOCREHAB') {con.Affiliation__c ='VOCATIONAL REHABILITATION'; con.Military_Branch__c = 'None'; con.Dom_Mil_Int_l__c = 'Domestic';}

        
    }
    public static void setGenderCodes(Contact con)
        //Sets the value of Gender used by ContactUdpateCodesTrigger
    {
        if(con.gender__c == 'Male') {con.Gender_Code__c ='M' ;} 
        else if(con.gender__c == 'Female') {con.Gender_Code__c ='F' ;} 
        else if(con.gender__c == 'Not specified') {con.Gender_Code__c ='U' ;} 
    }
    public static void setRaceCodes(Contact con)
        //Sets the value of Race used by ContactUdpateCodesTrigger
    {
        if(con.Race__c == 'Black or African American') {con.Race_Code__c ='AA' ;}
        else if(con.Race__c == 'American Indian or Alaska Native') {con.Race_Code__c ='AI' ;} 
        else if(con.Race__c == 'Asian') {con.Race_Code__c ='AP' ;} 
        else if(con.Race__c == 'Hispanic') {con.Race_Code__c='H' ;} 
        else if(con.Race__c == 'Two or more races') {con.Race_Code__c ='M' ;} 
        else if(con.Race__c == 'Nonresident Alien') {con.Race_Code__c ='NA' ;} 
        else if(con.Race__c == 'Other') {con.Race_Code__c='O' ;} 
        else if(con.Race__c == 'Race and Ethnicity Unknown') {con.Race_Code__c ='RU' ;} 
        else if(con.Race__c == 'Not Specified') {con.Race_Code__c ='U' ;} 
        else if(con.Race__c == 'White') {con.Race_Code__c='W' ;} 
    }
    public static void setMaritalCodes(Contact con)
        //Sets the value of Marital Code used by ContactUdpateCodesTrigger
    {
        if(con.Marital_Status__c == 'Divorced') {con.Marital_Code__c ='D' ;} 
        else if(con.Marital_Status__c == 'Married') {con.Marital_Code__c ='M' ;} 
        else if(con.Marital_Status__c == 'Separated') {con.Marital_Code__c ='P' ;} 
        else if(con.Marital_Status__c == 'Single') {con.Marital_Code__c='S' ;} 
        else if(con.Marital_Status__c == 'Not specified') {con.Marital_Code__c ='U' ;} 
        else if(con.Marital_Status__c == 'Widowed') {con.Marital_Code__c ='W' ;}
    }
    public static void setCitizenshipCodes(Contact con)
           //Sets the value of Citizenship Code used by ContactUdpateCodesTrigger
    {
        if(con.Citizenship_Status__c == 'Non-citizen') {con.Citizenship_Code__C ='ELNON' ;} 
        else if(con.Citizenship_Status__c == 'Eligible Non-citizen') {con.Citizenship_Code__C ='N' ;} 
        else if(con.Citizenship_Status__c == 'Not specified') {con.Citizenship_Code__C ='U' ;} 
        else if(con.Citizenship_Status__c == 'Unknown') {con.Citizenship_Code__C ='UNKOWN' ;} 
        else if(con.Citizenship_Status__c == 'US Citizen') {con.Citizenship_Code__C ='US' ;}
    }
    public static void setNationalityCodes(Contact con)
        //Sets the value of Nationality Code used by ContactUdpateCodesTrigger
    {
        if(con.Nationality__c == 'Afghan') {con.Nationality_Code__c ='AFG' ;} 
        else if(con.Nationality__c == 'African') {con.Nationality_Code__c ='AFRICAN' ;} 
        else if(con.Nationality__c == 'Albanian') {con.Nationality_Code__c ='ALB' ;} 
        else if(con.Nationality__c == 'American') {con.Nationality_Code__c ='AMER' ;} 
        else if(con.Nationality__c == 'Argentine') {con.Nationality_Code__c ='ARGENT' ;} 
        else if(con.Nationality__c == 'Australian') {con.Nationality_Code__c ='AUS' ;} 
        else if(con.Nationality__c == 'Austrian') {con.Nationality_Code__c ='AUSTRIA' ;} 
        else if(con.Nationality__c == 'Bahamian') {con.Nationality_Code__c ='BAH' ;} 
        else if(con.Nationality__c == 'none') {con.Nationality_Code__c ='BLK' ;} 
        else if(con.Nationality__c == 'Brazilian') {con.Nationality_Code__c ='BRAZIL' ;} 
        else if(con.Nationality__c == 'Briton British') {con.Nationality_Code__c ='BRI' ;} 
        else if(con.Nationality__c == 'Bulgarian') {con.Nationality_Code__c ='BULGARIA' ;} 
        else if(con.Nationality__c == 'Canadian') {con.Nationality_Code__c ='CAN' ;} 
        else if(con.Nationality__c == 'Chilean') {con.Nationality_Code__c ='CHILE' ;} 
        else if(con.Nationality__c == 'Chinese') {con.Nationality_Code__c ='CHINA' ;} 
        else if(con.Nationality__c == 'Colombian') {con.Nationality_Code__c ='CLB' ;} 
        else if(con.Nationality__c == 'Dominican') {con.Nationality_Code__c ='DOM' ;} 
        else if(con.Nationality__c == 'Egyptian') {con.Nationality_Code__c ='EGYPT' ;} 
        else if(con.Nationality__c == 'Salvadoran') {con.Nationality_Code__c ='ELSAL' ;} 
        else if(con.Nationality__c == 'Filipino') {con.Nationality_Code__c ='FIL' ;} 
        else if(con.Nationality__c == 'French') {con.Nationality_Code__c ='FRANCE' ;} 
        else if(con.Nationality__c == 'German') {con.Nationality_Code__c ='GERMAN' ;} 
        else if(con.Nationality__c == 'Hungarian') {con.Nationality_Code__c ='HUN' ;} 
        else if(con.Nationality__c == 'icelandic') {con.Nationality_Code__c ='ICE' ;} 
        else if(con.Nationality__c == 'Indian') {con.Nationality_Code__c ='IND' ;} 
        else if(con.Nationality__c == 'Indonesian') {con.Nationality_Code__c ='INDO' ;} 
        else if(con.Nationality__c == 'Iranian') {con.Nationality_Code__c ='IRAN' ;} 
        else if(con.Nationality__c == 'Israeli') {con.Nationality_Code__c ='ISRAEL' ;} 
        else if(con.Nationality__c == 'Italian') {con.Nationality_Code__c ='ITALY' ;} 
        else if(con.Nationality__c == 'Jamaican') {con.Nationality_Code__c ='JAMAICA' ;} 
        else if(con.Nationality__c == 'Korean') {con.Nationality_Code__c ='KOREA' ;} 
        else if(con.Nationality__c == 'Japanese') {con.Nationality_Code__c ='JAPAN' ;} 
        else if(con.Nationality__c == 'Jordanian') {con.Nationality_Code__c ='JOR' ;} 
        else if(con.Nationality__c == 'Kenyan') {con.Nationality_Code__c ='KENYA' ;} 
        else if(con.Nationality__c == 'Lao or Laotian') {con.Nationality_Code__c ='LAO' ;} 
        else if(con.Nationality__c == 'Lebanese') {con.Nationality_Code__c ='LEBANON' ;} 
        else if(con.Nationality__c == 'Liberian') {con.Nationality_Code__c ='LIB' ;} 
        else if(con.Nationality__c == 'Malaysian') {con.Nationality_Code__c ='MAL' ;} 
        else if(con.Nationality__c == 'Mexican') {con.Nationality_Code__c ='MEX' ;} 
        else if(con.Nationality__c == 'NA') {con.Nationality_Code__c ='NA' ;} 
        else if(con.Nationality__c == 'Nigerian') {con.Nationality_Code__c ='NIGERIA' ;} 
        else if(con.Nationality__c == 'Pakistani') {con.Nationality_Code__c ='PAK' ;} 
        else if(con.Nationality__c == 'Peruvian') {con.Nationality_Code__c ='PERU' ;} 
        else if(con.Nationality__c == 'Phillippino') {con.Nationality_Code__c ='PHILLIPP' ;} 
        else if(con.Nationality__c == 'Portuguese') {con.Nationality_Code__c ='PORTUGAL' ;} 
        else if(con.Nationality__c == 'Puerto Rican') {con.Nationality_Code__c ='PR' ;} 
        else if(con.Nationality__c == 'Romanian') {con.Nationality_Code__c ='ROMANIA' ;} 
        else if(con.Nationality__c == 'Russian') {con.Nationality_Code__c ='RUSSIA' ;} 
        else if(con.Nationality__c == 'Saudi Arabian') {con.Nationality_Code__c ='SAUDI' ;} 
        else if(con.Nationality__c == 'South African') {con.Nationality_Code__c ='SOUTHAF' ;} 
        else if(con.Nationality__c == 'Georgian') {con.Nationality_Code__c ='SOVIETG' ;} 
        else if(con.Nationality__c == 'Spanish') {con.Nationality_Code__c ='SPAIN' ;} 
        else if(con.Nationality__c == 'Spaniard') {con.Nationality_Code__c ='SPN' ;} 
        else if(con.Nationality__c == 'Swedish') {con.Nationality_Code__c ='SWEDEN' ;} 
        else if(con.Nationality__c == 'Swiss') {con.Nationality_Code__c ='SWTZ' ;} 
        else if(con.Nationality__c == 'Trinidadian') {con.Nationality_Code__c ='TRI' ;} 
        else if(con.Nationality__c == 'Tunisian') {con.Nationality_Code__c ='TUNISIA' ;} 
        else if(con.Nationality__c == 'Turkish') {con.Nationality_Code__c ='TURKEY' ;} 
        else if(con.Nationality__c == 'Not Specified') {con.Nationality_Code__c ='U' ;} 
        else if(con.Nationality__c == 'Ukrainian') {con.Nationality_Code__c ='UKRANE' ;} 
        else if(con.Nationality__c == 'Uruguayan') {con.Nationality_Code__c ='URUGUAY' ;} 
        else if(con.Nationality__c == 'Venezuelan') {con.Nationality_Code__c ='VENEZ' ;} 
    }
        public static void setSchoolStatusCodes(Contact con)
        //Sets the value of Gender used by ContactUdpateCodesTrigger
    {
        if(con.School_status__c == 'Attempted') {con.School_Status_Code__c ='ATTMPT' ;} 
        else if(con.School_status__c == 'Connected') {con.School_Status_Code__c ='CONNECT' ;} 
        else if(con.School_status__c == 'Appointment Set') {con.School_Status_Code__c ='APPT' ;}
        else if(con.School_status__c == 'Interviewed') {con.School_Status_Code__c ='INT' ;} 
        else if(con.School_status__c == 'Application Submitted') {con.School_Status_Code__c ='APPSUB' ;} 
        else if(con.School_status__c == 'Do Not Contact') {con.School_Status_Code__c ='NOCONTAC' ;} 
        else if(con.School_status__c == 'Stop') {con.School_Status_Code__c ='STOP' ;} 
        else if(con.School_status__c == 'Enrolled') {con.School_Status_Code__c ='FUT' ;} 
        else if(con.School_status__c == 'Enrolled-RTA') {con.School_Status_Code__c ='FUT-OL' ;} 
        else if(con.School_status__c == 'Active') {con.School_Status_Code__c ='ATT' ;} 
        else if(con.School_status__c == 'Withdrawn') {con.School_Status_Code__c ='WITHDRAW' ;} 
        else if(con.School_status__c == 'Canceled Enrollment') {con.School_Status_Code__c ='CANCEL' ;} 
        else if(con.School_status__c == 'Dismissed') {con.School_Status_Code__c ='DISMISS' ;} 
        else if(con.School_status__c == 'Pending Graduate') {con.School_Status_Code__c ='PENDGRAD' ;} 
        else if(con.School_status__c == 'Graduate') {con.School_Status_Code__c ='GRAD' ;} 
        else if(con.School_status__c == 'Denied') {con.School_Status_Code__c ='APPDEN' ;} 
        else if(con.School_status__c == 'Leave of Absence') {con.School_Status_Code__c ='LOA' ;} 
        else if(con.School_status__c == 'New Lead') {con.School_Status_Code__c ='NEW' ;} 
        else if(con.School_status__c == 'Invalid') {con.School_Status_Code__c ='INVALID' ;} 
        else if(con.School_status__c == 'Bad Number') {con.School_Status_Code__c ='BADNUM' ;} 
        
        
            
        
    }
}