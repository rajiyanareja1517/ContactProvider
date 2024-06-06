import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider_practice/model/contact.dart';
import 'package:provider_practice/provider/contact_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepperProvider extends ChangeNotifier {
  int step = 0;
  int id = 0;
  TextEditingController nmController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  //String pickImagePath="";

  Future<void> fordwardStep(BuildContext context,String pickImagePath) async {
    print(step.toString());
    print(pickImagePath);
    if (step == 3) {
      Contact contact = Contact(
          id:id,
          name: nmController.text,
          contact: contactController.text,
          email: emailController.text,
          img: pickImagePath);

      Provider.of<ContactProvider>(context, listen: false).addContacts(contact);
      id++;
      //save('contact', Provider.of<ContactProvider>(context, listen: false).allContact);
      // _savePersons( Provider.of<ContactProvider>(context, listen: false).allContact);
      /*  ContactProvider contactProvider=ContactProvider();
      ContactProvider.addContacts(contact);
      print(contactProvider.allContact[0].email);*/
      Navigator.pop(context);
    }
    if (step < 3) {
      step++;
    }
    notifyListeners();
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  void _savePersons(List<Contact> persons) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> personsEncoded =
        persons.map((person) => jsonEncode(person.toJson())).toList();
    await sharedPreferences.setStringList('contact', personsEncoded);
  }

  void backwardStep() {
    if (step > 0) {
      step--;
    }
    notifyListeners();
  }
}
