/**
 * 
Name		: ProjectDeploymentBetch
Date		: 9 Feb, 2021
Author		: Jitendra Singh
Description	: This is a betch class to used to sent email to projet owner  where projet status is deployment and also 
			  sent email to those who didn't complete there last projet task to projet task owner .

*/


public class ProjectDeploymentBetch implements Database.Batchable<sObject>,Database.StateFul {
    

    public Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id,  Status__c, Project_Owner__r.Email FROM Project__c Where Status__c = \'Deployment\' ';

        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<Project__c> projectList) {
		ProjectDeploymentHelper.sendEmail(projectList);        
    }   
    public void finish(Database.BatchableContext BC) {
          
    }
    
}