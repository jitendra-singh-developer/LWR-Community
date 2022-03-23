public class AccountContactDetailController {
    public List<Account> accountList {get;set;}
    public List<Contact> contactList {get;set;}
    public List<AccountContactModel> accountContactList {get;set;}
    public Integer controller {get;set;}
    public Integer limitor {get;set;}
    public Integer rowSize {get;set;}
    boolean isTrue ;
    
    public AccountContactDetailController(){
        accountContactList = new List<AccountContactModel>();
        controller = 0;
        limitor =0;
        rowSize = 5;
        isTrue = true;
    }
    
    public List<AccountContactModel> getleAccountList(){
        
        accountList = [select Id,Name, Email__c , Phone from Account];
        Integer i = 0;
        for(Account acc: accountList){
            
            AccountContactModel ac = new AccountContactModel();
            ac.accountObj = acc;
            ac.srNon= ++i;
            accountContactList.add(ac);
            
            
            
        }
        if(limitor == 0)
            limitor = accountContactList.size();
        System.debug('accountcontactList'+ accountContactList);
        return accountContactList;
        
        
    }
    
    public List<AccountContactModel> getleContactList(){
        contactList = [select Id, Name , Email , Phone from Contact];
        
        Integer i = 0;
        for(Contact con: contactList){
            
            AccountContactModel ac = new AccountContactModel();
            ac.contactObj = con;
            ac.srNon = ++i;
            accountContactList.add(ac);
            
        }
        if(limitor == 0)
            limitor = accountContactList.size();
        return accountContactList;
    }
    
    public void  next(){
        
        if(isTrue){  
            controller = controller + rowSize;
            if(limitor - controller < 5){
                rowSize = limitor - controller;
                isTrue = false;  
            }
        }
        
    }
    
    public void previous(){
        if(controller >= 10)
            controller = controller - rowSize;
        isTrue = true;
    }
    
    public void first(){
        controller = 0;
        isTrue = true;
    }
    
    public void last(){
        controller = limitor-5;
        rowSize = 5;
        isTrue = false;
    }
    
    public class AccountContactModel{
        public Account accountObj {get;set;}
        public Contact contactObj {get;set;}
        public Integer srNon {get;set;}
    }
}