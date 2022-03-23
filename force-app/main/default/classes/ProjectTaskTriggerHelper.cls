/**
Name		: ProjectTaskTriggerHelper
Date		: 6 Feb, 2021
Author		: Jitendra Singh
Description	: This is helper class used to update project status according to project task type.
			  And also check project task have "terms & conditions " description in their attachment or not .

*/
public class ProjectTaskTriggerHelper {
    
    public static void updateProjectTaskList(List<Project_Task__c> projectTaskList, Map<Id,Project_Task__c> projectTaskOldMap){
        
        Set<Id> projectIdSet = new Set<Id>();
        for(Project_Task__c proejctObject : projectTaskList ){ 
            
            if(proejctObject.Completed__c && !projectTaskOldMap.get(proejctObject.Id).Completed__c ){
                projectIdSet.add(proejctObject.Project__c);
            }  
            
        }
        
        System.debug('set of idns'+ projectIdSet);
        List<Attachment> attachmentList = [Select ID, Description, parentId from Attachment where ParentId in : projectIdSet And Description = : 'Terms & Conditions'];
        System.debug('hello buddy' + attachmentList);
        
        
        Map<Id,Project__c> projectsMap = new Map<Id,Project__c>([select Id, Status__c from Project__c where Id in : projectIdSet ]);
        if(!projectsMap.isEmpty()){
            
            List<Project__c> projectUpdateList = new List<Project__c>();
            for(Project_Task__c projectTaskObject : projectTaskList){
                Project__c projectObject = new Project__c();
                
                projectObject =  projectsMap.get(projectTaskObject.Project__c);
                if(projectTaskObject.Type__c == 'New Task'){
                    projectObject.Status__c = 'New';
                }
                else if(projectTaskObject.Type__c == 'Planning Phase'){
                    projectObject.Status__c = 'Planning' ;
                    
                }else if(projectTaskObject.Type__c == 'Construction Work'){
                    projectObject.Status__c = 'Construction';
                    
                }else if(projectTaskObject.Type__c == 'Completion Step'){
                    projectObject.Status__c = 'Deployment';
                    
                }else if(projectTaskObject.Type__c == 'Contract End'){
                    projectObject.Status__c = 'Signoff';
                    
                }
                projectUpdateList.add(projectObject);   
            }
            if(projectUpdateList.size() > 0){
                update projectUpdateList;   
            }
            
        }
        
    }
    
    public static void checkDescription(List<Project_Task__c> projectTaskList, Map<Id,Project_Task__c> projectTaskOldMap){
        
        Set<Id> projectTaskIdSet = new Set<Id>();
        Project_Task__c projectTask = new Project_Task__c();
        for(Project_Task__c projectObject : projectTaskList ){ 
            
            if(projectObject.Completed__c && !projectTaskOldMap.get(projectObject.Id).Completed__c ){
                projectTaskIdSet.add(projectObject.Id);
                projectTask = projectObject;
            }  
            
        }
        
        
        
        List<Attachment> attachmentList = [Select ID, Description, parentId from Attachment 
                                           where ParentId in : projectTaskIdSet And Description Like : '%Terms & Conditions%'];
        
        if(attachmentList.size() > 0){
            
        Set<Id> attachmentIds = new Set<Id>();
        Map<Id,Attachment> attachmentMap = new Map<Id,Attachment>();
        for(Attachment attachmentObject : attachmentList){
            
            attachmentIds.add(attachmentObject.Id);
            attachmentMap.put(attachmentObject.ParentId, attachmentObject);
        } 
        for(Project_Task__c projectObject : projectTaskList){  
            if(attachmentMap.get(projectObject.Id) == null){
                projectObject.addError('Project attachment can\'t be empty and attachment decription must be Terms & Conditions');
            }
        }
        }else{
            projectTask.addError('Project attachment can\'t be empty and attachment decription must be Terms & Conditions');
        }
        
        
        
        
    }
    
    
}