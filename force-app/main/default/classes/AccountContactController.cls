public class AccountContactController {
	
    public List<Account> accountList {get;set;}
    public List<Contact> contactList {get;set;}
    public Integer count {get;set;}
    public List<Integer> totalcount {get;set;}
    public Integer cc {get;set;}
    public List<AccountContactModel> accountContactList {get;set;}
    
    public AccountContactController()
    {
        count = 0;
        cc =0;
        accountContactList  = new List<AccountContactModel>();
		accountList = new List<Account>();
        totalcount = new List<Integer>();
        loadAccounts();
        loadContacts();
        for(Account acct : accountList)
        {
            count = 0;
          	
            for(Contact cont : contactList)
            { 
                if(acct.Id == cont.AccountId)
                {
                    count++;
				}
            }
            AccountContactModel  ac = new AccountContactModel();
            ac.accounts = acct;
            ac.num = count;
            
            
        	accountContactList.add(ac);   
        }
      
     	
        
		        
    }
   	public List<Contact> loadContacts()
    {
        contactList = [select Id,Name,AccountId from Contact];
        return contactList;
    }
    
    public List<Account> loadAccounts()
    {
         accountList = [select Id, Name From Account];
         return accountList;
	}
    public Class AccountContactModel
    {
        public Integer num {get;set;}
        public Account accounts {get;set;}
    }
    
    
   
}