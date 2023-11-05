@isTest
public class UserWrapperTest {

    @IsTest
    static void wrapperClassInitialisedAsExpected() {
        String testFirstName = 'Test First Name';
        
        User testUser = new User(FirstName = testFirstName);
        UserWrapper testWrapper = new UserWrapper(testUser);

        System.assertEquals(testFirstName, testWrapper.user.FirstName, 'UserWrapper has not been correctly initialised');
    }
}
