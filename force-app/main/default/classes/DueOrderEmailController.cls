global  class DueOrderEmailController implements Messaging.InboundEmailHandler{

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope){

    Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
    String csvToString;
    List<Attachment> attList = new List<Attachment>();
    for(Messaging.InboundEmail.BinaryAttachment att : email.binaryAttachments)
    {  
        System.debug(att.body.toString());
        csvToString=att.body.toString();
    }
    List<String> fileLines = new List<String>();
    fileLines = csvToString.split('\n');
    Id orderId;
    Set<Id> orderIds = new Set<Id>();
    List<Order> orderUpdateList = new List<Order>();
    Integer indexNumber=0;
    String[] csvTabs = new String[]{'Order Id','Order Number','Order Start Date','Order Due Date','Amount','Status','Comment'};
   	Boolean isTrue = true;
    String generatedErrorCSVFile ='';
    for(String files: fileLines){
        
           String[] inputvalues = new String[]{};
           inputValues = files.split(',');
        if(inputValues.size() == csvTabs.size()){

            for(Integer index=0;index<csvTabs.size();index++){
             
            	inputValues[index] = inputValues[index].trim();
            	csvTabs[index] = csvTabs[index].trim();
                if(!(inputValues[index].equalsIgnoreCase(csvTabs[index]))){
                   //isTrue = false;
                   break;
                } 
       		}
        }else
        {
            isTrue = false;
             Integer indexNum = 0;
             Boolean isIncrease = true;
             for(Integer index=0;index<csvTabs.size();index++){
        
                 try{
                      	
                       	inputValues[indexNum] = inputValues[indexNum].trim();
            			csvTabs[index] = csvTabs[index].trim();
                     if(inputValues[indexNum].equalsIgnoreCase(csvTabs[index])){
                         isIncrease = true;
                         System.debug('inputvalues'+ inputValues[indexNum] +' == '+ csvTabs[index]);
                       
                     }
                     else{
                          isIncrease = false;
                          System.debug('inputvalues'+ inputValues[indexNum] +' != '+ csvTabs[index]);
                          generatedErrorCSVFile += ','+csvTabs[index];
                     }
            
                 }
                 catch(Exception e){
                     generatedErrorCSVFile += ','+csvTabs[index];
                     System.debug('exception'+' !='+ csvTabs[index]);
                 }
                 if(isIncrease){
                   indexNum++;  
                 }
           
        }
        break;	 
        }
      
        	
    }	
         System.debug('chal rha ha i'+ fileLines);
        if(isTrue){
            System.debug('chal rha ha i');
            
            for(String files: fileLines){
                
                 String[] inputvalues = new String[]{};
           		 inputValues = files.split(',');
                 //System.debug('inputValues'+ inputValues[6]);
                inputValues[6] = inputValues[6].trim();
                if(inputValues[6].equalsIgnoreCase('Paid')){
                    
                   //  System.debug('inputValues5555'+ inputValues[6]);
            		Order orderObject = new Order();
            		orderObject.Id = inputValues[0];
                    System.debug('inputvalues[0]5555'+ inputValues[0]);
            		orderObject.Status = 'Paid';
            		orderUpdateList.add(orderObject);
                    
                }
                  
            }
            if(orderUpdateList.size() > 0){
        	update orderUpdateList; 
    		}
            String fileName;
          for (Messaging.Inboundemail.BinaryAttachment file : email.binaryAttachments) 
    		{
        	Attachment attachment = new Attachment();
        	attachment.Name = file.fileName;
            fileName = file.fileName;
        	attachment.Body = file.body;
        	attachment.ParentId = fetchOrderAccountId(fileLines);
        	attList.add(attachment);
    	}
         List<Attachment> existsFileList = [select Id, Name From Attachment 
                                                where parentId = : fetchOrderAccountId(fileLines) And Name = : fileName ];
            if(existsFileList.size() > 0){
                delete existsFileList;
            }
    	if(attList.size()>0)
   	 	{
        insert attList;
   	 	}
          
        }
        else{
            
             System.debug('erroro'+ generatedErrorCSVFile );
     		 generatedErrorCSVFile = generatedErrorCSVFile.replaceFirst(',','');
    		 System.debug('erroro'+ generatedErrorCSVFile );
     		 Blob csvBlob = blob.valueOf(generatedErrorCSVFile);
     		 String csvName = 'error.csv';
     		 List<Attachment> existsFileList = [select Id, Name From Attachment 
                                                where parentId = : fetchOrderAccountId(fileLines) And Name = : csvName ];
            if(existsFileList.size() > 0){
                delete existsFileList;
            }
      		 Attachment attachment = new Attachment();
        		attachment.Name = csvName;
        		attachment.Body = csvBlob;
        		attachment.ParentId = fetchOrderAccountId(fileLines);
        		attList.add(attachment);
      			if(attList.size()>0)
    			{
        			insert attList;
    			}
            
            
            
        }
    result.success = true;
    return result ;
    }
    global static Id fetchOrderAccountId(List<String> fileLines){
            	Id orderId;
             	Boolean isExist = false;
        		for(String files: fileLines){
             	String[] inputValues = new String[]{};
           		inputValues = files.split(',');
            
            	if(isExist){
               // System.debug('orderId commant'+ inputValues[6]);
                orderId = inputValues[0];
                
            	}
            	if(inputValues[0].equalsIgnoreCase('Order Id')){
                System.debug('orderId'+ inputValues[0]);
                isExist = true;
            	}  
        	}
          Order orderObject = [Select Id, AccountId from Order Where Id = : orderId];
          return orderObject.AccountId;  
        }
}