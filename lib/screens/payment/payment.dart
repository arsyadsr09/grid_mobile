import 'package:flutter/material.dart';
import '../../constants/enum/payment_enum.dart';
import './payment_view.dart';

class Payment extends StatefulWidget {
  const Payment({super.key, required this.type});

  final PaymentTypeEnum type;

  @override
  PaymentView createState() => PaymentView();
}
