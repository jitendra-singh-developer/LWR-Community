public class AccountAddRemoveContactController {
    public List<Contact> contactsList {get;set;}
    public List<Contact> contactAddList {get;set;}
    public List<Contact> contactDelList {get;set;}
    public List<Integer> indexList {get;set;}
    public Contact contactObj {get;set;}
    public List<Contact> contactList {get;set;}
    public List<Contact> unContactList {get;set;}
    public List<ContactModel> contactmodelList {get;set;}
    public List<ContactModel> unContactModels {get;set;}
    public Id recordId ;
    public boolean isAllChecked {get;set;}
    public boolean isAllCheckedCon {get;set;}
    
 
    public AccountAddRemoveContactController(ApexPages.StandardController sc)
    {
        isAllCheckedCon = false;
        isAllChecked = false;
        contactsList = new List<Contact>();
        contactDelList = new List<Contact>();
        indexList = new List<Integer>();
        contactObj = new Contact(AccountId = sc.getId());
        contactAddList = new List<Contact>();
      //  unContactList = new List<Contact>();
       unContactModels = new List<ContactModel>();
        unContactList = [select Id,Name from Contact where AccountId = null];
        contactmodelList = new List<ContactModel>();
         recordId = sc.getId();
        System.debug('recordid'+ recordId);
        contactList = [select Id , Name ,Email, Phone  from Contact Where AccountId = : recordId ];
        Integer i=0;
        
        for(Contact cn : contactList){
            ContactModel com = new ContactModel();
            com.contact = cn;
            com.ischecked = false;
            com.indNum = ++i;
            contactmodelList.add(com);
        }
        i=0;
        for(Contact ct : unContactList){
             ContactModel co = new ContactModel();
            co.contact = ct;
            co.ischecked = false;
            co.indNum = ++i;
            unContactModels.add(co);
            
        }
        
        
        
    }
    public void remove()
    {
        isAllChecked = false;
        contactsList = new List<Contact>();
        indexList = new List<Integer>();
        for(ContactModel cMod : contactmodelList){
            if(cMod.ischecked)
            {
                ContactModel cm = new ContactModel();
                cm.ischecked = false;
                cm.contact = cMod.contact;
                contactAddList.add(cMod.contact);
                cm.indNum = unContactModels.size()+1;
              unContactModels.add(cm);
                indexList.add(cMod.indNum-1);
               
            }
        }
           Integer i = 0 ;
        for(Integer ind : indexList){
              
                ind = ind - i;
                contactmodelList.remove(ind);
                i++;
                
            }
        
         for(Contact ct : contactAddList){
             ct.AccountId = null;
             contactsList.add(ct);
             
         }
    }
    public void add(){
        isAllCheckedCon = false;
        contactsList = new List<Contact>();
         indexList = new List<Integer>();
        for(ContactModel cMod : unContactModels) {
            if(cMod.ischecked)
            {
                ContactModel cm = new ContactModel();
                cm.ischecked = false;
                cm.contact = cMod.contact;
                contactDelList.add(cMod.contact);
                cm.indNum = contactmodelList.size()+1;
                contactmodelList.add(cm);
                 indexList.add(cMod.indNum-1);
            }
        }
             Integer i = 0 ;
        for(Integer ind : indexList){
              
                ind = ind - i;
                unContactModels.remove(ind);
                i++;
                
            }
         for(Contact ct : contactDelList){
             ct.AccountId = recordId;
             contactsList.add(ct);
             
         }
        
    }
    public void submit()
    {
       
        upsert contactsList;
       
    }
    public void makeTrue()
    {
        System.debug(isAllChecked);
        for(ContactModel cm : contactmodelList){
            if(isAllChecked)
            {
                cm.isChecked = true;
            }
            else
            {
                cm.isChecked = false;
            }
        }
    }
      public void makeTrueCon()
    {
        System.debug(isAllCheckedCon);
        for(ContactModel cm : unContactModels){
            if(isAllCheckedCon)
            {
                cm.isChecked = true;
            }
            else
            {
                cm.isChecked = false;
            }
        }
    }
 
    public class ContactModel
    {
        public Contact contact {get;set;}
        public boolean ischecked {get;set;}
        public Integer indNum {get;set;}
    }
}