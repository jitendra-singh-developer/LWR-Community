trigger PrimaryContactEmailController on Contact (before insert, before update) {
    
  
   /* Map<Id,Account> accountMap = new Map<Id,Account>([Select Id,Name ,Primary_Contact_Email__c from Account]);
    List<Contact> contactList = new List<Contact>(trigger.New);
   
    List<Account> accountList = new List<Account>();
 
    for(Contact con : contactList)
    {
        Account acc = accountMap.get(con.AccountId);
       
        if(acc.Primary_Contact_Email__c != null)
        {
            acc.Primary_Contact_Email__c = null;
            accountList.add(acc);
        }
        
        if(con.Email != null)
        {
            System.debug('this is debug zone');
     
            acc.Primary_Contact_Email__c = con.Email;
            if(accountList.contains(acc))
            {
               Integer indexNum =  accountList.indexOf(acc) ;
               accountList.remove(indexNum);
            }
            accountList.add(acc);
            break;
        }
    }
   
    
    update accountList;*/
}