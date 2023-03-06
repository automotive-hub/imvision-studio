import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'video_player.dart';

class ContainerDetailsAds extends StatefulWidget {
  String title;
  String urlRender;
  ContainerDetailsAds(
      {super.key, required this.title, required this.urlRender});

  @override
  State<ContainerDetailsAds> createState() => _ContainerDetailsAdsState();
}

class _ContainerDetailsAdsState extends State<ContainerDetailsAds> {
  @override
  Widget build(BuildContext context) {
    final Color colorsForceBackgroundTitle =
        Colors.deepPurpleAccent.withOpacity(0.7);
    return InkWell(
      onTap: () async {
        if (await canLaunchUrlString(widget.urlRender)) {
          await launchUrlString(widget.urlRender);
        }
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        // padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(right: 10, top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.deepPurple.shade400,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 170,
              margin: const EdgeInsets.only(top: 5, left: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: colorsForceBackgroundTitle.withOpacity(0.5),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(widget.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            AspectRatio(
              aspectRatio: 3.75 / 2,
              child: VideoPlayerWidget(
                videoStringUrl: widget.urlRender,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
