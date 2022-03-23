public class StudentDomController {
    
    public List<Student__c> students{get;set;}
    public List<Student__c> deleted {get;set;}
    public List<Student__c> selectedList {get;set;}
    public List<Student__c> addList ;
    boolean test ;
    public Student__c st;
    
    String a = 'You must have to save first ....!!!';
    
    // List<Studnet__c> deletedStudents; //studentsDeleted studentsDeletedList
    public StudentDomController()
    {
        deleted = new List<Student__c>();
        selectedList = new List<Student__c>();
        addList = new List<Student__c>();
        st = new Student__c();
        students = [Select Id, First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c,Married__c,WifeName__c,Husband_Name__c From Student__c];
    }
    public PageReference save()
    {
        
        if(st.Class__c != null && st.First_Name__c != '' && st.First_Name__c != null)
        {
            insert st;
        }
        if(!(deleted.isEmpty()) && deleted != null)
        {
            delete deleted;
            
        }
        try
        {
            
            //students = [Select Id, First_Name__c , Last_Name__c, Date_of_Birth__c,Email__c,HaveWahicle__c,Sex__c,Class__c,Married__c,WifeName__c,Husband_Name__c From Student__c];
            for(Student__c cn : students)
            {
                String cid = ApexPages.currentPage().getParameters().get(cn.Id); 
                System.debug('###'+ cid);
                if(cid != null)
                {
                    selectedList.add(cn) ; 
                }
            }
            
            
            
            upsert selectedList;
        }
        catch(Exception e)
        {
            Apexpages.addMessages(e);        
        }
        
        PageReference pg = new PageReference('/apex/StudentDom');
        pg.setRedirect(True);
        return pg;
    }
    public void addRow()
    {
        st = new Student__c(Last_Name__c = 'Puri' , Class__c = 'a045g000000umeBAAQ');
        students.add(st); 
        
        
        
        
    }
    
    public void removeRow()
    {
        if(st.Last_Name__c != null)
        { 
            insert st;
            
            students.remove(students.size()-1); 
            
            st.Last_Name__c = '';
            delete st;
        }
        else
        {
            deleted.add(students.remove(students.size()-1));
            upsert students;
        }
        //deleted.add(students.get(students.size()-1));  
        //students.remove(students.size()-1);    
    }
    public void clearList()
    {
        //delete students;
        
        
    }
}