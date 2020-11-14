import 'package:flutter/material.dart';
import '../models/contact.dart';
import 'package:flutter_dev/utils/database_helper.dart';

class FormView extends StatefulWidget {
  FormView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FormViewState createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final _formKey = GlobalKey<FormState>();

  Contact _contact = Contact();
  DatabaseHelper _dbHelper;

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper.instance;
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
                    _textFormField('First Name', _contact.firstName),
                    _textFormField('Last Name', _contact.lastName),
                  ),
                  _expandedWidgetPair(
                    _dropdownFormField(_sexes, _contact.sex, 'Sex'),
                    _datePickerFormField(DateTime.parse(_contact.birthDay)),
                  ),
                  _expandedWidgetPair(
                    _textFormField('Phone', _contact.phone),
                    _textFormField('Email', _contact.email),
                  ),
                  _textFormField('Facebook URL', _contact.facebook),
                  _expandedWidgetPair(
                    _dropdownFormField(
                        _provinces, _contact.province, 'Province'),
                    _dropdownFormField(_zips, _contact.zip, 'ZIP Code'),
                  ),
                  _expandedWidgetPair(
                    _dropdownFormField(_cities, _contact.city, 'City'),
                    _dropdownFormField(_streets, _contact.street, 'Street'),
                  ),
                  TextFormField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Notes',
                      alignLabelWithHint: true,
                    ),
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

  _onSubmit() async {
    _contact.fullName = '${_contact.firstName} ${_contact.lastName}';
    var _form = _formKey.currentState;
    _form.save();
    await _dbHelper.insertContact(_contact);
    _form.reset();
    Navigator.pop(context);
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

  _textFormField(String label, String variable) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      onChanged: (value) {
        setState(() {
          variable = value;
        });
      },
    );
  }

  _dropdownFormField(List<String> dataSet, String groupValue, String label) {
    return DropdownButtonFormField(
      hint: Text(label),
      value: groupValue,
      onChanged: (String newValue) {
        setState(() {
          groupValue = newValue;
        });
      },
      items: dataSet.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
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
        _contact.birthDay = date.toString();
      });
    }
  }
}
