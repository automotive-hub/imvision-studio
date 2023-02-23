import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imvision_studio/services/firestore_database.dart';
import 'package:provider/provider.dart';

class VehicleVINInput extends StatefulWidget {
  const VehicleVINInput({super.key});

  @override
  State<VehicleVINInput> createState() => _VehicleVINInputState();
}

class _VehicleVINInputState extends State<VehicleVINInput> {
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
            fillColor: const Color(0xfff3f3f4),
            filled: true),
        onSubmitted: (vin) async =>
            {print("Searching for " + vin), await db.init(vin: vin)},
      ),
    );
  }
}

class UppercaseInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}
