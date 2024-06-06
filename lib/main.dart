import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_practice/provider/contact_provider.dart';
import 'package:provider_practice/provider/stepper_provider.dart';
import 'package:provider_practice/view/contacy_details.dart';
import 'package:provider_practice/view/home_page.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => StepperProvider()),
    ChangeNotifierProvider(create: (context) => ContactProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme:ThemeData.light(),

        routes: {
          '/': (context) => HomePage(),
          'details':(context)=>ContactDetails(),
        },
       );
  }
}
