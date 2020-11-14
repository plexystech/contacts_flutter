class Contact {
  static const tblContact = 'contacts';
  static const colId = 'id';
  static const colFirstName = 'firstName';
  static const colLastName = 'lastName';
  static const colFullName = 'fullName';
  static const colBirthDay = 'birthday';
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
  DateTime birthday;
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
    this.birthday,
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

  factory Contact.fromJson(Map<String, dynamic> map) {
    return Contact(
      id: map[colId] as int,
      firstName: map[colFirstName] as String,
      lastName: map[colLastName] as String,
      fullName: map[colFullName] as String,
      birthday: DateTime.parse(map[colBirthDay]),
      sex: map[colSex] as String,
      phone: map[colPhone] as String,
      email: map[colEmail] as String,
      facebook: map[colFacebook] as String,
      street: map[colStreet] as String,
      city: map[colCity] as String,
      province: map[colProvince] as String,
      zip: map[colZip] as String,
      notes: map[colNotes] as String,
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      colFirstName: firstName,
      colLastName: lastName,
      colFullName: fullName,
      colBirthDay: birthday.toIso8601String(),
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

  static initialState() async {
    return Contact(
      id: null,
      firstName: '',
      lastName: '',
      fullName: '',
      birthday: null,
      sex: null,
      phone: '',
      email: '',
      facebook: '',
      street: null,
      city: null,
      province: null,
      zip: null,
      notes: '',
    );
  }
}
