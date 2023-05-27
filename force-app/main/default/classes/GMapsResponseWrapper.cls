public with sharing class GMapsResponseWrapper {
    @AuraEnabled
    public String firstAddressLine { get; set; }

    @AuraEnabled
    public String city { get; set; }

    @AuraEnabled
    public String state { get; set; }

    @AuraEnabled
    public String zip { get; set; }

    @AuraEnabled
    public String country { get; set; }

    @AuraEnabled
    public String zipCodeExtension { get; set; }

    // make a constructor
    public GMapsResponseWrapper(String firstAddressLine, String city, String state, String zip, String zipCodeExtension, String country) {
        this.firstAddressLine = firstAddressLine;
        this.city = city;
        this.state = state;
        this.zip = zip;
        this.country = country;
        this.zipCodeExtension = zipCodeExtension;
    }
}