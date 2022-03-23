public class AccountDetailController {
    public String accountId {get;set;}
  
    public Account getAccountObj(){
        return [Select Id, Name, Phone, Email__c from Account where Id = : accountId];
        
    }
}