import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/ads_model.dart';

class ContentClassification extends StatefulWidget {
  const ContentClassification({super.key});

  @override
  State<ContentClassification> createState() => _ContentClassificationState();
}

class _ContentClassificationState extends State<ContentClassification> {
  String videoDataStringDesktop = '';
  String videoDataStringMobile = '';

  Stream<DocumentSnapshot<Ads>> documentStream = FirebaseFirestore.instance
      .collection('classification')
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
            scrollDirection: Axis.vertical,
            children: [
              Container(
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
