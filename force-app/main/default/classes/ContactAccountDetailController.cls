public class ContactAccountDetailController {
    public Contact contactObj {get;set;}
    public Account accountObj {get;set;}
    public ContactAccountDetailController(){
        Id recordid = ApexPages.currentPage().getParameters().get('id');
        contactObj = [select Id,Name , Phone , AccountID, Email from Contact where id = : recordId];
        if(contactObj.AccountId != null)
        accountObj = [select Id, Name , Phone from Account where id = : contactObj.AccountId];
    }
}