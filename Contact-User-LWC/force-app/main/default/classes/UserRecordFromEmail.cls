public class UserRecordFromEmail {
    

    public static UserWrapper findUserFromEmail(String email){

        User user = [SELECT FirstName FROM User WHERE Email =: email];

        return new UserWrapper(user);
    } 
}