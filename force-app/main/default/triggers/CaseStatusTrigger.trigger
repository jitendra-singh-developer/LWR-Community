trigger CaseStatusTrigger on Case (before update) {
	
    List<Case> caseList = new List<Case>(Trigger.New);
    Map<Id,Case> caseMap = new Map<Id,Case>(caseList);
    Map<Id,Contact> contactMap = new Map<Id,Contact>([select Id, Name from Contact Where Id in : caseMap.keySet() ]);
    List<Hire_From__c> hireList = new List<Hire_From__c>([select  Id, Candidate__c,Status__c from Hire_From__c Where Candidate__c in : contactMap.keySet()]);
    Map<Set<Id>,List<Hire_From__c>> hireMap = new Map<Set<Id>,List<Hire_From__c>>();
    hireMap.put(contactMap.keySet(), hireList);
    for(Case ca : caseList){
        
        if(ca.Status == 'Closed'){
            
            Contact con = contactMap.get(ca.ContactId);
            
            
            
            
        }
        
    }
}