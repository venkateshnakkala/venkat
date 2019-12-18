public class QueryController {
    
    //Global variables and properties
    public List<Query__c> AllQueries{get;set;}
    public Map<String,String> Fields {get;set;}
    public Map<String,String> Operators {get;set;}
    public Map<String,String> Directions {get;set;}
    public String QueryName {get;set;}
    public String QueryID {get;set;}
    public String Field1 {get;set;}                     
    public String Field2 {get;set;}                     
    public String Field3 {get;set;}                     
    public String Field4 {get;set;}
    public String Field5 {get;set;}
    public String Operator1 {get;set;}                     
    public String Operator2 {get;set;}                     
    public String Operator3 {get;set;}                     
    public String Operator4 {get;set;}
    public String Operator5 {get;set;}
    public String Value1 {get;set;}                     
    public String Value2 {get;set;}                     
    public String Value3 {get;set;}                     
    public String Value4 {get;set;}
    public String Value5 {get;set;}
    public String SortBy1 {get;set;}
    public String SortBy2 {get;set;}
    public String SortBy3 {get;set;}
    public String Direction1 {get;set;}
    public String Direction2 {get;set;}
    public String Direction3 {get;set;}
    public Boolean AddMode {get;set;}
    public Boolean EditMode {get;set;}
    public String SelectedRadio {get;set;}    
    
    //Constructor
    public QueryController() {
        
        //Initializing Queries list
        this.AllQueries = new list<Query__c>();
        
        //Getting all fields of Contact Object
        Schema.DescribeSObjectResult a_desc = Contact.sObjectType.getDescribe();
        Map<String, Schema.SObjectField> a_fields = a_desc.fields.getMap();
        Fields = new Map<String,String>();
        Fields.put('None','none');
        for(Schema.sObjectField fld:a_fields.values()){ 
        String LabelName = fld.getDescribe().getLabel();
            if(LabelName != 'Mailing Address' && LabelName != 'Contact Description' && LabelName != 'Other Address' && LabelName != 'SSN' && LabelName != 'Referral Notes' && LabelName != 'Original Source Info' && LabelName != 'Pardot First Referrer' && LabelName != 'Pardot Comments' && LabelName != 'Pardot Notes' && LabelName != 'Duplicate Check Index')
            {
                Fields.put(string.valueof(fld.getDescribe().getLabel()),string.valueof(fld));
            }
                }
        
        //Setting Operators name and value
        Operators = new Map<String,String>();
        Operators.put('-None-','none');
        Operators.put('equals','=');
        Operators.put('not equal to','<>');
        Operators.put('starts with','like start');
        Operators.put('contains','like mid');
        Operators.put('does not contain','not like');
        Operators.put('less than','<');
        Operators.put('greater than','>');
        Operators.put('less or equal','<=');
        Operators.put('greater or equal','>=');
        
        //Setting Directions
        Directions = new Map<String,String>();
        Directions.put('-None-','none');
        Directions.put('Asc','Asc');
        Directions.put('Desc','Desc');
        
        //Setting Fields, Operators & SortBy default value to 'None'
        this.Field1 = 'none';
        this.Field2 = 'none';
        this.Field3 = 'none';
        this.Field4 = 'none';
        this.Field5 = 'none';
        this.Operator1 = 'none';
        this.Operator2 = 'none';
        this.Operator3 = 'none';
        this.Operator4 = 'none';
        this.Operator5 = 'none';
        this.SortBy1='none';
        this.SortBy2='none';
        this.SortBy3='none';
        this.Direction1='none';
        this.Direction2='none';
        this.Direction3='none';
        this.SelectedRadio = 'All';
        
        //Add mode & Edit mode is off by default
        EditMode = false;
        AddMode = false;
    }
    
    //Methods
    public void SaveQuery(){
        
        if(EditMode == false){
                try{
                Query__c que = new Query__c();
                que.name = QueryName;
                que.FilterField1__c = Field1;
                que.FilterField2__c = Field2;
                que.FilterField3__c = Field3;
                que.FilterField4__c = Field4;
                que.FilterField5__c = Field5;
                que.FilterField1Operator__c = Operator1;
                que.FilterField2Operator__c = Operator2;
                que.FilterField3Operator__c = Operator3;
                que.FilterField4Operator__c = Operator4;
                que.FilterField5Operator__c = Operator5;
                que.FilterField1Value__c = Value1;
                que.FilterField2Value__c = Value2;
                que.FilterField3Value__c = Value3;
                que.FilterField4Value__c = Value4;
                que.FilterField5Value__c = Value5;
                que.SortBy1__c = SortBy1;
                que.SortBy2__c = SortBy2;
                que.SortBy3__c = SortBy3;
                que.SortBy1Direction__c = Direction1;
                que.SortBy2Direction__c = Direction2;
                que.SortBy3Direction__c = Direction3;
                que.All_or_my__c = SelectedRadio;
                    
                AggregateResult[] groupedResults = [SELECT Max(Sequence__c)aver FROM Query__c];
                Object maxSequence = groupedResults[0].get('aver');
                    try{
                        Integer i = Integer.valueOf(maxSequence) + 1;
                        que.sequence__c = i;
                    }
                    catch(Exception ex1){
                        que.sequence__c = 1;
                    }
                
                    
                insert que;
                ShowAllQueries();
            }
            catch(Exception ex){
                system.debug('Save Error: ' + ex.getMessage() + ', Line: ' + ex.getLineNumber());
            }
        }
        else{
            UpdateQuery();
        }
        
        AddMode = false;
        EditMode = false;
    }
        
    public void AddNewQuery(){
        AddMode = true;
        EditMode = false;
        
        QueryName = '';
            Field1 = 'none';
            Field2 = 'none';
            Field3 = 'none';
            Field4 = 'none';
            Field5 = 'none';
            
            Operator1 = 'none';
            Operator2 = 'none';
            Operator3 = 'none';
            Operator4 = 'none';
            Operator5 = 'none';
            
            Value1 = '';
            Value2 = '';
            Value3 = '';
            Value4 = '';
            Value5 = '';
            
            SortBy1 = 'none';
            SortBy2 = 'none';
            SortBy3 = 'none';
            
            Direction1 = 'none';
            Direction2 = 'none';
            Direction3 = 'none';
    }
    
    public void EditQuery(){
    AddMode = false;
    EditMode = true;
         try{
            Query__c que = [Select name, FilterField1__c, FilterField2__c, FilterField3__c, FilterField4__c, FilterField5__c,  
                            FilterField1Operator__c, FilterField2Operator__c, FilterField3Operator__c, 
                            FilterField4Operator__c, FilterField5Operator__c, 
                            FilterField1Value__c, FilterField2Value__c, FilterField3Value__c, 
                            FilterField4Value__c, FilterField5Value__c,
                            SortBy1__c, SortBy2__c, SortBy3__c,
                            SortBy1Direction__c, SortBy2Direction__c, SortBy3Direction__c, all_or_my__c
                            from Query__c where id = :QueryID];
            QueryName = que.name;
            SelectedRadio = que.all_or_my__c;
            Field1 = que.FilterField1__c;
            Field2 = que.FilterField2__c;
            Field3 = que.FilterField3__c;
            Field4 = que.FilterField4__c;
            Field5 = que.FilterField5__c;
            
            Operator1 = que.FilterField1Operator__c;
            Operator2 = que.FilterField2Operator__c;
            Operator3 = que.FilterField3Operator__c;
            Operator4 = que.FilterField4Operator__c;
            Operator5 = que.FilterField5Operator__c;
            
            Value1 = que.FilterField1Value__c;
            Value2 = que.FilterField2Value__c;
            Value3 = que.FilterField3Value__c;
            Value4 = que.FilterField4Value__c;
            Value5 = que.FilterField5Value__c;
            
            SortBy1 = que.SortBy1__c;
            SortBy2 = que.SortBy2__c;
            SortBy3 = que.SortBy3__c;
            
            Direction1 = que.SortBy1Direction__c;
            Direction2 = que.SortBy2Direction__c;
            Direction3 = que.SortBy3Direction__c;
        }
        catch(Exception ex){
            system.debug('Edit Error: ' + ex.getMessage() + ', Line: ' + ex.getLineNumber());
        }
    }
    
    public void UpdateQuery(){
        try{
            Query__c que = [Select id from Query__c where id = :QueryID];
            que.name = QueryName;
            que.FilterField1__c = Field1;
            que.FilterField2__c = Field2;
            que.FilterField3__c = Field3;
            que.FilterField4__c = Field4;
            que.FilterField5__c = Field5;
            que.FilterField1Operator__c = Operator1;
            que.FilterField2Operator__c = Operator2;
            que.FilterField3Operator__c = Operator3;
            que.FilterField4Operator__c = Operator4;
            que.FilterField5Operator__c = Operator5;
            que.FilterField1Value__c = Value1;
            que.FilterField2Value__c = Value2;
            que.FilterField3Value__c = Value3;
            que.FilterField4Value__c = Value4;
            que.FilterField5Value__c = Value5;
            que.SortBy1__c = SortBy1;
            que.SortBy2__c = SortBy2;
            que.SortBy3__c = SortBy3;
            que.SortBy1Direction__c = Direction1;
            que.SortBy2Direction__c = Direction2;
            que.SortBy3Direction__c = Direction3;
            que.All_or_my__c = SelectedRadio;
            update que;
            ShowAllQueries();
        }
        catch(Exception ex){
            system.debug('Update Error: ' + ex.getMessage() + ', Line: ' + ex.getLineNumber());
        }
    }

        public void DeleteQuery(){
        try{
            Query__c que = [Select id from Query__c where id = :QueryID];
            Delete que;
            ShowAllQueries();
            EditMode = false;
        }
        catch(Exception ex){
            system.debug('Delete Error: ' + ex.getMessage() + ', Line: ' + ex.getLineNumber());
        }
       }
    
     public void Up(){
        try{
            
            for(integer i = 0; i < AllQueries.size(); i++){
                if(QueryID == AllQueries[i].id){
                    if(i != 0){
                        integer PreviousIndex = i - 1;
                        decimal SequenceNumberPrevious = AllQueries[PreviousIndex].sequence__c;
                        decimal SequenceNumberCurrent = AllQueries[i].sequence__c;
                        AllQueries[PreviousIndex].sequence__c = SequenceNumberCurrent;
                        AllQueries[i].sequence__c = SequenceNumberPrevious;
                        update AllQueries;
                        ShowAllQueries();
                        break;
                    }
                }
            }
            
        }
        catch(Exception ex){
            system.debug('Up Error: ' + ex.getMessage() + ', Line: ' + ex.getLineNumber());
        }
       }
    
     public void Down(){
        try{
            
            for(integer i = 0; i < AllQueries.size(); i++){
                if(QueryID == AllQueries[i].id){
                    if(i != AllQueries.size() - 1){
                        integer NextIndex = i + 1;
                        decimal SequenceNumberNext = AllQueries[NextIndex].sequence__c;
                        decimal SequenceNumberCurrent = AllQueries[i].sequence__c;
                        AllQueries[NextIndex].sequence__c = SequenceNumberCurrent;
                        AllQueries[i].sequence__c = SequenceNumberNext;
                        update AllQueries;
                        ShowAllQueries();
                        break;
                    }
                }
            }
            
        }
        catch(Exception ex){
            system.debug('Up Error: ' + ex.getMessage() + ', Line: ' + ex.getLineNumber());
        }
       }
    
    public void ShowAllQueries(){
        
        AllQueries = [Select id, name, Sequence__c from Query__c order by sequence__c asc Limit 100];
    }
    
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('All','All Student Masters'));
        options.add(new SelectOption('My','My Student Masters'));
        return options;
    }

}