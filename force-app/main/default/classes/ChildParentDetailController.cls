public class ChildParentDetailController {
		
  
    List<Contact> contactList {get;set;}
    public ChildParentDetailController()
    {
        contactList = [select Id,Name , Phone from Contact];
    }

    
}