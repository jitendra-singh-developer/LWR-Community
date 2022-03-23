/**
	Name		: ProjectTaskTrigger
	Date		: 6 Feb, 2021
	Author		: Jitendra Singh
	Description	: This trigger is perform when user checked the compeliton checkBox then set the project status according to that Project Task type .
				  
*/

trigger ProjectTaskTrigger on Project_Task__c (after update) {
    
    if(Trigger.isAfter){
         ProjectTaskTriggerHelper.updateProjectTaskList(trigger.new, trigger.oldMap);  
         ProjectTaskTriggerHelper.checkDescription(trigger.new , trigger.oldMap);
    }
   
    
   
      
}