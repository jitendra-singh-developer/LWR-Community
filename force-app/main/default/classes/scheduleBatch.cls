global class scheduleBatch implements Schedulable {             

    global static void scheduleMe(String CRON_EXPR) {

        System.schedule(' Schedule Job – '+String.valueOf(Math.abs(Crypto.getRandomLong())).substring(0, 5), CRON_EXPR, new scheduledBatchable());

    }

    global void execute(SchedulableContext sc) {

       PrintNameController obj = new PrintNameController();   

    }    

}