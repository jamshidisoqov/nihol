import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../config/routes/app_router.gr.dart';
import '../../../../core/widgets/w_appbar.dart';
import '../../../../core/widgets/w_background.dart';
import '../../../data/data.dart';
import '../../../data/fairy_tale.dart';

@RoutePage()
class QScannerPage extends StatefulWidget {
  const QScannerPage({super.key});

  @override
  State<QScannerPage> createState() => _QScannerPageState();
}

class _QScannerPageState extends State<QScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  MobileScannerController cameraController = MobileScannerController();
  late Barcode result;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WBackground(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WAppBar(
                title: 'Scanner',
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width - 8,
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: MobileScanner(
                    // fit: BoxFit.contain,
                    controller: cameraController,
                    onDetect: (capture) {
                      final code = capture.barcodes.first.rawValue;
                      late int index;
                      FairyTale tale = FAIRY_TALE_DATA.firstWhere((element) {
                        bool has = false;
                        for (int i = 0; i < element.qrCodes.length; i++) {
                          if (element.qrCodes[i] == code) {
                            has = true;
                            index = i;
                            break;
                          } else {
                            continue;
                          }
                        }
                        return has;
                      });
                      if (tale.id.isNotEmpty) {
                        context.router.replace(
                            FairyTaleRoute(fairyTale: tale, index: index));
                      } else {
                        if (kDebugMode) {
                          print(code);
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
