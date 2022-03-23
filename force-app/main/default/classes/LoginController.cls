public class LoginController {
   
    public Contact contactSignup {get;set;}
    public Contact contactLogin {get;set;}
   
    public loginController(){
        contactSignup = new Contact();
        contactLogin = new Contact();
    }
   
  
    public PageReference doLogin(){
        if(contactLogin != Null){
            System.debug('contactLogin.Email ==> ' + contactLogin.Email);
            System.debug('contactLogin.Password ==> ' + contactLogin.Password__c);
            Contact con = [SELECT Id, Email, Password__c FROM Contact WHERE Email =: contactLogin.Email AND Password__c =: contactLogin.Password__c];
           
            if(con != Null){
                System.debug('Login Successfully..!!!');
                String startUrl = System.currentPageReference().getParameters().get('startURL');
                System.debug('startUrl'+ startUrl);
        		return Site.login(con.Email,con.Password__c,'/ibirdscommunity/');
            }else{
                
                return Null;
            }
        }else{
            return Null;
        }  
    }
   
   
   
}