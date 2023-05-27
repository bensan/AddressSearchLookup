import { LightningElement, wire, api } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import lookupAddress from '@salesforce/apex/GMapsAddressLookup.lookupAddress';


export default class AddressSearchLookup extends LightningElement {
    @api recordId;  // This gets the record ID when the controller is used on a record page

    standardAddress = '';
    showStandardAddress = false;
    addressLines = [];
    
    // This method is called when the user selects an address from the lookup
    handleAddressSearch(event) {
        const address = this.template.querySelector('lightning-input-address');
        // output all the event target values here
        let addressLines = [address.street, address.city, address.province, address.postalCode, address.country];
        this.addressLines = addressLines;
    }

    @wire(lookupAddress, {addressLines: '$addressLines'})
    wiredAddress({error, data}) {
        if(data){
            console.log('data', data.firstAddressLine);
            this.showStandardAddress = true;
            this.standardAddress = data;
            this.updateRecordWithApiResponse(data);
            this.error = undefined;
        } else if(error) {
            this.error = error;
            this.standardAddress = undefined;
            this.showStandardAddress = false;
        }
    }

    updateRecordWithApiResponse(apiResponse) {
        const fields = {};

        fields['Id'] = this.recordId;
        fields['Shipping_Address__c'] = apiResponse.firstAddressLine;
        fields['Shipping_City__c'] = apiResponse.city;
        fields['Shipping_State__c'] = apiResponse.state;
        fields['Shipping_Postal_Code__c'] = apiResponse.zip + '-' + apiResponse.zipCodeExtension;
        fields['Shipping_Country__c'] = 'US';

        const recordInput = { fields: fields };
        updateRecord(recordInput)
            .then((record) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Shipping Location Updated Successfully for ' + record.fields.Name.value,
                        variant: 'success'
                    })
                );
            })
            .catch(error => {
                console.log('error', error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error updating record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }
}