public class DueDateOrderController {
@AuraEnabled(cacheable=true)
public static List<Order> fetchDueDateOrders(Id recordId){
      List<Order> orderList =  new List<Order>();
      Date todayDate  = Date.today();
 
      orderList = [SELECT Id, OrderNumber, Due_Date__c, EffectiveDate, Amount__c, Status,Order.Account.Name, Order.Account.Email__c 
      FROM Order WHERE AccountId = : recordId AND Due_Date__c >= : todayDate AND Status != 'Paid' ];

      if(orderList.size() > 0 ){
         return orderList;
      }else {
         return null;
      }
}
@AuraEnabled
public static String sentMailToVendor(List<Order> dueOrderList){

      String returnMessage ;
      String generatedCSVFile ='';
      String fileRow = '';
      generatedCSVFile = 'Order Id'+','+'Order Number'+','+'Order Start Date'+','+'Order Due Date'+','+'Amount'+','+'Status'+','+'Comment'+'\n';
      for(Order orderObject: dueOrderList){
         fileRow = '';
         fileRow = fileRow +','+ orderObject.Id;
         fileRow = fileRow +','+ orderObject.OrderNumber;
         fileRow = fileRow +','+ orderObject.EffectiveDate;
         fileRow = fileRow +','+ orderObject.Due_Date__c;
         fileRow = fileRow +','+ orderObject.Amount__c;
         fileRow = fileRow +','+ orderObject.Status;
         fileRow = fileRow +','+ '';
         fileRow = fileRow.replaceFirst(',','');
         generatedCSVFile = generatedCSVFile + fileRow + '\n';
      }
      Messaging.EmailFileAttachment csvAttachment = new Messaging.EmailFileAttachment();
      Blob csvBlob = blob.valueOf(generatedCSVFile);
      String csvName = 'Due Date Orders.csv';
      csvAttachment.setFileName(csvName);
      csvAttachment.setBody(csvBlob);
      Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
      
      List<Messaging.SingleEmailMessage> emailMessage = new List<Messaging.SingleEmailMessage>();
      List<String> toAddresses = new List<String>();
      System.debug('email of Accounts 3'+ dueOrderList.get(0).Account.Email__c );
      if(dueOrderList.get(0).Account.Email__c != null){

         String emailAddress = dueOrderList.get(0).Account.Email__c;
         toAddresses.add(emailAddress);
         toAddresses.add('salonishekhawat123@gmail.com');
         System.debug('mail gya '+ emailAddress);
         String subject = 'company details which doesn';
         email.setSubject(subject);
         email.setToAddresses(toAddresses);
         email.setPlainTextBody('Hi '+ dueOrderList.get(0).Account.Name+','+'\n\n Your following order are bypass due dare order .\n please paid the order amount of these and comment as paid in file and resend us .\n Thank you \n Salesforce Team');
         email.setReplyTo('dueorderemailservice@l46ps45fvvzvat0lxvbuolcag9leniokv0ypbk2qqi7pa041d.5g-2ut72eaa.ap24.apex.salesforce.com');
         email.setSenderDisplayName('Vikas Joshi');
         email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttachment});
         emailMessage.add(email);
         Messaging.sendEmail(emailMessage);
         returnMessage = 'Success';

      }
      else{
          returnMessage = 'error';
      }
     


   
   
   
   return returnMessage;
   
}
}