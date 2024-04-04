import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
      body: Stack(
        children: [
          Image.asset(
            'assets/background.jpg',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 100, 20, 450),
              child: Card(
                color: Colors.white.withOpacity(0.2),
                child: Column(
                  children: [
                    const Gap(20),
                    Text(name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const Gap(5),
                    Text(phone,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1)),
                    const Gap(40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Card(
                        color: Colors.white.withOpacity(0.7),
                        child: SizedBox(
                          height: 100,
                          width: 500,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Address',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              const Gap(10),
                              Text(address)
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Card(
                        color: Colors.white.withOpacity(0.7),
                        child: SizedBox(
                          height: 100,
                          width: 500,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Email',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              const Gap(5),
                              Text(email)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
