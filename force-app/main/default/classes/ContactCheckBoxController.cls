public class ContactCheckBoxController {
    
    public List<ContactCheckBoxModel> contactCheckBoxModels {get;set;}	
    public List<Contact> deleteList {get;set;}
    public List<Contact> contactList {get;set;}
    public List<Contact> selectedRecord {get;set;}
    public Id contactID {get;set;}
    public List<Contact> contactParemList ;
    public Id cloneId {get;set;}
    public  Contact clonedata {get;set;}
    public Boolean cloneB {get;set;}
    
    public Boolean isck {get;set;}
    public Contact cloneInsert {get;set;}
    public integer noRecord=15;
    
    public ContactCheckBoxController()
    {
        integer i=0;
        cloneInsert = new Contact();
        cloneData = new Contact();
        isck = false;
        cloneB = false;
        contactParemList = new List<Contact>();
        contactList = [select FirstName,LastName,Email,Phone,BirthDate,Experience__c,Sub__c from Contact order by LastModifiedDate ];
        deleteList = new List<Contact>();
        selectedRecord = new List<Contact>();
        contactCheckBoxModels = new List<ContactCheckBoxModel>();
        for(Contact cont : contactList)
        {
            ContactCheckBoxModel cbox = new ContactCheckBoxModel();
            cbox.isChecked = false;
            cbox.con = cont;
            cbox.srNum = ++i;
            
            contactCheckBoxModels.add(cbox);  
            
        }
        
    }
    public PageReference save()
    {
        for(ContactCheckBoxModel cc : contactCheckBoxModels)
        {
            if(cc.isChecked)
            {
                selectedRecord.add(cc.con);
            }
        }
        if(contactParemList.size() > 0)
        {
            delete contactParemList;
        }
        
        upsert selectedRecord;
        PageReference pg = new PageReference('/apex/ContactCheckBox');
        pg.setRedirect(true);
        return pg;
    }
    public class ContactCheckBoxModel
    {
        public Boolean isChecked {get;set;}
        public Contact con {get;set;}
        public Integer srNum {get;set;}
    }
    
    public void deletefun()
    {
        for(ContactCheckBoxModel cc : contactCheckBoxModels)
        {
            if(cc.isChecked)
            {
                deletelist.add(cc.con);
            }
        }
    }
    public PageReference cancelfun()
    {
        PageReference pg = new PageReference('/apex/ContactCheckBox');
        pg.setRedirect(true);
        return pg;
    }
    public void selectedData()
    {
        Integer removedContact=0 ;
        Integer i=0;
        // System.debug('heleelel'+ contactID);
        // Contact contactIDD = [Select Id,FirstName From Contact Where Id = : ContactID];
        //  System.debug('hhhhhh'+ contactIDD);
        for(ContactCheckBoxModel cm : contactCheckBoxModels)
        {
            
            if(cm.con.id == contactID)
            {
                removedContact = i;
            }
            
            
            
            i=i+1;
        }
        ContactCheckBoxModel contactParem = contactCheckBoxModels.remove(removedContact);
        
        contactParemList.add(contactParem.con); 
        //    System.debug('djfdkfkd'+ contactCheckBoxModels);
        // System.debug('hehehehe'+ contactCheckBoxModels.remove(removedContact));
        
        
    }
    public void multiSelect()
    {
        
        System.debug('kdhfas'+isck);
        for(ContactCheckBoxModel cbox : contactCheckBoxModels)
        {
            if(isck)
            {
                cbox.ischecked = true;
                
            }
            else
            {
                cbox.ischecked = false;  
            }
        }
    }
    public void cloneRecord()
    {
        cloneB = true;
        cloneInsert = new Contact();
        for( ContactCheckBoxModel cbox : contactCheckBoxModels)
        {   
          
            // System.debug('idies ==>'+ cbox.con.id + '    '+ cloneId);
            if(cbox.con.id == cloneId)
            {
                  //System.debug('detail'+ cbox);
                //System.debug('idies ==>'+ cbox.con.id + '    '+ cloneId);
                cloneInsert.FirstName = cbox.con.FirstName;
               // System.debug('firstName'+ cloneInsert.FirstName);
                cloneInsert.LastName = cbox.con.LastName;
                cloneInsert.Email = cbox.con.Email;
                cloneInsert.Phone = cbox.con.Phone;
                cloneInsert.Birthdate = cbox.con.BirthDate;
                 cloneInsert.Experience__c = cbox.con.Experience__c;
                cloneInsert.Sub__c = cbox.con.Sub__c;
                System.debug('cloneInsert' + cloneInsert);
                
                
            }
        }
        
     
    }
    public PageReference cloneSave()
    {
         
    	 try
         {
			  insert cloneInsert; 
         }catch(Exception e)
         {
            apexPages.addMessages(e);
             return null;
         }
       
        //  System.debug('hiii'+ cloneData);
       PageReference pg = new PageReference('/apex/ContactCheckBox');
       pg.setRedirect(true);
        return pg;
        
    }
    public void next()
    {
        noRecord = noRecord + 15;
    }
    public void last()
    {
        
    }
    
}