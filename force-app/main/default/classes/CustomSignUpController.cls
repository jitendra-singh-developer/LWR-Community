public class CustomSignUpController {
    
    Public Contact contactObj {get;set;}
    public CustomSignUpController(){
        contactObj = new Contact();
    }
    public PageReference signUp(){
        Boolean isTrue = true;
        Account accountObj = [Select Id from Account Where Name = 'Star Infotech College'];
        contactObj.AccountId = accountObj.Id;
        try{
             insert contactObj;
        }catch(Exception e){
			isTrue = false;
        }
        System.debug('Hello ist');
        if(isTrue){
            System.debug('Hi....');
            PageReference pg = new PageReference('/apex/costom_login');
            return pg;
        }
        return null;
	}

}