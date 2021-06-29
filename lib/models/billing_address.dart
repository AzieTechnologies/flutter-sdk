class BillingAddress {
  late String country;
  late String zip;
  late String state;
  late String city;
  late String street;

  BillingAddress(
      String street, String city, String zip, String state, String country) {
    this.street = street;
    this.city = city;
    this.zip = zip;
    this.state = state;
    this.country = country;
  }

  Map<String, dynamic> toJSON() => {
        'street': street,
        'city': city,
        'country': country,
        'zip': zip,
        'state': state,
      };
}
