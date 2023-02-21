import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:imvision_studio/models/classification_model.dart';
import 'package:imvision_studio/widgets/shimmer.dart';
import 'package:imvision_studio/widgets/shimmer_default.dart';

import 'divider.dart';

class ContentClassification extends StatefulWidget {
  String idVin;
  bool isDone;
  bool isInprogress;
  ContentClassification(
      {super.key,
      required this.idVin,
      this.isDone = false,
      this.isInprogress = false});

  @override
  State<ContentClassification> createState() => _ContentClassificationState();
}

class _ContentClassificationState extends State<ContentClassification> {
  Classification? currentData;

  final textStyleTitle =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot<Classification>> documentStream =
        FirebaseFirestore.instance
            .collection('classification')
            .doc(widget.idVin)
            .withConverter<Classification>(
              fromFirestore: (snapshot, _) =>
                  Classification.fromJson(snapshot.data()!),
              toFirestore: (ads, _) => ads.toJson(),
            )
            .snapshots();
    return widget.isDone
        ? StreamBuilder(
            stream: documentStream,
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Classification>> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }
              try {
                currentData = snapshot.data?.data();
              } catch (e) {
                return const Text('Something went wrong when parsing data');
              }
              if (widget.isDone) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (currentData!.exterior!.isNotEmpty)
                      Wrap(
                        children: [
                          Text(
                            'EXTERIOR',
                            style: textStyleTitle,
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
                                itemCount: currentData!.exterior!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: CachedNetworkImage(
                                      imageUrl: currentData!.exterior![index],
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
                    if (currentData!.rightPanel!.isNotEmpty)
                      Wrap(
                        children: [
                          Text(
                            'RIGHT_PANEL',
                            style: textStyleTitle,
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
                                itemCount: currentData!.rightPanel!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: CachedNetworkImage(
                                      imageUrl: currentData!.rightPanel![index],
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
                    if (currentData!.bottomRightPanel!.isNotEmpty)
                      Wrap(
                        children: [
                          Text(
                            'BOTTOM_RIGHT_PANEL',
                            style: textStyleTitle,
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
                                itemCount:
                                    currentData!.bottomRightPanel!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          currentData!.bottomRightPanel![index],
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
                    if (currentData!.bottomBack!.isNotEmpty)
                      Wrap(
                        children: [
                          Text(
                            'BOTTOM_BACK',
                            style: textStyleTitle,
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
                                itemCount: currentData!.bottomBack!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: CachedNetworkImage(
                                      imageUrl: currentData!.bottomBack![index],
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
                    if (currentData!.bottomLeftPanel!.isNotEmpty)
                      Wrap(
                        children: [
                          Text(
                            'BOTTOM_LEFT_PANEL',
                            style: textStyleTitle,
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
                                itemCount: currentData!.bottomLeftPanel!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          currentData!.bottomLeftPanel![index],
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
                    if (currentData!.dashPanel!.isNotEmpty)
                      Wrap(
                        children: [
                          Text(
                            'DASH_PANEL',
                            style: textStyleTitle,
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
                                itemCount: currentData!.dashPanel!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: CachedNetworkImage(
                                      imageUrl: currentData!.dashPanel![index],
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
                    if (currentData!.midCenterPoint!.isNotEmpty)
                      Wrap(
                        children: [
                          Text(
                            'MID_CENTER_POINT',
                            style: textStyleTitle,
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
                                itemCount: currentData!.midCenterPoint!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          currentData!.midCenterPoint![index],
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
                    if (currentData!.imageWithAdvertisement!.isNotEmpty)
                      Wrap(
                        children: [
                          Text(
                            'IMAGE_WITH_ADVERTISEMENT',
                            style: textStyleTitle,
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
                                itemCount:
                                    currentData!.imageWithAdvertisement!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: CachedNetworkImage(
                                      imageUrl: currentData!
                                          .imageWithAdvertisement![index],
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
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EXTERIOR',
                    style: textStyleTitle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ShimmerCustom(),
                  const DividerCustom(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'RIGHT_PANEL',
                    style: textStyleTitle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ShimmerCustom(),
                  const DividerCustom(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'BOTTOM_RIGHT_PANEL',
                    style: textStyleTitle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ShimmerCustom(),
                  const DividerCustom(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'BOTTOM_BACK',
                    style: textStyleTitle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ShimmerCustom(),
                  const DividerCustom(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'BOTTOM_LEFT_PANEL',
                    style: textStyleTitle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ShimmerCustom(),
                  const DividerCustom(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'BOTTOM_LEFT',
                    style: textStyleTitle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ShimmerCustom(),
                  const DividerCustom(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'DASH_PANEL',
                    style: textStyleTitle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ShimmerCustom(),
                  const DividerCustom(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'MID_CENTER_POINT',
                    style: textStyleTitle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ShimmerCustom(),
                  const DividerCustom(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'IMAGE_WITH_ADVERTISEMENT',
                    style: textStyleTitle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ShimmerCustom(),
                ],
              );
            })
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EXTERIOR',
                style: textStyleTitle,
              ),
              const SizedBox(
                height: 10,
              ),
              const ShimmerCustom(),
              const DividerCustom(),
              const SizedBox(
                height: 10,
              ),
              Text(
                'RIGHT_PANEL',
                style: textStyleTitle,
              ),
              const SizedBox(
                height: 10,
              ),
              const ShimmerCustom(),
              const DividerCustom(),
              const SizedBox(
                height: 10,
              ),
              Text(
                'BOTTOM_RIGHT_PANEL',
                style: textStyleTitle,
              ),
              const SizedBox(
                height: 10,
              ),
              const ShimmerCustom(),
              const DividerCustom(),
              const SizedBox(
                height: 10,
              ),
              Text(
                'BOTTOM_BACK',
                style: textStyleTitle,
              ),
              const SizedBox(
                height: 10,
              ),
              const ShimmerCustom(),
              const DividerCustom(),
              const SizedBox(
                height: 10,
              ),
              Text(
                'BOTTOM_LEFT_PANEL',
                style: textStyleTitle,
              ),
              const SizedBox(
                height: 10,
              ),
              const ShimmerCustom(),
              const DividerCustom(),
              const SizedBox(
                height: 10,
              ),
              Text(
                'BOTTOM_LEFT',
                style: textStyleTitle,
              ),
              const SizedBox(
                height: 10,
              ),
              const ShimmerCustom(),
              const DividerCustom(),
              const SizedBox(
                height: 10,
              ),
              Text(
                'DASH_PANEL',
                style: textStyleTitle,
              ),
              const SizedBox(
                height: 10,
              ),
              const ShimmerCustom(),
              const DividerCustom(),
              const SizedBox(
                height: 10,
              ),
              Text(
                'MID_CENTER_POINT',
                style: textStyleTitle,
              ),
              const SizedBox(
                height: 10,
              ),
              const ShimmerCustom(),
              const DividerCustom(),
              const SizedBox(
                height: 10,
              ),
              Text(
                'IMAGE_WITH_ADVERTISEMENT',
                style: textStyleTitle,
              ),
              const SizedBox(
                height: 10,
              ),
              const ShimmerCustom(),
            ],
          );
  }
}
