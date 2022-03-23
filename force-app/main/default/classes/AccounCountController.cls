/**
* 
Name		: AccounCountController
Date		: 25-3-2021
Author		: Jitendra Singh
Description	: This Controller is used to Show Account and number of Contact .

*/
public class AccounCountController {
    
    
    public List<Account> accountList ;
    public Boolean isAllow {get;set;}
    public AccounCountController(){
        
        isAllow = true;   
    }
    
    public List<AccountCountWrapper> getAccountCountList(){
        List<AccountCountWrapper> wrapperList = new List<AccountCountWrapper>();
        for(Account account : [select Id, Name, (Select Id from Contacts) from Account]){
            AccountCountWrapper accountWrapperObject = new AccountCountWrapper();
            accountWrapperObject.accountName = account ;
            accountWrapperObject.accountCount = account.Contacts.size(); 
            wrapperList.add(accountWrapperObject);
            
        }
        return wrapperList ;
    }
    public class AccountCountWrapper {
        public Account accountName {get;set;}
        public Integer accountCount {get;set;}    
    }
}