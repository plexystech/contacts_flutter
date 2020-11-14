import 'package:flutter/material.dart';
import 'package:flutter_dev/pages/Form.dart';
import 'package:flutter_dev/utils/http_service.dart';
import '../models/contact.dart';
import 'package:intl/intl.dart';

class DetailsView extends StatelessWidget {
  DetailsView({
    Key key,
    this.title,
    this.contactSingle,
  }) : super(key: key);

  final String title;
  final Contact contactSingle;
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormView(
                        title: 'Form View',
                        // contactSingle: _contacts[index],
                        mode: 'update',
                        contact: contactSingle,
                      ),
                    ),
                  )),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              httpService.deleteContact(contactSingle.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 80,
                    ),
                    Text(
                      contactSingle.fullName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Divider(
              height: 48.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: _description('First Name', contactSingle.firstName)),
                Expanded(
                    flex: 1,
                    child: _description('Last Name', contactSingle.lastName))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: _description('Birthday',
                      DateFormat('d MMMM yyyy').format(contactSingle.birthday)),
                ),
                Expanded(
                    flex: 1,
                    child: _description(
                        'Sex', _setSex(contactSingle.sex.toString()))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child:
                        _description('Phone', contactSingle.phone.toString())),
                Expanded(
                    flex: 1, child: _description('Email', contactSingle.email)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child:
                        _description('Facebook URL', contactSingle.facebook)),
                Expanded(
                  flex: 1,
                  child: _description(
                    'Address',
                    '${contactSingle.street}\n${contactSingle.city}\n${contactSingle.province} ${contactSingle.zip}',
                  ),
                ),
              ],
            ),
            _description(
              'Notes',
              contactSingle.notes,
            ),
          ],
        ),
      ),
    );
  }

  _description(String label, String data) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 4),
          Text(
            data,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  _setSex(String input) {
    if (input == 'male') return 'Male';
    if (input == 'female') return 'Female';
    return 'Non-binary';
  }
}
