# Contact

A Contact project created in flutter. Contact supports both ios and android, clone the appropriate branches mentioned below:

* For Mobile: https://github.com/rajiyanareja1517/ContactProvider

Download or clone this repo by using the link below:

```
https://github.com/rajiyanareja1517/Contact_provider.git
```


### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- provider/
|- models/
|- view/android/
|- view/ios/
|- main.dart
```

### view

This directory screens all the screen of the application together in one place. A separate file is created for each type as shown in example below:

```
android/
|- HomePage.dart
|- ContactDetails.dart

ios/
|- HomeIOSPage.dart

```



### Main

This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.

```dart
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

  
```

![Screenshot_20240817_181917](https://github.com/user-attachments/assets/a5f26adf-2333-4912-ac3c-045ea4d8bf2e)
![Screenshot_20240817_181857](https://github.com/user-attachments/assets/52c68225-67a1-44a8-b685-8c67e94ff3e3)
![Screenshot_20240817_181804](https://github.com/user-attachments/assets/b13b0d6d-7996-4fe2-b121-25baf5baccb3)
![Screenshot_20240817_181959](https://github.com/user-attachments/assets/ccfc408a-c39c-4596-b283-3817b2039779)
![Screenshot_20240817_181931](https://github.com/user-attachments/assets/4286d319-27d0-4544-b703-6dcdc64fc871)




https://github.com/user-attachments/assets/be67bb1b-6432-4928-96f8-49c3630d05b4



## Conclusion

Again to note, this is example can appear as my code for what it is - but it is an example only. If you liked my work, don’t forget to ⭐ star the repo to show your support.
