import 'package:conatact_api/controller/contacts_provider.dart';
import 'package:conatact_api/controller/search_provider.dart';
import 'package:conatact_api/view/add_screen.dart';
import 'package:conatact_api/widgets/contact_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.person_alt_circle_fill, size: 28),
              Gap(5),
              Text('CONTACT LIST',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
            ],
          ),
          backgroundColor: Colors.grey[350]),
      floatingActionButton: FloatingActionButton.small(
          backgroundColor: Colors.white.withOpacity(0.7),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: () {
            navigateToAdd(context);
          },
          child: const Icon(Icons.add)),
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset('assets/background.jpg',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: TextFormField(
                    onChanged: (value) {
                      searchProvider.contactSearch = value;
                      searchProvider.contactSearchResult(context);
                    },
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'search contact'),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: fetchContactData(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error:${snapshot.error}'));
                      } else {
                        return Consumer2<SearchProvider, ContactProvider>(
                            builder: (context, searchprovider, contactprovider,
                                child) {
                          return SizedBox(
                              child: searchProvider.contactSearch.isNotEmpty
                                  ? searchProvider.filteredContact.isEmpty
                                      ? const Center(
                                          child: Text('no items found'),
                                        )
                                      : buildContactList(context,
                                          searchProvider.filteredContact)
                                  : buildContactList(
                                      context, contactprovider.contacts));
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchContactData(BuildContext context) async {
    final provider = Provider.of<ContactProvider>(context, listen: false);
    await provider.fetchContacts(context);
  }

  void navigateToAdd(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ContactAddScreen(),
        )).then((value) {
      if (value != null) {
        final provider = Provider.of<ContactProvider>(context, listen: false);
        provider.fetchContacts(context);
      }
    });
  }
}
