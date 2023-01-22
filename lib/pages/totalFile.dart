import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_tracking_system/costomWidget/fullButton.dart';
import 'package:file_tracking_system/costomWidget/internetConntivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TotalFile extends StatelessWidget {
  TotalFile({super.key});
  final db = FirebaseFirestore.instance
      .collection("allUser")
      .doc("9409497905")
      .collection("allFile")
      .snapshots();

  Widget iconFun(String status) {
    if (status == "reject") {
      return Icon(
        Icons.cancel,
        color: Colors.red,
      );
    } else if (status == "pandding") {
      return Icon(
        Icons.work_history,
        color: Color.fromARGB(255, 234, 187, 17),
      );
    } else if (status == "approve") {
      return Icon(
        Icons.verified,
        color: Color.fromARGB(255, 15, 161, 20),
      );
    }
    return Icon(Icons.abc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("All Files"),
          centerTitle: true,
          backgroundColor: PrimaryColor,
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 20),
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
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: db,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              "Some Error",
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                        }

                        if (snapshot.hasData) {}

                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(5),
                              child: Card(
                                  elevation: 15,
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              snapshot.data!.docs[index]
                                                  .reference.id
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            iconFun(snapshot
                                                .data!.docs[index]["status"]
                                                .toString()),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "File Name :- ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              snapshot
                                                  .data!.docs[index]["fileName"]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "File Submit Date :- ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              snapshot.data!
                                                  .docs[index]["submitDate"]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: PrimaryColor),
                                            onPressed: () {
                                              InternetConntivity();
                                            },
                                            child: Text(
                                              "Trak File",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))
                                      ],
                                    ),
                                  )),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            )));
  }
}
