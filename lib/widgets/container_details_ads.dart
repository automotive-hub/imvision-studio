import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:imvision_studio/widgets/video_player.dart';
import 'package:shimmer/shimmer.dart';

class ContainerDetailsAds extends StatelessWidget {
  String title;
  String urlRender;
  ContainerDetailsAds(
      {super.key, required this.title, required this.urlRender});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
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
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                icon: const Icon(Icons.download),
                onPressed: () async {
                  downloadFile(urlRender);
                },
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext contextDiaglog) {
                        return VideoPlayerWidget(
                          videoStringUrl: urlRender,
                        );
                      });
                },
              )
            ]),
          ],
        ),
      ),
    );
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
