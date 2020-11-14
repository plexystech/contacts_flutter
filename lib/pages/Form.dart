import 'package:flutter/material.dart';

import '../utils/http_service.dart';

import '../models/contact.dart';

class FormView extends StatefulWidget {
  FormView({Key key, this.title, this.mode, this.contact}) : super(key: key);

  final String title;
  final String mode;
  final Contact contact;

  @override
  _FormViewState createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final _formKey = GlobalKey<FormState>();

  final HttpService httpService = HttpService();

  Contact _contact;
  @override
  void initState() {
    super.initState();
    setState(() {
      _contact = widget.contact;
    });
  }

  List<String> _sexes = [
    'Male',
    'Female',
    'Non-binary',
  ];

  List<String> _provinces = [
    'Province 1',
    'Province 2',
    'Province 3',
  ];

  List<String> _streets = [
    'Street 1',
    'Street 2',
    'Street 3',
  ];

  List<String> _cities = [
    'City 1',
    'City 2',
    'City 3',
  ];

  List<String> _zips = [
    'ZIP 1',
    'ZIP 2',
    'ZIP 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 30,
          ),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _expandedWidgetPair(
                    _textFormField(
                      'First Name',
                      _contact.firstName,
                      (String value) {
                        _contact.firstName = value;
                      },
                    ),
                    _textFormField(
                      'Last Name',
                      _contact.lastName,
                      (String value) {
                        _contact.lastName = value;
                      },
                    ),
                  ),
                  _expandedWidgetPair(
                    _dropdownFormField(
                      _sexes,
                      _contact.sex,
                      'Sex',
                      (String value) {
                        _contact.sex = value;
                      },
                    ),
                    _datePickerFormField(_contact.birthday),
                  ),
                  _expandedWidgetPair(
                    _textFormField(
                      'Phone',
                      _contact.phone,
                      (String value) {
                        _contact.phone = value;
                      },
                    ),
                    _textFormField(
                      'Email',
                      _contact.email,
                      (String value) {
                        _contact.email = value;
                      },
                    ),
                  ),
                  _textFormField(
                    'Facebook URL',
                    _contact.facebook,
                    (String value) {
                      _contact.facebook = value;
                    },
                  ),
                  _expandedWidgetPair(
                    _dropdownFormField(
                      _provinces,
                      _contact.province,
                      'Province',
                      (String value) {
                        _contact.province = value;
                      },
                    ),
                    _dropdownFormField(
                      _zips,
                      _contact.zip,
                      'ZIP Code',
                      (String value) {
                        _contact.zip = value;
                      },
                    ),
                  ),
                  _expandedWidgetPair(
                    _dropdownFormField(
                      _cities,
                      _contact.city,
                      'City',
                      (String value) {
                        _contact.city = value;
                      },
                    ),
                    _dropdownFormField(
                      _streets,
                      _contact.street,
                      'Street',
                      (String value) {
                        _contact.street = value;
                      },
                    ),
                  ),
                  TextFormField(
                    maxLines: 4,
                    initialValue: _contact.notes,
                    decoration: InputDecoration(
                      labelText: 'Notes',
                      alignLabelWithHint: true,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _contact.notes = value;
                      });
                    },
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: RaisedButton(
                      onPressed: () => {_onSubmit()},
                      child: Text('Submit'),
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  _onSubmit() {
    setState(() {
      _contact.fullName = '${_contact.firstName} ${_contact.lastName}';
    });
    var _form = _formKey.currentState;
    if (_form.validate()) {
      if (_contact.birthday != null) {
        _form.save();
        _onUpsert(widget.mode, _contact);
        _form.reset();

        Navigator.pop(context);
      } else {
        showAlertDialog(context);
      }
    } else {
      showAlertDialog(context);
    }
  }

  _expandedWidgetPair(widget1, widget2) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: widget1,
        ),
        SizedBox(width: 12),
        Expanded(
          flex: 1,
          child: widget2,
        ),
      ],
    );
  }

  _textFormField(String label, String variable, Function saveToState) {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'This field is required!';
        }
        return null;
      },
      initialValue: variable,
      decoration: InputDecoration(labelText: label),
      onChanged: (String value) {
        setState(() {
          saveToState(value);
        });
      },
    );
  }

  _dropdownFormField(
    List<String> dataSet,
    String groupValue,
    String label,
    Function saveToState,
  ) {
    return DropdownButtonFormField(
      hint: Text(label),
      value: groupValue,
      validator: (value) {
        if (value == null) {
          return 'This field is required!';
        }
        return null;
      },
      onChanged: (String newValue) {
        setState(() {
          saveToState(newValue);
        });
      },
      items: dataSet.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: _setDropdownValue(value, label),
          child: Text(value),
        );
      }).toList(),
    );
  }

  _datePickerFormField(DateTime birthday) {
    String _subtitle = 'Set Birthday';

    if (birthday != null) {
      _subtitle = '${birthday.year}-${birthday.month}-${birthday.day}';
    }

    return ListTile(
      leading: Icon(
        Icons.date_range,
        size: 40,
      ),
      title: Text('Birthday'),
      subtitle: Text(_subtitle),
      onTap: () {
        _showDatePicker();
      },
    );
  }

  _showDatePicker() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        _contact.birthday = date;
      });
    }
  }

  _setDropdownValue(String input, String label) {
    if (label == 'Sex') {
      if (input == 'Male') return 'male';
      if (input == 'Female') return 'female';
      return 'nonBinary';
    }
    return input;
  }

  showAlertDialog(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text('All entries must be filled.'),
      content: Text('You left some unfilled entries.'),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  _onUpsert(String mode, Contact contact) async {
    if (mode == 'update') {
      httpService.updateContact(contact);
    } else {
      httpService.insertContact(contact);
    }
  }
}
