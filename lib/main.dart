import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_practice/provider/contact_provider.dart';
import 'package:provider_practice/provider/stepper_provider.dart';
import 'package:provider_practice/view/android/contacy_details.dart';
import 'package:provider_practice/view/android/home_page.dart';
import 'package:provider_practice/view/ios/home_page.dart';

import 'provider/change_theme_provider.dart';
import 'provider/platform_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => StepperProvider()),
    ChangeNotifierProvider(create: (context) => ContactProvider()),
    ChangeNotifierProvider(create: (context) => PlatformProvider()),
    ChangeNotifierProvider(create: (context) => ChangeThemeProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<ChangeThemeProvider>(context);
    return Consumer<PlatformProvider>(builder: (context, plaProvider, _) {
      return plaProvider.isIOS
          ? CupertinoApp(
              debugShowCheckedModeBanner: false,
              routes: {'/': (context) => const HomeIOSPage()},
            )
          : MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              themeMode: provider.modeTheme,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              routes: {
                '/': (context) => HomePage(),
                'details': (context) => ContactDetails(),
              },
            );
    });
  }
}
