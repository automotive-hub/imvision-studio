import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:imvision_studio/widgets/title_custom_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../constants/global_constants.dart';
import '../services/firestore_database.dart';
import 'box_content_download.dart';

class ContentDownloadWidget extends StatefulWidget {
  String idVin;
  ContentDownloadWidget({super.key, required this.idVin});

  @override
  State<ContentDownloadWidget> createState() => _ContentDownloadWidgetState();
}

class _ContentDownloadWidgetState extends State<ContentDownloadWidget> {
  var totalImage = 0;
  var imageCounter = 0;
  var predictionCounter = 0;
  var predictionTotal = 0;

  @override
  Widget build(BuildContext context) {
    context.read<FireStoreDatabase>().generationStatusStream.listen((event) {
      totalImage = event.imageTotal;
      imageCounter = event.imageCounter;
      predictionCounter = event.predictionCounter;
      predictionTotal = event.predictionTotal;
      setState(() {});
    });

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget(
              title: GlobalText.titleDownload,
              subTitle: widget.idVin,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BoxContentDownloadWidget(
                  firstTitle: DownloadText.fetchImages,
                  secondTitle: DownloadText.totalImages,
                  firstValue: imageCounter,
                  secondValue: totalImage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
