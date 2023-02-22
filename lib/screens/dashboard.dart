import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../constants/global_constants.dart';
import '../models/status_model.dart';
// ignore: library_prefixes
import '../widgets/stepper.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String documentId = '1FMCU9G62LUB64553_1676971001985';
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
                      documentId =
                          '${textControllerVin.text}_${DateTime.now().millisecondsSinceEpoch}';

                      try {
                        final responseData = await submitVin(documentId);
                        if (responseData) {
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
                        } else {}
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
                      if (currentStatus.classification == 'processing') {
                        classificationDone = false;
                        classificationInprogress = true;
                      }
                      if (currentStatus.video == 'done') {
                        adsDone = true;
                        adsInprogress = false;
                      }
                      if (currentStatus.video == 'processing') {
                        adsDone = false;
                        adsInprogress = true;
                      }
                      if (currentStatus.download == 'done') {
                        downloadDone = true;
                        downloadInprocess = false;
                      }
                      if (currentStatus.download == 'processing') {
                        downloadDone = false;
                        downloadInprocess = true;
                      }
                      return Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular((3)),
                            ),
                          ),
                          child: Column(
                            children: [
                              StepperCustom(
                                title: GlobalText.titleDownload,
                                isDone: downloadDone,
                                isInprocess: downloadInprocess,
                                vinId: documentId,
                                isDownloadWidget: true,
                              ),
                              StepperCustom(
                                title: GlobalText.titleClassification,
                                isDone: classificationDone,
                                isInprocess: classificationInprogress,
                                vinId: documentId,
                                isClassificationWidget: true,
                              ),
                              StepperCustom(
                                title: GlobalText.titleAds,
                                isDone: adsDone,
                                isInprocess: adsInprogress,
                                vinId: documentId,
                                isAdsWidget: true,
                              ),
                            ],
                          ));

                      //  stepperCustom.ModifiedStepper(
                      //     controlsBuilder: (BuildContext buildContext,
                      //         stepperCustom.ControlsDetails
                      //             controlsDetails) {
                      //       return Row(
                      //         children: <Widget>[
                      //           Container(),
                      //         ],
                      //       );
                      //     },
                      //     steps: [
                      //       stepperCustom.ModifiedStep(
                      //           title: TitleStepperCustom(
                      //             title: 'Download',
                      //             isDone: downloadDone,
                      //             isInprogress: downloadInprocess,
                      //           ),
                      //           content: ShimmerCustom()),

                      //       /// Enable when backend done
                      //       if (classificationInprogress ||
                      //           classificationDone)
                      //         stepperCustom.ModifiedStep(
                      //             title: TitleStepperCustom(
                      //               title: 'Classification',
                      //               isDone: classificationDone,
                      //               isInprogress: classificationInprogress,
                      //             ),
                      //             content: ContentClassification(
                      //               idVin: documentId,
                      //               isDone: classificationDone,
                      //             isInprogress: classificationInprogress,
                      //             )),

                      //       if (adsInprogress || adsDone)
                      //         stepperCustom.ModifiedStep(

                      //           title: TitleStepperCustom(
                      //             title: 'Ads',
                      //             isDone: adsDone,
                      //             isInprogress: adsInprogress,
                      //           ),
                      //           content: ContentAds(
                      //             idVin: documentId,
                      //             isDone: adsDone,
                      //             isInprogress: adsInprogress,
                      //           ),
                      //         )
                      //     ]),
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

Future<bool> submitVin(String vinId) async {
  String url = 'https://api.imvision-hackathon.tech:5000/dummy/';
  // String url = 'http://34.136.157.18:5000/dummy/';

  final response = await http.post(Uri.parse(url + vinId),
      headers: {'Access-Control-Allow-Origin': '*'});

  if (response.statusCode == 200) {
    // response.body['message'] :
    print(response);
    return true;
  } else {
    throw Exception('Failed to load album');
  }
}
