import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_dev/models/contact.dart'; //change this to plexys_contacts

class DatabaseHelper {
  static const _databaseName = 'PlexysContacts.db';
  static const _databaseVersion = 1;

  // singleton class
  // Private constructor
  DatabaseHelper._();
  // for only one instance of db
  static final DatabaseHelper instance = DatabaseHelper._();

  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseName);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${Contact.tblContact}(
        ${Contact.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Contact.colFirstName} TEXT,
        ${Contact.colLastName} TEXT,
        ${Contact.colFullName} TEXT,
        ${Contact.colBirthDay} DATE,
        ${Contact.colSex} TINYTEXT,
        ${Contact.colPhone} TEXT,
        ${Contact.colEmail} TEXT,
        ${Contact.colFacebook} TEXT,
        ${Contact.colStreet} TEXT,
        ${Contact.colCity} TEXT,
        ${Contact.colProvince} TEXT,
        ${Contact.colZip} TEXT,
        ${Contact.colNotes} TEXT
        )
    ''');
  }

  Future<int> insertContact(Contact contact) async {
    Database db = await database;
    return db.insert(Contact.tblContact, contact.toMap());
  }

  Future<List<Contact>> getContacts() async {
    var db = await database;

    List<Map> maps = await db.rawQuery('SELECT * FROM ${Contact.tblContact}');
    List<Contact> contacts = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        contacts.add(Contact.fromMap(maps[i]));
      }
    }
    print(
        'THIS WILL BE PRINTED: First element-${contacts[0].firstName}, length-${contacts.length}');
    return contacts;
  }

  // Future<Contact> getSingle(int id) async {
  //   var db = await database;

  //   List<Map> maps = await db.rawQuery(
  //       'SELECT * FROM ${Contact.tblContact} WHERE ${Contact.colId} = $id');
  //   List<Contact> contacts = [];
  //   if (maps.length > 0) {
  //     for (int i = 0; i < maps.length; i++) {
  //       contacts.add(Contact.fromMap(maps[i]));
  //     }
  //   }

  //   return contacts[0];
  // }

  Future<int> delete(int id) async {
    var db = await database;
    return await db.delete(Contact.tblContact,
        where: '${Contact.colId} = ?', whereArgs: [id]);
  }

  Future<int> update(Contact contact) async {
    var db = await database;
    return await db.update(Contact.tblContact, contact.toMap(),
        where: '${Contact.colId} = ?', whereArgs: [contact.id]);
  }

  Future close() async {
    var db = await database;
    db.close();
  }
}
