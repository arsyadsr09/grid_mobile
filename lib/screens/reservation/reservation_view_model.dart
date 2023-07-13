import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grid_mobile/constants/dummy_data.dart';
import 'package:grid_mobile/constants/enum/payment_enum.dart';
import 'package:grid_mobile/redux/actions/payments_action.dart';
import 'package:grid_mobile/redux/app_state.dart';
import 'package:grid_mobile/screens/payment/payment.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart' show LatLng;
import 'package:redux/redux.dart';
import '../../models/models.dart';
import './reservation.dart';

abstract class ReservationViewModel extends State<Reservation> {
  late Store<AppState> store;
  LatLng initLatLng = const LatLng(-8.1727817, 114.3855937);

  List initSpace = [
    {
      "id": "1",
      "name": "A1",
      "charging_ports": [1, 2, 3],
      "is_avail": true,
    },
    {
      "id": "2",
      "name": "A2",
      "charging_ports": [1, 2, 3],
      "is_avail": false,
    },
  ];

  bool pickMySpace = false;

  int? selectedPort;

  String? selectedSpace;

  void togglePickMySpace(bool value) {
    setState(() => pickMySpace = value);
  }

  void setSelectedSpace(String value) {
    setState(() {
      selectedSpace = value;
      selectedPort = null;
    });
  }

  void setSelectedPort(int value) {
    setState(() => selectedPort = value);
  }

  String getPortString() {
    switch (selectedPort) {
      case 1:
        return "type_1";
      case 2:
        return "type_2";
      case 3:
        return "gb_t";
      default:
        return "";
    }
  }

  Future<void> onContinue() async {
    int reserveAmount = 20000;
    int spacePickAmount = 10000;
    int amount = reserveAmount + spacePickAmount;
    int tax = (amount * 0.1).round();

    PaymentModel payment = PaymentModel(
      amount: amount,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      tax: tax,
      total: amount + tax,
    );

    ReservationModel reservation = ReservationModel(
        chargingPointId: DummyData.selectedMarker.id,
        reserveAmount: reserveAmount,
        spacePickAmount: spacePickAmount,
        isSelectManual: pickMySpace,
        space: Space(id: selectedSpace, port: getPortString()),
        payment: payment);

    await store.dispatch(SetReservation(reservation: reservation));

    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const Payment(
                  type: PaymentTypeEnum.reservation,
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
