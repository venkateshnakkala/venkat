public class WrpDispDiffData {
    public List<wrapperForTwoObjectsDisplay> wrpDisp {set;get;}
    public set<Account>                     accIds {set;get;}
    public  WrpDispDiffData(){
        DataOfAccANDConwrp();
    }
    public void DataOfAccANDConwrp(){
        
        wrpDisp=new List<wrapperForTwoObjectsDisplay>();
        accIds=new set<Account>([select id from Account]);
       system.debug('account data'+accIds);
        for(Contact c:[select id,Name,AccountId,Account.Name from Contact where AccountId IN:accIds]){
            wrpDisp.add(new wrapperForTwoObjectsDisplay(c));
            system.debug('wrapper data'+wrpDisp);
        }
         for(Opportunity o:[select id,Name,AccountId from Opportunity where AccountId IN:accIds]){
           wrpDisp.add(new wrapperForTwoObjectsDisplay(o));
             system.debug('wrapper data'+wrpDisp);

        }
        
     
    }
    
    public class wrapperForTwoObjectsDisplay{
         public Contact      con{set;get;}
         public Opportunity  opp{set;get;}
        public Boolean  selected{set;get;}
        public wrapperForTwoObjectsDisplay(Contact con){
           this.con=con;
        }
         public wrapperForTwoObjectsDisplay(Opportunity opp){
           this.opp=opp;
        }
    }
}