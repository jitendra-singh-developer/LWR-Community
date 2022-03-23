/*
    Name        : ProjectSchedular
    Date        : 9 Feb, 2021
    Author      : Jitendra Singh
    Description : This is Schedular class used to schedule ProjectDeloymentBetch class  .


*/
public class ProjectSchedular implements Schedulable {
   public void execute(SchedulableContext sc) {
      ProjectDeploymentBetch projectDeploymentObject = new ProjectDeploymentBetch(); 
      database.executebatch(projectDeploymentObject);
   }
}