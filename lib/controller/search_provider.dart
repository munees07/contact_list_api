import 'package:conatact_api/controller/contacts_provider.dart';
import 'package:conatact_api/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchProvider extends ChangeNotifier {
  String contactSearch = '';
  List<ContactModel> filteredContact = [];

  void contactSearchResult(BuildContext context) {
    final provider = Provider.of<ContactProvider>(context, listen: false);
    final filteredContactList = provider.contacts
        .where((contact) =>
            contact.name.toLowerCase().contains(contactSearch.toLowerCase()))
        .toList();
    filteredContactSearch(filteredContactList);
  }

  void filteredContactSearch(List<ContactModel> value) async {
    filteredContact = value;
    notifyListeners();
  }
}
