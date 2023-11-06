public class UserWrapper {

    @AuraEnabled public User user;
    @AuraEnabled public Boolean blankEmail;

    public UserWrapper(User user) {
        this.user = user;
    }

    public void blankEmailCheck(String email) {
        if(String.isEmpty(email)) {
            this.blankEmail = true;
            } else {
                this.blankEmail = false;
            }
    }
}