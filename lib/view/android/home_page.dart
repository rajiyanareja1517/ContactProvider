import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../provider/change_theme_provider.dart';
import '../../provider/contact_provider.dart';
import '../../provider/platform_provider.dart';
import '../../provider/stepper_provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<PlatformProvider>(context, listen: false)
                    .setIsIos();
              },
              icon: Icon(Icons.apple)),
          IconButton(
            onPressed: () {
              Provider.of<StepperProvider>(context, listen: false)
                  .nmController
                  .clear();
              Provider.of<StepperProvider>(context, listen: false)
                  .contactController
                  .clear();
              Provider.of<StepperProvider>(context, listen: false)
                  .emailController
                  .clear();
              Provider.of<StepperProvider>(context, listen: false).step = 0;
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertBox();
                  });
            },
            icon: const Icon(Icons.add),
          ),
          PopupMenuButton<int>(
            itemBuilder: (context) {
              return [
                // PopupMenuItem 1
                PopupMenuItem(
                  value: 1,
                  // row with 2 children
                  child: Row(
                    children: [
                      Icon(Icons.light_mode),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Light")
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  // row with 2 children
                  child: Row(
                    children: [
                      Icon(Icons.dark_mode),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Dark")
                    ],
                  ),
                ),
                // PopupMenuItem 2
                PopupMenuItem(
                  value: 2,
                  // row with two children
                  child: Row(
                    children: [
                      Icon(Icons.auto_mode),
                      SizedBox(
                        width: 10,
                      ),
                      Text("System")
                    ],
                  ),
                ),
              ];
            },
            // on selected we show the dialog box
            onSelected: (value) {
              // if value 1 show dialog
              if (value == 1) {
                Provider.of<ChangeThemeProvider>(context, listen: false)
                    .changeThemeMode(1);
              } else if (value == 2) {
                Provider.of<ChangeThemeProvider>(context, listen: false)
                    .changeThemeMode(2);
              } else if (value == 3) {
                Provider.of<ChangeThemeProvider>(context, listen: false)
                    .changeThemeMode(3);
              }
            },
          ),
        ],
      ),
      body: Consumer<ContactProvider>(
        builder: (context, contactProvider, _) {
          return ListView(
            children: contactProvider.allContact.map((e) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('details', arguments: e);
                },
                child: Card(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  color: Colors.grey.shade50,
                  child: ListTile(
                    leading: CircleAvatar(
                      maxRadius: 37,
                      minRadius: 37,
                      backgroundImage: FileImage(File(
                          e.img)), // No matter how big it is, it won't overflow
                    ),
                    title: Text(
                      e.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(e.contact),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class AlertBox extends StatelessWidget {
  AlertBox({super.key});

  ImagePicker imagePicker = ImagePicker();
  XFile? xFile;
  String pickImagePath = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add New Contact"),
      content: SizedBox(
        height: 350,
        width: 280,
        child: Consumer<StepperProvider>(
          builder: (context, stepProvider, _) {
            return Stepper(
              currentStep: stepProvider.step,
              controlsBuilder: (context, _) {
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 95,
                        height: 40,
                        margin: const EdgeInsets.only(right: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            stepProvider.fordwardStep(context, pickImagePath);
                          },
                          child:
                              Text((stepProvider.step == 3) ? "Save" : "Next"),
                        ),
                      ),
                      (stepProvider.step == 0)
                          ? Container()
                          : SizedBox(
                              width: 95,
                              height: 40,
                              child: OutlinedButton(
                                onPressed: () {
                                  stepProvider.backwardStep();
                                },
                                child: const Text("Cancel"),
                              ),
                            ),
                    ],
                  ),
                );
              },
              steps: [
                Step(
                  title: const Text("Name"),
                  content: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: stepProvider.nmController,
                      decoration: const InputDecoration(
                        hintText: "Enter your name",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Step(
                  title: const Text("Contact"),
                  content: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: stepProvider.contactController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: "Enter your contact",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Step(
                  title: const Text("Email"),
                  content: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: stepProvider.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Enter your email",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Step(
                  title: Text("Choose Image From Gallery or Camera"),
                  content: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GestureDetector(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Pick Image",
                                  ),
                                  content: Text(
                                    "Choose Image From Gallery or Camera",
                                  ),
                                  actions: [
                                    FloatingActionButton(
                                      mini: true,
                                      onPressed: () async {
                                        xFile = await imagePicker.pickImage(
                                          source: ImageSource.camera,
                                        );
                                        if (xFile != null) {
                                          pickImagePath = xFile!.path;
                                        }

                                        Navigator.of(context).pop();
                                      },
                                      elevation: 3,
                                      child: Icon(
                                        Icons.camera_alt,
                                      ),
                                    ),
                                    FloatingActionButton(
                                      mini: true,
                                      onPressed: () async {
                                        xFile = await imagePicker.pickImage(
                                          source: ImageSource.gallery,
                                        );
                                        if (xFile != null) {
                                          pickImagePath = xFile!.path;
                                        }

                                        Navigator.of(context).pop();
                                      },
                                      elevation: 3,
                                      child: Icon(
                                        Icons.image,
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: const Text("click")),
                    alignment: Alignment.center,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
