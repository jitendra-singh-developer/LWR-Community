/*
    Name        : ProjectDeploymentHelper
    Date        : 9 Feb, 2021
    Author      : Jitendra Singh
    Description : This is a helper class of ProjectDeloymentBetch used to sent message to project owner of projet task owner   .


*/

public class ProjectDeploymentHelper {
    
    public static void sendEmail(List<Project__c> projectList){
        
        List<EmailTemplate> templatesId = [Select ID, DeveloperName from EmailTemplate  where DeveloperName = 'Project_Inform_Template' Or DeveloperName = 'Signoff_Information'];
       	Map<String,Id> templatesMap = new Map<String,Id>();
        for(EmailTemplate template : templatesId){
            
            templatesMap.put(template.DeveloperName , template.Id);
            
        }
       
        List<String> emailRecipentList = new List<String>();
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage  mail = new Messaging.SingleEmailMessage();
       
        Messaging.SingleEmailMessage  signOffMail = new Messaging.SingleEmailMessage();
       
        Set<Id> projectIds = new Set<Id>();
        for(Project__c projectObject : projectList){
            
        
                
                projectIds.add(projectObject.Id);
                
            	
                mail.setTemplateId(templatesMap.get('Project_Inform_Template'));
                mail.setWhatId(projectObject.Id);
                mail.setSaveAsActivity(false);
                mail.setTargetObjectId(projectObject.Project_Owner__c);
                mail.setTreatTargetObjectAsRecipient(false);
                emailRecipentList.add(projectObject.Project_Owner__r.Email);                
                mail.setToAddresses(emailRecipentList);
                
                mailList.add(mail);  
          
        }
        List<Project_Task__c> projectTaskList = [Select Id, OwnerId, Owner.Email, Project__r.Project_Owner__c, Type__c from Project_Task__c where Project__c in : projectIds and Type__c = 'Contract End'];
        for(Project_Task__c projectTaskObject : projectTaskList){
            
                signOffMail.setTemplateId(templatesMap.get('Signoff_Information'));
                signOffMail.setTargetObjectId(projectTaskObject.Project__r.Project_Owner__c);
           		signOffMail.setTreatTargetObjectAsRecipient(false);
                signOffMail.setWhatId(projectTaskObject.Id);
                signOffMail.setSaveAsActivity(false);
                signOffMail.setToAddresses(new List<String>{projectTaskObject.Owner.Email});
                mailList.add(signoffmail);
        }
        
         Messaging.sendEmail(mailList);
     
    }
}