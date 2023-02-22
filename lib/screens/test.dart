import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../constants/global_constants.dart';
import '../services/firestore_database.dart';
import '../widgets/dashboard/info_corner.dart';
import 'package:http/http.dart' as http;

class DashBoardTest extends StatefulWidget {
  const DashBoardTest({super.key});

  @override
  State<DashBoardTest> createState() => _DashBoardTestState();
}

class _DashBoardTestState extends State<DashBoardTest> {
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
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton:
          IconButton(onPressed: () {}, icon: Icon(Icons.insights)),
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
                    TextButton(
                        onPressed: () async {
                          var vin =
                              '3FA6P0G76JR114164_${DateTime.now().millisecondsSinceEpoch}';
                          await submitVin(vin);
                          context.read<FireStoreDatabase>().init(vin: vin);
                          context
                              .read<FireStoreDatabase>()
                              .generationStatusStream
                              .listen((event) {
                            print(event.toJson());
                          });
                        },
                        child: Text(
                          GlobalText.titleDashboard,
                          style: styleTitle.copyWith(color: Colors.grey),
                        )),
                    const SizedBox(
                      height: marginContainerDetails,
                    ),
                    TextButton(
                        onPressed: () {
                          print('Download');
                        },
                        child: const Text(
                          GlobalText.titleDownload,
                          style: styleTitle,
                        )),
                    const SizedBox(
                      height: marginContainerDetails,
                    ),
                    TextButton(
                        onPressed: () {
                          print('Classification');
                        },
                        child: const Text(
                          GlobalText.titleClassification,
                          style: styleTitle,
                        )),
                    const SizedBox(
                      height: marginContainerDetails,
                    ),
                    TextButton(
                        onPressed: () {
                          print('Ads');
                        },
                        child: const Text(
                          GlobalText.titleAds,
                          style: styleTitle,
                        ))
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
            child: const Text('asdas'),
          )
        ],
      )),
    );
  }

  Future<bool> submitVin(String vinId) async {
    String url = 'https://staging.imvision-hackathon.tech/dummy/';
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
}
