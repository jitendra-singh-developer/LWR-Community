trigger HireFormTrigger on Hire_From__c (before insert,before Update) {
    
    List<Hire_From__c> hireList = trigger.new;
    
    if(Trigger.isInsert){
        List<Contact> contactList  = new List<Contact>();
        Map<Id,Contact> contactMap = new Map<Id,Contact>(contactList);
        for(Hire_From__c  hi : hireList){
            
            hi.Status__c = 'In Progress';
            Contact con = new Contact();
            con.FirstName = hi.First_Name__c;
            con.LastName = hi.Last_Name__c;
            con.Email = hi.Email__c;
            con.Phone = hi.Phone__c;
            contactList.add(con);
            
            
        }
        insert contactList;
        System.debug('contactList'+ contactList);
        
        Integer indexNum = 0;
        List<Case> caseList = new List<Case>();
        for(Hire_From__c hi : hireList){
            
            hi.Candidate__c =  contactList.get(indexNum).Id;
            
            Case c = new Case();
            c.ContactId = contactList.get(indexNum).Id;
            c.Status = 'New';
            caseList.add(c);
            indexNum ++;  
        }
        insert caseList;    
    }
    
    if(Trigger.isUpdate)
    {
        Set<ID> conId = new Set<Id>();
        for(Hire_From__c hi : hireList )
        {
            if( hi.Status__c =='Completed'){
                     
               conId.add(hi.Candidate__c);  
            }
        }
        
        if(!conId.isEmpty()){
            
            List<Case> caseList = new List<Case>([Select Id,Status from Case Where ContactId in : conId ]);
            for(Case ca : caseList){
                
                ca.Status = 'Closed';
                
            }
           update caseList;  
        }
        
        
       
    }
}