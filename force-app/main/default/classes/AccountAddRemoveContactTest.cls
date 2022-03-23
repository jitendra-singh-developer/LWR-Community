@isTest
public class AccountAddRemoveContactTest {

    @isTest
    static void firstMethod(){
        Account acc = new Account(Name='jitendra',Email__c='jitndra@gmail.com');
       
		insert acc;
       
		ApexPages.StandardController sc = new ApexPages.standardController(acc);
        
        Contact contacts = new Contact(LastName='jitendra',Email='jietendrar@gmail.com',Phone='464646656',AccountId = acc.Id);
        Contact contacts2 = new Contact(LastName='jitendra',Email='viashalbhai@gmail.com',Phone='55486632',AccountId = null);
        List<Contact> contactListInsert = new List<Contact>();
        contactListInsert.add(contacts);
        contactListInsert.add(contacts2);
        insert contactListInsert;
        
        List<Contact> contactList = [select LastName,Email,Phone from Contact ];
        List<Contact> unContactList = [Select LastName,Email,Phone from Contact];
        AccountAddRemoveContactController arc = new AccountAddRemoveContactController(sc);
   
       
		List<AccountAddRemoveContactController.ContactModel> contactmodelList = new List<AccountAddRemoveContactController.ContactModel>();
        AccountAddRemoveContactController.ContactModel  AcCon = new AccountAddRemoveContactController.ContactModel();
        AcCon.ischecked = true;
        contactmodelList.add(AcCon);
        arc.remove();
        arc.add();
        
    /*	AcCon.contact =  [Select LastName,Email,Phone from Contact];
        AcCon.indNum = 2;
        AcCon.ischecked = true;
        contactmodelList.add(AcCon);*/
        
   		
       
      	
        arc.makeTrue();
        arc.submit();
        arc.makeTrueCon();
    }
}