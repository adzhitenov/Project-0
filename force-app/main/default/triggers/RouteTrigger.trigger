trigger RouteTrigger on Route__c (after insert) {

    if (trigger.isAfter){
        for (Route__c newRoute : trigger.new){
            RouteTriggerHelper.addStopsToRoute(newRoute);
        }

    }
}