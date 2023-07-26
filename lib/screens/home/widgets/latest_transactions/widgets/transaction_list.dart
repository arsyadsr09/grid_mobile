import 'package:flutter/material.dart';
import 'package:grid_mobile/models/transaction_model.dart';
import 'package:grid_mobile/utils/formatter.dart';

import '../../../../../helpers/helpers.dart';
import '../../../../../widgets/widgets.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key, required this.data});

  final TransactionModel data;

  @override
  Widget build(BuildContext context) {
    final IconData icon = data.type == 'topup' || data.type == 'received'
        ? Icons.call_received
        : Icons.call_made;
    final Color color = data.type == 'topup' || data.type == 'received'
        ? ColorsCustom.green
        : ColorsCustom.primary;
    final String dateFormatted =
        Formatters.formatLongMonthDateTime(DateTime.parse(data.datetime!));
    final String value = data.creditIdr != null
        ? Formatters.formatCurrency(data.creditIdr)
        : Formatters.formatNumber(data.creditKwh);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: ColorsCustom.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: const Offset(4, 0),
                blurRadius: 12,
                spreadRadius: 0,
                color: Colors.black.withOpacity(0.1))
          ]),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: color,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  Formatters.capitalizeFirstofEach(data.type!),
                  color: ColorsCustom.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
                const SizedBox(height: 1),
                CustomText(
                  dateFormatted,
                  color: ColorsCustom.disabled,
                  fontWeight: FontWeight.w400,
                  fontSize: 9,
                ),
              ],
            ),
          ),
          CustomText(
            data.type == 'topup' || data.type == 'received'
                ? value
                : "- $value",
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
