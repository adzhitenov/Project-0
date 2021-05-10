trigger testtrigger on Train__c (before update) {

    System.debug(trigger.new);

}