import 'package:flutter/material.dart';
import 'package:grid_mobile/screens/home/widgets/latest_transactions/widgets/transaction_list.dart';
import '../../../../helpers/helpers.dart';
import '../../../../localization/app_translations.dart';
import '../../../../widgets/widgets.dart';
import './latest_transactions_view_model.dart';

class LatestTransactionsView extends LatestTransactionsViewModel {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                AppTranslations.of(context)!.text("transactions"),
                color: ColorsCustom.black,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              SizedBox(
                height: 35,
                width: 35,
                child: IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.more_horiz,
                    color: ColorsCustom.black,
                  ),
                ),
              ),
            ],
          ),
          ...transactions.map((data) => TransactionList(data: data)).toList()
        ],
      ),
    );
  }
}
