public class ProjectProcessBarController {
    
    public ProjectProcessBarController(ApexPages.StandardController sc){
        
    }
     @AuraEnabled(cacheable=true)
    public static List<Project__c> getProjectObj(){
      
       
        return [Select Id, Name, Status__c from Project__c  ];

    }
                                     

}