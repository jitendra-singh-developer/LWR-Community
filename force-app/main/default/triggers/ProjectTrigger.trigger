/**
	Name		: ProjectTrigger
	Date		: 6 Feb, 2021
	Author		: Jitendra Singh
	Description	: This trigger is perform when project is created and then 5 project Task of different type automatically created 
				   with pervious self lookup relationship .
				  
*/

trigger ProjectTrigger on Project__c (after insert) {
    if(trigger.isAfter){
          ProjectTriggerHelper.createProjects(trigger.newMap);   
    }
          
}