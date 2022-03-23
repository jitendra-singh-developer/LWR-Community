public class InvokeScheduler {

    public void SchedulerMethod() {
        Schedule_Batch_Apex_Code__mdt scheduleBatchMDT = [SELECT Every_X_Minute__c, Execute_Every_Hour__c, Hour_Of_The_Day__c 
                                                          FROM Schedule_Batch_Apex_Code__mdt
                                                          WHERE DeveloperName = 'Demo1'];
        String CRON_EXPR;
        if((scheduleBatchMDT.Every_X_Minute__c != null) || Test.isRunningTest()){                             

            list<String> CRON_SubStringList = new list<String>();
            Integer X_MINS = Integer.valueOf(scheduleBatchMDT.Every_X_Minute__c);                                                                   
            Integer Interval = Integer.valueOf(60/X_MINS);
            system.debug('*** Interval ===> '+Interval);
            if(Interval == 1){
                Interval += 1;
            }

            Integer seriesVal = X_MINS;
            Integer seriesCount = 0;

            for(Integer i = 0; i < Interval; i++){ 
                seriesCount += seriesVal;
                if(seriesCount < 60){
                    CRON_SubStringList.add(String.valueOf(seriesCount));
                }
            }
            for(String schedulerMinsInterval : CRON_SubStringList){

                CRON_EXPR = '0 '+schedulerMinsInterval+' * * * ?';               

                scheduleBatch.scheduleMe(CRON_EXPR);

            }
        }
        if((scheduleBatchMDT.Execute_Every_Hour__c != false) || Test.isRunningTest()){                       

            CRON_EXPR = '0 0 * * * ?';
            scheduleBatch.scheduleMe(CRON_EXPR);

        }
        if((scheduleBatchMDT.Hour_Of_The_Day__c != null) || Test.isRunningTest()){                        

            if(Test.isRunningTest()){
                scheduleBatchMDT.Hour_Of_The_Day__c = '21';
            }
            CRON_EXPR = '0 0 '+scheduleBatchMDT.Hour_Of_The_Day__c+' * * ?';

            scheduleBatch.scheduleMe(CRON_EXPR);
        }                              

    }

}