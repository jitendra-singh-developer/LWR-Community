public class SendEmailController {
    
    public SendEmailController()
    {
        
    }
    public static void  sendEmail()
    {
        List<Messaging.SingleEmailMessage> emailMessage = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage sem = new Messaging.SingleEmailMessage();
        List<String> emailAddresses = new List<String>{'jitendrasingh1304082@gmail.com','vishalchandnani41@gmail.com'};
            
            sem.setToAddresses(emailAddresses);
        sem.setSubject('Practice ke liye');
        String body = 'Hi,<br/>'+
            'this message not contains any kind of virus so do not worry <br/>'
            + 'Thank You';
        sem.setHtmlBody(body);
        emailMessage.add(sem);
        Messaging.sendEmail(emailMessage);
    }
    public static void  sendTemplateEmail()
    {
        List<Messaging.SingleEmailMessage> emailMessage = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage sem = new Messaging.SingleEmailMessage();
        List<String> emailAddresses = new List<String>{'jitendrasingh1304082@gmail.com','vishalchandnani41@gmail.com'};
            
            sem.setToAddresses(emailAddresses);
        List<EmailTemplate> emailTemplate = [Select Id from emailtemplate where developerName = 'SupportSelfServiceResetPassword'];
        Id contactId = getContactId(); 
        if(!emailTemplate.isEmpty() && contactId != null)
        {
        	sem.setTemplateId(emailTemplate.get(0).id);
            sem.setTargetObjectId(contactId);
            emailMessage.add(sem);
            Messaging.sendEmail(emailMessage);
            
        }
        
        
        
    }
    private static id getContactId()
    {
        List<Contact> conlist = [Select Id from Contact where id = '0035g000002fu3VAAQ'];
        return conlist.get(0).id == null ? null : conlist.get(0).id;
    }
}