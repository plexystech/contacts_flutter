class Contact {
  static const tblContact = 'contacts';
  static const colId = 'id';
  static const colFirstName = 'firstName';
  static const colLastName = 'lastName';
  static const colFullName = 'fullName';
  static const colBirthDay = 'birthDay';
  static const colSex = 'sex';
  static const colPhone = 'phone';
  static const colEmail = 'email';
  static const colFacebook = 'facebook';
  static const colStreet = 'street';
  static const colCity = 'city';
  static const colProvince = 'province';
  static const colZip = 'zip';
  static const colNotes = 'notes';

  int id;
  String firstName;
  String lastName;
  String fullName;
  String birthDay;
  String sex;
  String phone;
  String email;
  String facebook;
  String street;
  String city;
  String province;
  String zip;
  String notes;

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

  Contact.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    firstName = map[colFirstName];
    lastName = map[colLastName];
    fullName = map[colFullName];
    birthDay = map[colBirthDay];
    sex = map[colSex];
    phone = map[colPhone];
    email = map[colEmail];
    facebook = map[colFacebook];
    street = map[colStreet];
    city = map[colCity];
    province = map[colProvince];
    zip = map[colZip];
    notes = map[colNotes];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      colFirstName: firstName,
      colLastName: lastName,
      colFullName: fullName,
      colBirthDay: birthDay,
      colSex: sex,
      colPhone: phone,
      colEmail: email,
      colFacebook: facebook,
      colStreet: street,
      colCity: city,
      colProvince: province,
      colZip: zip,
      colNotes: notes,
    };
    if (id != null) {
      map[colId] = id;
    }
    return map;
  }
}
