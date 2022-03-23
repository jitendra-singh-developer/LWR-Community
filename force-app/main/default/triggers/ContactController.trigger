trigger ContactController on Contact (before insert,before update, after update) {
    
    if(trigger.isUpdate && trigger.isAfter){
        system.debug('This is Trigger.new'+ trigger.new);
        for(Contact con : trigger.new ){
            //
        }
    }
    
   /* List<Contact> contactList = new List<Contact>(Trigger.New);
    List<Account> accountUpdateList = new List<Account>();
    Map<Id,Account> accountMap = New Map<ID,Account>([Select Id , Name , Total_Contact__c from Account]);
    System.debug('insert trigger is called ');
    
    if(trigger.isInsert)
    {
        for(Contact con : contactList){
            
            System.debug('con Accountid'+ con.AccountId);
            Account acc = accountMap.get(con.AccountId);
            if(con.AccountId != null){
                
                
                acc.Total_Contact__c = acc.Total_Contact__c + 1;
                if(accountUpdateList.contains(acc))
                {
                    Integer indexofNum = accountUpdateList.indexOf(acc);
                    accountUpdateList.remove(indexofNum);
                    
                }
                accountUpdateList.add(acc);
            }
        }
        update accountUpdateList;
    }
    
    if(trigger.isUpdate)
    {
        Integer indexNum =0;
        List<Account> accountOldUpdateList = new List<Account>();
        List<Contact> contactOldList = new List<Contact>(trigger.Old);
        for(Contact con : contactList){
            
            System.debug('con Accountid'+ con.AccountId);
            Account acc = accountMap.get(con.AccountId);
            if(con.AccountId != null){
                
                
                if(con.AccountId != contactOldList.get(indexNum).AccountId)
                {
                    acc.Total_Contact__c = acc.Total_Contact__c + 1;
                    if(accountOldUpdateList.contains(acc))
                    {
                        Integer indexofNum = accountOldUpdateList.indexOf(acc);
                        accountOldUpdateList.remove(indexofNum);
                        
                    }
                    accountOldUpdateList.add(acc);
                    
                    if(contactOldList.get(indexNum).AccountId != null){
                        
                        Account accOld = accountMap.get(contactOldList.get(indexNum).AccountId);
                        accOld.Total_Contact__c = accOld.Total_Contact__c - 1;
                        if(accountOldUpdateList.contains(accOld))
                        {
                            Integer indexofNum = accountOldUpdateList.indexOf(accOld);
                            accountOldUpdateList.remove(indexofNum);
                            
                        }  
                        accountOldUpdateList.add(accOld);
                    }
                }
            }
            else
            {
                Account accOld = accountMap.get(contactOldList.get(indexNum).AccountId);
                accOld.Total_Contact__c = accOld.Total_Contact__c - 1;
                if(accountOldUpdateList.contains(accOld))
                {
                    Integer indexofNum = accountOldUpdateList.indexOf(accOld);
                    accountOldUpdateList.remove(indexofNum);
                    
                }
                accountOldUpdateList.add(accOld);
            }
            
            indexNum ++;
        }
        update accountOldUpdateList;
        
        
    }*/
}