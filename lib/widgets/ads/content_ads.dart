import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:imvision_studio/widgets/shimmer.dart';
import 'package:imvision_studio/widgets/shimmer_default.dart';
import 'package:provider/provider.dart';

import '../../constants/global_constants.dart';
import '../../models/ads_model.dart';
import '../../services/firestore_database.dart';
import '../title_custom_widget.dart';
import 'container_details_ads.dart';

class ContentAds extends StatefulWidget {
  String idVin;
  bool isDone;
  bool isInprogress;
  ContentAds(
      {super.key,
      required this.idVin,
      this.isDone = false,
      this.isInprogress = false});

  @override
  State<ContentAds> createState() => _ContentAdsState();
}

class _ContentAdsState extends State<ContentAds> {
  String videoDataStringDesktop = '';
  String videoDataStringMobile = '';
  String gifRefString = '';
  String bannerRefString = '';

  @override
  Widget build(BuildContext context) {
    context.read<FireStoreDatabase>().generationAdsStream.listen((event) {
      videoDataStringDesktop = event.desktopVideoRef;
      videoDataStringMobile = event.mobileVideoRef;
      gifRefString = event.gifRef;
      bannerRefString = event.bannerRef;
      setState(() {
        if (widget.isInprogress &&
            (event.desktopVideoRef.isNotEmpty ||
                event.mobileVideoRef.isNotEmpty ||
                event.gifRef.isNotEmpty ||
                event.bannerRef.isNotEmpty)) {
          widget.isInprogress = false;
          widget.isDone = true;
        }
      });
    });
    return widget.isDone
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWidget(
                  title: GlobalText.titleAds,
                  subTitle: widget.idVin,
                ),
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      if (videoDataStringDesktop.isNotEmpty)
                        ContainerDetailsAds(
                          title: GlobalText.titleUrlVideoDesktop,
                          urlRender: videoDataStringDesktop,
                        ),
                      if (videoDataStringMobile.isNotEmpty)
                        ContainerDetailsAds(
                          title: GlobalText.titleUrlVideoMobile,
                          urlRender: videoDataStringMobile,
                        ),
                      if (videoDataStringMobile.isNotEmpty)
                        ContainerDetailsAds(
                          title: GlobalText.titleUrlGif,
                          urlRender: gifRefString,
                        ),
                      if (videoDataStringMobile.isNotEmpty)
                        ContainerDetailsAds(
                          title: GlobalText.titleUrlBanner,
                          urlRender: bannerRefString,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : ShimmerCustom();
  }
}
