@isTest
private class ClientOrderTriggerTest {

    /*
    @TestSetup
    private static void createData(){
        Client_Order__c test1 = new Client_Order__c(Handled__c = false,
                                                    Date_Due__c = Date.Today()+7);
        Client_Order__c test2 = new Client_Order__c(Handled__c = true,
                                                    Date_Due__c = Date.Today()+7);
        Client_Order__c test3 = new Client_Order__c(Handled__c = true,
                                                    Date_Due__c = Date.Today()-7);
        Client_Order__c test4 = new Client_Order__c(Handled__c = false,
                                                    Date_Due__c = Date.Today()-7);


        List<Client_Order__c> testData1 = new List<Client_Order__c>();
        List<Client_Order__c> testData2 = new List<Client_Order__c>();
        List<Client_Order__c> testData3 = new List<Client_Order__c>();
        List<Client_Order__c> testData4 = new List<Client_Order__c>();

        for (integer iii=0; iii<300; ++iii){

            Client_Order__c testOrder1 = new Client_Order__c(Handled__c = false,
            Date_Due__c = Date.Today()+7);
            testData1.add(testOrder1);

            Client_Order__c testOrder2 = new Client_Order__c(Handled__c = true,
            Date_Due__c = Date.Today()+7);
            testData2.add(testOrder2);

            Client_Order__c testOrder3 = new Client_Order__c(Handled__c = true,
            Date_Due__c = Date.Today()-7);
            testData3.add(testOrder3);

            Client_Order__c testOrder4 = new Client_Order__c(Handled__c = false,
            Date_Due__c = Date.Today()-7);
            testData4.add(testOrder4);
        }

        insert test1;
        insert test2;
        insert test3;
        insert test4;

        insert testOrder1;
        insert testOrder2;
        insert testOrder3;
        insert testOrder4;
    }
    */

    @isTest
    private static void ClientOrderTriggerTest_Unhandled_Unexpired() {

        //Single record test, deletion should NOT be possible

        System.debug('Start of first test method: ' + [SELECT Id FROM Client_Order__c].size());
    
        Client_Order__c test1 = new Client_Order__c(Handled__c = false,
        Date_Due__c = Date.Today()+7);
        insert test1;
        System.assert([SELECT Id FROM Client_Order__c].size() == 1);

        
        try{
            delete test1;
        }
        catch (DmlException e){
        }
        
        System.debug('Part 1 of first test method: ' + [SELECT Id FROM Client_Order__c].size());
        
        System.assert([SELECT Id FROM Client_Order__c].size() != 0);

        //Bulk records test, deletion should NOT be possible

        List<Client_Order__c> bulkTestData1 = new List<Client_Order__c>();

        for (integer iii=0; iii<300; ++iii){

            Client_Order__c testOrder1 = new Client_Order__c(Handled__c = false,
            Date_Due__c = Date.Today()+7);
            bulkTestData1.add(testOrder1);
        }

        insert bulkTestData1;

        for (List<Client_Order__c> testList : [SELECT Id FROM Client_Order__c]){
            try{
                delete testList;
            }
            catch (DmlException e){

            }
        }

        System.assert([SELECT Id FROM Client_Order__c].size() != 0);

    }

    @isTest
    private static void ClientOrderTriggerTest_Handled_Unexpired() {

        //Single record test, deletion should be possible

        System.debug('Start of second test method: ' + [SELECT Id FROM Client_Order__c].size());

        Client_Order__c test2 = new Client_Order__c(Handled__c = true,
        Date_Due__c = Date.Today()+7);
        insert test2;
        System.assert([SELECT Id FROM Client_Order__c].size() == 1);

        try{
            delete test2;
        }
        catch (DmlException e){
            System.debug('DML exception raised in first test method.');
        }

        System.assert([SELECT Id FROM Client_Order__c].size() == 0);

        //Bulk records test, deletion should be possible

        List<Client_Order__c> bulkTestData2 = new List<Client_Order__c>();

        for (integer iii=0; iii<300; ++iii){

            Client_Order__c testOrder2 = new Client_Order__c(Handled__c = true,
            Date_Due__c = Date.Today()+7);
            bulkTestData2.add(testOrder2);
        }

        insert bulkTestData2;

        for (List<Client_Order__c> testList : [SELECT Id FROM Client_Order__c]){
            try{
                delete testList;
            }
            catch (DmlException e){
                System.debug('DML exception raised in second test method.');
            }
        }

        System.assert([SELECT Id FROM Client_Order__c].size() == 0);

    }

    @isTest
    private static void ClientOrderTriggerTest_Handled_Expired() {

        //Single records test, should be deleted

        Client_Order__c test3 = new Client_Order__c(Handled__c = true,
        Date_Due__c = Date.Today()-7, TEST__c = true);
        insert test3;
        System.assert([SELECT Id FROM Client_Order__c].size() == 1);

        try{
            delete test3;
        }
        catch (DmlException e){
            System.debug('DML exception raised in first test method.');
        }

        System.assert([SELECT Id FROM Client_Order__c].size() == 0);

        //Bulk records test, should be deleted

        List<Client_Order__c> bulkTestData3 = new List<Client_Order__c>();

        for (integer iii=0; iii<300; ++iii){

            Client_Order__c testOrder3 = new Client_Order__c(Handled__c = true,
            Date_Due__c = Date.Today()-7, TEST__c = true);
            bulkTestData3.add(testOrder3);
        }

        insert bulkTestData3;

        for (List<Client_Order__c> testList : [SELECT Id FROM Client_Order__c]){
            try{
                delete testList;
            }
            catch (DmlException e){
                System.debug('DML exception raised in second test method.');
            }
        }

        System.assert([SELECT Id FROM Client_Order__c].size() == 0);

    }

    @isTest
    private static void ClientOrderTriggerTest_Unhandled_Expired() {

        //Single record test, should be deleted

        Client_Order__c test4 = new Client_Order__c(Handled__c = false,
        Date_Due__c = Date.Today()-7, TEST__c = true);
        insert test4;
        System.assert([SELECT Id FROM Client_Order__c].size() == 1);

        try{
            delete test4;
        }
        catch (DmlException e){
            System.debug('DML exception raised in first test method.');
        }

        System.debug('Start of first test method: ' + [SELECT Id FROM Client_Order__c].size());
        System.assert([SELECT Id FROM Client_Order__c].size() == 0);

        //Bulk records test, should be deleted

        List<Client_Order__c> bulkTestData4 = new List<Client_Order__c>();

        for (integer iii=0; iii<300; ++iii){

            Client_Order__c testOrder4 = new Client_Order__c(Handled__c = false,
            Date_Due__c = Date.Today()-7, TEST__c = true);
            bulkTestData4.add(testOrder4);
        }

        insert bulkTestData4;

        for (List<Client_Order__c> testList : [SELECT Id FROM Client_Order__c]){
            try{
                delete testList;
            }
            catch (DmlException e){
                System.debug('DML exception raised in second test method.');
            }
        }

        System.assert([SELECT Id FROM Client_Order__c].size() == 0);

    }

}
