import { LightningElement, wire } from 'lwc';
import lookupAddress from '@salesforce/apex/GMapsAddressLookup.lookupAddress';

export default class AddressSearchLookup extends LightningElement {
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
            this.showStandardAddress = true;
            this.standardAddress = data;
            this.error = undefined;
        } else if(error) {
            this.error = error;
            this.standardAddress = undefined;
            this.showStandardAddress = false;
        }
    }
}