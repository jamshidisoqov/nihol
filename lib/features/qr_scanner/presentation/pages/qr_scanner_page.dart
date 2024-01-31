import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '/core/resources/enums.dart';
import '/config/routes/app_router.gr.dart';
import '../bloc/fairy_tale_bloc.dart';
import '/core/di/di_container.dart';
import '/core/widgets/w_appbar.dart';
import '/core/widgets/w_background.dart';

@RoutePage()
class QScannerPage extends StatefulWidget implements AutoRouteWrapper {
  const QScannerPage({super.key});

  @override
  State<QScannerPage> createState() => _QScannerPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ls<FairyTaleBloc>()..add(const FairyTaleEvent.getQRCodes()),
      child: this,
    );
  }
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
              BlocBuilder<FairyTaleBloc, FairyTaleState>(
                builder: (context, state) {
                  return state.status == Statuses.success
                      ? Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width - 8,
                          padding: const EdgeInsets.all(16.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: MobileScanner(
                              // fit: BoxFit.contain,
                              controller: cameraController,
                              onDetect: (capture) async {
                                final code = capture.barcodes.first.rawValue;
                                bool has =
                                    state.qrCodes?.qr_codes?.contains(code) ??
                                        false;
                                if (has) {
                                  final bloc = context.read<FairyTaleBloc>();
                                  bloc.add(
                                      FairyTaleEvent.getTales(qrCode: code));
                                  context.router.replace(
                                      FairyTaleRoute(bloc: bloc, qrCode: code));
                                } else {
                                  if (kDebugMode) {
                                    print(code);
                                  }
                                }
                              },
                            ),
                          ),
                        )
                      : const Center(
                          child: Text('Nothing here'),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
