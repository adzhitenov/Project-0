trigger RouteTrigger on Route__c (after insert) {

    if (trigger.isAfter){
        List<Stop__c> stopsToAdd = new List<Stop__c>();
        for (Route__c newRoute : trigger.new){
            stopsToAdd.addAll(RouteTriggerHandler.addStopsToRoute(newRoute));
        }
        insert stopsToAdd;
    }
}