import 'package:flutter/material.dart';
import '../../constants/enum/payment_enum.dart';
import './payment_status_view.dart';

class PaymentStatus extends StatefulWidget {
  const PaymentStatus({super.key, required this.type});

  final PaymentTypeEnum type;

  @override
  PaymentStatusView createState() => PaymentStatusView();
}
