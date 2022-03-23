public class FileUploadController {

    public PageReference deleteDocument() {

        String docCodeParam = apexpages.currentpage().getparameters().get('docCodeParam');

        System.debug('delete a document :: '+docCodeParam);

        return null;
    }


   public String docCode {get; set;}

   public List<Document> documentList {get; set;}

   public List<Folder> folderList {get; set;}

   public Document document {
        get {
          if (document == null)
            document = new Document();
          return document;
        }
        set;
   }

public FileUploadController(){


      folderList = [SELECT Id,Name FROM Folder WHERE Name = 'IMAGE DOCS' ];

      if(folderList!=null && !folderList.isEmpty()){

          Folder folder = folderList.get(0);

          documentList = [SELECT Name , Type , Url, AuthorId, Body , 
                            LastReferencedDate , LastViewedDate, FolderId  FROM Document  
                            document where FolderId IN:folderList ];

      }


  }

  public PageReference upload() {

     Boolean isSuccess = true;

     if(folderList!=null && !folderList.isEmpty()){

          Folder folder = folderList.get(0);
          document.AuthorId = UserInfo.getUserId();
          document.FolderId =  folder.Id;// put it in running user's folder
          document.name = docCode+'-'+document.name;
    }

    try {

      insert document;

    } catch (DMLException e) {

      isSuccess = false;
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file'));

    } finally {

      document.body = null; // clears the viewstate
      document = new Document();

    }

    if(isSuccess){
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully'));
    }

    return null;
  }

  public List<SelectOption> getDocCodes(){

     List<SelectOption> docCodeList = new List<SelectOption>();
     docCodeList.add(new SelectOption('','')); 
     docCodeList.add(new SelectOption('PHOTO','PHOTO - PHOTO')); 
     docCodeList.add(new SelectOption('DOC','DOC - DOC')); 

     return docCodeList;
  } 

}