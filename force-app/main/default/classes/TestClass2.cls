public class TestClass2 {
    public Opportunity opp{get;set;}
    public boolean pb2Rendered{get;set;} // true -> show pb2
    public boolean pb3Rendered{get;set;} // true -> show pb3
    public String selectedRT{get;set;} // selected value of selectList
    public TestClass2(){
        opp = new Opportunity(Name='Some Random Name',stageName='Prospecting');
        pb2Rendered = pb3Rendered = false;
        selectedRT='';
    }
    public void save(){
        // your logic to save data here
        //you may choose to have different save functions for different record types
    }
    public void onChangeFnCall(){
        if(selectedRT=='abc'){
            pb2Rendered = true;
            pb3Rendered = false;
        }
        else if(selectedRT=='def'){
            pb2Rendered = false;
            pb3Rendered = true;
        }
        else{
            pb2Rendered = false;
            pb3Rendered = false;
        }
    }
}