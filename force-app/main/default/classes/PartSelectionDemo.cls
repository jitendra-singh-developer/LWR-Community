public with sharing class PartSelectionDemo {
 
    @AuraEnabled(cacheable=true)
    public static List<Warranty_Product__c> fetchWarrantyProductRecords(){
       return (List<Warranty_Product__c>)[Select Id, Name , File_Image__c from Warranty_Product__c];
    }
}