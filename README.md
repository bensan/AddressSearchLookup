# AddressSearchLookup

AddressSearchLookup is a Salesforce Lightning Web Component (LWC) that allows users to search and lookup address information using the Google Maps Places API. This component makes it easy to input accurate address information into your Salesforce instance, increasing data quality and reducing manual entry errors.

## Languages and Technologies

The project primarily uses the following languages and technologies:

- Apex (Salesforce server-side programming language)
- JavaScript (Salesforce Lightning Web Component)
- HTML and CSS (for component structure and styling)

## Metadata Types

The following metadata types are used in the project:

- Apex Classes
- Lightning Web Components
- Custom Labels
- Custom Settings
- Static Resources

## Lightning Web Components

The project contains the following Lightning Web Components:

- `addressSearchLookup`: The main component that provides the address search functionality
- `addressSearchLookupItem`: A child component used to display individual search results

## Installation

Follow these step-by-step instructions to install the AddressSearchLookup LWC in another Salesforce instance:

1. **Clone the repository:**

   Open a terminal and run the following command to clone the repository:

   ```
   git clone https://github.com/bensan/AddressSearchLookup.git
   ```

2. **Set up Salesforce CLI:**

   Ensure you have the Salesforce CLI installed on your machine. If you don't have it, follow the [installation instructions](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_install_cli.htm) from Salesforce.

3. **Authorize your Salesforce org:**

   Run the following command to authorize your Salesforce org:

   ```
   sfdx force:auth:web:login -d -a yourOrgAlias
   ```

   Replace `yourOrgAlias` with a unique alias to identify the target Salesforce org.

4. **Deploy the component to your org:**

   Use the following command to deploy the AddressSearchLookup component to your Salesforce org:

   ```
   sfdx force:source:deploy -p AddressSearchLookup/force-app -u yourOrgAlias
   ```

   Replace `yourOrgAlias` with the alias you set in step 3.

5. **Add the component to your Lightning App or Record Page:**

   - Open your Salesforce instance.
   - Navigate to the Lightning App Builder or a Lightning Record Page where you want to add the component.
   - In the Components panel, find the `AddressSearchLookup` component and drag it to the desired position on the page.
   - Save and activate the changes.

## Usage

To use the AddressSearchLookup component, simply start typing an address in the search field. The component will display a list of suggested addresses based on your input. Select an address from the list to populate the fields with the complete address information.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.