import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_practice/provider/contact_provider.dart';
import 'package:provider_practice/provider/stepper_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/contact.dart';
import 'package:share_extend/share_extend.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Contact data = ModalRoute
        .of(context)!
        .settings
        .arguments as Contact;
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile;
    String pickImagePath = "";

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Provider
                    .of<StepperProvider>(context, listen: false)
                    .nmController
                    .text = data.name;
                Provider
                    .of<StepperProvider>(context, listen: false)
                    .contactController
                    .text = data.contact;
                Provider
                    .of<StepperProvider>(context, listen: false)
                    .emailController
                    .text = data.email;
                pickImagePath = data.img;

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('UPDATE'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
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
                            child: Text(
                              "Select Image from \nGallery and Camera",
                            ),
                          ),
                          TextField(
                            controller: Provider
                                .of<StepperProvider>(context,
                                listen: false)
                                .nmController,
                            decoration: InputDecoration(
                                hintText: "Name", labelText: "Name"),
                            onChanged: (value) {
                              Provider
                                  .of<StepperProvider>(context,
                                  listen: false)
                                  .nmController
                                  .text = value.toString();
                            },
                          ),
                          TextField(
                            controller: Provider
                                .of<StepperProvider>(context,
                                listen: false)
                                .contactController,
                            decoration: InputDecoration(
                              hintText: "Contact",
                              labelText: "Contact",
                            ),
                            onChanged: (value) {
                              Provider
                                  .of<StepperProvider>(context,
                                  listen: false)
                                  .contactController
                                  .text = value.toString();
                            },
                          ),
                          TextField(
                            controller: Provider
                                .of<StepperProvider>(context,
                                listen: false)
                                .emailController,
                            decoration: InputDecoration(
                                hintText: "Email", labelText: "Email"),
                            onChanged: (value) {
                              Provider
                                  .of<StepperProvider>(context,
                                  listen: false)
                                  .emailController
                                  .text = value.toString();
                            },
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Update'),
                          onPressed: () {
                            Provider.of<ContactProvider>(context, listen: false)
                                .updateContacts(data, context, pickImagePath);
                            data = Contact(id: data.id,
                                name
                                :Provider.of<StepperProvider>(context,listen: false).nmController.text,
                                contact: Provider.of<StepperProvider>(context,listen: false).contactController.text,
                                email: Provider.of<StepperProvider>(context,listen: false).emailController.text,
                                img: pickImagePath);

                            Navigator.of(context).pop();
                            // Handle the submit action
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.edit)),
          IconButton(onPressed: () {}, icon: Icon(Icons.star)),
          PopupMenuButton(
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                    onTap: () {
                      ShareExtend.share(
                          "Name: ${data.name}\nContact: ${data.contact}",
                          "Text");
                    },
                    child: Text("Share")),
                PopupMenuItem(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context)
                      {
                        return AlertDialog(
                          title: const Text(
                              'Delete entry'),
                          content: const Text(
                              'Are you sure you want to delete?'),
                          actions: <Widget>[
                            TextButton(
                              child:
                              const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop();
                              },
                            ),
                            TextButton(
                              child:
                              const Text('Confirm'),
                              onPressed: () {
                                Provider.of<ContactProvider>(
                                    context, listen: false)
                                    .deleteContacts(data);
                                Navigator.of(context)
                                    .pushNamed('/');
                              },
                            ),
                          ],
                        );
                      });


                    },
                    child: Text("Delete")),
              ];
            },
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 40),
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              maxRadius: 90,
              minRadius: 90,
              backgroundImage: FileImage(File("${data.img}")),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${data.name}",
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () async {
                    await launchUrl(Uri.parse("tel:${data.contact}"));
                  },
                  child: CircleAvatar(
                      maxRadius: 32,
                      minRadius: 32,
                      child: Icon(
                        Icons.call,
                        size: 32,
                      )),
                ),
                GestureDetector(
                  onTap: () async {
                    await launchUrl(Uri.parse("sms:${data.contact}"));
                  },
                  child: CircleAvatar(
                      maxRadius: 32,
                      minRadius: 32,
                      child: Icon(
                        Icons.chat,
                        size: 32,
                      )),
                ),
                GestureDetector(
                  onTap: () async {
                    await launchUrl(Uri.parse(
                        "mailto:${data
                            .email}?subject=Dummy&body=This is Dummy content"));
                  },
                  child: CircleAvatar(
                      maxRadius: 32,
                      minRadius: 32,
                      child: Icon(
                        Icons.email_sharp,
                        size: 32,
                      )),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Card(
                child: Container(
                  width: double.infinity,
                  height: 120,
                  padding: EdgeInsets.only(left: 15, top: 15),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cotact info",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(Icons.call),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "${data.contact}",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
