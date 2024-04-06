// ignore_for_file: use_build_context_synchronously

import 'package:conatact_api/controller/contacts_provider.dart';
import 'package:conatact_api/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
      body: Stack(
        children: [
          Image.asset('assets/background.jpg',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const Gap(40),
                const Row(
                  children: [
                    Icon(Icons.person_add),
                    Text('Create new contact')
                  ],
                ),
                const Gap(20),
                TextFormField(
                    controller: nameController,
                    decoration:
                        const InputDecoration(hintText: 'Enter the Name')),
                const Gap(20),
                TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    decoration:
                        const InputDecoration(hintText: 'Enter the Phone')),
                const Gap(20),
                TextFormField(
                    controller: emailController,
                    decoration:
                        const InputDecoration(hintText: 'Enter the Email')),
                const Gap(20),
                TextFormField(
                    controller: addressController,
                    decoration:
                        const InputDecoration(hintText: 'Enter the Address')),
                const Gap(40),
                ElevatedButton.icon(
                    style: ButtonStyle(
                        padding: const MaterialStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 18, horizontal: 12)),
                        foregroundColor:
                            const MaterialStatePropertyAll(Colors.black),
                        backgroundColor: MaterialStatePropertyAll(
                            Colors.white.withOpacity(0.4))),
                    onPressed: () {
                      submit(context, nameController.text, phoneController.text,
                          emailController.text, addressController.text);
                    },
                    icon: Icon(contact != null ? Icons.edit : Icons.add),
                    label:
                        Text(contact != null ? 'Edit Contact' : 'Add Contact'))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> submit(BuildContext context, String name, String phone,
      String email, String address) async {
    final provider = Provider.of<ContactProvider>(context, listen: false);
    if (contact != null) {
      await provider.updateContact(contact!.id, name, phone, address, email);
      provider.clearControllers();
      Navigator.pop(context);
    } else {
      await provider.submitContact(name, phone, address, email);
      provider.clearControllers();
    }
    provider.fetchContacts(context);
  }
}
