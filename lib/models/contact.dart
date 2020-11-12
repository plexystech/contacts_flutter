class Contact {
  Contact({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.birthDay,
    this.sex,
    this.phone,
    this.email,
    this.facebook,
    this.street,
    this.city,
    this.province,
    this.zip,
    this.notes,
  }); // Constructor where parameters are optional

  int id;
  String firstName;
  String lastName;
  String fullName;

  DateTime birthDay;
  String sex;

  String phone;
  String email;
  String facebook;

  String street;
  String city;
  String province;
  String zip;

  String notes;
}
