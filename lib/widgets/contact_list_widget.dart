import 'package:conatact_api/controller/contacts_provider.dart';
import 'package:conatact_api/model/contact_model.dart';
import 'package:conatact_api/view/add_screen.dart';
import 'package:conatact_api/view/contact_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

Widget buildContactList(BuildContext context, List<ContactModel> contactlist) {
  return contactlist.isEmpty
      ? const Center(
          child: Text('No Contacts'),
        )
      : ListView.builder(
          itemCount: contactlist.length,
          itemBuilder: (context, index) {
            ContactModel data = contactlist[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Card(
                color: Colors.white.withOpacity(0.2),
                child: InkWell(
                  hoverDuration: Durations.long1,
                  borderRadius: BorderRadius.circular(10),
                  hoverColor: Colors.white.withOpacity(0.5),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ContactDetailScreen(
                          name: data.name.toString(),
                          phone: data.phone.toString(),
                          address: data.address.toString(),
                          email: data.email.toString()))),
                  child: ListTile(
                    tileColor: Colors.transparent,
                    leading: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [Gap(10), Icon(CupertinoIcons.phone), Gap(10)],
                    ),
                    title: Text(data.name.toString()),
                    subtitle: Text(data.phone.toString()),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'edit') {
                          navigateToEdit(context, data);
                        } else if (value == 'delete') {
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
              ),
            );
          },
        );
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

Future<void> deleteContactById(BuildContext context, String id) async {
  final provider = Provider.of<ContactProvider>(context, listen: false);
  try {
    await provider.deleteById(id);
  } catch (e) {
    // ignore: avoid_print
    print('unable to delete$e');
  }
}
