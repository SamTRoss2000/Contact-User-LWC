public class UserRecordFromEmail {
    
    @AuraEnabled(cacheable = true)
    public static UserWrapper findUserFromEmail(String email){

        User user = [SELECT FirstName, LastName, Username FROM User WHERE Email =: email];

        return new UserWrapper(user);
    } 
}