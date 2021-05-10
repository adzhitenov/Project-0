trigger RouteTrigger on Route__c (after insert) {
    if (trigger.isAfter){
        List <Stop__c> stopsToAdd = new List<Stop__c>();
        for (Route__c newRoute : trigger.new){
            for (integer iii=1; iii<=newRoute.Number_of_Stops__c; ++iii){
                Stop__c newStop = new Stop__c(Route_del__c = newRoute.Id, Stop_Number__c = iii);
                stopsToAdd.add(newStop);
            }
            insert stopsToAdd;
        }

    }
}