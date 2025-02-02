trigger UserTrigger on User (after update) {

//    System.debug('Trigger fired.');

    for (User u : trigger.new){

//        System.debug(u.UserRoleId);

        if (u.IsActive)
            UserTriggerHandler.usersAddedToRole(u);
    }

    for (User u : trigger.old){
        if (u.IsActive){
            UserTriggerHandler.usersRemovedFromRole(u);
        }
    }

}