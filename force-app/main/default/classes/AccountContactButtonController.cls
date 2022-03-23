/*
Name		: AccountContactButtonController
Date		: 6 May, 2021
Author		: Jitendra Singh
Description	: This controller is use to contact related to Account and create a zip of contacts files.
*/


public class AccountContactButtonController {
  
    @AuraEnabled(cacheable = true)
    public static List<Contact> fetchContacts(Id recordId){

        return [select Id, Name, Email, Owner.Name, AccountId from Contact where AccountId = : recordId];
    }

    @AuraEnabled
    public static string addFilesToAccount(List<ContentVersion> contentVersionList,Id recordId){
      
        String message = 'error';
        Set<Id> contentIdSet = new Set<Id>();
        
       if(contentVersionList.size() > 0){
           message = 'success';
           List<ContentVersion> fileInsertList = new List<ContentVersion>();
           for(ContentVersion contentObject: contentVersionList){
               contentIdSet.add(contentObject.Id);
           }
       //    AccountContactButtonBatch accountContactBatchObject = new AccountContactButtonBatch(contentIdSet,recordId);
        //   database.executeBatch(accountContactBatchObject);
          List<ContentVersion> contentVersionRecordList = [Select ID, Title, VersionData, ContentSize, ContentBodyId, PathOnClient
                                                            From ContentVersion Where Id In : contentIdSet];
           Zippex contactfilesZip = new Zippex();
           for(ContentVersion contentObject: contentVersionRecordList){
            
                Blob fileData = contentObject.VersionData;
                contactfilesZip.addFile(contentObject.Title+'/'+contentObject.PathOnClient, fileData, null);
                fileData = null; //REDUCE HEAP SIZE
           }
           Blob zipData = contactfilesZip.getZipArchive();
           ContentVersion contentVersionObject = new ContentVersion();
           contentVersionObject.VersionData =zipData;
           contentVersionObject.Title = 'Files';
           contentVersionObject.PathOnClient = '/Files.zip';
           contentVersionObject.FirstPublishLocationId = recordId;
           fileInsertList.add(contentVersionObject);
           try{
              
               insert fileInsertList;

           }
           catch(Exception e){
              
               message = 'error';
           }
       }
       return message;
    }


    @AuraEnabled
    public static List<ContentVersion> showAttachments(List<Contact> contactList){

        if(contactList.size() > 0){

            Set<Id> contactIds = new Set<Id>();
            for(Contact con: contactList){
                contactIds.add(con.Id);
            }
    
            List<ContentDocumentLink> linkedIds = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId IN : contactIds];
            Set<Id> idSet = new Set<Id>();
            for(ContentDocumentLink con:linkedIds){
            idSet.add(con.ContentDocumentId);
            }
            List<ContentVersion> contentVersionList = [SELECT Id, Title, VersionData ,ContentBodyId, ContentSize, PathOnClient FROM ContentVersion WHERE ContentDocumentId IN : idSet];
          
    
            return contentVersionList;
        }else{
            return null;
        }
  
    }
}