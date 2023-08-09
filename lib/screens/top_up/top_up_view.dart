import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grid_mobile/utils/formatter.dart';
import 'package:grid_mobile/widgets/custom_list_tile.dart';
import '../../helpers/helpers.dart';
import '../../localization/app_translations.dart';
import '../../redux/app_state.dart';
import '../../widgets/widgets.dart';
import './top_up_view_model.dart';

class TopUpView extends TopUpViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (context, state) {
              return Stack(children: [
                const HeaderPage(title: "Top Up"),
                Positioned(
                    left: 20,
                    right: 20,
                    bottom: 0,
                    top: 90,
                    child: ListView(
                      padding: const EdgeInsets.only(bottom: 20),
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              "Saldo Grid Cash:",
                              color: ColorsCustom.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                            CustomText(
                              Formatters.formatCurrency(state.userState.credit),
                              color: ColorsCustom.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            )
                          ],
                        ),
                        const SizedBox(height: 40),
                        CustomText(
                          AppTranslations.of(context)!.text("payment_method"),
                          color: ColorsCustom.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: 15),
                        topUpMethod("Oneklik", image: "oneklik.png"),
                        topUpMethod("Alfamart", image: "alfamart.png"),
                        topUpMethod("Indomaret", image: "indomaret.png"),
                        topUpMethod("Debit Visa / Mastercard",
                            icon: Icons.credit_card_outlined),
                        topUpMethod("ATM", icon: Icons.atm_rounded),
                        topUpMethod("Internet / Mobile Banking",
                            icon: Icons.phone_iphone_outlined),
                      ],
                    ))
              ]);
            }));
  }

  Widget topUpMethod(String name, {String? image, IconData? icon}) {
    return CustomListTile(
        onClick: onTopUpMethodClicked,
        suffix: Icon(
          Icons.chevron_right_rounded,
          size: 20,
          color: ColorsCustom.disabled,
        ),
        preffix: image != null
            ? Image.asset(
                "assets/images/payments/$image",
                width: 24,
              )
            : Icon(
                icon,
                size: 24,
                color: ColorsCustom.primary,
              ),
        name: name);
  }
}
