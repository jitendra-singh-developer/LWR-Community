trigger AccountTriggerNew on Account (after insert) {
    
    if(Trigger.isInsert && Trigger.isAfter){
        List<OPportunity> oppList = new List<Opportunity>();
        for(Account acc : trigger.new){
                Opportunity objectObj  = new Opportunity();
        objectObj.StageName = 'Draft';
        objectObj.AccountId = acc.ID;
            oppList.add(objectObj);
        }
        if(oppList.size() > 0){
        insert oppList;
    }
    }
    
}