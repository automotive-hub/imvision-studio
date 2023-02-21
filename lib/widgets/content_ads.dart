import 'dart:html' as html;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:imvision_studio/widgets/video_player.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/ads_model.dart';

class ContentAds extends StatefulWidget {
  String idVin;
  ContentAds({super.key, required this.idVin});

  @override
  State<ContentAds> createState() => _ContentAdsState();
}

class _ContentAdsState extends State<ContentAds> {
  String videoDataStringDesktop = '';
  String videoDataStringMobile = '';

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
            if (currentData!.desktopVideo.isNotEmpty ||
                currentData.mobileVideo.isNotEmpty) {
              videoDataStringDesktop = currentData.desktopVideo;
              videoDataStringMobile = currentData.mobileVideo;
            }
          } catch (e) {}
          return SizedBox(
            height: 500,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.black,
                  )),
                  child: Column(
                    children: [
                      const Text(
                        'URL Video Ads Desktop',
                      ),
                      Center(
                        child: Row(children: [
                          IconButton(
                            icon: const Icon(Icons.download),
                            onPressed: () async {
                              downloadFile(videoDataStringDesktop);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.play_arrow),
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext contextDiaglog) {
                                    return VideoPlayerWidget(
                                      videoStringUrl: videoDataStringDesktop,
                                    );
                                  });
                            },
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
                InkWell(
                    child: const Text('URL Video Ads Mobile'),
                    onTap: () async {
                      if (await canLaunchUrlString(videoDataStringMobile)) {
                        await launchUrlString(videoDataStringMobile);
                      }
                    }),
              ],
            ),
          );
        });
  }
}

// void downloadFile(String url) async {
//   html.AnchorElement anchorElement = html.AnchorElement(href: url);
//   anchorElement.download = url;
//   anchorElement.click();
// }

void downloadFile(String atUrl) {
  final v = html.window.document.getElementById('triggerVideoPlayer');
  if (v != null) {
    v.setInnerHtml('<source type="video/mp4" src="$atUrl">',
        validator: html.NodeValidatorBuilder()
          ..allowElement('source', attributes: ['src', 'type']));
    final a = html.window.document.getElementById('triggerVideoPlayer');
    if (a != null) {
      a.dispatchEvent(html.MouseEvent('click'));
    }
  }
}
