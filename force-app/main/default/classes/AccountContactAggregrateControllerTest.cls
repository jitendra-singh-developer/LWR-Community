@isTest
public class AccountContactAggregrateControllerTest {

    @isTest
    static void firstMethod(){
		AccountContactAggregrateController acc = new AccountContactAggregrateController();
        Account account = new Account(Name='jitendra',Id='0015g0000047eDcAAI');
        acc.accounts = [select Name from Account ];
          Contact contact = new Contact(FirstName='jitendra',AccountId='0015g0000047eDcAAI',Id='0035g000002fu3LAAQ');
        AggregateResult aggregate = [Select count(id) total,AccountId from Contact Where AccountId = : account.Id Group By AccountId];
        
    }
}