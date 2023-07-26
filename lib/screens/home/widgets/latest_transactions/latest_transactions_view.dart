import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grid_mobile/models/models.dart';
import 'package:grid_mobile/redux/modules/payments_state.dart';
import 'package:grid_mobile/screens/home/widgets/latest_transactions/widgets/transaction_list.dart';
import '../../../../helpers/helpers.dart';
import '../../../../localization/app_translations.dart';
import '../../../../redux/app_state.dart';
import '../../../../widgets/widgets.dart';
import './latest_transactions_view_model.dart';

class LatestTransactionsView extends LatestTransactionsViewModel {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: StoreConnector<AppState, PaymentsState>(
          converter: (store) => store.state.paymentsState,
          builder: (context, state) {
            return Column(
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
                ...state.transactions!
                    .map((TransactionModel data) => TransactionList(data: data))
                    .toList()
              ],
            );
          }),
    );
  }
}
