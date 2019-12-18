global with sharing class CheckinLoginController {
    global String username {get; set;}
    global String password {get; set;}
    
    global CheckinLoginController() { 
             
    }
    global PageReference login() {
        return Site.login(username, password, '/Checkin'); 
    }  
}