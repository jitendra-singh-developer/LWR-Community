public with sharing class AccountContactCountController {
    
    @AuraEnabled(cacheable = true)
    public static List<AccountCountWrapper> getAccountCountList(){
        List<AccountCountWrapper> wrapperList = new List<AccountCountWrapper>();
        for(Account account : [select Id, Name, (Select Id from Contacts) from Account]){
            AccountCountWrapper accountWrapperObject = new AccountCountWrapper();
            accountWrapperObject.accountObject = account ;
            accountWrapperObject.accountCount = account.Contacts.size();
             
            wrapperList.add(accountWrapperObject);
            
        }
        return wrapperList ;
    }
    public class AccountCountWrapper {
        @AuraEnabled
        public Account accountObject {get;set;}
        @AuraEnabled
        public Integer accountCount {get;set;}   
         
    }
}