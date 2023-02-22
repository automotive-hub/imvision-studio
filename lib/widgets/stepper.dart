// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:imvision_studio/widgets/shimmer.dart';
// import 'package:imvision_studio/widgets/title_stepper.dart';

// import 'content_ads.dart';
// import 'content_classification.dart';
// import 'content_download.dart';

// class StepperCustom extends StatelessWidget {
//   bool isDone;
//   bool isInprocess;
//   String title;
//   String vinId;
//   bool isAdsWidget;
//   bool isClassificationWidget;
//   bool isDownloadWidget;
//   StepperCustom(
//       {super.key,
//       required this.isDone,
//       required this.isInprocess,
//       required this.title,
//       required this.vinId,
//       this.isAdsWidget = false,
//       this.isClassificationWidget = false,
//       this.isDownloadWidget = false});

//   @override
//   Widget build(BuildContext context) {
//     Widget widgetBuilderContent = ShimmerCustom();
//     if (isAdsWidget && isDone) {
//       widgetBuilderContent = ContentAds(
//         idVin: vinId,
//         isDone: isDone,
//         isInprogress: isInprocess,
//       );
//     } else if (isClassificationWidget && isDone) {
//       widgetBuilderContent = ContentClassification(
//         idVin: vinId,
//         isDone: isDone,
//         isInprogress: isInprocess,
//       );
//     } else if (isDownloadWidget && isDone) {
//       widgetBuilderContent = ContentDownloadWidget();
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Container(
//               margin: const EdgeInsets.only(left: 8, right: 5),
//               height: 20,
//               width: 20,
//               decoration: BoxDecoration(
//                   color: isInprocess
//                       ? Colors.blue
//                       : isDone
//                           ? Colors.green
//                           : Colors.grey,
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.black)),
//             ),
//             TitleStepperCustom(
//               title: title,
//               isDone: isDone,
//               isInprogress: isInprocess,
//             ),
//           ],
//         ),
//         Container(
//           margin: const EdgeInsets.only(left: 17),
//           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
//           decoration: const BoxDecoration(
//               border: Border(
//                   left: BorderSide(
//             color: Colors.grey,
//           ))),
//           child: widgetBuilderContent,
//         ),
//       ],
//     );
//   }
// }
