import 'package:conatact_api/controller/contacts_provider.dart';
import 'package:conatact_api/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactAddScreen extends StatelessWidget {
  final ContactModel? contact;
  const ContactAddScreen({super.key, this.contact});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ContactProvider>(context, listen: false);
    final TextEditingController nameController = provider.nameController;
    final TextEditingController phoneController = provider.phoneController;
    final TextEditingController addressController = provider.addressController;
    final TextEditingController emailController = provider.emailController;
    if (contact != null) {
      nameController.text = contact!.name;
      phoneController.text = contact!.phone;
      addressController.text = contact!.address;
      emailController.text = contact!.email;
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Enter the Name'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: phoneController,
              decoration: const InputDecoration(hintText: 'Enter the Phone'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Enter the Email'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(hintText: 'Enter the Address'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  submit(context, nameController.text, phoneController.text,
                      emailController.text, addressController.text);
                },
                icon: Icon(contact != null ? Icons.edit : Icons.add),
                label: Text(contact != null ? 'Edit Contact' : 'Add Contact'))
          ],
        ),
      ),
    );
  }

  Future<void> submit(BuildContext context, String name, String phone,
      String email, String address) async {
    final provider = Provider.of<ContactProvider>(context, listen: false);
    if (contact != null) {
      await provider.updateContact(contact!.id, name, phone, address, email);
    } else {
      await provider.submitContact(name, phone, address, email);
      provider.clearControllers();
    }
    provider.fetchContacts(context);
  }
}
