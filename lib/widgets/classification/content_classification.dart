import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imvision_studio/widgets/shimmer.dart';
import 'package:imvision_studio/widgets/shimmer_default.dart';
import 'package:provider/provider.dart';

import '../../constants/global_constants.dart';
import '../../services/firestore_database.dart';
import '../divider.dart';
import '../title_custom_widget.dart';

// ignore: must_be_immutable
class ContentClassification extends StatefulWidget {
  bool isDone;
  bool isInprogress;
  String vinId;
  ContentClassification(
      {super.key,
      this.isDone = false,
      this.isInprogress = false,
      required this.vinId});

  @override
  State<ContentClassification> createState() => _ContentClassificationState();
}

class _ContentClassificationState extends State<ContentClassification> {
  List<dynamic>? bottomBack = [];
  List<dynamic>? bottomLeftPanel = [];
  List<dynamic>? bottomRightPanel = [];
  List<dynamic>? dashPanel = [];
  List<dynamic>? exterior = [];
  List<dynamic>? imageWithAdvertisement = [];
  List<dynamic>? leftPanel = [];
  List<dynamic>? midCenterPoint = [];
  List<dynamic>? rightPanel = [];
  List<String> positionWidgetRender = [
    'EXTERIOR',
    'RIGHT_PANEL',
    'LEFT_PANEL',
    'BOTTOM_BACK',
    'BOTTOM_LEFT_PANEL',
    'BOTTOM_RIGHT_PANEL',
    'DASH_PANEL',
    'IMAGE_WITH_ADVERTISEMENT',
    'MID_CENTER_POINT',
  ];

  Map<String, List<dynamic>> positionWidgetRenderABC = {
    'EXTERIOR': [],
    'RIGHT_PANEL': [],
    'LEFT_PANEL': [],
    'BOTTOM_BACK': [],
    'BOTTOM_LEFT_PANEL': [],
    'BOTTOM_RIGHT_PANEL': [],
    'DASH_PANEL': [],
    'IMAGE_WITH_ADVERTISEMENT': [],
    'MID_CENTER_POINT': [],
  };

  List<MapEntry<String, List<dynamic>>> widgetBuilders = [];
  final textStyleTitle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);
  final Color colorsForceBackgroundTitle =
      Colors.deepPurpleAccent.withOpacity(0.7);
  bool stateDone = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<FireStoreDatabase>()
        .generationClassificationStream
        .listen((event) {
      final jsonData = event.toJson();
      final keys = jsonData.keys;
      for (var key in keys) {
        positionWidgetRenderABC[key] =
            (jsonData[key] as List<dynamic>).map((e) {
          return e;
        }).toList();
      }
      setState(() {
        widgetBuilders = positionWidgetRenderABC.entries.toList();
        if (widget.isInprogress && event.exterior!.isNotEmpty) {
          widget.isInprogress = false;
          widget.isDone = true;
        }
      });
    });

    return widget.isDone
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleWidget(
                    title: GlobalText.titleClassification,
                    subTitle: widget.vinId,
                  ),
                  for (var element in widgetBuilders)
                    if (element.value.isNotEmpty)
                      Wrap(
                        children: [
                          Container(
                            color: colorsForceBackgroundTitle,
                            child: Text(
                              element.key,
                              style: textStyleTitle,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: element.value.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: CachedNetworkImage(
                                      imageUrl: element.value[index],
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              const ShimmerDefaultCustom(),
                                      errorWidget: (context, url, error) =>
                                          SizedBox(
                                              child: Image.asset(
                                                  'assets/images/error_images.png')),
                                    ),
                                  );
                                }),
                          ),
                          const DividerCustom(),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                ],
              ),
            ),
          )
        : widget.isInprogress
            ? SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleWidget(
                        title: GlobalText.titleClassification,
                        subTitle: widget.vinId,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: positionWidgetRender.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  color: colorsForceBackgroundTitle,
                                  child: Text(
                                    positionWidgetRender[index],
                                    style: textStyleTitle,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const ShimmerCustom(),
                                const DividerCustom(),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              )
            : const SizedBox();
  }
}
