public class UserWrapper {

    @AuraEnabled public User user;

    public UserWrapper(User user) {
        this.user = user;
    }
}