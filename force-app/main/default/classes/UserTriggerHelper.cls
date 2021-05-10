public class UserTriggerHelper {

    public static void addPermissionSetToUser(User u, String permissionSetName){
//        System.debug('Trigger fired!');
        PermissionSetAssignment psa = new PermissionSetAssignment(
            PermissionSetId = [SELECT Id FROM PermissionSet WHERE Name = :permissionSetName LIMIT 1].Id,
            AssigneeId = u.Id);
        insert psa;
    }

    public static void removePermissionSetFromUser(User u, String permissionSetName){
        PermissionSetAssignment psa = [SELECT AssigneeId, PermissionSet.Name FROM PermissionSetAssignment 
            WHERE AssigneeId = :u.Id AND PermissionSet.Name = :permissionSetName];
        delete psa;
    }

    public static void usersAddedToRole(User u) {
        if (u.UserRoleId == [SELECT Id FROM UserRole WHERE Name = 'Accountant'].Id){
            addPermissionSetToUser(u, 'Accounting_Standard');
        }

        else if (u.UserRoleId == [SELECT Id FROM UserRole WHERE Name = 'Accounting Admin'].Id){
            addPermissionSetToUser(u, 'Accounting_Admin');
        }

        else if (u.UserRoleId == [SELECT Id FROM UserRole WHERE Name = 'Mechanic'].Id){
            addPermissionSetToUser(u, 'Mechanic');
        }

    }

    public static void usersRemovedFromRole(User u){
        if (u.UserRoleId == [SELECT Id FROM UserRole WHERE Name = 'Accountant'].Id){
            removePermissionSetFromUser(u, 'Accounting_Standard');
        }
        if (u.UserRoleId == [SELECT Id FROM UserRole WHERE Name = 'Accounting Admin'].Id){
            removePermissionSetFromUser(u, 'Accounting_Admin');
        }
        if (u.UserRoleId == [SELECT Id FROM UserRole WHERE Name = 'Mechanic'].Id){
            removePermissionSetFromUser(u, 'Mechanic');
        }
    }
}
