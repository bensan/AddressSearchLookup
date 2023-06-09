/** 
 * @description This class is used to lookup addresses using the Google Maps API
*/
public with sharing class GMapsAddressLookup {
    // create a static variable to hold the API key
    private static String apiKey = '';

    // write a utility class that sends out an HTTP request
    // to the Google Maps API and returns the results
    @AuraEnabled(cacheable=true)
    public static GMapsResponseWrapper lookupAddress(List<String> addressLines) {
        // get the API key from a custom setting
        GMapsAddressLookup__c gmaps = GMapsAddressLookup__c.getOrgDefaults();
        apiKey = gmaps.API_Key__c;
        System.debug('apiKey: ' + apiKey);
        // TODO: There should be an error here if there is no API key found
        
        // create a new PostalCode object, add input address lines to PostalCode instance

        // public PostalAddress(List<String> addressLines, String regionCode, String locality, String adminArea, String postalCode) {
        // (7536 Belted Kingfisher Way, Winter Garden, FL, 34787, US)
        GMapsAddressLookup.PostalAddress postalCode = new GMapsAddressLookup.PostalAddress(addressLines, 
            'US',
            addressLines[1], 
            addressLines[2],
            addressLines[3]
        );
        // create a new mapsRequest object, add PostalCode instance to mapsRequest instance
        GMapsAddressLookup.mapsRequest mapsRequest = new GMapsAddressLookup.mapsRequest(postalCode, null, 'true');

        // create a new HTTP request
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        // set the endpoint URL
        request.setEndpoint('https://addressvalidation.googleapis.com/v1:validateAddress?key='+apiKey);

        // add a header to the request for a json content type
        request.setHeader('Content-Type', 'application/json');
        request.setMethod('POST');

        // set the request body
        request.setBody(JSON.serialize(mapsRequest));
        // send the request
        try {
            HttpResponse response = http.send(request);

            // return the response body and deserialize it
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> resultMap = (Map<String, Object>) responseMap.get('result');
            Map<String, Object> addressMap = (Map<String, Object>) resultMap.get('address');
            String formattedAddress = (String) addressMap.get('formattedAddress');
            Map<String, Object> uspsData = (Map<String, Object>) resultMap.get('uspsData');
            System.debug(uspsData);

            Map<String, Object> standardizedAddress = (Map<String, Object>) uspsData.get('standardizedAddress');
            String firstAddressLine = (String) standardizedAddress.get('firstAddressLine'); // street name and number
            String city = (String) standardizedAddress.get('city'); // city
            String state = (String) standardizedAddress.get('state'); // state
            String zipCode = (String) standardizedAddress.get('zipCode'); // street name and number
            String zipCodeExtension = (String) standardizedAddress.get('zipCodeExtension'); // street name and number
            String country = 'US'; // street name and number

            GMapsResponseWrapper responseWrapper = new GMapsResponseWrapper(firstAddressLine, city, state, 
                zipCode, zipCodeExtension, country);
            return responseWrapper;
        } catch (Exception e) {
            System.debug('Error in lookupAddress method: ' + e.getMessage());
            return null;
        }
    }

    // Create a wrapper class to hold the address information called PostalCode
    private class PostalAddress {
        public Integer revision { get; set; }
        public String regionCode { get; set; }
        public String languageCode { get; set; }
        public String postalCode { get; set; }
        public String sortingCode { get; set; }
        public String administrativeArea { get; set; }
        public String locality { get; set; }
        public String sublocality { get; set; }
        public List<String> addressLines { get; set; }
        public List<String> recipients { get; set; }
        public String organization { get; set; }
        
        // Create a constructor that accepts a List<String> as a parameter
        // and sets the addressLines property
        public PostalAddress(List<String> addressLines, String regionCode, String locality, String adminArea, String postalCode) {
            this.addressLines = addressLines;
            this.regionCode = regionCode;
            this.locality = locality;
            this.administrativeArea = adminArea;
            this.postalCode = postalCode;
        }
    }

    private class MapsRequest {
        public PostalAddress address { get; set; }
        public String previousResponseId { get; set; }
        public String enableUspsCass { get; set; }

        public MapsRequest(PostalAddress address, String previousResponseId, String enableUspsCass) {
            this.address = address;
            this.previousResponseId = previousResponseId;
            this.enableUspsCass = enableUspsCass;
        }
    }
}