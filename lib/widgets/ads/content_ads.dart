import 'package:flutter/material.dart';
import 'package:imvision_studio/widgets/shimmer.dart';
import 'package:provider/provider.dart';

import '../../constants/global_constants.dart';
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
                Container(
                  child: Wrap(
                    children: [
                      if (videoDataStringDesktop.isNotEmpty)
                        Container(
                          height: 250,
                          width: 369,
                          child: ContainerDetailsAds(
                            title: GlobalText.titleUrlVideoDesktop,
                            urlRender: videoDataStringDesktop,
                          ),
                        ),
                      if (videoDataStringMobile.isNotEmpty)
                        Container(
                          height: 250,
                          width: 369,
                          child: ContainerDetailsAds(
                            title: GlobalText.titleUrlVideoMobile,
                            urlRender: videoDataStringMobile,
                          ),
                        ),
                      if (videoDataStringMobile.isNotEmpty)
                        Container(
                          height: 250,
                          width: 369,
                          child: ContainerDetailsAds(
                            title: GlobalText.titleUrlGif,
                            urlRender: gifRefString,
                          ),
                        ),
                      if (videoDataStringMobile.isNotEmpty)
                        Container(
                          height: 250,
                          width: 369,
                          child: ContainerDetailsAds(
                            title: GlobalText.titleUrlBanner,
                            urlRender: bannerRefString,
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          )
        : ShimmerCustom();
  }
}
