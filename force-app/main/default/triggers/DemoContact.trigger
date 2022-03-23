trigger DemoContact on Contact (after insert,after update,after delete) {
        Set<Id> accountIds = new Set<Id>();
    List<Account> accountUdpatedList = new List<Account>();
    for(Contact contactObj: Trigger.new){
        if(contactObj.AccountId != Null){
            
            accountIds.add(contactObj.AccountId);
        if(contactObj.accountId != trigger.oldMap.get(contactObj.Id).AccountId){
            accountIds.add(trigger.oldMap.get(contactObj.Id).AccountId);
        }
            
        }
        

    }   
    List<Account> accountList = [select Id ,num_of_contacts__c ,(Select Id from Contacts) from Account Where Id IN : accountIds];
    for(Account accountObj : accountList){
        Account accObj = new Account();
        accObj.Id = accountObj.Id;
        accobj.num_of_contacts__c = accountObj.Contacts.size();
        accountUdpatedList.add(accObj); 
    }
    update accountUdpatedList ;
    

}