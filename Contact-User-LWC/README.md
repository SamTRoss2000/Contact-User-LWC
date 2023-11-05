This repository contains a solution to a coding challenge that satisfies three requirements:

Requirement 1 Develop a LWC that will be placed on a Contact record page. Run an apex method that gets the user record information based on the email address of the Contact. The apex method should return a wrapper class object back to the LWC. The LWC will display the user information if found, alternatively will display appropriate messages if a user is not found or if the Contact record does not have an email address.

Requirement 2 Write a test class for the apex class written in requirement 1.

Requirement 3 Control visibility of the component to only allow users with a “System Administrator” profile to have visibility.

The remainder of this README will contain documentation on the solution design with justification of why certain design choices have been made.

Commit 1 - Created UserWrapper class & associated test class -
    I decided to create the backend/Apex of the solution first due to the simplicity of the data that the frontend/LWC will require to be passed to it (& a personal preference of inside-out TDD). 
    This first commit contains the wrapper class, which itself contains a constructor with a User parameter. I have chosen to use the User object as a parameter rather than the fields that will be shown in the LWC as this allows more flexibility of which fields are accessible for the LWC. This will also remove potential duplication with the fields that will be selected in a future SOQL query.

Commit 2 - Created UserRecordFromEmail class & associated test class -
    This commit contains the apex class responsible for retrieving details of the User record & returning this information within the wrapper class that was created in the prior commit. 
    Regarding design choices - 
        The SOQL query within the UserRecordFromEmail class currently only selects for FirstName, I chose to do this as this is a minimum requirement for testing the behaviour of retrieving the User record. Also attempting to include more fields within the query would increase the chances of excess data being retrieved further down the line, while also developing logic which does not necessarily contribute to the final solution. 
        Although I could work on making this class more robust now, I'm opting to not do this until the minimum working solution has been completed. As I would not be able to cover every edge case / scenario that this code could be subject to, due to the time constraint of the challenge. The primary reason I'm opting to complete the minium working solution first is that this will highlight which scenarios pose the largest risk to the solution. With this clarity I will be able to more effectively prioritise solutions which mitigate the largest risks. 