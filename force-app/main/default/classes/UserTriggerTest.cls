@isTest
private class UserTriggerTest {
    @TestSetup
    private static void setTestUserRole(){
        User testUser = [SELECT Id, LastName, UserRoleId FROM User WHERE LastName = 'UserTriggerTest' LIMIT 1];
        testUser.UserRoleId = NULL;
        update testUser;
    }
    @isTest
    private static void accountantPermissionsTest() {
        User testUser = [SELECT Id, LastName, UserRoleId FROM User 
                            WHERE LastName = 'UserTriggerTest'];
        testUser.UserRoleId = [SELECT Id FROM UserRole WHERE Name='Accountant' LIMIT 1].Id;
        update testUser;
        System.assert([SELECT AssigneeId, PermissionSet.Name FROM PermissionSetAssignment 
                        WHERE AssigneeId = :testUser.Id AND PermissionSet.Name = 'Accounting_Standard'].size() != 0);

        setTestUserRole();

        System.assert([SELECT AssigneeId, PermissionSet.Name FROM PermissionSetAssignment 
                        WHERE AssigneeId = :testUser.Id AND PermissionSet.Name = 'Accounting_Standard'].size() == 0);
    }
    @isTest
    private static void accountingAdminPermissionsTest() {
        User testUser = [SELECT Id, LastName, UserRoleId FROM User 
                            WHERE LastName = 'UserTriggerTest'];
        testUser.UserRoleId = [SELECT Id FROM UserRole WHERE Name='Accounting Admin' LIMIT 1].Id;
        update testUser;
        System.assert([SELECT AssigneeId, PermissionSet.Name FROM PermissionSetAssignment 
                        WHERE AssigneeId = :testUser.Id AND PermissionSet.Name = 'Accounting_Admin'].size() != 0);

        setTestUserRole();

        System.assert([SELECT AssigneeId, PermissionSet.Name FROM PermissionSetAssignment 
                        WHERE AssigneeId = :testUser.Id AND PermissionSet.Name = 'Accounting_Admin'].size() == 0);                
    }
    @isTest
    private static void mechanicPermissionsTest() {
        User testUser = [SELECT Id, LastName, UserRoleId FROM User 
                            WHERE LastName = 'UserTriggerTest'];
        testUser.UserRoleId = [SELECT Id FROM UserRole WHERE Name='Mechanic' LIMIT 1].Id;
        update testUser;
        System.assert([SELECT AssigneeId, PermissionSet.Name FROM PermissionSetAssignment 
                        WHERE AssigneeId = :testUser.Id AND PermissionSet.Name = 'Mechanic'].size() != 0);
        
        setTestUserRole();

        System.assert([SELECT AssigneeId, PermissionSet.Name FROM PermissionSetAssignment 
                                        WHERE AssigneeId = :testUser.Id AND PermissionSet.Name = 'Mechanic'].size() == 0);
    }
}
