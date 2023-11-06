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

Commit 3 - Created front end/LWC -
    The focal point of this commit is creating a functional LWC that satisfies the minimum requirements. To do this I also had to make some edits to the Apex classes, which are detailed below.
    Regarding design choices -
        Opted to add the if:false for the userWrapper being passed into the HTML to prevent any errors from being produced while the wire methods were retrieving the relevant data. This solution functions currently but once complexity of the solution grows I'll likely to opt to change the parameter of the if:false to a boolean variable stored within the userWrapper. This boolean variable would be assigned based on the results of the SOQL query within the UserRecordFromEmailClass.
        Used the {error, data} format to ensure any errors are recorded to aid in development. In the future the error path will be developed further so that the system is able to handle any errors appropriately.
        No delay was required for the second @wire method as this will fire after the first.
        Using wire methods means that the LWC can dynamically update. So that if the data within the Email field is updated to match a different User, the LWC will reflect this.
        I understand Jest could have been used to test the Javascript within the LWC, I opted not to do this due to both time constraints & the lack of complexity within the Javascript.
        Currently the LWC will only function as intended when used on record pages with a field named 'Email'. In the future I would opt to enable an administrator to input the Name of whichever field contains the Email string on the record page edit screen. This would be possible by adding a '@api' decorated variable to the Javascript file & adding a target config and property details to the meta.xml file. This variable could then be used in place of the occurences of 'Email' in the Javascript file.
            To prevent this LWC from being used where it would not be functional e.g. on a screen Flow the only target on the meta.xml file is 'lightning__RecordPage'.
        Upon testing I found that I needed to ensure that the methods and variables within the Apex classes that were made prior are Aura Enabled. So this update was also made as part of this commit.

Commit 4 - Added component visibility -
    Ensured that only Users with the Profile of System Administrator could view the component by adding component visibility to the Contact record page. 
    Regarding design choices -
        If there were multiple aspects of the page that should only be visible to Sys admins then I could've created a new page layout & assign it to Sys admins only. But since there isn't I've opted not to, to avoid unnecessary complexity. 
        
Commit 5 - Added additional fields to be displayed in component -
    Added additional fields to the HTML & the SOQL query within the UserRecordFromEmails class.
    Regarding design choices -
        I added Username as this is a field which is not displayed in the Standard Contact record page.
        Further fields could be added via adding them to both the HTMl and SOQL query.
        A future enhancement to this functionality would be enabling the configuration of which fields are displayed within the component in the edit record page. This could be done by using another '@api' decorated variable to the Javascript, similar to how it was mentioend earlier. Another benefit of doing this is that it would remove duplication between the Apex class & HTML.

Commit 6 - Added backed functionality to handle if the email field is blank & refactored the backend -
    Added a boolean variable 'blankEmail' to the wrapper class, this is set when the findUserFromEmail function is called. In future work, this variable will be used to add conditional visibilty to the HTML class, using if:true functionality. If true a message would be displayed to the user, informing them that the Email field is empty, so a User cannot be found.
    I then chose to partially refactor the backend to increase the readability of my code and reduce some feature envy that had began to appear in the UserRecordFromEmail class.
    Regarding design choices -
        I chose to add this functionality to the backend rather than the frontend as it allowed me to prevent SOQL queries running without a need. I'm aware this could have also been done by refactoring the method in the class further so that a different method would be called in the Javascript if the Email field was blank, however due to the time constraint I opted to not do this. 

Future Updates - Here I'll describe updates I'll be making to the codebase in the future -
    Added front end functionality to display to the user if the Email field on the Contact record is blank, this change is described in further detail in the description of Commit 6.
    Added functionality for if more than one User exists with the same email. To make my code more robust I've added a 'LIMIT 1' to the SOQL query to ensure that the component still functions as intended until this update is made. To make this update I would convert the UserWrapper in the UserRecordFromEmail class to a list. This would allow me to then run a SOQL query on multiple User records, which could then be put into a Map variable. Each record in this Map could then be ran through a for loop to add their relevant data to the User Wrapper List. Each of these User details could then be displayed in the HTML by introducing a for:each loop which would generate a display for each User.
    Add configurability within the edit record page. This has been described in Commit 3. The goal of doing this would be to increase the reusability & flexibility of the component, which in turn would decrease the need to duplicate & hard code multiple variations of this component.
