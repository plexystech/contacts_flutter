import 'package:flutter/material.dart';
import 'package:flutter_dev/utils/database_helper.dart';
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
  DatabaseHelper _dbHelper;

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper.instance;
    _refreshContactList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[_list(_contacts)],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/form'),
        child: Icon(Icons.add),
      ),
    );
  }

  _refreshContactList() async {
    List<Contact> dbContacts = await _dbHelper.getContacts();
    setState(() {
      _contacts = dbContacts;
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
                                  // contactSingle: _contacts[index],
                                )),
                      );
                    },
                    leading: Icon(Icons.account_circle, size: 40.0),
                    title: Text(
                      // _contacts[index].firstName,
                      'Naruto Uzumaki'.toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // subtitle: Text(_contacts[index].email),
                    subtitle: Text('nuzumaki@konoha.jp'),
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
}
