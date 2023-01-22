import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConntivity extends StatefulWidget {
  const InternetConntivity({super.key});

  @override
  State<InternetConntivity> createState() => _InternetConntivityState();
}

class _InternetConntivityState extends State<InternetConntivity> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertset = false;

  getContivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasListeners;
      if (!isDeviceConnected && isAlertset == false) {
        showDialogBox();
        setState(() {
          isAlertset = true;
        });
      }
    });
  }

  showDialogBox() {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text("No Internet Conntivity"),
              content: Text("Please check your internet conntivity"),
              actions: [
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context, "cancel");
                      setState(() {
                        isAlertset = false;
                      });

                      isDeviceConnected =
                          await InternetConnectionChecker().hasConnection;
                      if (!isDeviceConnected) {
                        showDialogBox();
                        setState(() {
                          isAlertset = true;
                        });
                      }
                    },
                    child: Text("Ok"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoAlertDialog(
        title: Text("No Internet Conntivity"),
        content: Text("Please check your internet conntivity"),
        actions: [TextButton(onPressed: () async {}, child: Text("Ok"))],
      ),
    );
  }
}
