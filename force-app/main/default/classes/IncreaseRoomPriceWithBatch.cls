global class IncreaseRoomPriceWithBatch implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        
        
        
        //Id JobId1 = BC.getJobId();
       //  System.abortJob(jobId1);
       
        return Database.getQueryLocator([select Id, Name , Price__c from Room__c ]);
    }
    
    global void execute( Database.BatchableContext bc, List<Room__c> roomList) {
        
     
        
        
        for(Room__c ro : roomList){
            if(ro.Price__c < 8000){
                if(ro.Price__c != null)
                {
                   ro.Price__c = ro.Price__c + 2000;   
                }else
                {
                    ro.Price__c = 2000;
                }
                    
                    
                    
              
            }
            
        }
        update roomlist;
    }
    
    global void finish( Database.BatchableContext bc){
        
        Id jobId = BC.getChildJobId();
        System.abortJob(jobId);
        
        System.debug('room price is updated ');
        List<Messaging.SingleEmailMessage> emailMessage = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage sem = new Messaging.SingleEmailMessage();
        List<String> emailAddresses = new List<String>{'jitendrasingh1304082@gmail.com','vishalchandnani41@gmail.com'};
            
            sem.setToAddresses(emailAddresses);
        sem.setSubject('Room Price Increases !!!');
        String body = 'Hi,<br/>'+
            'Congratulation Dear, Your room price is increases with only 2000 rs , Hope you enjoy your day. <br/>'
            + 'Thank You';
        sem.setHtmlBody(body);
        emailMessage.add(sem);
        Messaging.sendEmail(emailMessage);
        
    }

}