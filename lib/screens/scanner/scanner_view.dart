import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:grid_mobile/helpers/helpers.dart';
import 'package:grid_mobile/screens/scanner/widgets/barcode_scanner_camera.dart';
import 'package:grid_mobile/widgets/custom_text.dart';
import '../../localization/app_translations.dart';
import './scanner_view_model.dart';

class ScannerView extends ScannerViewModel {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: BarcodeScannerCamera(
            canPop: false,
            onScan: onScanned,
            controller: scannerController,
            hintWidget: const SizedBox(),
            borderLength: 80,
            borderWidth: 8,
            cutOutSize: screenSize.width * 0.8,
            borderColor: ColorsCustom.white,
            borderRadius: 15,
            startDelay: true,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ColorsCustom.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                )),
            child: CustomText(
              AppTranslations.of(context)!.text("scan_qr_code"),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Positioned(
            left: 20,
            right: 20,
            top: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 36,
                  height: 36,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 18,
                    ),
                    color: ColorsCustom.white,
                    style: IconButton.styleFrom(
                        backgroundColor: ColorsCustom.white.withOpacity(0.3)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(
                  width: 36,
                  height: 36,
                  child: IconButton(
                    color: ColorsCustom.white,
                    tooltip: AppTranslations.of(context)!.text("torch"),
                    onPressed: () => scannerController.toggleTorch(),
                    icon: ValueListenableBuilder<TorchState>(
                      valueListenable: scannerController.torchState,
                      builder: (context, state, child) {
                        switch (state) {
                          case TorchState.off:
                            return const Icon(
                              Icons.flash_off,
                              color: Colors.grey,
                            );
                          case TorchState.on:
                            return const Icon(
                              Icons.flash_on,
                              color: Colors.orange,
                            );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ))
      ]),
    );
  }
}
