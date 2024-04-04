import 'package:conatact_api/model/contact_model.dart';
import 'package:conatact_api/service/contact_services.dart';
import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier {
  bool onHover = false;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  List<ContactModel> contacts = [];

  Future<void> fetchContacts(BuildContext context) async {
    try {
      final response = await ContactServices.fetchContact();
      if (response.isEmpty) {
        throw Exception('Failed to fetch data');
      }
      contacts = response;
    } catch (e) {
      Center(
        child: Text('Error:$e'),
      );
    }
    notifyListeners();
  }

  Future<void> deleteById(String id) async {
    final isSuccess = await ContactServices.deleteById(id);
    if (isSuccess) {
      contacts.removeWhere((element) => element.id == id);
      notifyListeners();
    } else {
      throw Exception('Faile to Delete contact');
    }
  }

  Future<bool> updateContact(String id, String name, String phone,
      String address, String email) async {
    try {
      await ContactServices.updateContact(id, name, phone, address, email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> submitContact(
      String name, String phone, String address, String email) async {
    try {
      await ContactServices.submitContact(name, phone, address, email);
      return true;
    } catch (e) {
      return false;
    }
  }

  void clearControllers() {
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    emailController.clear();
    notifyListeners();
  }

  void onHovervalue(bool value) {
    onHover = value;
    notifyListeners();
  }
}
