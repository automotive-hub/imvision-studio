import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/global_constants.dart';
import '../../models/status_model.dart';
import '../../services/firestore_database.dart';
import '../title_custom_widget.dart';
import 'dashboard_widget_title.dart';

class DashBoardScreen extends StatefulWidget {
  String idVin;
  final Function(String)? callBackVin;
  DashBoardScreen({Key? key, required this.idVin, this.callBackVin})
      : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final Color colorsForceBackgroundTitle =
      Colors.deepPurpleAccent.withOpacity(0.7);
  final subTitleTextStyle = const TextStyle(
      color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20);
  var listDocument = [];
  @override
  Widget build(BuildContext context) {
    String currentVin = widget.idVin;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget(
              title: GlobalText.titleDashboard,
              isShowVin: false,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DashboardText.currentVin,
                          style: subTitleTextStyle,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: colorsForceBackgroundTitle.withOpacity(0.5),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              await context
                                  .read<FireStoreDatabase>()
                                  .init(vin: widget.idVin);
                              setState(() {});
                            },
                            child: Text(currentVin,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 369,
                      height: 650,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.deepPurple.shade400,
                          )),
                      child: FutureBuilder<List<dynamic>>(
                          future: getCollection(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                            onPressed: () async {
                                              await context
                                                  .read<FireStoreDatabase>()
                                                  .init(
                                                      vin: snapshot
                                                          .data![index].id);
                                              if (widget.callBackVin != null) {
                                                widget.callBackVin!(
                                                    snapshot.data![index].id);
                                              }
                                              currentVin =
                                                  snapshot.data![index].id;
                                              setState(() {});
                                            },
                                            child: Text(
                                                snapshot.data![index].id
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: subTitleTextStyle)),
                                        if (snapshot.data!.length - 1 != index)
                                          const Divider(
                                            color: Colors.deepPurple,
                                          )
                                      ],
                                    );
                                  });
                            }
                            return const SizedBox.shrink();
                          }),
                    )
                  ],
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        DashboardText.titleChecklist,
                        style: subTitleTextStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: const [
                        DashBoardTitleWidget(
                          title: DashboardText.statusDownload,
                          menuType: AppMenu.download,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DashBoardTitleWidget(
                          title: DashboardText.statusClassification,
                          menuType: AppMenu.classification,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DashBoardTitleWidget(
                          title: DashboardText.statusAds,
                          menuType: AppMenu.video,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<List<dynamic>> getCollection() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('status').get();
      listDocument = snapshot.docs.toList();
      return listDocument;
    } catch (error) {
      listDocument = [];
      return listDocument;
    }
  }
}
