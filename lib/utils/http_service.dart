import 'dart:convert';

import 'package:http/http.dart';

import '../models/contact.dart';

class HttpService {
  final String api = "http://api.cashbook.plexys.co/contacts";

  Future<List<Contact>> getContacts() async {
    Response res = await get(api);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Contact> contacts =
          body.map((dynamic item) => Contact.fromJson(item)).toList();
      return contacts;
    } else {
      throw "Can't get record list.";
    }
  }

  Future<Contact> getSingle(int id) async {
    Response res = await get("$api/$id");

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      return Contact.fromJson(body);
    } else {
      throw "Can't get record.";
    }
  }

  Future<void> deleteContact(int id) async {
    Response res = await delete("$api/$id");
    if (res.statusCode == 200) {
      print("Record Deleted.");
    } else {
      throw "Can't delete record.";
    }
  }

  Future<void> insertContact(Contact contact) async {
    dynamic responseBody = jsonEncode(contact.toMap());

    Response res = await post(api, body: responseBody);
    if (res.statusCode == 200) {
      print("Record Inserted.");
    } else {
      throw "Can't insert record.";
    }
  }

  Future<void> updateContact(Contact contact) async {
    dynamic responseBody = jsonEncode(contact.toMap());

    Response res = await put("$api/${contact.id}", body: responseBody);
    if (res.statusCode == 200) {
      print("Record Updated.");
    } else {
      throw "Can't update record.";
    }
  }
}
