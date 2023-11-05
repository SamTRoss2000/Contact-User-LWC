This repository contains a solution to a coding challenge that satisfies three requirements:

Requirement 1 Develop a LWC that will be placed on a Contact record page. Run an apex method that gets the user record information based on the email address of the Contact. The apex method should return a wrapper class object back to the LWC. The LWC will display the user information if found, alternatively will display appropriate messages if a user is not found or if the Contact record does not have an email address.

Requirement 2 Write a test class for the apex class written in requirement 1.

Requirement 3 Control visibility of the component to only allow users with a “System Administrator” profile to have visibility.

The remainder of this README will contain documentation on the solution design with justification of why certain design choices have been made.

Commit 1 - Created UserWrapper class & associated test class -
    I decided to create the backend/Apex of the solution first due to the simplicity of the data that the frontend/LWC will require to be passed to it (& a personal preference of inside-out TDD). 
    This first commit contains the wrapper class, which itself contains a constructor with a User parameter. I have chosen to use the User object as a parameter rather than the fields that will be shown in the LWC as this allows more flexibility of which fields are accessible for the LWC. This will also remove potential duplication with the fields that will be selected in a future SOQL query.