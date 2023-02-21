import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:imvision_studio/widgets/shimmer.dart';
import 'package:imvision_studio/widgets/video_player.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/ads_model.dart';
import 'container_details_ads.dart';

class ContentAds extends StatefulWidget {
  String idVin;
  ContentAds({super.key, required this.idVin});

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
    return StreamBuilder(
        stream: documentStream,
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Ads>> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
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
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                if (videoDataStringDesktop.isNotEmpty)
                  ContainerDetailsAds(
                    title: 'Url Video Ads Desktop',
                    urlRender: videoDataStringDesktop,
                  ),
                if (videoDataStringMobile.isNotEmpty)
                  ContainerDetailsAds(
                    title: 'Url Video Ads Mobile',
                    urlRender: videoDataStringMobile,
                  ),
                if (videoDataStringMobile.isNotEmpty)
                  ContainerDetailsAds(
                    title: 'Gif',
                    urlRender: videoDataStringMobile,
                  ),
                if (videoDataStringMobile.isNotEmpty)
                  ContainerDetailsAds(
                    title: 'Banner',
                    urlRender: videoDataStringMobile,
                  ),
              ],
            ),
          );
        });
  }
}
