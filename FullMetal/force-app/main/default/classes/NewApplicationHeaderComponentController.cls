public class NewApplicationHeaderComponentController {
    
    public User loggedInUser { get; set; }
    public Boolean resetpassmodal {get; set;}
    public Boolean isSignin {get; set;}
    public string page{get;set;}
    public NewApplicationHeaderComponentController() {
        this.loggedInUser = new User();
        initializeComponent();
        String resetpass = apexpages.currentpage().getparameters().get('resetPassword');
        isSignin=True;
          system.debug('resetpass=='+resetpass);
        
          if(resetpass != null){
            if(resetpass.equals('true'))
            {
               resetpassmodal = True; 
            }
            else{
               resetpassmodal = false;  
            }
          }     
    }
    
    private void initializeComponent() {
        
        try {
            System.debug( 'User Id:-\n' + UserInfo.getUserId() );
            this.loggedInUser = [ SELECT ID, Name FROM User WHERE ID =: UserInfo.getUserId() AND IsPortalEnabled = TRUE LIMIT 1 ];
            System.debug( 'this.loggedInUser:-\n' + JSON.serialize( this.loggedInUser ) );
            
            
        }
        catch( Exception e ) {
            System.debug( 'NewApplicationHeaderComponentController - Invalid User:-\n' + UserInfo.getUserId() );
        }
    }
   
}