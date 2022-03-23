public class ProcessBuilderDemoController {
	@InvocableMethod 
    public static void  updateAccountName(List<Id> ids){
        List<Account> accountList = new List<Account>();
        List<Account> accounts = [select Id,Name from Account where Id in : ids];
        for(Account acc : accounts){
            acc.Name = acc.Name + ' Zean';
            accountList.add(acc);
        }
        update accountList;
    }
}