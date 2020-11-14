import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dev/utils/http_service.dart';

import '../models/contact.dart';

import 'Form.dart';
import 'Details.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Contact> _contacts;
  final HttpService httpService = HttpService();

  @override
  void initState() {
    super.initState();
    _refreshContactList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: httpService.getContacts(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          if (snapshot.hasData)
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[_list(_contacts)],
              ),
            );
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FormView(
              title: 'Form View',
              // contactSingle: _contacts[index],
              mode: 'create',
              contact: Contact(),
            ),
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }

  _refreshContactList() async {
    List<Contact> contacts = await httpService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  _list(List<Contact> _contacts) => Expanded(
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsView(
                            title: 'Details View',
                            contactSingle: _contacts[index],
                          ),
                        ),
                      ).then(onGoBack);
                    },
                    leading: Icon(Icons.account_circle, size: 40.0),
                    title: Text(
                      _contacts[index].fullName.toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(_contacts[index].email),
                  ),
                  Divider(
                    height: 5.0,
                  ),
                ],
              );
            },
            itemCount: _contacts.length,
          ),
        ),
      );

  FutureOr onGoBack(dynamic value) {
    _refreshContactList();
    setState(() {});
  }
}
