import 'package:flutter/material.dart';

class DetailsView extends StatelessWidget {
  DetailsView({Key key, this.title}) : super(key: key);

  final String title;

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
              height: 24.0,
            ),
            _description('First Name', 'Naruto'),
            _description('Last Name', 'Uzumaki'),
            _description('Full Name', 'Naruto Uzumaki'),
            _description('Birthday', 'October 11, 2011'),
            _description('Sex', 'Male'),
            _description('Phone', '+639090090099'),
            _description('Email', 'nuzumaki@konoha.jp'),
            _description('Facebook URL', 'https://fb.com/uzumaki.naruto'),
            _description('Address', 'Konohagakure, Los Baños, Laguna 4030'),
            _description('Notes',
                'A young ninja who seeks recognition from his peers and dreams of becoming the Hokage, the leader of his village.'),
          ],
        ),
      ),
    );
  }

  _description(String label, String data) {
    return Text('$label: $data');
  }
}
