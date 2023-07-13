import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grid_mobile/constants/enum/payment_enum.dart';
import 'package:grid_mobile/screens/payment_status/payment_status.dart';
import 'package:redux/redux.dart';
import '../../models/models.dart';
import '../../redux/actions/payments_action.dart';
import '../../redux/app_state.dart';
import './payment.dart';

abstract class PaymentViewModel extends State<Payment> {
  late Store<AppState> store;

  String refNumber = "12387982137912837";
  String selectedPaymentMethod = "";

  void selectPaymentMethod(String name) {
    setState(() {
      selectedPaymentMethod = name;
    });
  }

  Future<void> onPay() async {
    if (selectedPaymentMethod.isEmpty) {
      return;
    }

    if (widget.type == PaymentTypeEnum.charging) {
      PaymentModel payment =
          store.state.paymentsState.scannedItem!.payment!.copyWith(
        paymentMethod: selectedPaymentMethod,
        refNumber: refNumber,
      );

      ScannedItem data =
          store.state.paymentsState.scannedItem!.copyWith(payment: payment);

      await store.dispatch(SetScannedItem(scannedItem: data));
    }

    if (widget.type == PaymentTypeEnum.reservation) {
      PaymentModel payment =
          store.state.paymentsState.reservation!.payment!.copyWith(
        paymentMethod: selectedPaymentMethod,
        refNumber: refNumber,
      );

      ReservationModel data =
          store.state.paymentsState.reservation!.copyWith(payment: payment);

      await store.dispatch(SetReservation(reservation: data));
    }

    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PaymentStatus(
                  type: widget.type,
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
