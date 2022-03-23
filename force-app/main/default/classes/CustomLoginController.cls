public class CustomLoginController {
   @AuraEnabled
   public static Lead  getParam(String param){
     System.debug('param'+ param);
    
     return [Select Id , Name from lead limit 1];
   }
}