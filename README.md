AddressSearchLookup Lightning Web Component
The AddressSearchLookup component is a reusable Salesforce Lightning Web Component (LWC) that allows users to search and look up addresses using the Google Places API. It provides a search input field with autocomplete suggestions based on the user's query.

Features
Address search input field with autocomplete.
Utilizes Google Places API for address suggestions.
Display suggestions in a dropdown list.
Select address from dropdown list to populate the input field.
Dependencies
Google Maps JavaScript API: Must be loaded in your Salesforce org.
Google Places API: API key is required.
Installation
Clone the repository to your local machine.

bash
Copy code
git clone https://github.com/bensan/AddressSearchLookup.git
Deploy the components to your Salesforce org using Salesforce CLI or any other preferred deployment method.

Add the AddressSearchLookup component to your Lightning App or Lightning Page by including the custom tag:

html
Copy code
<c-address-search-lookup></c-address-search-lookup>
Customization
To customize the component, you can modify the source code of the AddressSearchLookup component. This includes editing the HTML, JavaScript, and CSS files as needed.

JavaScript
addressSearchLookup.js: Contains the main functionality of the component, including initializing the Google Places API, handling user input, and displaying address suggestions.
HTML
addressSearchLookup.html: Contains the structure and layout of the component, including the search input field and the dropdown list for address suggestions.
CSS
addressSearchLookup.css: Contains the styles for the component, including the appearance of the search input field and the dropdown list for address suggestions.