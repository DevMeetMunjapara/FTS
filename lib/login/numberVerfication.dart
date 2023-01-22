import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_tracking_system/costomWidget/fullButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NumberVerfication extends StatefulWidget {
  const NumberVerfication({super.key});

  @override
  State<NumberVerfication> createState() => NumberVerficationState();
}

class NumberVerficationState extends State<NumberVerfication> {
  final GlobalKey<FormState> _mobileKey = GlobalKey<FormState>();
  TextEditingController mobileNumber = TextEditingController();
  final auth = FirebaseAuth.instance;
  var contryCode = "+91";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Image(
                image: AssetImage("img/login/mobileNumber.png"),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Phone Verfication",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone number before getting started!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _mobileKey,
                child: TextFormField(
                  controller: mobileNumber,
                  keyboardType: TextInputType.number,
                  cursorColor: PrimaryColor,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: PrimaryColor),
                      borderRadius: BorderRadius.circular(5.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: PrimaryColor),
                      borderRadius: BorderRadius.circular(5.5),
                    ),
                    prefixIcon: Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                        child: Text(
                          "+91",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    hintText: "Enter Mobile Number",
                    hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    filled: true,
                    fillColor: Color.fromARGB(255, 231, 231, 231),
                  ),
                  validator: (val) {
                    if (val == "") {
                      return "Enter Mobile Number";
                    }
                    if (val!.length != 10) {
                      return 'Only 10 digit number valid';
                    }
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 20,
              ),
              FullButton(
                title: "Send OTP",
                onPressed: () async {
                  print(contryCode + mobileNumber.text);
                  if (_mobileKey.currentState!.validate()) {
                    auth.verifyPhoneNumber(
                        phoneNumber: contryCode + mobileNumber.text,
                        verificationCompleted: (phoneAuthCredential) {},
                        verificationFailed: (e) {
                          print(e);
                        },
                        codeSent: (verificationId, int? token) {},
                        codeAutoRetrievalTimeout: (verificationId) {});
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
