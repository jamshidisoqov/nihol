import 'package:auto_route/auto_route.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/resources/boxes.dart';
import '../../data/model/fairy_tale_dto.dart';
import '../../data/model/local/fairy_tale_local.dart';
import '../bloc/fairy_tale_bloc.dart';
import '/config/routes/app_router.gr.dart';
import '/core/widgets/w_appbar.dart';
import '/core/widgets/w_background.dart';

@RoutePage()
class QScannerPage extends StatefulWidget {
  const QScannerPage({Key? key});

  @override
  State<QScannerPage> createState() => _QScannerPageState();
}

class _QScannerPageState extends State<QScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  MobileScannerController cameraController = MobileScannerController();

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Lottie.asset(
              'assets/animation/birds.json',
              fit: BoxFit.cover,
            ),
            WBackground(
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
                        controller: cameraController,
                        onDetect: (capture) async {
                          final prefs = await SharedPreferences.getInstance();
                          final bloc = context.read<FairyTaleBloc>();
                          final code = capture.barcodes.first.rawValue;

                          List<String> qrCodesListInLocal =
                              qrCodesLocalBox.values.toList().cast<String>();
                          List<FairyTaleLocal> fairyTaleListInLocal =
                              fairyTaleLocalBox.values
                                  .toList()
                                  .cast<FairyTaleLocal>();
                          bool hasQrCodesInLocal =
                              qrCodesListInLocal.contains(code);

                          final dir = await getApplicationDocumentsDirectory();
                          if (hasQrCodesInLocal) {
                            LocalCheck local = hasFairyTaleInLocal(
                                fairyTaleListInLocal, code ?? '');
                            if (local.has) {
                              bloc.add(
                                FairyTaleEvent.hasInLocal(
                                  local: local.taleLocal,
                                ),
                              );
                              if (context.mounted) {
                                if (prefs.getBool("send_tv") ?? false) {
                                  sendTv(prefs, code ?? "",context);
                                } else {
                                  context.router.replace(
                                    FairyTaleRoute(
                                      fairyTaleLocal: FairyTaleDto(
                                        titles: local.taleLocal?.titles,
                                        titleId: local.taleLocal?.titleId,
                                        musics: local.taleLocal?.musics,
                                        pics: local.taleLocal?.pics,
                                        qrCodes: local.taleLocal?.qrCodes,
                                      ),
                                      has: local.has,
                                      dirPath: dir.path,
                                      bloc: bloc,
                                      qrCode: code,
                                      isBackgroundMusicOn:
                                          prefs.getBool('music') ?? true,
                                    ),
                                  );
                                }
                              }
                            } else {
                              if (context.mounted) {
                                if (prefs.getBool("send_tv") ?? false) {
                                  sendTv(prefs, code ?? "",context);
                                } else {
                                  context.router.replace(
                                    FairyTaleRoute(
                                      has: false,
                                      dirPath: dir.path,
                                      bloc: bloc,
                                      qrCode: code,
                                      isBackgroundMusicOn:
                                          prefs.getBool('music') ?? true,
                                    ),
                                  );
                                }
                                ;
                              }
                              bloc.add(
                                FairyTaleEvent.getTales(
                                  qrCode: code,
                                ),
                              );
                            }
                          } else {
                            bloc.add(const FairyTaleEvent.getQRCodes());
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  LocalCheck hasFairyTaleInLocal(
      List<FairyTaleLocal> fairyTaleLocal, String code) {
    bool has = false;
    late FairyTaleLocal taleLocal;
    for (int i = 0; i < fairyTaleLocal.length; i++) {
      if (fairyTaleLocal[i].qrCodes.contains(code)) {
        has = true;
        taleLocal = fairyTaleLocal[i];
        break;
      }
      has = false;
      continue;
    }
    if (has) {
      return LocalCheck(has: true, taleLocal: taleLocal);
    } else {
      return LocalCheck(has: false);
    }
  }

  void sendTv(SharedPreferences prefs, String qrCode,BuildContext context) async {
    try {
      String id = prefs.getString("device_id")!;
      final ref = FirebaseDatabase.instance.ref();
      Map<String, String> map = {};
      map["qr_code"] = qrCode;
      await ref.child('device_qr_codes').child(id).set(map);
      context.router.maybePop();
    } catch (e) {
      e.toString();
    }
  }
}

class LocalCheck {
  final bool has;
  final FairyTaleLocal? taleLocal;

  LocalCheck({required this.has, this.taleLocal});
}
