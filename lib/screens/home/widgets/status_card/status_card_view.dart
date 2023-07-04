import 'package:flutter/material.dart';
import 'package:grid_mobile/constants/enum/status_enum.dart';
import 'package:grid_mobile/screens/home/widgets/status_card/widgets/done_card.dart';
import 'package:grid_mobile/screens/home/widgets/status_card/widgets/inactive_card.dart';
import 'package:grid_mobile/screens/home/widgets/status_card/widgets/process_card.dart';
import 'package:grid_mobile/screens/home/widgets/status_card/widgets/ready_card.dart';
import 'package:grid_mobile/screens/home/widgets/status_card/widgets/reserved_card.dart';
import './status_card_view_model.dart';

class StatusCardView extends StatusCardViewModel {
  @override
  Widget build(BuildContext context) {
    switch (status) {
      case ChargingStatus.ready:
        return ReadyCard(
          onStartCharging: onStartCharging,
          statusBgColor: statusBgColor,
          statusIconColor: statusIconColor,
          statusText: statusText,
          location: location,
          slot: slot,
          expiredIn: expiredIn,
        );
      case ChargingStatus.inactive:
        return const InactiveCard();
      case ChargingStatus.process:
      case ChargingStatus.interupted:
        return ProcessCard(
            isShow: isShow,
            minHeightShow: minHeightShow,
            minHeightHide: minHeightHide,
            progress: progress,
            totalPower: totalPower,
            currentPower: currentPower,
            statusBgColor: statusBgColor,
            statusIconColor: statusIconColor,
            statusText: statusText,
            statusDetailText: statusDetailText,
            statusDetailIcon: statusDetailIcon,
            toggleIsShow: toggleIsShow,
            toggleIsStop: toggleIsStop,
            isStop: isStop);
      case ChargingStatus.reserved:
        return ReservedCard(
          isShow: isShow,
          isStop: isStop,
          minHeightShow: minHeightShow,
          minHeightHide: minHeightHide,
          statusText: statusText,
          location: location,
          slot: slot,
          statusBgColor: statusBgColor,
          statusIconColor: statusIconColor,
          expiredIn: expiredIn,
          toggleIsShow: toggleIsShow,
          toggleIsStop: toggleIsStop,
          onClaimSlot: onClaimSlot,
          onOpenDirection: onOpenDirection,
          latLng: reservedLocation,
        );
      case ChargingStatus.done:
        return const DoneCard();
      default:
        return const SizedBox();
    }
  }
}
