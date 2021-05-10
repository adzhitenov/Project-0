trigger RouteTrigger on Route__c (after insert) {
    
    if (trigger.isAfter){
        for (Route__c newRoute : trigger.new){

            List <Stop__c> stopsToAdd = new List<Stop__c>();

            for (integer iii=1; iii<=newRoute.Number_of_Stops__c; ++iii){
                String stopName = newRoute.Name + ' Stop ' + iii;
                Stop__c newStop = new Stop__c(Name = stopName, Route_del__c = newRoute.Id, Stop_Number__c = iii);
                stopsToAdd.add(newStop);
            }
            insert stopsToAdd;
        }

    }
}