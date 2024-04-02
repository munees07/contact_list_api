import 'package:conatact_api/controller/contacts_provider.dart';
import 'package:conatact_api/model/contact_model.dart';
import 'package:conatact_api/view/add_screen.dart';
import 'package:conatact_api/view/contact_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: () {
          navigateToAdd(context);
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: fetchContactData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error:${snapshot.error}'),
            );
          } else {
            return _buildContactList(context);
          }
        },
      ),
    );
  }

  Widget _buildContactList(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);
    return contactProvider.contacts.isEmpty
        ? const Center(
            child: Text('No Contacts'),
          )
        : ListView.builder(
            itemCount: contactProvider.contacts.length,
            itemBuilder: (context, index) {
              ContactModel data = contactProvider.contacts[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ContactDetailScreen(
                          name: data.name.toString(),
                          phone: data.phone.toString(),
                          address: data.address.toString(),
                          email: data.email.toString()))),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    tileColor: Colors.black12,
                    leading: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black26,
                      ),
                      height: 30,
                      width: 30,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text('${index + 1}')),
                    ),
                    title: Text(data.name.toString()),
                    subtitle: Text(data.phone.toString()),
                    // Column(
                    //   children: [
                    //
                    //     Text(data.email.toString()),
                    //     Text(data.address.toString())
                    //   ],
                    // ),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'edit') {
                          //edit
                          navigateToEdit(context, data);
                        } else if (value == 'delete') {
                          //delete
                          deleteContactById(context, data.id.toString());
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                              value: 'edit', child: Text('Edit')),
                          const PopupMenuItem(
                              value: 'delete', child: Text('Delete'))
                        ];
                      },
                    ),
                  ),
                ),
              );
            },
          );
  }

  Future<void> fetchContactData(BuildContext context) async {
    final provider = Provider.of<ContactProvider>(context, listen: false);
    await provider.fetchContacts(context);
  }

  Future<void> deleteContactById(BuildContext context, String id) async {
    final provider = Provider.of<ContactProvider>(context, listen: false);
    try {
      await provider.deleteById(id);
    } catch (e) {
      // ignore: avoid_print
      print('unable to delete$e');
    }
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

  void navigateToEdit(BuildContext context, ContactModel contact) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContactAddScreen(
            contact: contact,
          ),
        )).then((value) {
      if (value != null) {
        final provider = Provider.of<ContactProvider>(context, listen: false);
        provider.fetchContacts(context);
      }
    });
  }
}
