public class ScheduleBatchJobController {
    
    public Integer hours {get;set;}
    public Integer minutes {get;set;}
  
   
    
    public List<SelectOption> getperiodHours()
    {
        List<SelectOption> options = new List<SelectOption>();
  
        options.add(new SelectOption('--None--','--None--'));
        for(Integer index = 0;index<24;index++){
             options.add(new SelectOption(String.valueOf(index),String.valueOf(index)));
        }        
        return options;
    }

    
 
    public List<SelectOption> getPeriodMinutes()
    {
        List<SelectOption> options = new List<SelectOption>();
  
        options.add(new SelectOption('--None--','--None--'));
        for(Integer index=0;index<60;index++){
            System.debug('index'+index);
			 options.add(new SelectOption(String.valueOf(index),String.valueOf(index)));            
       }
        
        return options;
    }
    
    
    public void scheduleBatchJob(){
    
        System.debug('hours'+ minutes);
        System.debug('hours'+ hours);
        String message ;
        List<CronTrigger> cronList = new List<Crontrigger>();
        List<CronJobDetail> cronJobList = new List<CronJobDetail>();
        cronJobList = [Select Id,Name From CronJobDetail Where Name = 'Ticket Batch Job'];
        
        if(cronJobList.size() > 0){
            cronList = [select Id from CronTrigger where CronJobDetailId = : cronJobList[0].Id];   
        }
        
        if(cronJobList.size() == 0 ){
            //   TicketReviewRecodErrorBatchSchedular tickedRecordSchedulerobj = new TicketReviewRecodErrorBatchSchedular();
            String cronExpression = '0 '+minutes+' */'+hours+' ? * *';
            //   String jobId = System.schedule('Ticket Batch Job',cronExpression,tickedRecordSchedulerobj);
            //	message = jobId; 
        }else{
            System.abortJob(cronList[0].Id);
            // TicketReviewRecodErrorBatchSchedular tickedRecordSchedulerobj = new TicketReviewRecodErrorBatchSchedular();
            String cronExpression = '0 '+minutes+' */'+hours+' ? * *';
            // String jobId = System.schedule('Ticket Batch Job',cronExpression,tickedRecordSchedulerobj);
            //            message = jobId;
            
        }
        if(message != null){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Batch Scheduled Successfully For Every '+hours+' Hours and '+minutes+' Minutes'));  
        }else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Batch Not Scheduled'));
        }
    }
    
}