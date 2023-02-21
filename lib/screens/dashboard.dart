import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../models/status_model.dart';
import '../widgets/content_ads.dart';
import '../widgets/content_classification.dart';
import '../widgets/shimmer.dart';
// ignore: library_prefixes
import '../widgets/stepper_custom.dart' as stepperCustom;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String documentId = '1FT6W1EV5PWG07389_C99';
  final textControllerVin = TextEditingController();
  bool isSubmitVinSuccess = false;
  late Stream<DocumentSnapshot<Status>> documentStream;
  String download = '';
  String classification = '';
  String video = '';
  String image = '';
  bool errorService = false;

  final textStyleTitle =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    bool classificationDone = false;
    bool classificationInprogress = false;
    bool adsDone = false;
    bool adsInprogress = false;
    bool downloadDone = false;
    bool downloadInprocess = false;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            child: Column(children: [
              Row(children: const [Text('MaiNH2 Tuyet Voi')]),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  alignment: Alignment.centerRight,
                  // decoration: const BoxDecoration(
                  //     image: DecorationImage(
                  //         fit: BoxFit.cover,
                  //         opacity: 0.8,
                  //         image: AssetImage('assets/images/bg_vin.png'))),
                  child: TextField(
                    controller: textControllerVin,
                    // inputFormatters: [LengthLimitingTextInputFormatter(17)],
                    decoration: const InputDecoration(
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide:
                      //       BorderSide(color: Colors.redAccent, width: 0.0),
                      // ),
                      border: OutlineInputBorder(),
                      labelText: 'Enter your VIN',
                    ),
                    onSubmitted: (value) async {
                      // documentId =
                      //     '${textControllerVin.text}_${DateTime.now().millisecondsSinceEpoch}';

                      try {
                        // final responseData = submitVin(documentId);
                        // if (responseData) {
                        setState(() {
                          isSubmitVinSuccess = true;
                          documentStream = FirebaseFirestore.instance
                              .collection('status')
                              .doc(documentId)
                              .withConverter<Status>(
                                fromFirestore: (snapshot, _) =>
                                    Status.fromJson(snapshot.data()!),
                                toFirestore: (status, _) => status.toJson(),
                              )
                              .snapshots();
                        });
                        // } else {}
                      } catch (e) {
                        /// Error service
                      }
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
                      classificationDone = false;
                      classificationInprogress = false;
                      adsDone = false;
                      adsInprogress = false;
                      downloadDone = false;
                      downloadInprocess = false;
                      if (currentStatus!.classification == 'done') {
                        classificationDone = true;
                        classificationInprogress = false;
                      }
                      if (currentStatus.classification == 'in-process') {
                        classificationDone = false;
                        classificationInprogress = true;
                      }
                      if (currentStatus.video == 'done') {
                        adsDone = true;
                        adsInprogress = false;
                      }
                      if (currentStatus.video == 'in-process') {
                        adsDone = false;
                        adsInprogress = true;
                      }
                      if (currentStatus.download == 'done') {
                        downloadDone = true;
                        downloadInprocess = false;
                      }
                      if (currentStatus.download == 'in-process') {
                        downloadDone = false;
                        downloadInprocess = true;
                      }
                      return Theme(
                        data: ThemeData(
                            primaryColor: Colors.red,
                            canvasColor: Colors.lightBlue),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular((3)),
                            ),
                          ),
                          child: stepperCustom.ModifiedStepper(
                              controlsBuilder: (BuildContext buildContext,
                                  stepperCustom.ControlsDetails
                                      controlsDetails) {
                                return Row(
                                  children: <Widget>[
                                    Container(),
                                  ],
                                );
                              },
                              steps: [
                                stepperCustom.ModifiedStep(
                                    state: downloadInprocess
                                        ? stepperCustom.StepState.editing
                                        : downloadDone
                                            ? stepperCustom.StepState.complete
                                            : stepperCustom.StepState.indexed,
                                    title: Row(
                                      children: [
                                        Text(
                                          'Download',
                                          style: textStyleTitle,
                                        ),
                                        if (downloadDone)
                                          const SizedBox(
                                            width: 20,
                                          ),
                                        if (downloadDone)
                                          const Icon(
                                            Icons.check_circle_outline_outlined,
                                            color: Colors.white,
                                          ),
                                        if (downloadInprocess)
                                          const SizedBox(
                                            width: 100,
                                          ),
                                        if (downloadInprocess)
                                          LoadingAnimationWidget.newtonCradle(
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            size: 100,
                                          ),
                                      ],
                                    ),
                                    content: Column(
                                      children: [
                                        Shimmer.fromColors(
                                          baseColor:
                                              ColorsCustom.primary.shade50,
                                          highlightColor: ColorsCustom
                                              .primary.shade100
                                              .withOpacity(0.3),
                                          child: Container(
                                            color: Colors.black12,
                                            child: const Text('Hello'),
                                          ),
                                        )
                                      ],
                                    )),

                                /// Enable when backend done
                                // if (classificationInprogress ||
                                //     classificationDone)
                                stepperCustom.ModifiedStep(
                                    state: classificationInprogress
                                        ? stepperCustom.StepState.editing
                                        : classificationDone
                                            ? stepperCustom.StepState.complete
                                            : stepperCustom.StepState.indexed,
                                    title: Row(
                                      mainAxisAlignment: classificationDone
                                          ? MainAxisAlignment.start
                                          : MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Classification',
                                          style: textStyleTitle,
                                        ),
                                        if (classificationDone)
                                          const SizedBox(
                                            width: 20,
                                          ),
                                        if (classificationDone)
                                          const Icon(
                                            Icons.check_circle_outline_outlined,
                                            color: Colors.white,
                                          ),
                                        if (classificationInprogress)
                                          const SizedBox(
                                            width: 100,
                                          ),
                                        if (classificationInprogress)
                                          LoadingAnimationWidget.newtonCradle(
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            size: 100,
                                          ),
                                      ],
                                    ),
                                    content: ContentClassification(
                                      idVin: documentId,
                                    )),

                                // if (adsInprogress || adsDone)
                                stepperCustom.ModifiedStep(
                                  state: adsInprogress
                                      ? stepperCustom.StepState.editing
                                      : adsDone
                                          ? stepperCustom.StepState.complete
                                          : stepperCustom.StepState.indexed,
                                  title: Row(
                                    children: [
                                      Text(
                                        'Ads',
                                        style: textStyleTitle,
                                      ),
                                      if (adsDone)
                                        const SizedBox(
                                          width: 20,
                                        ),
                                      if (adsDone)
                                        const Icon(
                                          Icons.check_circle_outline_outlined,
                                          color: Colors.white,
                                        ),
                                      if (adsInprogress)
                                        const SizedBox(
                                          width: 100,
                                        ),
                                      if (adsInprogress)
                                        LoadingAnimationWidget.newtonCradle(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          size: 100,
                                        ),
                                    ],
                                  ),
                                  content: ContentAds(
                                    idVin: documentId,
                                  ),
                                )
                              ]),
                        ),
                      );
                    } catch (e) {
                      Future.delayed(
                          Duration.zero,
                          () => showBottomSheet(
                              backgroundColor: Colors.grey.shade50,
                              constraints: const BoxConstraints(maxHeight: 500),
                              context: context,
                              builder: (BuildContext contextDiaglog) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Center(
                                    child: SizedBox(
                                      height: 500,
                                      width: 500,
                                      child: Column(
                                        children: [
                                          const Text(
                                              'Something wrong with service. Please try again!'),
                                          const SizedBox(
                                            height: 50,
                                          ),
                                          Text(e.toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }));
                    }
                    return Container();
                  },
                ),
            ]),
          ),
        ),
      ),
    );
  }
}

bool getIsActive(int currentIndex, int index) {
  if (currentIndex <= index) {
    return true;
  } else {
    return false;
  }
}

Future<bool> submitVin(String vinId) async {
  String url = 'http://35.226.148.8:5000/dummy/';
  final response = await http.get(Uri.parse(url + vinId));

  if (response.statusCode == 200) {
    print(response);
    return true;
  } else {
    throw Exception('Failed to load album');
  }
}
