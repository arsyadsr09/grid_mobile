import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grid_mobile/models/marker_model.dart';
import 'package:grid_mobile/redux/modules/map_state.dart';
import 'package:grid_mobile/widgets/widgets.dart';
import '../../../../helpers/helpers.dart';
import '../../../../localization/app_translations.dart';
import '../../../../redux/app_state.dart';
import './detail_station_view_model.dart';

class DetailStationView extends DetailStationViewModel {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return StoreConnector<AppState, MapState>(
        converter: (store) => store.state.mapState,
        builder: (context, state) {
          return Container(
            width: screenSize.width,
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            decoration: BoxDecoration(
                color: ColorsCustom.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Container(
                    height: 4,
                    width: 50,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: ColorsCustom.disabled.withOpacity(0.4)),
                  ),
                ),
                CustomText(
                  state.selectedMarker?.name,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                const SizedBox(height: 5),
                CustomText(
                  state.selectedMarker?.address,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: ColorsCustom.disabled,
                ),
                const SizedBox(height: 5),
                ratingStars(state.selectedMarker!.rating!,
                    state.selectedMarker?.reviews),
                const SizedBox(height: 20),
                Row(
                  children: state.selectedMarker!.chargingPorts!
                      .map((int i) =>
                          chargingTypeImage(screenSize: screenSize, type: i))
                      .toList(),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  onPressed: () => Navigator.pushNamed(context, "/Reservation"),
                  text: AppTranslations.of(context)!.text("reserve"),
                  textColor: ColorsCustom.white,
                  bgColor: ColorsCustom.pomegrande,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  borderRadius: BorderRadius.circular(8),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  margin: EdgeInsets.zero,
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        });
  }

  Widget ratingStars(double rating, List<Reviews>? reviews) {
    return Row(
      children: [
        AbsorbPointer(
          child: RatingBar(
            initialRating: rating,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 20,
            glow: false,
            ratingWidget: RatingWidget(
              full: Icon(Icons.star_rounded, color: ColorsCustom.sunflower),
              half:
                  Icon(Icons.star_half_rounded, color: ColorsCustom.sunflower),
              empty: Icon(Icons.star_border_rounded,
                  color: ColorsCustom.sunflower),
            ),
            itemPadding: const EdgeInsets.only(right: 2.0),
            onRatingUpdate: (_) {},
          ),
        ),
        const SizedBox(width: 5),
        CustomText(
          "$rating, ${reviews?.length ?? 0} ${AppTranslations.of(context)!.text("reviews")}",
          fontWeight: FontWeight.w500,
          fontSize: 11,
          color: ColorsCustom.disabled,
        ),
      ],
    );
  }

  Widget chargingTypeImage({required int type, required Size screenSize}) {
    String image = "";
    if (type == 1) image = "assets/images/type_charging/type_1.png";
    if (type == 2) image = "assets/images/type_charging/type_2.png";
    if (type == 3) image = "assets/images/type_charging/gbt.png";

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Image.asset(
          image,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
