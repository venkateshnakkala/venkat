global class SearchAndReplace implements Database.Batchable<sObject>{

   public String Query;
   public List<Row> data;
   
   public SearchAndReplace(){
       data = new List<Row>();
   }
   
   public SearchAndReplace(String q, string field, object value){
        Query=q;
        data = new List<Row>();
        Row r = new Row(field, value);
        data.add(r);
   }

   public SearchAndReplace(String q, row r){
        Query=q;
        data = new List<Row>();
        data.add(r);
    }
    
    public SearchAndReplace(String q, List<row> r){
        Query=q;
        data = new List<Row>();
        data=r;
    }
    
    public void set(string f, object v){
        this.data.add(new row(f,v));
    }

    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator(this.Query);
    }

    public void execute(Database.BatchableContext BC, List<sObject> scope)
    {
        for(sobject s : scope)
        {
            for(Row r :data){
                s.put(r.field,r.value);
            }
        }
        update scope;
    }
    
    public void finish(Database.BatchableContext BC){
    }
    
    public class row{
        public string field{get;set;}
        public object value{get;set;}  
        
        public row(string f, object v){
            this.field=f;
            this.value=v;
        }
    }
}