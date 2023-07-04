import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan/scan.dart';
import './scanner.dart';

abstract class ScannerViewModel extends State<Scanner> {
  MobileScannerController scannerController =
      MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);

  final ImagePicker picker = ImagePicker();

  String resultScan = "";

  void onScanned(String value) {
    debugPrint(value);
    if (value.isNotEmpty) {
      setState(() {
        resultScan = value;
      });
    }
  }

  Future<void> onGetImageFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    String? result = await Scan.parse(image!.path);

    if (result!.isNotEmpty) {
      setState(() {
        resultScan = result;
      });
    }
  }
}
