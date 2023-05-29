// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  //const Contact({ Key? key }) : super(key: key);
  void launchWhatsApp({
    String phone = "+923116568742",
    String message = "",
  }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunchUrl(Uri.parse(url()))) {
      await launchUrl(Uri.parse(url()));
    } else {
      // throw 'Could not launch ${url()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic devHeight = MediaQuery.of(context).size.height;
    dynamic devWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.blue[300],
        body: SizedBox(
          height: devHeight,
          width: devWidth,
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                height: devHeight / 3,
                width: devWidth,
                child: const Text(
                  "Contact Us",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 50, left: 70, right: 70, bottom: 70),
                child: SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("images/fb.png"),
                      GestureDetector(
                          onTap: () {
                            launchWhatsApp();
                          },
                          child: Image.asset("images/whatsapp.png")),
                      Image.asset("images/gmail.png"),
                    ],
                  ),
                ),
              ),
              const Center(
                child: Divider(
                  color: Colors.blue,
                  thickness: 3,
                  //height: 5,
                  endIndent: 80,
                  indent: 80,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
