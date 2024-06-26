import 'package:conatact_api/controller/contacts_provider.dart';
import 'package:conatact_api/controller/search_provider.dart';
import 'package:conatact_api/view/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        ),
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: ContactScreen()),
    );
  }
}
