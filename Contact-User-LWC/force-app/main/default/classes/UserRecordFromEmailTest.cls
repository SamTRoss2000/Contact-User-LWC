@IsTest
public class UserRecordFromEmailTest {
    
    @IsTest
    static void userRecordCanBeFoundUsingEmail() {
        // Create test data
        String testFirstName = 'Test First Name';
        String testUserEmail = 'test@test.com';
        Profile profile = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User testUser = new User(FirstName = testFirstName, LastName = 'Test Last Name', Username = 'TestUser@codingchallenge.sandbox', Alias = 'tuser',  
            Email = testUserEmail, EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = profile.Id, TimeZoneSidKey='America/Los_Angeles');
        insert testUser;

        UserWrapper foundUser = UserRecordFromEmail.findUserFromEmail(testUserEmail);

        System.assertEquals(testFirstName, foundUser.user.FirstName, 'The User has not been found via email');
    }
}
