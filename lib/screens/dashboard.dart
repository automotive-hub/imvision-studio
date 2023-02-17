import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../models/status_model.dart';
import '../widgets/slider_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String documentId = 'JA4AZ3A30LZ038326_1676364152141';
  final textControllerVin = TextEditingController();
  bool isSubmitVinSuccess = false;
  late Stream<DocumentSnapshot<Status>> documentStream;
  String download = '';
  String classification = '';
  String video = '';
  String image = '';
  double _value = 100.0;
  // final statusDocumentRef = FirebaseFirestore.instance.collection('Status').doc("xxx").sna;
  @override
  Widget build(BuildContext context) {
    // final Stream<QuerySnapshot> _usersStream =
    //     FirebaseFirestore.instance.collection('users').snapshots();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child: Column(children: [
            Row(children: [const Text('KBBMobile-Innovation-Idea')]),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                alignment: Alignment.centerRight,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        opacity: 0.6,
                        image: AssetImage('assets/images/bg_vin.png'))),
                child: TextField(
                  controller: textControllerVin,
                  inputFormatters: [LengthLimitingTextInputFormatter(17)],
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.redAccent, width: 0.0),
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Enter your VIN',
                  ),
                  onSubmitted: (value) {
                    // documentId =
                    //     textControllerVin.text + DateTime.now().millisecondsSinceEpoch.toString();

                    setState(() {
                      isSubmitVinSuccess = true;
                      documentStream = FirebaseFirestore.instance
                          .collection('status')
                          .doc(documentId.toLowerCase())
                          .withConverter<Status>(
                            fromFirestore: (snapshot, _) =>
                                Status.fromJson(snapshot.data()!),
                            toFirestore: (status, _) => status.toJson(),
                          )
                          .snapshots();
                    });
                    print(documentId);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            if (isSubmitVinSuccess)
              StreamBuilder(
                stream: documentStream,
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot<Status>> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }
                  try {
                    final currentStatus = snapshot.data?.data();
                    return Theme(
                      data: ThemeData(
                          primaryColor: Colors.red,
                          canvasColor: Colors.lightBlue),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular((3)),
                          ),
                          gradient: LinearGradient(
                              colors: [
                                Color(0xFF00c6ff),
                                Color(0xFF0072ff),
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 1.00),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: Stepper(steps: [
                          Step(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Download',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                LoadingAnimationWidget.newtonCradle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 100,
                                ),
                                const SizedBox.shrink(),
                              ],
                            ),
                            content: const Text('Lo'),
                            isActive: true,
                          ),
                          Step(
                              title: Row(
                                children: [
                                  Text('dasdsa'),
                                  LoadingAnimationWidget.newtonCradle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    size: 100,
                                  ),
                                  const SizedBox.shrink(),
                                ],
                              ),
                              content: Text('grgr')),
                          const Step(
                              title: Text('dasdsa'), content: Text('grgr')),
                        ]),
                      ),
                    );
                  } catch (e) {
                    print(e);
                  }
                  return Container();
                },
              ),
          ]),
        ),
      ),
    );
  }
}
