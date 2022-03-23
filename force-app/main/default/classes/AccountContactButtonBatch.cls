// Batch Job for Processing the Records

  global class AccountContactButtonBatch implements Database.Batchable<sObject>, Database.Stateful {

      public Set<String> contentVersionSet {get;set;}
      public Id accountId {get;set;}
      
      public AccountContactButtonBatch(Set<Id> contentVersionIds , Id recordId){
			contentVersionSet = new Set<String>();
          for(Id content: contentVersionIds){
              contentVersionSet.add(content);
          }
			
          	System.debug('contentVersionSet'+ contentVersionSet);
			accountId = recordId;          
      }

    global Database.QueryLocator start(Database.BatchableContext BC) {
  String contentId = '0685g000001mcRXAAY';
  String query = 'Select ID, Title, VersionData, ContentSize, ContentBodyId, PathOnClient From ContentVersion Where Id IN : contentVersionSet' ;
        system.debug('qery'+ query);
        return Database.getQueryLocator(query);

    }

   // Execute method

    global void execute(Database.BatchableContext BC, List<ContentVersion> contentVersionList) {
			
        	 List<ContentVersion> fileInsertList = new List<ContentVersion>();
         	Zippex contactfilesZip = new Zippex();
           for(ContentVersion contentObject: contentVersionList){
            
                Blob fileData = contentObject.VersionData;
                contactfilesZip.addFile(contentObject.Title+'/'+contentObject.PathOnClient, fileData, null);
                fileData = null; //REDUCE HEAP SIZE
           }
           Blob zipData = contactfilesZip.getZipArchive();
           ContentVersion contentVersionObject = new ContentVersion();
           contentVersionObject.VersionData =zipData;
           contentVersionObject.Title = 'Files';
           contentVersionObject.PathOnClient = '/Files.zip';
           contentVersionObject.FirstPublishLocationId = accountId;
           fileInsertList.add(contentVersionObject);
           try{
              
               insert fileInsertList;

           }
           catch(Exception e){
              
              System.debug('Exception'+ e);
           }
         

    }   

    // Finish Method

    global void finish(Database.BatchableContext BC) {

    }

}