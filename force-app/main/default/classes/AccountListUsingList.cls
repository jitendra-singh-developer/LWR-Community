public class AccountListUsingList {
    public Account acc {get;set;}
    public List<Account> accounts {get;set;}
    public AccountListUsingList()
    {
        acc = new Account();
        accounts = [Select Id, Name,Cities__c,Password__c,Rating,Phone,Fax,Website From Account];
	}
    
    
}