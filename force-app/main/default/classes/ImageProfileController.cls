public class ImageProfileController {
    Public Contact contact {get;set;}
    public String contentName {get;set;}
    public List<Attachment> attachmentList {get;set;}
    public Id attId {get;set;}
    public Id recordId {get;set;}
    public Attachment attachment {get;set;}
    public ImageProfileController(ApexPages.StandardController pi)
    {
        recordId = pi.getId();
      	attachment = new Attachment(); 
     	attId = '00P5g000001JtZA';
        attachmentList = [select Id , parentId , ContentType from Attachment where parentId = : recordId order by lastModifiedDate];
        for(Attachment att: attachmentList)
        {
            attId = att.id;
           // System.debug('content type'+ att.ContentType);
            
            
        }
             
        
    }

    public void upload()
    {		 
              attachment.ParentId = recordId;
             
        	  contentName = attachment.name;
              integer types =  contentName.indexOf('.');
        	  String NameofFile = contentName.substring(types+1);
        
        	  System.debug('name '+ attachment.ContentType);
        	  try
              {
                  insert attachment;  
              }
        	  catch(Exception e)
              {
                 apexpages.addMessages(e);  
			  }
         
     		
        
    }
  
    //   <apex:image value="/servlet/servlet.FileDownload?file={!cm.attach.Id}" rendered="{!cm.isImage}"  height="30px" width="30px" /> 
    //         <apex:image value="{!$Resource.Jitendrasingh}" height="30px" width="30px" rendered="{!!cm.isImage}" />
}