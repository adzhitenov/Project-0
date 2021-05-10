public class RouteTriggerHelper {

    public static void addStopsToRoute(Route__c newRoute) {

        List <Stop__c> stopsToAdd = new List<Stop__c>();

        for (integer iii=1; iii<=newRoute.Number_of_Stops__c; ++iii){
            String stopName = newRoute.Name + ' Stop ' + iii;
            Stop__c newStop = new Stop__c(Name = stopName, Route_del__c = newRoute.Id, Stop_Number__c = iii);
            stopsToAdd.add(newStop);
        }
        insert stopsToAdd;
    }
}
