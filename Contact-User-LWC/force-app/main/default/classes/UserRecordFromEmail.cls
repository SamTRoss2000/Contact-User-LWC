public class UserRecordFromEmail {
    
    @AuraEnabled(cacheable = true)
    public static UserWrapper findUserFromEmail(String email){

        Userwrapper userWrapper = new UserWrapper(null); // This constructor will need removing / reworking

        userWrapper.blankEmailCheck(email);
        
        if (!String.isEmpty(email)) {   
            User user = [SELECT FirstName, LastName, Username FROM User WHERE Email =: email];
            userWrapper.user = user;
        }

        return userWrapper;
    } 
}