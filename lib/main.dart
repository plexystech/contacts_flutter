import 'package:flutter/material.dart';
import 'models/contact.dart';

// Pages
import 'pages/Form.dart';
import 'pages/Details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plexys Contacts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'List View'),
        '/form': (context) => FormView(title: 'Form View'),
        '/details': (context) => DetailsView(title: 'Details View'),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Contact> _contacts = [
    Contact(
      id: 1,
      fullName: 'Naruto Uzumaki',
      email: 'nuzumaki@konoha.jp',
    ),
    Contact(
      id: 2,
      fullName: 'Sasuke Uchiha',
      email: 'suchiha@konoha.jp',
    ),
  ];

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
                      Navigator.pushNamed(context, '/details');
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
}
