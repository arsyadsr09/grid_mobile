import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grid_mobile/constants/dummy_data.dart';
import 'package:grid_mobile/redux/actions/scanner_action.dart';
import 'package:grid_mobile/redux/app_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import 'package:scan/scan.dart';
import '../../models/models.dart';
import './scanner.dart';

abstract class ScannerViewModel extends State<Scanner> {
  late Store<AppState> store;
  MobileScannerController scannerController =
      MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);

  final ImagePicker picker = ImagePicker();

  void onScanned(String value) {
    debugPrint(value);
    if (value.isNotEmpty) {
      ScannedItem data =
          ScannedItem(string: value, data: DummyData.selectedMarker);
      store.dispatch(SetScannedItem(scannedItem: data));
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/ChargingPoint");
    }
  }

  Future<void> onGetImageFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    String? result = await Scan.parse(image!.path);

    if (result!.isNotEmpty) {
      ScannedItem data =
          ScannedItem(string: result, data: DummyData.selectedMarker);

      store.dispatch(SetScannedItem(scannedItem: data));
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/ChargingPoint");
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of(context);
    });
  }
}
