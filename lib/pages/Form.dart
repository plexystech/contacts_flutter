import 'package:flutter/material.dart';

class FormView extends StatefulWidget {
  FormView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FormViewState createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final _formKey = GlobalKey<FormState>();
  String _sex = 'male';

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
                  _textFormField('First Name'),
                  _textFormField('Last Name'),
                  _textFormField('Full Name'),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Birthday',
                      hintText: 'YYYY-MM-DD',
                    ),
                  ),
                  Row(
                    children: [
                      _radioFormField('Male', 'male', _sex),
                      _radioFormField('Female', 'female', _sex),
                      _radioFormField('Non-binary', 'nonBinary', _sex),
                    ],
                  ),
                  _textFormField('Phone'),
                  _textFormField('Email'),
                  _textFormField('Facebook URL'),
                  _textFormField('Street'),
                  _textFormField('City'),
                  _textFormField('Province'),
                  _textFormField('ZIP'),
                  _textFormField('Notes'),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: RaisedButton(
                      onPressed: () => {},
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

  _textFormField(String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
    );
  }

  _radioFormField(String label, String value, groupValue) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: (value) {
            setState(() {
              groupValue = value;
            });
          },
        ),
        Text(label),
      ],
    );
  }
}
