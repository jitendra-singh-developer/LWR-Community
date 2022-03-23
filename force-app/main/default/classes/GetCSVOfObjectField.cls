public class GetCSVOfObjectField {
    
    public static void getObjectFieldCSV(String selectObject){
        
        
        List<String> accountFields = new List<String>();
        accountFields = GetAllFieldsController.getFields(selectObject);
        System.debug('accountfields'+ accountFields);
        String csvFile = 'FieldOfYourObject'+'\n';
        for(String ac: accountFields){
            csvFile += ac + '\n';
        }
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
  		List<String> toAddresses = new List<String>();
        toAddresses.add('jitendrasingh1304082@gmail.com');
        message.setToAddresses(toAddresses);
        message.subject = 'Subject Test Message';
        message.plainTextBody = 'This is the message body.';
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
  		efa.setFileName('field.csv');
        blob csvBlob = Blob.valueOf(csvFile);
  		efa.setBody(csvBlob);
 		

        message.setFileAttachments(new Messaging.EmailFileAttachment[]{efa});
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        
    }
}