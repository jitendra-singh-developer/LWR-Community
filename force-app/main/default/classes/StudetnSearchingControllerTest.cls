@isTest
public class StudetnSearchingControllerTest {
	
    @isTest
    static void firstMethod(){
        StudetnSearchingController ssc = new StudetnSearchingController();
         Student__c stu =  new Student__c(First_Name__c ='jitendra',Last_Name__c='singh',Class__c='a045g000000umeBAAQ');
          insert stu;
         
       
       ssc.students = [select First_Name__c from Student__c];
         
         ssc.mySave();
         ssc.mySearch();
       
       
      
       
       
    }
    
   
}