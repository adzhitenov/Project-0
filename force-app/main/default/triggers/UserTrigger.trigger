trigger UserTrigger on User (after update) {

    System.debug('Trigger fired.');

    for (User u : trigger.new){

        System.debug(u.UserRoleId);

        if (u.IsActive){

            switch on (u.UserRoleId){
                when [SELECT Id FROM UserRole WHERE Name = 'Accountant'].Id{
                    System.debug('Trigger fired!');
                    PermissionSetAssignment psa = new PermissionSetAssignment(
                    PermissionSetId = [SELECT Id FROM PermissionSet WHERE Name = 'Accounting_Standard' LIMIT 1].Id,
                    AssigneeId = u.Id);
                    insert psa;
                }
                when [SELECT Id FROM UserRole WHERE Name = 'Accounting Admin'].Id{
                    System.debug('Trigger fired!');
                    PermissionSetAssignment psa = new PermissionSetAssignment(
                    PermissionSetId = [SELECT Id FROM PermissionSet WHERE Name = 'Accounting_Admin' LIMIT 1].Id,
                    AssigneeId = u.Id);
                    insert psa;
                }
                when [SELECT Id FROM UserRole WHERE Name = 'Mechanic'].Id{
                    System.debug('Trigger fired!');
                    PermissionSetAssignment psa = new PermissionSetAssignment(
                    PermissionSetId = [SELECT Id FROM PermissionSet WHERE Name = 'Mechanic' LIMIT 1].Id,
                    AssigneeId = u.Id);
                    insert psa;
                }
            }

        }
    }

}