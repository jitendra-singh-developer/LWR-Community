public class ContactDomUpgradeController {
    
    public List<StudentModel> studentModels {get;set;}  
    public List<StudentModel> checkedList ;
    
    public List<Student__c> studentList {get;set;}
    public ContactDomUpgradeController()
    {
        Integer i=0;
        studentModels = new List<StudentModel>();
        checkedList = new List<StudentModel>();
        studentList = [Select Id, First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c,Married__c,WifeName__c,Husband_Name__c From Student__c];
      // studentModels = new List<Student__c>();
       // [Select Id, First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c,Married__c,WifeName__c,Husband_Name__c From Student__c];
       for(Student__c con : studentList )
       {
         
           StudentModel cm = new StudentModel();
           cm.con = con;
           cm.srNo = ++i;
           cm.ischecked = false;
           studentModels.add(cm);
         
	   }
    }
    
    public Class StudentModel
    {
        public Boolean ischecked {get;set;}
        public Integer srNo {get;set;}
        public Student__c con {get;set;}
    }
    
    public PageReference save()
    {

        for(StudentModel sm : studentModels)
        {
            if(sm.ischecked)
            {
                upsert sm.con;
			}
		}
        PageReference pg = new PageReference('/apex/StudentDomUpgrade');
        pg.setRedirect(True);
        return pg;
     
	}
    
    public void addRow()
    {
        checkedList.add(new StudentModel());
    }
    
    
    
    
    
    
    
    
    
    
}