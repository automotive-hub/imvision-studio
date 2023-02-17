import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../models/status_model.dart';
import '../widgets/divider.dart';
import '../widgets/shimmer.dart';
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
  double _value = 100.0;
  bool hide = false;

  final textStyleTitle =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          opacity: 0.8,
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
                            // gradient: LinearGradient(
                            //     colors: [
                            //       Color(0xFF00c6ff),
                            //       Color(0xFF0072ff),
                            //     ],
                            //     begin: FractionalOffset(0.0, 0.0),
                            //     end: FractionalOffset(1.0, 1.00),
                            //     stops: [0.0, 1.0],
                            //     tileMode: TileMode.clamp),
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
                                    state:
                                        currentStatus!.download == 'in-process'
                                            ? stepperCustom.StepState.editing
                                            : stepperCustom.StepState.complete,
                                    title: Row(
                                      children: [
                                        Text(
                                          'Download',
                                          style: textStyleTitle,
                                        ),
                                        if (currentStatus.download == 'done')
                                          const SizedBox(
                                            width: 20,
                                          ),
                                        if (currentStatus.download == 'done')
                                          const Icon(
                                            Icons.check_circle_outline_outlined,
                                            color: Colors.white,
                                          ),
                                        if (currentStatus.download ==
                                            'in-process')
                                          const SizedBox(
                                            width: 100,
                                          ),
                                        if (currentStatus.download ==
                                            'in-process')
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
                                      state: currentStatus.classification ==
                                              'in-process'
                                          ? stepperCustom.StepState.editing
                                          : stepperCustom.StepState.complete,
                                      title: Row(
                                        mainAxisAlignment: currentStatus
                                                    .classification ==
                                                'done'
                                            ? MainAxisAlignment.start
                                            : MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Classification',
                                            style: textStyleTitle,
                                          ),
                                          if (currentStatus.classification ==
                                              'done')
                                            const SizedBox(
                                              width: 20,
                                            ),
                                          if (currentStatus.classification ==
                                              'done')
                                            const Icon(
                                              Icons
                                                  .check_circle_outline_outlined,
                                              color: Colors.white,
                                            ),
                                          if (currentStatus.classification ==
                                              'in-process')
                                            const SizedBox(
                                              width: 100,
                                            ),
                                          if (currentStatus.classification ==
                                              'in-process')
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
                                if (currentStatus.video == 'idle')
                                  stepperCustom.ModifiedStep(
                                    state: currentStatus.video == 'in-process'
                                        ? stepperCustom.StepState.editing
                                        : stepperCustom.StepState.complete,
                                    title: Row(
                                      children: [
                                        Text(
                                          'Ads',
                                          style: textStyleTitle,
                                        ),
                                        if (currentStatus.video == 'done')
                                          const SizedBox(
                                            width: 20,
                                          ),
                                        if (currentStatus.video == 'done')
                                          const Icon(
                                            Icons.check_circle_outline_outlined,
                                            color: Colors.white,
                                          ),
                                        if (currentStatus.video == 'in-process')
                                          const SizedBox(
                                            width: 100,
                                          ),
                                        if (currentStatus.video == 'in-process')
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
                                          'Video',
                                          style: textStyleTitle,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ShimmerCustom(),
                                        DividerCustom(),
                                        Text(
                                          'Gif',
                                          style: textStyleTitle,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ShimmerCustom(),
                                        DividerCustom(),
                                        Text(
                                          'Image',
                                          style: textStyleTitle,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ShimmerCustom(),
                                        DividerCustom(),
                                      ],
                                    ),
                                  ),
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
