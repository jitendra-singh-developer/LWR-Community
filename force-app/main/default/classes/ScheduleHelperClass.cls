public class ScheduleHelperClass{
    
    @InvocableMethod()
    public static void scheduleJobs() {
       	scheduledBatchable m = new scheduledBatchable();
		String sch = '0 0 * ? * *';
		String jobID = system.schedule('Merge Job', sch, m); 
        
    }
        
}