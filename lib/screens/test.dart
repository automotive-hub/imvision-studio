import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../constants/global_constants.dart';

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
    const TextStyle styleNameUser = TextStyle(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20);
    const TextStyle styleTitle = TextStyle(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 17);
    const TextStyle styleEmailUser =
        TextStyle(color: Colors.grey, fontSize: 12);
    return Scaffold(
      backgroundColor: Colors.black,
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
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/images/avatar.jpeg')),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      TitleUSer.userName,
                      style: styleNameUser,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const Text(
                      TitleUSer.email,
                      style: styleEmailUser,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: paddingWithTitle),
                    TextButton(
                        onPressed: () {
                          print('Dash board');
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
}
