/*
Name		: AccountPhaseController
Date		: 6 May, 2021
Author		: Jitendra Singh
Description	: This controller is use to fetch Accounts and update them on click of save button .
*/
public class AccountPhaseController {
    
    public List<Contact> contactList {get;set;}
    public List<AccountWrapperClass> accountContactWrapper {get;set;}
    
    public AccountPhaseController(){
        accountContactWrapper = new List<AccountWrapperClass>();
        contactList = new List<Contact>();
        contactList = [select Id, Name, Phone, Email ,Account.Allow_to_Edit__c , Account.Account_Phase__c from Contact 
                       Where Email != null And AccountId != null
                       limit 100];
        
        for(Contact contactObject: contactList){
            AccountWrapperClass accountWrapperObject = new AccountWrapperClass();
            accountWrapperObject.contactObject = contactObject;
            accountContactWrapper.add(accountWrapperObject);
            
        }
        System.debug('accoutWarpper class'+ accountContactWrapper);
    }
    
    public void save(){
        List<Contact> contactUpdateList = new List<Contact>();
        for(AccountWrapperClass accountWrapperObject :accountContactWrapper)
            
            
            if(accountWrapperObject.contactObject.Account.Allow_to_Edit__c){
                
                Contact contactObj = new Contact();
                contactObj.Id = accountWrapperObject.contactObject.Id;
                contactObj.Account_Phase_Status__c = accountWrapperObject.contactObject.Account.Account_Phase__c;
                contactUpdateList.add(contactObj);
            }
        if(contactUpdateList.size() > 0){
            System.debug('contactupdateList'+ contactUpdateList);
            update contactUpdateList;
        }
    }
    
    public class AccountWrapperClass{
        public Contact contactObject {get;set;}
        
    }
    
}