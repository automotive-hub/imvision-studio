import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imvision_studio/widgets/shimmer.dart';
import 'package:imvision_studio/widgets/shimmer_default.dart';
import 'package:provider/provider.dart';

import '../constants/global_constants.dart';
import '../services/firestore_database.dart';
import 'divider.dart';
import 'title_stepper.dart';

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

  final textStyleTitle = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20);
  final Color colorsForceBackgroundTitle =
      Colors.deepPurpleAccent.withOpacity(0.7);
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
      bottomBack = event.bottomBack;
      bottomLeftPanel = event.bottomLeftPanel;
      bottomRightPanel = event.bottomRightPanel;
      dashPanel = event.dashPanel;
      exterior = event.exterior;
      imageWithAdvertisement = event.imageWithAdvertisement;
      leftPanel = event.leftPanel;
      midCenterPoint = event.midCenterPoint;
      rightPanel = event.rightPanel;
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
                  const SizedBox(
                    height: 20,
                  ),
                  if (exterior!.isNotEmpty)
                    Wrap(
                      children: [
                        Container(
                          color: colorsForceBackgroundTitle,
                          child: Text(
                            ClassificationtText.exterior,
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
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: exterior!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: CachedNetworkImage(
                                    imageUrl: exterior![index],
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            const ShimmerDefaultCustom(),
                                    errorWidget: (context, url, error) => SizedBox(
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
                  if (rightPanel!.isNotEmpty)
                    Wrap(
                      children: [
                        Container(
                          color: colorsForceBackgroundTitle,
                          child: Text(
                            ClassificationtText.rightPanel,
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
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: rightPanel!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: CachedNetworkImage(
                                    imageUrl: rightPanel![index],
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            const ShimmerDefaultCustom(),
                                    errorWidget: (context, url, error) =>
                                        SizedBox(
                                            child: Image.asset(
                                                'error_images.png')),
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
                  if (leftPanel!.isNotEmpty)
                    Wrap(
                      children: [
                        Container(
                          color: colorsForceBackgroundTitle,
                          child: Text(
                            ClassificationtText.leftPanel,
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
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: leftPanel!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: CachedNetworkImage(
                                    imageUrl: leftPanel![index],
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            const ShimmerDefaultCustom(),
                                    errorWidget: (context, url, error) =>
                                        SizedBox(
                                            child: Image.asset(
                                                'error_images.png')),
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
                  if (bottomRightPanel!.isNotEmpty)
                    Wrap(
                      children: [
                        Container(
                          color: colorsForceBackgroundTitle,
                          child: Text(
                            ClassificationtText.bottomRightPanel,
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
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: bottomRightPanel!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: CachedNetworkImage(
                                    imageUrl: bottomRightPanel![index],
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            const ShimmerDefaultCustom(),
                                    errorWidget: (context, url, error) =>
                                        SizedBox(
                                            child: Image.asset(
                                                'error_images.png')),
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
                  if (bottomBack!.isNotEmpty)
                    Wrap(
                      children: [
                        Container(
                          color: colorsForceBackgroundTitle,
                          child: Text(
                            ClassificationtText.bottomBack,
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
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: bottomBack!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: CachedNetworkImage(
                                    imageUrl: bottomBack![index],
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            const ShimmerDefaultCustom(),
                                    errorWidget: (context, url, error) =>
                                        SizedBox(
                                            child: Image.asset(
                                                'error_images.png')),
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
                  if (bottomLeftPanel!.isNotEmpty)
                    Wrap(
                      children: [
                        Container(
                          color: colorsForceBackgroundTitle,
                          child: Text(
                            ClassificationtText.bottomLeftPanel,
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
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: bottomLeftPanel!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: CachedNetworkImage(
                                    imageUrl: bottomLeftPanel![index],
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            const ShimmerDefaultCustom(),
                                    errorWidget: (context, url, error) =>
                                        SizedBox(
                                            child: Image.asset(
                                                'error_images.png')),
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
                  if (dashPanel!.isNotEmpty)
                    Wrap(
                      children: [
                        Container(
                          color: colorsForceBackgroundTitle,
                          child: Text(
                            ClassificationtText.dashPanel,
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
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: dashPanel!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: CachedNetworkImage(
                                    imageUrl: dashPanel![index],
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            const ShimmerDefaultCustom(),
                                    errorWidget: (context, url, error) =>
                                        SizedBox(
                                            child: Image.asset(
                                                'error_images.png')),
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
                  if (midCenterPoint!.isNotEmpty)
                    Wrap(
                      children: [
                        Container(
                          color: colorsForceBackgroundTitle,
                          child: Text(
                            ClassificationtText.midCenterPoint,
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
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: midCenterPoint!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: CachedNetworkImage(
                                    imageUrl: midCenterPoint![index],
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            const ShimmerDefaultCustom(),
                                    errorWidget: (context, url, error) =>
                                        SizedBox(
                                            child: Image.asset(
                                                'error_images.png')),
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
                  if (imageWithAdvertisement!.isNotEmpty)
                    Wrap(
                      children: [
                        Container(
                          color: colorsForceBackgroundTitle,
                          child: Text(
                            ClassificationtText.imageWithAdvertisement,
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
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: imageWithAdvertisement!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: CachedNetworkImage(
                                    imageUrl: imageWithAdvertisement![index],
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            const ShimmerDefaultCustom(),
                                    errorWidget: (context, url, error) =>
                                        SizedBox(
                                            child: Image.asset(
                                                'error_images.png')),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          )
        : widget.isDone
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: colorsForceBackgroundTitle,
                    child: Text(
                      ClassificationtText.exterior,
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
                  Container(
                    color: colorsForceBackgroundTitle,
                    child: Text(
                      ClassificationtText.exterior,
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
                  Container(
                    color: colorsForceBackgroundTitle,
                    child: Text(
                      ClassificationtText.exterior,
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
                  Container(
                    color: colorsForceBackgroundTitle,
                    child: Text(
                      ClassificationtText.exterior,
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
                  Container(
                    color: colorsForceBackgroundTitle,
                    child: Text(
                      ClassificationtText.exterior,
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
                  Container(
                    color: colorsForceBackgroundTitle,
                    child: Text(
                      ClassificationtText.exterior,
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
                  Container(
                    color: colorsForceBackgroundTitle,
                    child: Text(
                      ClassificationtText.exterior,
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
                  Container(
                    color: colorsForceBackgroundTitle,
                    child: Text(
                      ClassificationtText.exterior,
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
                  Container(
                    color: colorsForceBackgroundTitle,
                    child: Text(
                      ClassificationtText.exterior,
                      style: textStyleTitle,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ShimmerCustom(),
                ],
              )
            : const SizedBox();
  }
}
