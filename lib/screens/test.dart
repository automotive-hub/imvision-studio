import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imvision_studio/models/status_model.dart';
import 'package:imvision_studio/widgets/content_download.dart';
import 'package:provider/provider.dart';

import '../constants/global_constants.dart';
import '../services/firestore_database.dart';
import '../widgets/classification/content_classification.dart';
import '../widgets/dashboard/info_corner.dart';
import 'package:http/http.dart' as http;

import '../widgets/dashboard/menu_button.dart';
import '../widgets/dashboard/vin_put.dart';
import '../widgets/shimmer_default.dart';

class DashBoardTest extends StatefulWidget {
  const DashBoardTest({super.key});

  @override
  State<DashBoardTest> createState() => _DashBoardTestState();
}

class _DashBoardTestState extends State<DashBoardTest> {
  final textControllerVin = TextEditingController();

  Widget switchWidget = ShimmerDefaultCustom();
  callbackSwitchWidget(newWidget) {
    setState(() {
      switchWidget = newWidget;
    });
  }

  String vin = '';

  @override
  Widget build(BuildContext context) {
    const double paddingWithTitle = 100;
    final double getSizeScreen = MediaQuery.of(context).size.width;
    final double sizeContainerButllet = getSizeScreen / 6;
    final double sizeContainerDetails =
        getSizeScreen - sizeContainerButllet - 120;
    const double marginContainerDetails = 20;
    const TextStyle styleTitle = TextStyle(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 17);
    const TextStyle styleEmailUser =
        TextStyle(color: Colors.grey, fontSize: 12);
    bool isClassificationDone = false;
    bool isClassificationInprocess = false;
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: IconButton(
          color: Colors.grey[200],
          iconSize: 55,
          onPressed: () {},
          icon: const Icon(Icons.info)),
      body: SafeArea(
          child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 50, right: 20),
            child: Container(
              width: sizeContainerButllet,
              height: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoCorner(),
                    const SizedBox(height: paddingWithTitle),
                    const VehicleVINInput(),
                    const SizedBox(
                      height: marginContainerDetails,
                    ),
                    TextButton(
                        onPressed: () async {},
                        child: Text(
                          GlobalText.titleDashboard,
                          style: styleTitle.copyWith(color: Colors.grey),
                        )),
                    const SizedBox(
                      height: marginContainerDetails,
                    ),
                    MenuButton(
                      menuType: AppMenu.download,
                      title: GlobalText.titleDownload,
                      switchWidget: callbackSwitchWidget,
                    ),
                    const SizedBox(
                      height: marginContainerDetails,
                    ),
                    MenuButton(
                      menuType: AppMenu.classification,
                      title: GlobalText.titleClassification,
                      switchWidget: callbackSwitchWidget,
                    ),
                    const SizedBox(
                      height: marginContainerDetails,
                    ),
                    MenuButton(
                      menuType: AppMenu.video,
                      title: GlobalText.titleAds,
                      switchWidget: callbackSwitchWidget,
                    ),
                    const SizedBox(
                      height: marginContainerDetails,
                    ),
                    DebugVIN(
                      styleTitle: styleTitle,
                      vin: '2G61N5S36J9156077_C99001',
                    ),
                    const SizedBox(
                      height: marginContainerDetails,
                    ),
                    DebugVIN(
                      styleTitle: styleTitle,
                      vin: '1FTER4FH1MLD65064_1677140984969',
                    ),
                  ]),
            ),
          ),
          Container(
            width: sizeContainerDetails,
            margin: const EdgeInsets.symmetric(
                horizontal: marginContainerDetails,
                vertical: marginContainerDetails),
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: switchWidget,
          )
        ],
      )),
    );
  }

  Future<bool> submitVin(String vinId) async {
    // String url = 'https://staging.imvision-hackathon.tech/dummy/';
    // // String url = 'http://34.136.157.18:5000/dummy/';

    // final response = await http.post(Uri.parse(url + vinId),
    //     headers: {'Access-Control-Allow-Origin': '*'});

    // if (response.statusCode == 200) {
    // response.body['message'] :
    // print(response);
    return true;
    // } else {
    //   throw Exception('Failed to load album');
    // }
  }
}

class DebugVIN extends StatelessWidget {
  final String vin;
  const DebugVIN({
    Key? key,
    required this.styleTitle,
    required this.vin,
  }) : super(key: key);

  final TextStyle styleTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white30,
      child: Column(
        children: [
          TextButton(
              onPressed: () async {
                await context.read<FireStoreDatabase>().init(vin: this.vin);
                context
                    .read<FireStoreDatabase>()
                    .generationStatusStream
                    .listen((event) {
                  print(vin + event.toJson().toString());
                });
              },
              child: Text(
                "DEBUG VIN : " + vin,
                style: styleTitle.copyWith(color: Colors.grey),
              )),
        ],
      ),
    );
  }
}
