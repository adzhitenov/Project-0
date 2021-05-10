trigger ClientOrderTrigger on Client_Order__c (before delete) {
    //Prevent deletion of unhandled and unexpired Client_Order__c records

    for (Client_Order__c order : trigger.old){
        if ((order.Handled__c != true) && (order.Date_Due__c > Date.today())){
            order.addError('Cannot delete unhandled and unexpired Client Order records.');
//            System.debug('Trigger fire.');
        }
    }

}