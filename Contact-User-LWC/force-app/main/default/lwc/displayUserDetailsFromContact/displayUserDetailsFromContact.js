import { LightningElement, api, wire } from 'lwc';
import { getFieldValue, getRecord } from 'lightning/uiRecordApi';
import findUserFromEmail from '@salesforce/apex/UserRecordFromEmail.findUserFromEmail';
import Email from '@salesforce/schema/Contact.Email';

export default class DisplayUserDetailsFromContact extends LightningElement {
    // Retrieves the Id of the record that this LWC is placed on
    @api recordId;
    emailValue;
    userWrapper;

    // Retrieve the String saved within the Email field
    @wire(getRecord, {
        recordId: "$recordId",
        fields: [Email]
    })
    wiredRecord({error, data}) {
        if (data) {
            this.emailValue = getFieldValue(data, Email);
            console.log('Email value: ' + this.emailValue)
        } else if(error) {
            console.error(error);
        }
    }

    // Retrieves an instance of the wrapper class, which contains the User data that was found via matching Email
    @wire(findUserFromEmail, {
        email: "$emailValue"
    })
    wiredUser({error, data}) {
        if (data) {
            this.userWrapper = data;
            console.log('The User within the userWrapper: ' + this.userWrapper.user)
        } else if(error) {
            console.error(error);
        }
    }
}