public class AssignTaskContactController {
    
    public List<Contact> contacts {get;set;}
    public Contact con {get;set;}
 
    public List<Task> tskList {get;set;}
    public List<Task> assignList {get;set;}
    public AssignTaskContactController(ApexPages.StandardController controller)
    {
        // public AssignTaskController(ApexPages.StandardController controller);
        contacts = [select Name,AccountId,Email,Phone from Contact] ; 
        con = new Contact();
        assignList = new List<Task>();
       
    }
    public Task[] getListTasks() {
        
        
        List<Contact> cntct = [SELECT Id, Name FROM Contact ];
        List<Id> contactIds = new List<Id>();
        
        for(Contact cn : cntct) {
            contactIds.add(cn.Id);
        }
        
         tskList = [select whoid,subject,WhatId,status,LastModifiedDate from task where whoid in : contactIds And WhatId = null order by LastModifiedDate desc];
        
        return tskList;
    }
    public PageReference assignTask()
    {
        PageReference pg = new PageReference('/apex/taskPage' );
        
        return pg;
    }
    
    public void assign()
    {
        for(Task ts : tsklist)
        {
            String cid = ApexPages.currentPage().getParameters().get(ts.id);
            if(cid != null)
            {
                 String ccid = ApexPages.currentPage().getParameters().get(con.id);
       			// System.debug('#ccid '+ ccid);
                ts.WhoId = ccid;
                assignList.add(ts);
                upsert assignList;
                
			}
		}
        
        
        
    }
    
}