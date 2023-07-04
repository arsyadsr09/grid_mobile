import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:grid_mobile/screens/map_layer/widgets/custom_search_bar.dart';
import 'package:grid_mobile/screens/map_layer/widgets/slider_info.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart' show LatLng;
import '../../constants/general_const.dart';
import '../../helpers/helpers.dart';
import '../../localization/app_translations.dart';
import '../../redux/app_state.dart';
import '../../redux/modules/main_state.dart';
import '../../widgets/widgets.dart';
import './map_layer_view_model.dart';

class MapLayerView extends MapLayerViewModel {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height,
      width: double.maxFinite,
      child: StoreConnector<AppState, MainState>(
          converter: (store) => store.state.mainState,
          builder: (context, state) {
            return Stack(children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  rotationWinGestures: MultiFingerGesture.none,
                  onMapReady: onMapReady,
                  center: state.myLocation != null
                      ? LatLng(state.myLocation!.latitude,
                          state.myLocation!.longitude)
                      : initLatLng,
                  minZoom: 1,
                  zoom: 18,
                  interactiveFlags:
                      InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                ),
                children: [
                  TileLayer(
                    backgroundColor: Colors.transparent,
                    maxNativeZoom: 19,
                    maxZoom: 30,
                    urlTemplate: GeneralConstants.gmapLayer,
                    subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
                  ),
                  Container(
                    color: ColorsCustom.black.withOpacity(0.2),
                    height: screenSize.height,
                    width: double.maxFinite,
                  ),
                  if (state.myLocation != null && mapReady)
                    getItemCurrentLocation(
                        latLng: LatLng(state.myLocation!.latitude,
                            state.myLocation!.longitude)),
                  AnimatedOpacity(
                      opacity: isShowSliderInfo ? 1 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: SliderInfo(value: filterValue)),
                  GestureDetector(
                    onTap: () => toggleResultShow(false),
                    child: Container(
                      color: Colors.transparent,
                      height: screenSize.height,
                      width: double.maxFinite,
                    ),
                  ),
                ],
              ),
              AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  bottom: 90,
                  right: isResultShow ? -55 : 10,
                  left: 20,
                  top: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 65),
                      Expanded(
                        child: Container(
                          width: 30,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                              color: ColorsCustom.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              Icon(
                                Icons.energy_savings_leaf_outlined,
                                color: ColorsCustom.primary,
                                size: 20,
                              ),
                              Expanded(
                                child: RotatedBox(
                                  quarterTurns: -1,
                                  child: Slider(
                                    max: 50,
                                    divisions: 50,
                                    value: filterValue,
                                    onChanged: setFilterValue,
                                  ),
                                ),
                              ),
                              CustomText(
                                filterValue.toStringAsFixed(0),
                                color: ColorsCustom.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 45,
                        width: 45,
                        child: FloatingActionButton(
                          // onPressed: () => getMyLocation(true),
                          onPressed: () => onDetailStationOpen(),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          backgroundColor: ColorsCustom.white,
                          child: Icon(
                            Icons.near_me_outlined,
                            color: ColorsCustom.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  )),
              Positioned(
                top: 40,
                left: 15,
                right: 15,
                child: CustomSearchBar(
                  controller: searchController,
                  color: ColorsCustom.black,
                  hint: AppTranslations.of(context)!.text("search_location"),
                  isResultShow: isResultShow,
                  onChange: onSearchChanged,
                  data: const [],
                ),
              ),
            ]);
          }),
    );
  }
}
