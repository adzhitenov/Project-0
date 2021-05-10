trigger UserTrigger on User (after update) {

    System.debug('Trigger fired.');

    for (User u : trigger.new){

        System.debug(u.UserRoleId);

        if (u.IsActive){

            if (u.UserRoleId == [SELECT Id FROM UserRole WHERE Name = 'Accountant'].Id){

                System.debug('Trigger fired!');
                PermissionSetAssignment psa = new PermissionSetAssignment(
                PermissionSetId = [SELECT Id FROM PermissionSet WHERE Name = 'Accounting_Standard' LIMIT 1].Id,
                AssigneeId = u.Id);
                insert psa;
            }

            else if (u.UserRoleId == [SELECT Id FROM UserRole WHERE Name = 'Accounting Admin'].Id){
                System.debug('Trigger fired!');
                PermissionSetAssignment psa = new PermissionSetAssignment(
                PermissionSetId = [SELECT Id FROM PermissionSet WHERE Name = 'Accounting_Admin' LIMIT 1].Id,
                AssigneeId = u.Id);
                insert psa;
            }

            else if (u.UserRoleId == [SELECT Id FROM UserRole WHERE Name = 'Mechanic'].Id){
                System.debug('Trigger fired!');
                PermissionSetAssignment psa = new PermissionSetAssignment(
                PermissionSetId = [SELECT Id FROM PermissionSet WHERE Name = 'Mechanic' LIMIT 1].Id,
                AssigneeId = u.Id);
                insert psa;
            }

        }
    }

    for (User u : trigger.old){
        if (u.IsActive){
            if (u.UserRoleId == [SELECT Id FROM UserRole WHERE Name = 'Accountant'].Id){
                PermissionSetAssignment psa = [SELECT AssigneeId, PermissionSet.Name FROM PermissionSetAssignment 
                WHERE AssigneeId = :u.Id AND PermissionSet.Name = 'Accounting_Standard'];
                delete psa;
            }
            if (u.UserRoleId == [SELECT Id FROM UserRole WHERE Name = 'Accounting Admin'].Id){
                PermissionSetAssignment psa = [SELECT AssigneeId, PermissionSet.Name FROM PermissionSetAssignment 
                WHERE AssigneeId = :u.Id AND PermissionSet.Name = 'Accounting_Admin'];
                delete psa;
            }
            if (u.UserRoleId == [SELECT Id FROM UserRole WHERE Name = 'Mechanic'].Id){
                PermissionSetAssignment psa = [SELECT AssigneeId, PermissionSet.Name FROM PermissionSetAssignment 
                WHERE AssigneeId = :u.Id AND PermissionSet.Name = 'Mechanic'];
                delete psa;
            }
        }
    }

}