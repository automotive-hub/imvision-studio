import 'package:flutter/material.dart';
import 'package:imvision_studio/models/status_model.dart';
import 'package:provider/provider.dart';

import '../constants/global_constants.dart';
import '../services/firestore_database.dart';
import '../widgets/dashboard/dashboard_content.dart';
import '../widgets/core/info_corner.dart';
import '../widgets/core/menu_button.dart';
import '../widgets/core/vin_put.dart';
import '../widgets/shimmer_default.dart';

class CoreScreen extends StatefulWidget {
  const CoreScreen({super.key});

  @override
  State<CoreScreen> createState() => _CoreScreenState();
}

class _CoreScreenState extends State<CoreScreen> {
  final textControllerVin = TextEditingController();

  Widget switchWidget = ShimmerDefaultCustom();
  callbackSwitchWidget(newWidget) {
    if (this.mounted) {
      setState(() {
        switchWidget = newWidget;
      });
    }
  }

  String vin = '';
  callbackVinNumber(vinNumberInput) {
    if (this.mounted) {
      vin = vinNumberInput;

      final screenName = switchWidget.toString();
      if (screenName == 'DashBoardScreen') {
        switchWidget =
            DashBoardScreen(idVin: vin, callBackVin: callbackVinNumber);
      }
      print(switchWidget.toString());
      setState(() {});
    }
  }

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
            child: SizedBox(
              width: sizeContainerButllet,
              height: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoCorner(),
                    const SizedBox(height: paddingWithTitle),
                    VehicleVINInput(
                      vinNumber: callbackVinNumber,
                      switchWidget: callbackSwitchWidget,
                      idVin: vin,
                    ),
                    const SizedBox(
                      height: marginContainerDetails,
                    ),
                    TextButton(
                        onPressed: () async {
                          switchWidget = DashBoardScreen(
                            idVin: vin,
                            callBackVin: callbackVinNumber,
                          );
                          setState(() {});
                        },
                        child: Text(
                          GlobalText.titleDashboard,
                          style: styleTitle.copyWith(color: Colors.white),
                        )),
                    const SizedBox(
                      height: marginContainerDetails,
                    ),
                    MenuButton(
                      menuType: AppMenu.download,
                      title: GlobalText.titleDownload,
                      switchWidget: callbackSwitchWidget,
                      idVin: vin,
                    ),
                    const SizedBox(
                      height: marginContainerDetails,
                    ),
                    MenuButton(
                      menuType: AppMenu.classification,
                      title: GlobalText.titleClassification,
                      switchWidget: callbackSwitchWidget,
                      idVin: vin,
                    ),
                    const SizedBox(
                      height: marginContainerDetails,
                    ),
                    MenuButton(
                      menuType: AppMenu.video,
                      title: GlobalText.titleAds,
                      switchWidget: callbackSwitchWidget,
                      idVin: vin,
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
