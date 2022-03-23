global class ProjectDeploymentSchedular implements Schedulable {
   global void execute(SchedulableContext sc) {
      ProjectDeploymentController projectDeploymentObject = new ProjectDeploymentController(); 
      database.executebatch(projectDeploymentObject);
   }
}