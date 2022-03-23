public class UpdateContactMailingAddressController {
    public Account account {get;set;}
    public List<Account> AccountList {get;set;} 
    public List<SelectOption> AccountOptions {get;set;}
    public String selectedAccount {get;set;}
    public Boolean isopenform {get;set;}
    public List<Contact> contacts {get;set;}
      public Id accId {get;set;}
    public boolean iscontactopen {get;set;}
    public UpdateContactMailingAddressController()
      
        {
            iscontactopen = false;
            isopenform = false;
          
            AccountList = new List<Account>();
            loadAccount();
            
        }
    public void loadAccount()
    {
        AccountList = [Select Name from Account ];
        loadAccountData();
        selectedAccount = '';
    }
    public void loadAccountData()
    {
       AccountOptions = new List<SelectOption>();
        for(Account acc : AccountList)
        {
            if(!AccountOptions.contains(new SelectOption(acc.Id , acc.Name)))
            {
            AccountOptions.add(new SelectOption(acc.Id , acc.Name));
            }
        }
    }
    public void submit()
    {
        upsert account;
         iscontactopen = true;
         system.debug('contadct s'+ selectedAccount);
        contacts = [select Name ,Email, Phone from Contact where AccountId = : selectedAccount];
        for(Contact con : contacts)
        {
            con.MailingCity = account.BillingCity;
            con.MailingCountry = account.BillingCountry;
            con.MailingStreet = account.BillingStreet;
            con.MailingState = account.BillingState;
            con.MailingPostalCode = account.BillingPostalCode;
                
        }
        upsert contacts;
        system.debug('contadct s'+ contacts);
    }
    public void isopen()
    {
         iscontactopen = false;
        account = [select BillingCity,BillingCountry,BillingStreet,BillingState,BillingPostalCode from Account Where Id = : selectedAccount];
        system.debug('contadct s'+ selectedAccount);
        isopenform = true;
    }
    public void showContact()
    {
        iscontactopen = true;
         system.debug('contadct s'+ selectedAccount);
        contacts = [select Name ,Email, Phone from Contact where AccountId = : selectedAccount];
        system.debug('contadct s'+ contacts);
    }
    
    
}