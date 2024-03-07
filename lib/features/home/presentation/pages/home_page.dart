import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/resources/boxes.dart';
import '../../../qr_scanner/data/model/fairy_tale_dto.dart';
import '../../../qr_scanner/data/model/local/fairy_tale_local.dart';
import '../../../qr_scanner/presentation/bloc/fairy_tale_bloc.dart';
import '/config/routes/app_router.gr.dart';
import '/core/widgets/w_background.dart';
import '/gen/assets.gen.dart';
import '../widgets/w_custom_button.dart';
import '../widgets/w_top_row_buttons.dart';

final AudioPlayer audioPlayer = AudioPlayer();

void backgroundMusicPlay() {
  audioPlayer.play(AssetSource('background_music.mp3'));
  audioPlayer.onPlayerComplete.listen((event) {
    audioPlayer.play(AssetSource('background_music.mp3'));
  });
}

@RoutePage()
class HomePage extends StatefulWidget {
  final SharedPreferences prefs;

  const HomePage({
    Key? key,
    required this.prefs,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    musicController();
  }

  void musicController() {
    if (widget.prefs.getBool('music') ?? true) {
      setState(() {
        backgroundMusicPlay();
      });
    } else {
      audioPlayer.stop();
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (context.router.currentPath == '/home') {
      if (state == AppLifecycleState.paused) {
        setState(() {
          audioPlayer.stop();
        });
      } else if (state == AppLifecycleState.resumed) {
        setState(() {
          musicController();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WBackground(
          child: Stack(
            children: [
              Lottie.asset(
                'assets/animation/birds.json',
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.black.withOpacity(0.30000001192092896),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      child: WTopRowButtons(),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/animation/scan.json',
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 16,
                              ),
                              child: WCustomButton(
                                icon: Assets.png.searchButton
                                    .image(width: 90, height: 90),
                                onPressed: () async {

                                  final prefs = await SharedPreferences.getInstance();
                                  final bloc = context.read<FairyTaleBloc>();
                                  final code = "ToSuRaEn17";
                                  //capture.barcodes.first.rawValue;

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
                                    } else {
                                      if (context.mounted) {
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
                                      bloc.add(
                                        FairyTaleEvent.getTales(
                                          qrCode: code,
                                        ),
                                      );
                                    }
                                  } else {
                                    bloc.add(const FairyTaleEvent.getQRCodes());
                                  }
                                  
                                  context.router.push(
                                    const QScannerRoute(),
                                  );



                                  setState(() {});
                                  var status = await Permission.camera.status;
                                  if (kDebugMode) {
                                    print(status);
                                  }
                                  if (status.isGranted && context.mounted) {
                                    context.router.push(
                                      const QScannerRoute(),
                                    );
                                  } else if (status.isPermanentlyDenied) {
                                    if (context.mounted) {
                                      showAdaptiveDialog(
                                        context: context,
                                        builder: (context) =>
                                            CupertinoAlertDialog(
                                          title:
                                              const Text("Permission Denied"),
                                          content: const Text(
                                              "Allow access to camera from settings"),
                                          actions: [
                                            CupertinoDialogAction(
                                              onPressed: () =>
                                                  context.router.pop(),
                                              child: const Text('Cancel'),
                                            ),
                                            CupertinoDialogAction(
                                              onPressed: () async {
                                                await context.router.pop();
                                                openAppSettings();
                                              },
                                              child: const Text('Settings'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  } else {
                                    await Permission.camera.request();
                                    status = await Permission.camera.status;
                                    if (status.isGranted && context.mounted) {
                                      context.router.push(
                                        const QScannerRoute(),
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
}

class LocalCheck {
  final bool has;
  final FairyTaleLocal? taleLocal;

  LocalCheck({required this.has, this.taleLocal});
}
