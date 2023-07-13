import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grid_mobile/redux/actions/payments_action.dart';
import 'package:grid_mobile/redux/app_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import '../../constants/enum/payment_enum.dart';
import '../../models/models.dart';
import '../payment/payment.dart';
import './charging_point.dart';

abstract class ChargingPointViewModel extends State<ChargingPoint> {
  late Store<AppState> store;
  final ImagePicker picker = ImagePicker();

  TextEditingController amountController = TextEditingController(text: '0');

  List chargingTypeData = ["Full Charging", "IDR Amount", "KWH Amount"];

  String chargingTypeValue = "IDR Amount";
  String parkingTicketID = "0173564ACCB";

  File? imageSelector;

  void setChargingTypeValue(String value) {
    setState(() {
      chargingTypeValue = value;
    });
  }

  void onAmountTap() {
    setState(() {
      amountController.clear();
    });
  }

  String handlePrefixAmount() {
    if (chargingTypeValue == 'IDR Amount') {
      return "IDR";
    } else {
      return "KWH";
    }
  }

  Future<void> onGetImageFromCamera() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      imageSelector = File(image!.path);
    });
  }

  Future<void> onContinue() async {
    int amount = int.parse(amountController.text.replaceAll(',', ''));
    int tax = (amount * 0.1).round();
    PaymentModel payment = PaymentModel(
      amount: amount,
      chargingType: chargingTypeValue,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      tax: tax,
      total: amount + tax,
      parkingTicket: parkingTicketID,
    );

    ScannedItem data =
        store.state.paymentsState.scannedItem!.copyWith(payment: payment);
    await store.dispatch(SetScannedItem(scannedItem: data));

    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const Payment(
                  type: PaymentTypeEnum.charging,
                )));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of(context);
    });
  }
}
