public with sharing class StudentListDesignController {
  
    @AuraEnabled(cacheable=true)
    public static List<Student__c> getStudnetList(){

        return [Select Id, Last_Name__c, First_Name__c, City__c from Student__c];
    }
}