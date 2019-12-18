public class TwoObjectsDataDisplayInOnTable {
    public List<wrapperForTwoObjectsDisplay> WrpObjDispaly{set;get;}
    public List<Account>                     acclst       {set;get;}
    public set<Account>                       AccountIds   {set;get;}
    public List<wrapperForTwoObjectsDisplay>  objlst       {set;get;}
    
    public TwoObjectsDataDisplayInOnTable(){
        
        AccountIds=new set<Account>([select id from Account]);
        acclst =new List<Account>();
      DataOfAccANDConwrp();
    }
    public  void DataOfAccANDConwrp(){
        
           WrpObjDispaly=new List<wrapperForTwoObjectsDisplay>();
            acclst=[select id,Name,(select id,Name,AccountId from Contacts where AccountId IN:AccountIds),(select id,Name,AccountId from Opportunities where AccountId IN:AccountIds) from Account];
            DisplayAccANDConDetails();
      
         
          
    }
    public void DisplayAccANDConDetails(){
        for(Account acc:acclst){
            system.debug('wrapper list'+acc);
            for(Contact con:acc.Contacts){
                system.debug('wrapper list'+con);
                for(Opportunity opp:acc.Opportunities){
                    WrpObjDispaly.add(new wrapperForTwoObjectsDisplay(acc,con,opp));
                    system.debug('wrapper list'+WrpObjDispaly);
                }
            } 
        } 
        
    }
   
    
   public pageReference SelectedValue(){
       
        objlst=new List<wrapperForTwoObjectsDisplay>();
       objlst.clear();
        system.debug('WrpObjDispaly=='+WrpObjDispaly.size()); 
        for(wrapperForTwoObjectsDisplay wtd: WrpObjDispaly){
            system.debug('--from selected wrapper'+wtd);           
            if(wtd.selected==true){
                system.debug('--in selected true'+wtd);
            
              objlst.add(new wrapperForTwoObjectsDisplay(wtd.acc,wtd.con,wtd.opp));   
                System.debug('objlst==='+objlst.size());     
            }          
       }
       if(objlst.size() > 0){
               return new PageReference('/apex/TwoObjectsDataDisaplySecondVf');
       }else{
                return null;
       }
      // return  null;
    } 
    public class wrapperForTwoObjectsDisplay{
        public Account             acc{set;get;}
        public Contact             con{set;get;}
        public Opportunity         opp{set;get;}
        public Boolean             selected{set;get;}
         
        public wrapperForTwoObjectsDisplay(Account acc,Contact con,Opportunity opp){
            This.acc=acc;
            This.con=con;
            This.opp=opp;
            This.selected=false;
        }
         
    }
}