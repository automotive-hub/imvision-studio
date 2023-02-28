import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../services/firestore_database.dart';

class VehicleVINInput extends StatefulWidget {
  final Function(String)? vinNumber;
  final Function(Widget)? switchWidget;
  final String idVin;
  const VehicleVINInput(
      {super.key, this.vinNumber, this.switchWidget, required this.idVin});

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
  @override
  Widget build(BuildContext context) {
    final db = context.read<FireStoreDatabase>();
    final textController = TextEditingController(
        text: widget.idVin.isNotEmpty ? widget.idVin : null);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 3, color: Colors.lightBlue.shade600),
        ),
      ),
      child: TextField(
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
            final vinWithSalt = handleVIN(vin);
            await submitVin(vinWithSalt);
            await db.init(vin: vinWithSalt);
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
