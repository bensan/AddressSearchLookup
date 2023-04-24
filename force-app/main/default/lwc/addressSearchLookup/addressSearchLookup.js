import { LightningElement } from 'lwc';

export default class AddressSearchLookup extends LightningElement {
    handleAddressSearch(event) {
        const addressSearchEvent = new CustomEvent('addresssearch', {
            detail: event.detail
        });
        this.dispatchEvent(addressSearchEvent);
    }
}