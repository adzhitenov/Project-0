trigger ClientTeamTrigger on Client_Team__c (after insert, after update) {
// Ensure that each Client Team has a public group containing all of its members, which is
// also in the Client Order Handling queue

    if (Trigger.isInsert){
        for (Client_Team__c ClientTeam : trigger.new){
            ClientTeamTriggerHelper.updateQueue(ClientTeam);
        }
    }

}