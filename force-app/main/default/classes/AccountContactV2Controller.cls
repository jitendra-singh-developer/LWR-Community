public class AccountContactV2Controller {
	
    public List<Account> accountList {get;set;}
    public List<Contact> contactList {get;set;}
    public Integer count {get;set;}
    public List<Integer> totalcount {get;set;}
    public List<Id> idies {get;set;}


    public List<AccountContactModel> accountContactList {get;set;}
    
    public AccountContactV2Controller()
    {
        count = 0;
  		idies = new List<Id>();
        accountContactList  = new List<AccountContactModel>();
		accountList = new List<Account>();
        totalcount = new List<Integer>();
        Map<Id,Account> accountMap = loadAccountMap();
        Set<Id> accountIds = accountMap.keyset();
     
        contactList = loadContacts(accountIds);
        Map<Id, List<Contact>> ContactMap = new Map<Id, List<Contact>>();
    
        
      
          Integer cc= 0 ;
        for(Contact cont : contactList)
        {
          
            List<Contact> contactListList = ContactMap.get(cont.AccountId);
              AccountContactModel  ac = new AccountContactModel();
             if(idies.contains(cont.AccountId))
            {
              //  count++; 
              //  cc = count;
                
            }
            else
            {
               
                
			}
            
            if(contactListList == null)
            {
                
                  contactListList = new List<Contact>();
             	  idies.add(cont.AccountId);
          		  ac.accounts = accountMap.get(cont.AccountId);          
                  accountContactList.add(ac); 
                  
                
            }                
              ac.num = count++; 
             contactListList.add(cont);
            ContactMap.put(cont.AccountId, contactListList );
        }
      
      //accountContactList.add(ContactMap.keyset());
            
            
            
       /* for(Account acct : accountMap.keyse())
        {
            count = 0;
          	
            List<
            AccountContactModel  ac = new AccountContactModel();
            ac.accounts = acct;
            ac.num = count;
            
            
        	accountContactList.add(ac);   
        }*/
      
     	
        	        
    }
   	public List<Contact> loadContacts(Set<Id> accountIds)
    {
        contactList = [select Id,Name,AccountId from Contact where AccountId in : accountIds ];
        return contactList;
    }
    
    public  Map<Id, Account> loadAccountMap()
    {
      // Map<Id, Account> accountMap = new Map<Id,Account>();
       //accountList = [Select Id,name from Account];
      // for(Account stt : accountList)
       //{
      //     accountMap.put(stt.id, stt);
      // }
       Map<Id, Account> accounts = new Map<Id,Account>([Select Id,name from Account]);
       return accounts;
        
       
	}
    public Class AccountContactModel
    {
        public Integer num {get;set;}
        public Account accounts {get;set;}
    }
    
    
   
}