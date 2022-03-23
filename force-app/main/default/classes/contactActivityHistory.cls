public class contactActivityHistory {
    public Task[] getListTasks() {
        List<Contact> cntct = [SELECT Id, Name FROM Contact];
        List<Id> contactIds = new List<Id>();
        for(Contact cn : cntct) {
            contactIds.add(cn.Id);
        }
        
        List<Task> tskList = [select whoid,subject,status,LastModifiedDate from task where whoid in : contactIds order by LastModifiedDate desc];    
        return tskList;
    }
    
    
}