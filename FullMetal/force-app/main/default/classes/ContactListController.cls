public class ContactListController {

    //Variables
    public Map<String,String> Fields {get;set;}
    private List<contact> FilteredContacts;                      //Contains final result set
    public Query__c QueryDetail;
    public List<Query__c> QueryDetails;
    
    private boolean PagingModeOn;                               //Checks if user is switching pages or not.
    private Integer RecordsPerPage;                             //Records to show per page
    private Integer MaximumPages;                               //Maximum pages that can be displayed in a page
    
    //Get Set Properties
    public String AlphaFilter {get;set;}               //Current Alphabet selected
    public String SearchKeyword {get;set;}              //Search Keyword input by user
    public String SortBy1 {get;set;}                     //Sort Results provided by drop down 1
    public String SortBy2 {get;set;}                     //Sort Results provided by drop down 2
    public String SortBy3 {get;set;}                     //Sort Results provided by drop down 3
    public String SortBy4 {get;set;}                     //Sort Results provided by drop down 4
    public Integer NumberOfPages {get;set;}            //Total Number of pages required for the current result set
    public Integer CurrentPage {get;set;}              //Current Selected Page Index
    public Integer CurrentShowingFrom {get;set;}        //Current Showing Record 1st Index
    public Integer CurrentShowingTo {get;set;}          //Current Showing Record last Index
    public Integer ContactsSize {get;set;}              //Total number of records found for a query
    public String ContactsSizeString {get;set;}         //Total number of records found for a query
    public List<String> AlphaList {get;set;}            //Contains A - Z alphabets
    public List<Integer> NumericList {get;set;}          //Contains all pages numbers
    public string queriesText {get;set;}
     
    //Constructor
    public ContactListController() {
        
        //Initialization of values
        this.FilteredContacts = new list<contact>();
        this.AlphaList = new list<String> {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
        this.NumericList = new list<Integer>();
        this.AlphaFilter = 'A';
        this.SearchKeyword = '';
        this.PagingModeOn = false;
        this.SortBy1 = 'None';
        this.SortBy2 = 'None';
        this.SortBy3 = 'None';
        this.SortBy4 = 'None';
        this.NumberOfPages = 1;
        this.RecordsPerPage = 20;
        this.MaximumPages = 100;
        this.ContactsSize = 0;
        this.CurrentPage = 1;
        this.CurrentShowingFrom = 1;
        this.CurrentShowingTo = RecordsPerPage;
        this.queriesText = '';
        
        //Getting all fields of Contact Object
        Schema.DescribeSObjectResult a_desc = Contact.sObjectType.getDescribe();
        Map<String, Schema.SObjectField> a_fields = a_desc.fields.getMap();
                Fields = new Map<String,String>();
        Fields.put('None','None');
        for(Schema.sObjectField fld:a_fields.values()){ 
        String LabelName = fld.getDescribe().getLabel();
                if(LabelName != 'Mailing Address' && LabelName != 'Contact Description' && LabelName != 'Other Address' && LabelName != 'SSN' && LabelName != 'Referral Notes' && LabelName != 'Original Source Info' && LabelName != 'Pardot First Referrer' && LabelName != 'Pardot Comments' && LabelName != 'Pardot Notes' && LabelName != 'Duplicate Check Index')
                {
                Fields.put(string.valueof(fld.getDescribe().getLabel()),string.valueof(fld));
                }
                }
        
        LoadAllQueries();
        
        
    }
    
     //Get Properties
    public List<Contact> getContactsFiltered() {
        //Calling this method will get the latest data based on provided filter
        LoadFilteredContacts();
        return FilteredContacts;
    }
    
    //Methods (Actions)
    
    //Getting All Queries Ids and names
    public void LoadAllQueries(){
        QueryDetails = new List<Query__c>();
        QueryDetails = [Select id, name,
                                     FilterField1__c, FilterField1Operator__c, FilterField1Value__c,
                                                FilterField2__c, FilterField2Operator__c, FilterField2Value__c,
                                                FilterField3__c, FilterField3Operator__c, FilterField3Value__c,
                                                FilterField4__c, FilterField4Operator__c, FilterField4Value__c,
                                                FilterField5__c, FilterField5Operator__c, FilterField5Value__c,
                                                SortBy1__c, SortBy1Direction__c,
                                                SortBy2__c, SortBy2Direction__c,
                                                SortBy3__c, SortBy3Direction__c,
                                                                        all_or_my__c
                                    from Query__c order by sequence__c asc limit 100];
    } 
    
    //When Search button clicks
    public void SearchByKeyword()
    {
        //PagingModeOn = false;
        //CurrentPage = 1;
        //CurrentShowingFrom = 1;
        //CurrentShowingTo = RecordsPerPage;
    }
    
    public void ApplySorting()
    {
        //Not using this method right now
    }
    
    //When any alphabet clicks
    public void SearchByAlphabets()
    {
        //IsSearchByKeyword = false;
        //PagingModeOn = false;
        //CurrentPage = 1;
        //CurrentShowingFrom = 1;
        //CurrentShowingTo = RecordsPerPage;
        //SearchKeyword='';
    }
    
    //When any page number clicks
    public void SearchByPaging()
    {
        PagingModeOn = true;
    }
    
    //When Next button clicks
    public void NextPage()
    {
        this.PagingModeOn = true;
        CurrentPage = CurrentPage + 1;
        
         If(CurrentPage > NumberOfPages)
        {
            CurrentPage = NumberOfPages;
        }
    }
        
   //When Previous button clicks    
    public void PreviousPage()
    {
        PagingModeOn = true;
        CurrentPage = CurrentPage - 1;
        
        If(CurrentPage < 1)
        {
            CurrentPage = 1;
        }
    }
    
    //Calculates the Paging buttons count
    private void CalculatePages(){
        
        NumberOfPages = (ContactsSize / RecordsPerPage) + 1;
        
        if(NumberOfPages > MaximumPages){
            
           NumberOfPages = MaximumPages;   
        }
        
        NumericList = new list<Integer>();
        for(integer i = 1; i <= NumberOfPages; i++)
        {
             NumericList.add(i);
        } 
    }
    
    //Load Filtered Contacts
    private void LoadFilteredContacts(){
        integer LimitPerQuery = 1000 / querydetails.size();
        
        QueryDetail = new Query__c();
        FilteredContacts = new List<contact>();
        queriestext = '';
        
        for(integer i = 0; i < QueryDetails.size(); i++){
            QueryDetail = QueryDetails[i];
             
        //Getting Filters values
        string filterQuery = 'where';
         if(QueryDetail.FilterField1__c != 'none'){
         
             //work
             if(QueryDetail.FilterField1Operator__c == '>' || QueryDetail.FilterField1Operator__c == '<' || QueryDetail.FilterField1Operator__c == '>=' || QueryDetail.FilterField1Operator__c == '<='){
                filterQuery += ' ' + QueryDetail.FilterField1__c + ' ' + QueryDetail.FilterField1Operator__c + ' ' + QueryDetail.FilterField1Value__c;        
             }
             else if(QueryDetail.FilterField1Operator__c == '=' || QueryDetail.FilterField1Operator__c == '<>'){
              filterQuery += ' ' + QueryDetail.FilterField1__c + ' ' + QueryDetail.FilterField1Operator__c + ' \'' + QueryDetail.FilterField1Value__c + '\'';        
             }
             else if(QueryDetail.FilterField1Operator__c == 'not like'){
              filterQuery += ' not (' + QueryDetail.FilterField1__c + ' like ' + ' \'%' + QueryDetail.FilterField1Value__c + '%\')';        
             }
             else if(QueryDetail.FilterField1Operator__c == 'like start'){
              filterQuery += ' ' + QueryDetail.FilterField1__c + ' like ' + ' \'' + QueryDetail.FilterField1Value__c + '%\'';        
             }
             else if(QueryDetail.FilterField1Operator__c == 'like mid'){
              filterQuery += ' ' + QueryDetail.FilterField1__c + ' like ' + ' \'%' + QueryDetail.FilterField1Value__c + '%\'';        
             }
             //-work
             
            if(QueryDetail.FilterField2__c != 'none'){
                
            //work
             if(QueryDetail.FilterField2Operator__c == '>' || QueryDetail.FilterField2Operator__c == '<' || QueryDetail.FilterField2Operator__c == '>=' || QueryDetail.FilterField2Operator__c == '<='){
                filterQuery += ' and ' + QueryDetail.FilterField2__c + ' ' + QueryDetail.FilterField2Operator__c + ' ' + QueryDetail.FilterField2Value__c;        
             }
             else if(QueryDetail.FilterField2Operator__c == '=' || QueryDetail.FilterField2Operator__c == '<>'){
              filterQuery += ' and ' + QueryDetail.FilterField2__c + ' ' + QueryDetail.FilterField2Operator__c + ' \'' + QueryDetail.FilterField2Value__c + '\'';        
             }
             else if(QueryDetail.FilterField2Operator__c == 'not like'){
              filterQuery += ' and not (' + QueryDetail.FilterField2__c + ' like ' + ' \'%' + QueryDetail.FilterField2Value__c + '%\')';        
             }
             else if(QueryDetail.FilterField2Operator__c == 'like start'){
              filterQuery += ' and ' + QueryDetail.FilterField2__c + ' like ' + ' \'' + QueryDetail.FilterField2Value__c + '%\'';        
             }
             else if(QueryDetail.FilterField2Operator__c == 'like mid'){
              filterQuery += ' and ' + QueryDetail.FilterField2__c + ' like ' + ' \'%' + QueryDetail.FilterField2Value__c + '%\'';        
             }
             //-work
            
             if(QueryDetail.FilterField3__c != 'none'){
               
             //work
             if(QueryDetail.FilterField3Operator__c == '>' || QueryDetail.FilterField3Operator__c == '<' || QueryDetail.FilterField3Operator__c == '>=' || QueryDetail.FilterField3Operator__c == '<='){
                filterQuery += ' and ' + QueryDetail.FilterField3__c + ' ' + QueryDetail.FilterField3Operator__c + ' ' + QueryDetail.FilterField3Value__c;        
             }
             else if(QueryDetail.FilterField3Operator__c == '=' || QueryDetail.FilterField3Operator__c == '<>'){
              filterQuery += ' and ' + QueryDetail.FilterField3__c + ' ' + QueryDetail.FilterField3Operator__c + ' \'' + QueryDetail.FilterField3Value__c + '\'';        
             }
             else if(QueryDetail.FilterField3Operator__c == 'not like'){
              filterQuery += ' and not (' + QueryDetail.FilterField3__c + ' like ' + ' \'%' + QueryDetail.FilterField3Value__c + '%\')';        
             }
             else if(QueryDetail.FilterField3Operator__c == 'like start'){
              filterQuery += ' and ' + QueryDetail.FilterField3__c + ' like ' + ' \'' + QueryDetail.FilterField3Value__c + '%\'';        
             }
             else if(QueryDetail.FilterField3Operator__c == 'like mid'){
              filterQuery += ' and ' + QueryDetail.FilterField3__c + ' like ' + ' \'%' + QueryDetail.FilterField3Value__c + '%\'';        
             }
             //-work
                   
             if(QueryDetail.FilterField4__c != 'none'){
                        
             //work
             if(QueryDetail.FilterField4Operator__c == '>' || QueryDetail.FilterField4Operator__c == '<' || QueryDetail.FilterField4Operator__c == '>=' || QueryDetail.FilterField4Operator__c == '<='){
                filterQuery += ' and ' + QueryDetail.FilterField4__c + ' ' + QueryDetail.FilterField4Operator__c + ' ' + QueryDetail.FilterField4Value__c;        
             }
             else if(QueryDetail.FilterField4Operator__c == '=' || QueryDetail.FilterField4Operator__c == '<>'){
              filterQuery += ' and ' + QueryDetail.FilterField4__c + ' ' + QueryDetail.FilterField4Operator__c + ' \'' + QueryDetail.FilterField4Value__c + '\'';        
             }
             else if(QueryDetail.FilterField4Operator__c == 'not like'){
              filterQuery += ' and not (' + QueryDetail.FilterField4__c + ' like ' + ' \'%' + QueryDetail.FilterField4Value__c + '%\')';        
             }
             else if(QueryDetail.FilterField4Operator__c == 'like start'){
              filterQuery += ' and ' + QueryDetail.FilterField4__c + ' like ' + ' \'' + QueryDetail.FilterField4Value__c + '%\'';        
             }
             else if(QueryDetail.FilterField4Operator__c == 'like mid'){
              filterQuery += ' and ' + QueryDetail.FilterField4__c + ' like ' + ' \'%' + QueryDetail.FilterField4Value__c + '%\'';        
             }
             //-work
                       
             if(QueryDetail.FilterField5__c != 'none'){
                        
             //work
             if(QueryDetail.FilterField5Operator__c == '>' || QueryDetail.FilterField5Operator__c == '<' || QueryDetail.FilterField5Operator__c == '>=' || QueryDetail.FilterField5Operator__c == '<='){
                filterQuery += ' and ' + QueryDetail.FilterField5__c + ' ' + QueryDetail.FilterField5Operator__c + ' ' + QueryDetail.FilterField5Value__c;        
             }
             else if(QueryDetail.FilterField5Operator__c == '=' || QueryDetail.FilterField5Operator__c == '<>'){
              filterQuery += ' and ' + QueryDetail.FilterField5__c + ' ' + QueryDetail.FilterField5Operator__c + ' \'' + QueryDetail.FilterField5Value__c + '\'';        
             }
             else if(QueryDetail.FilterField5Operator__c == 'not like'){
              filterQuery += ' and not (' + QueryDetail.FilterField5__c + ' like ' + ' \'%' + QueryDetail.FilterField5Value__c + '%\')';        
             }
             else if(QueryDetail.FilterField5Operator__c == 'like start'){
              filterQuery += ' and ' + QueryDetail.FilterField5__c + ' like ' + ' \'' + QueryDetail.FilterField5Value__c + '%\'';        
             }
             else if(QueryDetail.FilterField5Operator__c == 'like mid'){
              filterQuery += ' and ' + QueryDetail.FilterField5__c + ' like ' + ' \'%' + QueryDetail.FilterField5Value__c + '%\'';        
             }
             //-work
                        
                    }
                 }
               }
            }
        }
        else
        {
        filterQuery = '';
        }
        
        //Getting Sorting Criteria Values
        string SortingQuery = 'order by';
        if(QueryDetail.SortBy1__c != 'none'){
        SortingQuery += ' ' + QueryDetail.SortBy1__c + ' ' + QueryDetail.SortBy1Direction__c;
        
            if(QueryDetail.SortBy2__c != 'none'){
            SortingQuery += ', ' + QueryDetail.SortBy2__c + ' ' + QueryDetail.SortBy2Direction__c;
            
               if(QueryDetail.SortBy3__c != 'none'){
               SortingQuery += ', ' + QueryDetail.SortBy3__c + ' ' + QueryDetail.SortBy3Direction__c;
               }
            }
        }
        else
        {
        SortingQuery = '';
        }
                
            List<contact> tempContacts = new List<contact>();
            
            //Getting Contacts
            String finalSoql = '';
            if(QueryDetail.All_or_My__c == 'my'){
                if(filterQuery == ''){
                        filterQuery = 'where ownerid=\'' + UserInfo.getUserId() + '\'';
                }
                else{
                    filterQuery += ' and ownerid=\'' + UserInfo.getUserId() + '\'';
                } 
                
                finalSoql = 'select con.id, con.name, con.account.name, con.email, con.phone, con.school_status__c,con.pi__grade__c from Contact con ' + filterQuery + ' ' + SortingQuery  + ' LIMIT ' + LimitPerQuery;    
            }
            else{
            finalSoql = 'select con.id, con.name, con.account.name, con.email, con.phone, con.school_status__c,con.pi__grade__c from Contact con ' + filterQuery + ' ' + SortingQuery  + ' LIMIT ' + LimitPerQuery;    
            }
                
            
            tempContacts = Database.query(finalSoql);
            
            /*
            if(PagingModeOn == false){
                tempContacts = Database.query('select con.id, con.name, con.account.name, con.email, con.phone, con.school_status__c,con.pi__grade__c from Contact con ' + filterQuery + ' ' + SortingQuery + ' LIMIT ' + RecordsPerPage);
            }
            else{
                //Retrieving result set with offset based on current page
                Integer Offset = (CurrentPage - 1) * RecordsPerPage;
                tempContacts = Database.query('select con.id, con.name, con.account.name, con.email, con.phone, con.school_status__c,con.pi__grade__c from Contact con ' + filterQuery + ' ' + SortingQuery  + ' LIMIT ' + RecordsPerPage + ' OFFSET ' + OFFSET);
            }
            */
            
            integer StartIndex = 0;
            StartIndex = FilteredContacts.size();
            
            system.debug(tempContacts.size());
            //adding the recent retrieved data into main Dataset
            for(integer j = 0; j < tempContacts.size(); j++){
                if(FilteredContacts.size() < 1000)
                {
                FilteredContacts.add(tempContacts[j]);
                }
                else
                {
                    break;
                }
            }
            
            //Calculates the Paging buttons count
                ContactsSize = FilteredContacts.size();
                CalculatePages();
            
            //integer StartIndex = 0;
            // StartIndex = (20 * i);
            
            queriestext += QueryDetail.Name + ',' + StartIndex + ',' + (FilteredContacts.size() - 1) + '\r\n';
            //adding logic ends
            
        } //loops ends
            
        //Calculating Showing From and Showing To
        If(CurrentPage == 1){
            CurrentShowingFrom = 1;
            //CurrentShowingTo = RecordsPerPage;
            CurrentShowingTo = FilteredContacts.size();
            
            if(CurrentShowingTo > ContactsSize)
            {
                CurrentShowingTo = ContactsSize;
            }
        }
        else
        {
            //CurrentShowingFrom = ((CurrentPage - 1) * RecordsPerPage) + 1;
            CurrentShowingFrom = ((CurrentPage - 1) * FilteredContacts.size()) + 1;
            if(CurrentShowingFrom > ContactsSize)
            {
                CurrentShowingFrom = ContactsSize;
            }
            
            //CurrentShowingTo = CurrentShowingFrom + RecordsPerPage - 1;
            CurrentShowingTo = CurrentShowingFrom + FilteredContacts.size() - 1;
            
            if(CurrentShowingTo > ContactsSize)
            {
                CurrentShowingTo = ContactsSize;
            }
        }
        
        if(ContactsSize == 0){
                CurrentShowingFrom = 0;
                CurrentShowingTo = 0;
        }
        
        ContactsSizeString = string.valueof(ContactsSize);
        if(ContactsSize >= 2000)
        {
            ContactsSizeString = ContactsSizeString + '+';
        }
      
        
        //Methods ends
    }
    
}