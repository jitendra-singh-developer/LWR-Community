/**
    Name		: ProjectTaskTriggerHelper
    Date		: 6 Feb, 2021
    Author		: Jitendra Singh
    Description	: This is helper class used to retrun list type of project .
    
*/
    public class ProjectTriggerHelper {
        
        public static void createProjects(Map<Id,Project__c> projectsMap){
            List<Project_Task__c> projectTaskList = new List<Project_Task__c>();
            for(Project__c project : projectsMap.values()){
                
                    projectTaskList.add(new Project_Task__c(Project__c = project.ID, Type__c = 'New Task'));
                    projectTaskList.add(new Project_Task__c(Project__c = project.ID, Type__c = 'Planning Phase'));
                    projectTaskList.add(new Project_Task__c(Project__c = project.ID, Type__c = 'Construction Work'));
                    projectTaskList.add(new Project_Task__c(Project__c = project.ID, Type__c = 'Completion Step'));
                    projectTaskList.add(new Project_Task__c(Project__c = project.ID, Type__c = 'Contract End'));
                           
            }
            insert projectTaskList;
            Id projectId ;
            List<Project_Task__c> projectTaskUpdateList = new List<Project_Task__c>();
            for(Project_Task__c projectTask:  projectTaskList){
                
                if(projectTask.Type__c == 'New Task'){
                    projectId = null;    
                }  
                projectTask.Project_Task__c = projectId;
                projectId = projectTask.Id;
                projectTaskUpdateList.add(projectTask);        
            }
            
            if(projectTaskUpdateList.size() > 0 ){
                update projectTaskUpdateList; 
            }
            
        }    
    }