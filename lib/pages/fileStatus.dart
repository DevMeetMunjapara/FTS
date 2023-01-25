import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_tracking_system/costomWidget/fileStatusIcon.dart';
import 'package:file_tracking_system/costomWidget/fullButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FileStatus extends StatelessWidget {
  var trckingId;

  FileStatus({
    super.key,
    required this.trckingId,
  });

  var fileData = FirebaseFirestore.instance
      .collection("allUser")
      .doc("9409497905")
      .collection("allFile");

  Widget getFileData() {
    return FutureBuilder(
      future: fileData.doc(trckingId).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("The Data Not Found");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document Not Exist");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: EdgeInsets.only(top: 20),
            child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Card(
                        elevation: 15,
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Traking ID : " + trckingId,
                                    textScaleFactor: 1.3,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  FileStatusIcon(fileStatus: data["fileStatus"])
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                "File Submition Information",
                                textScaleFactor: 1.2,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "File Name :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["fileName"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "File Submit Date :- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data["submitDate"],
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ],
                )),
          );
        }

        return Text("loading");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        title: Text("File Status"),
        elevation: 10,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "File Reject ",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "In Procces ",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.work_history,
                          color: Color.fromARGB(255, 234, 187, 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "File Approve ",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.verified,
                          color: Color.fromARGB(255, 15, 161, 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              getFileData(),
            ],
          ),
        ),
      ),
    );
  }
}
