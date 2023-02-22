// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:imvision_studio/widgets/shimmer.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// // ignore: library_prefixes
// import '../models/ads_model.dart';
// import '../widgets/stepper_custom.dart' as stepperCustom;
// import 'divider.dart';
// import 'package:video_player/video_player.dart';

// widgetStepperAds(
//     bool adsInprocess, bool adsDone, BuildContext context, String documentId) {
//   Stream<DocumentSnapshot<Ads>> documentStream = FirebaseFirestore.instance
//       .collection('ads')
//       .doc('1FT6W1EV5PWG07389')
//       .withConverter<Ads>(
//         fromFirestore: (snapshot, _) => Ads.fromJson(snapshot.data()!),
//         toFirestore: (ads, _) => ads.toJson(),
//       )
//       .snapshots();

//   const textStyleTitle =
//       TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
//   return stepperCustom.ModifiedStep(
//     state: adsInprocess
//         ? stepperCustom.StepState.editing
//         : stepperCustom.StepState.complete,
//     title: Row(
//       children: [
//         const Text(
//           'Ads',
//           style: textStyleTitle,
//         ),
//         if (adsDone)
//           const SizedBox(
//             width: 20,
//           ),
//         if (adsDone)
//           const Icon(
//             Icons.check_circle_outline_outlined,
//             color: Colors.white,
//           ),
//         if (adsInprocess)
//           const SizedBox(
//             width: 100,
//           ),
//         if (adsInprocess)
//           LoadingAnimationWidget.newtonCradle(
//             color: const Color.fromARGB(255, 255, 255, 255),
//             size: 100,
//           ),
//       ],
//     ),
//     content: adsInprocess
//         ? Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: const [
//               Text(
//                 'Video',
//                 style: textStyleTitle,
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               ShimmerCustom(),
//               DividerCustom(),
//               Text(
//                 'Gif',
//                 style: textStyleTitle,
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               ShimmerCustom(),
//               DividerCustom(),
//               Text(
//                 'Image',
//                 style: textStyleTitle,
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               ShimmerCustom(),
//               DividerCustom(),
//             ],
//           )
//         : adsDone
//             ? Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Video',
//                     style: textStyleTitle,
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   StreamBuilder(
//                       stream: documentStream,
//                       builder: (BuildContext context,
//                           AsyncSnapshot<DocumentSnapshot<Ads>> snapshot) {
//                         if (snapshot.hasError) {
//                           return Text('Something went wrong');
//                         }
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return Text("Loading");
//                         }
//                         try {
//                           final currentData = snapshot.data?.data();
//                           VideoPlayerController controller =
//                               VideoPlayerController.network(
//                             currentData!.desktopVideo,
//                             videoPlayerOptions:
//                                 VideoPlayerOptions(mixWithOthers: true),
//                           );
//                           Future<void> initializeVideoPlayerFuture =
//                               controller.initialize();
//                           FutureBuilder(
//                             future: initializeVideoPlayerFuture,
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.done) {
//                                 return AspectRatio(
//                                   aspectRatio: controller.value.aspectRatio,
//                                   child: VideoPlayer(controller),
//                                 );
//                               } else {
//                                 return const Center(
//                                   child: CircularProgressIndicator(),
//                                 );
//                               }
//                             },
//                           );
//                         } catch (e) {}
//                         return SizedBox();
//                       })
//                 ],
//               )
//             : SizedBox.shrink(),
//   );
// }
