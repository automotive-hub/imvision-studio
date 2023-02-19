import 'package:any_link_preview/any_link_preview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_player/video_player.dart';

import '../models/ads_model.dart';

class ContentAds extends StatefulWidget {
  const ContentAds({super.key});

  @override
  State<ContentAds> createState() => _ContentAdsState();
}

class _ContentAdsState extends State<ContentAds> {
  String videoDataStringDesktop = '';
  String videoDataStringMobile = '';

  Stream<DocumentSnapshot<Ads>> documentStream = FirebaseFirestore.instance
      .collection('ads')
      .doc('1FT6W1EV5PWG07389')
      .withConverter<Ads>(
        fromFirestore: (snapshot, _) => Ads.fromJson(snapshot.data()!),
        toFirestore: (ads, _) => ads.toJson(),
      )
      .snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: documentStream,
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Ads>> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          try {
            final currentData = snapshot.data?.data();
            if (currentData!.desktopVideo.isNotEmpty ||
                currentData.mobileVideo.isNotEmpty) {
              videoDataStringDesktop = currentData.desktopVideo;
              videoDataStringMobile = currentData.mobileVideo;
            }
          } catch (e) {}
          return ListView(
            // scrollDirection: Axis.vertical,
            children: [
              Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: InkWell(
                    child: const Text('URL Video Ads Desktop'),
                    onTap: () async {
                      if (await canLaunchUrlString(videoDataStringDesktop)) {
                        await launchUrlString(videoDataStringDesktop);
                      }
                    }),
              ),
              InkWell(
                  child: const Text('URL Video Ads Mobile'),
                  onTap: () async {
                    if (await canLaunchUrlString(videoDataStringMobile)) {
                      await launchUrlString(videoDataStringMobile);
                    }
                  }),
            ],
          );
        });
  }
}
