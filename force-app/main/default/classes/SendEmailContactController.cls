public class SendEmailContactController {
    public  String emailAddress {get;set;}
    public  List<Contact> contacts {get;set;}
    public  List<ContactModel> contactmodels {get;set;}
    public Map<Id,Contact> contactMap {get;set;}
    public String Body {get;set;}  
    public String emailSubject {get;set;}
    List<String> emailAddresses {get;set;}
    public Id checkedContactId {get;set;}
    public boolean isContactId {get;set;}
    
    
    public SendEmailContactController()
    {
       
        emailAddress = '';
        contactmodels = new List<ContactModel>();
        emailAddresses = new List<String>();
        
        
        contacts = [select Id,Name,Email ,Phone from Contact where Email != Null];
        contactMap = new Map<Id,Contact>(contacts);
        for(Contact cn : contacts)
        {
            ContactModel sm = new ContactModel();
            sm.con = cn;
            sm.ischecked = false;
            contactModels.add(sm);
        }
        
    }
    
    public void sendEmail()
    {
        List<Messaging.SingleEmailMessage> emailMessage = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage sem = new Messaging.SingleEmailMessage();
        
        sem.setToAddresses(emailAddresses);  
         sem.setHtmlBody(Body);
            sem.setSubject(emailSubject);
        	emailMessage.add(sem);
      	System.debug('contain of body '+ Body);
        if( Body != '' ){
            system.debug('we are in body of email is dkfjksdfhs');
             
        	Messaging.sendEmail(emailMessage); 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.Confirm,'Your Email Sent , Successfully ')); 
            
             
        }
        else{
              ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'Body Cannot be Empty....!!!')); 
            system.debug('we are in body of email else');
        }
        
        
    }
    
    public void sendEmailTemplate()
    {
        
    }
    
    public Class ContactModel
    {
        public  Contact con {get;set;}
        public  boolean ischecked {get;set;}
    }
    public void fetchEmail()
    {
        System.debug('boolean '+ isContactId);
        System.debug('heeheh bro ' );
        System.debug('id of contact'+ checkedContactId);
        
        Contact con = contactMap.get(checkedContactId);
      
        if(emailAddresses.contains(con.Email)){
             isContactId = false;
            
            Integer indexOfNum = emailAddresses.indexOf(con.Email);
            emailAddresses.remove(indexOfNum);
           
            
        }
        else{
           
             emailAddresses.add(con.Email);    
            
               
        }
        emailAddress = '';
        for(String em : emailAddresses){
            emailAddress += em+',';
        }
        
        
        
    }
}