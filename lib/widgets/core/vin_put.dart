import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../services/firestore_database.dart';
import '../dashboard/dashboard_content.dart';

class VehicleVINInput extends StatefulWidget {
  final Function(String)? vinNumber;
  final Function(Widget)? switchWidget;

  const VehicleVINInput({super.key, this.vinNumber, this.switchWidget});

  @override
  State<VehicleVINInput> createState() => _VehicleVINInputState();
}

class _VehicleVINInputState extends State<VehicleVINInput> {
  bool isReadonly = false;
  bool isEnable = true;
  bool isStreamDone = false;
  Color colorInput = Colors.white;
  final inputStyle = const TextStyle(
      fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15);
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final db = context.read<FireStoreDatabase>();
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 3, color: Colors.lightBlue.shade600),
        ),
      ),
      child: TextField(
        // enabled: isEnable,
        // readOnly: isReadonly,
        controller: textController,
        textCapitalization: TextCapitalization.characters,
        style: inputStyle,
        inputFormatters: [
          UppercaseInputFormatter(),
          LengthLimitingTextInputFormatter(17)
        ],
        decoration: InputDecoration(
            hintText: "INPUT YOUR VIN",
            hintStyle: inputStyle,
            border: InputBorder.none,
            fillColor: colorInput,
            filled: true),
        onSubmitted: (vin) async {
          if (vin.isNotEmpty) {
            widget.vinNumber!(vin);
            isReadonly = true;
            isEnable = false;
            colorInput = Colors.white54;
            final vinWithSalt = handleVIN(vin);
            await submitVin(vinWithSalt);
            await db.init(vin: vinWithSalt);
            // ignore: use_build_context_synchronously
            widget.switchWidget!(DashBoardScreen(
              idVin: vin,
              callBackVin: widget.vinNumber,
            ));
            final streamStatus = context
                .read<FireStoreDatabase>()
                .generationStatusStream
                .listen((event) {
              if (event.download == 'done' &&
                  event.classification == 'done' &&
                  event.video == 'done') {
                colorInput = Colors.white;
                isReadonly = false;
                isEnable = true;
                isStreamDone = true;
                setState(() {});
              }
            });
            // if (isStreamDone) {
            //   streamStatus.cancel();
            //   isStreamDone = false;
            // }
            setState(() {});
          }
        },
      ),
    );
  }

  String handleVIN(String vin) {
    final vinWithSalt = '${vin}_${DateTime.now().millisecondsSinceEpoch}';
    return vinWithSalt;
  }

  Future<bool> submitVin(String vinId) async {
    String url = 'https://staging.imvision-hackathon.tech/dummy/';
    // String url = 'https://34.27.27.160/dummy/';
    final response = await http.post(Uri.parse(url + vinId),
        headers: {'Access-Control-Allow-Origin': '*'});

    if (response.statusCode == 200) {
      print(response);
      return true;
    } else {
      throw Exception('Failed to load album');
    }
  }
}

class UppercaseInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}
