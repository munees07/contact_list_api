import 'package:flutter/material.dart';

class ContactDetailScreen extends StatelessWidget {
  final String name;
  final String phone;
  final String address;
  final String email;
  const ContactDetailScreen(
      {super.key,
      required this.name,
      required this.phone,
      required this.address,
      required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 200),
        child: Center(
          child: Card(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(name),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      child: SizedBox(
                        height: 80,
                        width: 130,
                        child: Column(
                          children: [const Text('Phone number'), Text(phone)],
                        ),
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        height: 80,
                        width: 130,
                        child: Column(
                          children: [const Text('Address'), Text(address)],
                        ),
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        height: 80,
                        width: 130,
                        child: Column(
                          children: [const Text('Email'), Text(email)],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
