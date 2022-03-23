/**
	Name		: StatusBarController
	Date		: 6 Feb, 2021
	Author		: Jitendra Singh
	Description	: This controller is used to retrun project record accourding currentPage Id  .
				  
*/

public with sharing class StatusBarController {
   
  
    
    @AuraEnabled(cacheable=true)
    public static Project__c getProjectObj(Id currentPageId){
        
        System.debug('Id '+ currentPageId);
        return [Select Id, Name, Status__c from Project__c where Id = : currentPageId  ];

    }

                                     

}