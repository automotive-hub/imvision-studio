import 'package:flutter/material.dart';
import 'package:imvision_studio/widgets/video_player.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContainerDetailsAds extends StatelessWidget {
  String title;
  String urlRender;
  ContainerDetailsAds(
      {super.key, required this.title, required this.urlRender});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (await canLaunchUrlString(urlRender)) {
          await launchUrlString(urlRender);
        }
      },
      child: Shimmer.fromColors(
        period: const Duration(milliseconds: 2000),
        baseColor: Colors.black,
        highlightColor: Colors.purple,
        child: Container(
          width: 200,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black,
              )),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              VideoPlayerWidget(
                videoStringUrl: urlRender,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
