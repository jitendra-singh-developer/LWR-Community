public class BulkUpsertContactsController {
    public List<Contact> contacts {get;set;}
    public boolean check {get;set;}
    public List<Contact> selectedContacts {get;set;} 
    public Contact con {get;set;}
		public BulkUpsertContactsController()
        {
            //contacts = new List<Contact>();
            selectedContacts = new List<Contact>();
            contacts = [Select Name, Email , Phone,Experience__c,Sub__c From Contact ];
		}
    	
    	public void save()
        {
            for(Contact cn : contacts)
            {
               	String cid = ApexPages.currentPage().getParameters().get(cn.Id); 
                System.debug('###'+ cid);
                if(cid != null)
                {
                  selectedContacts.add(cn) ; 
				}
            }
          
            upsert selectedContacts;
		}
    
    
}