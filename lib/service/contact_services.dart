import 'package:conatact_api/model/contact_model.dart';
import 'package:dio/dio.dart';

class ContactServices {
  static Future<List<ContactModel>> fetchContact() async {
    final Dio dio = Dio();
    final response = await dio
        .get('https://contacts-management-server.onrender.com/api/contacts');
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = response.data;
      return jsonData.map((json) => ContactModel.fromJson(json)).toList();
    } else {
      throw Exception('Unable to load data');
    }
  }

  static Future<bool> deleteById(String id) async {
    final Dio dio = Dio();
    final response = await dio.delete(
        'https://contacts-management-server.onrender.com/api/contacts/$id');
    return response.statusCode == 200;
  }

  static Future<bool> updateContact(String id, String name, String phone,
      String email, String address) async {
    final Dio dio = Dio();
    final response = await dio.put(
        'https://contacts-management-server.onrender.com/api/contacts/$id',
        data: {
          "name": name,
          "email": email,
          "phone": phone,
          "address": address
        },
        options: Options(headers: {'Content-Type': 'application/json'}));
    return response.statusCode == 200;
  }

  static Future<bool> submitContact(
      String name, String phone, String email, String address) async {
    final Dio dio = Dio();
    final response = await dio.post(
        'https://contacts-management-server.onrender.com/api/contacts',
        data: {
          "name": name,
          "email": email,
          "phone": phone,
          "address": address
        },
        options: Options(headers: {'Content-Type': 'application/json'}));
    return response.statusCode == 201;
  }
}
