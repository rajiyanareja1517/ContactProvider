import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider_practice/provider/stepper_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/contact.dart';

class ContactProvider extends ChangeNotifier {
  List<Contact> allContact = [];

  void addContacts(Contact contact) {
    allContact.add(contact);
    notifyListeners();
  }

  void deleteContacts(Contact contact) {
    allContact.remove(contact);
    notifyListeners();
  }

  void updateContacts(Contact data, BuildContext context, String pickImagePath) {
    for (int i = 0; i < allContact.length; i++) {
      if (data.id ==
          Provider.of<ContactProvider>(context, listen: false)
              .allContact[i]
              .id) {
        Provider.of<ContactProvider>(context, listen: false).allContact[i] =
            Contact(
              id: data.id,
                name: Provider.of<StepperProvider>(context, listen: false)
                    .nmController
                    .text,
                contact: Provider.of<StepperProvider>(context, listen: false)
                    .contactController
                    .text,
                email: Provider.of<StepperProvider>(context, listen: false)
                    .emailController
                    .text,
                img: pickImagePath);
      }
    }

    notifyListeners();
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString("contact")!);
  }
}
