import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:imvision_studio/widgets/shimmer.dart';
import 'package:imvision_studio/widgets/shimmer_default.dart';

import '../constants/global_constants.dart';
import '../models/ads_model.dart';
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
    Stream<DocumentSnapshot<Ads>> documentStream = FirebaseFirestore.instance
        .collection('ads')
        .doc(widget.idVin)
        .withConverter<Ads>(
          fromFirestore: (snapshot, _) => Ads.fromJson(snapshot.data()!),
          toFirestore: (ads, _) => ads.toJson(),
        )
        .snapshots();
    return widget.isDone
        ? StreamBuilder(
            stream: documentStream,
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Ads>> snapshot) {
              try {
                final currentData = snapshot.data?.data();
                if (currentData!.desktopVideoRef.isNotEmpty) {
                  videoDataStringDesktop = currentData.desktopVideoRef;
                }
                if (currentData.mobileVideoRef.isNotEmpty) {
                  videoDataStringDesktop = currentData.desktopVideoRef;
                }
                if (currentData.gifRef.isNotEmpty) {
                  gifRefString = currentData.gifRef;
                }
                if (currentData.bannerRef.isNotEmpty) {
                  bannerRefString = currentData.bannerRef;
                }
              } catch (e) {}
              return SizedBox(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // if (videoDataStringDesktop.isNotEmpty)
                    ContainerDetailsAds(
                      title: GlobalText.titleUrlVideoDesktop,
                      urlRender: videoDataStringDesktop,
                    ),
                    // if (videoDataStringMobile.isNotEmpty)
                    ContainerDetailsAds(
                      title: GlobalText.titleUrlVideoMobile,
                      urlRender: videoDataStringMobile,
                    ),
                    // if (videoDataStringMobile.isNotEmpty)
                    ContainerDetailsAds(
                      title: GlobalText.titleUrlGif,
                      urlRender: gifRefString,
                    ),
                    // if (videoDataStringMobile.isNotEmpty

                    ContainerDetailsAds(
                      title: GlobalText.titleUrlBanner,
                      urlRender: bannerRefString,
                    ),
                  ],
                ),
              );
            })
        : ShimmerCustom();
  }
}
