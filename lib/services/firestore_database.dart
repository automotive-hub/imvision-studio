import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imvision_studio/models/ads_model.dart';
import 'package:imvision_studio/models/classification_model.dart';
import 'package:imvision_studio/models/status_model.dart';
import 'package:rxdart/subjects.dart';

class FireStoreDatabase {
  final statusCollection =
      FirebaseFirestore.instance.collection('status').withConverter<Status>(
            fromFirestore: (snapshot, _) => Status.fromJson(snapshot.data()!),
            toFirestore: (data, _) => data.toJson(),
          );

  //
  final adsCollection =
      FirebaseFirestore.instance.collection('ads').withConverter<Ads>(
            fromFirestore: (snapshot, _) => Ads.fromJson(snapshot.data()!),
            toFirestore: (data, _) => data.toJson(),
          );

  //
  final classificationCollection = FirebaseFirestore.instance
      .collection('classification')
      .withConverter<Classification>(
        fromFirestore: (snapshot, _) =>
            Classification.fromJson(snapshot.data()!),
        toFirestore: (data, _) => data.toJson(),
      );

  BehaviorSubject<Status> generationStatus = BehaviorSubject();
  Stream<Status> get generationStatusStream =>
      generationStatus.asBroadcastStream();
  // #
  BehaviorSubject<Classification> generationClassification = BehaviorSubject();
  Stream<Classification> get generationClassificationStream =>
      generationClassification.asBroadcastStream();
  // #
  BehaviorSubject<Ads> generationAds = BehaviorSubject();
  Stream<Ads> get generationAdsStream => generationAds.asBroadcastStream();
  // -- -- --
  //
  final List<StreamSubscription> _streamListener = [];
//
  Future<void> init({required String vin}) async {
    await dispose();
    var statusSub = statusCollection.doc(vin).snapshots().map((event) {
      final data = event.data();
      if (data != null) {
        generationStatus.add(data);
      }
    }).listen((event) {});

    var classificationSub =
        classificationCollection.doc(vin).snapshots().map((event) {
      final data = event.data();
      if (data != null) {
        generationClassification.add(data);
      }
    }).listen((event) {});

    var adsSub = adsCollection.doc(vin).snapshots().map((event) {
      final data = event.data();
      if (data != null) {
        generationAds.add(data);
      }
    }).listen((event) {});

    _streamListener.addAll([statusSub, classificationSub, adsSub]);
  }

  Future<void> dispose() async {
    for (var element in _streamListener) {
      await element.cancel();
    }
  }
}
