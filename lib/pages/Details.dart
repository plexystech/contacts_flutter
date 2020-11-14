import 'package:flutter/material.dart';
import '../models/contact.dart';

class DetailsView extends StatelessWidget {
  DetailsView({
    Key key,
    this.title,
    /*this.contactSingle*/
  }) : super(key: key);

  final String title;
  // final Contact contactSingle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
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
                      'Naruto Uzumaki',
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
                Expanded(flex: 1, child: _description('First Name', 'Naruto')),
                Expanded(flex: 1, child: _description('Last Name', 'Uzumaki'))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: _description('Birthday', 'October 11, 2011')),
                Expanded(flex: 1, child: _description('Sex', 'Male')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    flex: 1, child: _description('Phone', '+639090090099')),
                Expanded(
                    flex: 1,
                    child: _description('Email', 'nuzumaki@konoha.jp')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: _description('Facebook URL', '/uzumaki.naruto')),
                Expanded(
                    flex: 1,
                    child: _description(
                        'Address', 'Konohagakure\nLos Baños\nLaguna 4030')),
              ],
            ),
            _description(
              'Notes',
              'A young ninja who seeks recognition from his peers and dreams of becoming the Hokage, the leader of his village.',
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
}
