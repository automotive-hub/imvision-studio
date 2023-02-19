import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../models/status_model.dart';
import '../widgets/content_ads.dart';
import '../widgets/divider.dart';
import '../widgets/shimmer.dart';
import '../widgets/stepper_ads.dart';
import '../widgets/stepper_ads.dart';
import '../widgets/stepper_custom.dart' as stepperCustom;

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
  bool hide = false;

  final textStyleTitle =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    bool classificationDone = false;
    bool classificationInprocess = false;
    bool adsDone = false;
    bool adsInprocess = false;
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
                    inputFormatters: [LengthLimitingTextInputFormatter(17)],
                    decoration: const InputDecoration(
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide:
                      //       BorderSide(color: Colors.redAccent, width: 0.0),
                      // ),
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
                      classificationInprocess = false;
                      adsDone = false;
                      adsInprocess = false;
                      downloadDone = false;
                      downloadInprocess = false;
                      if (currentStatus!.classification == 'done') {
                        classificationDone = true;
                        classificationInprocess = false;
                      }
                      if (currentStatus.classification == 'in-process') {
                        classificationDone = false;
                        classificationInprocess = true;
                      }
                      if (currentStatus.video == 'done') {
                        adsDone = true;
                        adsInprocess = false;
                      }
                      if (currentStatus.video == 'in-process') {
                        adsDone = false;
                        adsInprocess = true;
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
                                        : stepperCustom.StepState.complete,
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
                                          child: Container(
                                            color: Colors.black12,
                                            child: Text('Hello'),
                                          ),
                                          baseColor:
                                              ColorsCustom.primary.shade50,
                                          highlightColor: ColorsCustom
                                              .primary.shade100
                                              .withOpacity(0.3),
                                        )
                                      ],
                                    )),
                                if (currentStatus.classification == 'idle')
                                  stepperCustom.ModifiedStep(
                                      state: classificationInprocess
                                          ? stepperCustom.StepState.editing
                                          : stepperCustom.StepState.complete,
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
                                              Icons
                                                  .check_circle_outline_outlined,
                                              color: Colors.white,
                                            ),
                                          if (classificationInprocess)
                                            const SizedBox(
                                              width: 100,
                                            ),
                                          if (classificationInprocess)
                                            LoadingAnimationWidget.newtonCradle(
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              size: 100,
                                            ),
                                        ],
                                      ),
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'EXTERIOR',
                                            style: textStyleTitle,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          // if (currentStatus.classification ==
                                          //     'in-process')
                                          ShimmerCustom(),
                                          // if(currentStatus.classification ==
                                          //     'done')
                                          // Row(
                                          //   children: [
                                          //     ListView(
                                          //       children: [],
                                          //     )
                                          //   ],
                                          // ),
                                          DividerCustom(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'RIGHT_PANEL',
                                            style: textStyleTitle,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ShimmerCustom(),
                                          DividerCustom(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'BOTTOM_RIGHT_PANEL',
                                            style: textStyleTitle,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ShimmerCustom(),
                                          DividerCustom(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'BOTTOM_BACK',
                                            style: textStyleTitle,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ShimmerCustom(),
                                          DividerCustom(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'BOTTOM_LEFT_PANEL',
                                            style: textStyleTitle,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ShimmerCustom(),
                                          DividerCustom(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'BOTTOM_LEFT',
                                            style: textStyleTitle,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ShimmerCustom(),
                                          DividerCustom(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'DASH_PANEL',
                                            style: textStyleTitle,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ShimmerCustom(),
                                          DividerCustom(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'MID_CENTER_POINT',
                                            style: textStyleTitle,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ShimmerCustom(),
                                          DividerCustom(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'IMAGE_WITH_ADVERTISEMENT',
                                            style: textStyleTitle,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ShimmerCustom(),
                                        ],
                                      )),
                                // if (currentStatus.video == 'idle')
                                stepperCustom.ModifiedStep(
                                  state: adsInprocess
                                      ? stepperCustom.StepState.editing
                                      : stepperCustom.StepState.complete,
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
                                      if (adsInprocess)
                                        const SizedBox(
                                          width: 100,
                                        ),
                                      if (adsInprocess)
                                        LoadingAnimationWidget.newtonCradle(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          size: 100,
                                        ),
                                    ],
                                  ),
                                  content: ContentAds(),

                                  // widgetStepperAds(
                                  //     adsInprocess, adsDone, context, documentId)
                                )
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
