@isTest
private class RouteTriggerTest {

    @isTest
    private static void singleTest(){

        Route__c newRoute = new Route__c(Name = 'Test Route 1', Number_of_Stops__c = 7);
        insert newRoute;

        List<Stop__c> stops = new List<Stop__c>();
        stops = [SELECT (SELECT Id FROM Stops_del__r) FROM Route__c WHERE Name = 'Test Route 1'].Stops_del__r;
        
        System.assert(stops.size() == newRoute.Number_of_Stops__c);
    }


    @isTest
    private static void zeroTest(){

        Route__c newRoute = new Route__c(Name = 'Test Route 1', Number_of_Stops__c = 0);
        insert newRoute;

        List<Stop__c> stops = new List<Stop__c>();
        stops = [SELECT (SELECT Id FROM Stops_del__r) FROM Route__c WHERE Name = 'Test Route 1'].Stops_del__r;
        
        System.assert(stops.size() == newRoute.Number_of_Stops__c);
    }


    @isTest
    private static void BulkTest() {

        List<Route__c> newRoutes = new List<Route__c>();

        Test.startTest();

        for (integer iii=0; iii<500; ++iii){
            Route__c r = new Route__c(Name = 'Test ' + iii, Number_of_Stops__c = iii/20);
            newRoutes.add(r);
        }

        insert newRoutes;

        Map<Route__c, List<Stop__c>> mapRouteStops = new Map<Route__c, List<Stop__c>>();

        newRoutes = [SELECT Number_of_Stops__c, (SELECT Id FROM Stops_del__r) FROM Route__c];

        for (Route__c r : newRoutes){
        
            List<Stop__c> stops = new List<Stop__c>();
            stops = r.Stops_del__r;

    //        stops = [SELECT (SELECT Id FROM Stops_del__r) FROM Route__c WHERE Id = :r.Id].Stops_del__r;
            System.assert(stops.size() == r.Number_of_Stops__c);
        }

        Test.stopTest();

    }
}
