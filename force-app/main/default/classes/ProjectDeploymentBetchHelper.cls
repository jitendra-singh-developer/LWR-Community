/*
    Name		: ProjectDeploymentHelper
	Date		: 9 Feb, 2021
	Author		: Jitendra Singh
	Description	: This is a helper class of ProjectDeloymentBetch used to sent message to project owner of projet task owner   .


*/

public class ProjectDeploymentBetchHelper {
	
    public static void sendEmail(List<Project__c> projectList, List<EmailTemplate> deploymentTemplateId, List<EmailTemplate> signOffTemplateId){
       
        List<String> emailRecipentList = new List<String>();
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage  mail = new Messaging.SingleEmailMessage();
        
        List<Messaging.SingleEmailMessage> signoffmailList = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage  signoffmail = new Messaging.SingleEmailMessage();
        System.debug('sign'+ signOffTemplateId + ' delp' +  deploymentTemplateId );
        Set<Id> projectIds = new Set<Id>();
        for(Project__c projectObject : projectList){
            
            if(projectObject.Status__c == 'Deployment'){
                
                projectIds.add(projectObject.Id);
                
            
                mail.setTemplateId(deploymentTemplateId.get(0).Id);
                mail.setWhatId(projectObject.Id);
                mail.setSaveAsActivity(false);
                mail.setTargetObjectId(projectObject.Project_Owner__c);
                emailRecipentList.add(projectObject.Project_Owner__r.Email);                
                mail.setToAddresses(emailRecipentList);
                
                mailList.add(mail);
                
          
                
             
            }
        }
        List<Project_Task__c> projectTaskList = [Select Id, OwnerId, Owner.Email, Project__r.Project_Owner__c, Type__c from Project_Task__c where Project__c in : projectIds and Type__c = 'Contract End'];
        for(Project_Task__c projectTaskObject : projectTaskList){
            
            	signoffmail.setTemplateId(signOffTemplateId.get(0).Id);
            	signoffmail.setTargetObjectId(projectTaskObject.Project__r.Project_Owner__c);
           
                signoffmail.setWhatId(projectTaskObject.Id);
                signoffmail.setSaveAsActivity(false);
            	signoffmail.setToAddresses(new List<String>{projectTaskObject.Owner.Email});
                mailList.add(signoffmail);
        }
        
		 Messaging.sendEmail(mailList);
     
    }
}