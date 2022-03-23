global class ContactLanguageBatch implements Database.Batchable<sObject> {
    
    Map<Id,Account> accountMap {get;set;}
    global ContactLanguageBatch(){
        
         accountMap = new Map<ID,Account>([Select Name from Account]);
        
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
       
        return Database.getQueryLocator([select Id, Languages__c,AccountId, Account.Name  from Contact ]);
    }
    
    global void execute( Database.BatchableContext bc, List<Contact> contactList) {
        
        for(Contact ro : contactList){
         
            ro.Languages__c = ro.Account.Name;
        }
        update contactList;
    }
    
    global void finish( Database.BatchableContext bc){
        
        System.debug('Contact is updated ');
       
        
    }

}