import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nihol_app/core/resources/boxes.dart';
import 'package:nihol_app/features/qr_scanner/data/model/local/fairy_tale_local.dart';
import '../../../../core/widgets/w_item_container.dart';
import '../../../home/presentation/pages/home_page.dart';
import '/core/resources/enums.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../firebase_options.dart';
import '/features/qr_scanner/data/model/fairy_tale_dto.dart';
import '/core/widgets/w_appbar.dart';
import '/core/widgets/w_background.dart';
import '../../../qr_scanner/presentation/bloc/fairy_tale_bloc.dart';
import '../widgets/w_play_buttons.dart';
import '../widgets/w_progress.dart';

@RoutePage()
class FairyTalePage extends StatefulWidget implements AutoRouteWrapper {
  final FairyTaleDto? fairyTaleLocal;
  final bool isBackgroundMusicOn;
  final String dirPath;
  final bool has;
  final String? qrCode;
  final FairyTaleBloc bloc;

  const FairyTalePage({
    super.key,
    required this.qrCode,
    required this.bloc,
    required this.dirPath,
    required this.has,
    this.fairyTaleLocal,
    required this.isBackgroundMusicOn,
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: this,
    );
  }

  @override
  State<FairyTalePage> createState() => _FairyTalePageState();
}

class _FairyTalePageState extends State<FairyTalePage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late String localFilePath = '';
  late String dirPath = '';
  final AudioPlayer _audioPlayer = AudioPlayer();
  late FairyTaleDto? fairyTale = const FairyTaleDto();
  late List<String> images = [];
  late List<String> playlist;
  int currentTrackIndex = 0;
  int currentImageIndex = 0;
  late bool isPlay = false;
  late bool isDownloaded = false;
  Duration duration = const Duration();
  Duration position = const Duration();
  late Animation<double> animation;
  late AnimationController animationController;
  late int totalSeconds;
  late int index = 0;
  late int count = 0;
  late int t = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    dirPath = widget.dirPath;
    if (widget.has) {
      if (kDebugMode) {
        print('TESTTSTSTSS');
        print('TESTTSTSTSS');
        print('TESTTSTSTSS');
      }
      fairyTale = widget.fairyTaleLocal;
      index = widget.fairyTaleLocal?.qrCodes?.indexOf(widget.qrCode ?? '') ?? 0;
      playlist = widget.fairyTaleLocal?.musics ?? [];
      images = widget.fairyTaleLocal?.pics ?? [];
    }

    if (images.length > 1) {
      Timer.periodic(const Duration(seconds: 20), (Timer timer) {
        setState(() {
          currentImageIndex = (currentImageIndex + 1) % images.length;
        });
      });
    }

    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
        // totalSeconds = d.inSeconds;
        // count = totalSeconds ~/ images.length;
        // t = totalSeconds ~/ images.length;
      });
    });
    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        position = p;
        // if (p.inSeconds >= count) {
        //   count = count + t;
        //   currentImageIndex = (currentImageIndex + 1) % images.length;
        // }
        // if (p.inSeconds == 0) {
        //   currentImageIndex = 0;
        // }
      });
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlay = false;
        position = duration;
      });
    });
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.elasticOut);
    animation.addListener(() => setState(() {}));
    animationController.forward();
    audioPlayer.stop();
    initFireBase();
  }

  void initFireBase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.isBackgroundMusicOn) {
      backgroundMusicPlay();
    }
    WidgetsBinding.instance.removeObserver(this);
    _audioPlayer.dispose();
    animationController.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if ((state == AppLifecycleState.resumed)) {
      if (isPlay) {
        play();
      }
    } else if (state == AppLifecycleState.paused) {
      if (isPlay) {
        pause();
      }
    }
  }

  Future<void> play() async {
    final path = '$dirPath/${fairyTale?.titleId}/${fairyTale?.musics?[index]}';

    try {
      await _audioPlayer.play(DeviceFileSource(path));
      setState(() {
        isPlay = true;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error playing audio: $e');
      }
    }
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    setState(() {
      isPlay = false;
    });
  }

  void requestStoragePermission() async {
    await Permission.storage.request();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Future<void> next() async {
    index = (index + 1) % playlist.length;
    await stop();
    await play();
  }

  Future<void> previous() async {
    index = (index - 1) % playlist.length;
    if (index < 0) {
      index = playlist.length - 1;
    }
    await stop();
    await play();
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
              BlocConsumer<FairyTaleBloc, FairyTaleState>(
                listener: (context, state) async {
                  if (state.status == Statuses.success) {
                    if (widget.has && widget.fairyTaleLocal != null) {
                    } else {
                      await download(state.fairyTale);
                      setState(() {
                        fairyTale = state.fairyTale;
                        index = state.fairyTale?.qrCodes
                            ?.indexOf(widget.qrCode ?? '') ??
                            0;
                        playlist = state.fairyTale?.musics ?? [];
                        images = state.fairyTale?.pics ?? [];
                      });
                      fairyTaleLocalBox.add(
                        FairyTaleLocal(
                          id: state.fairyTale?.id ?? '',
                          titles: state.fairyTale?.titles ?? [],
                          titleId: state.fairyTale?.titleId ?? '',
                          musics: state.fairyTale?.musics ?? [],
                          qrCodes: state.fairyTale?.qrCodes ?? [],
                          pics: state.fairyTale?.pics ?? [],
                        ),
                      );
                    }
                  }
                },
                builder: (context, state) {
                  if (state.status == Statuses.success) {
                    return isDownloaded || widget.has
                        ? Container(
                      color:
                      Colors.black.withOpacity(0.30000001192092896),
                      child: Column(
                        children: [
                          WAppBar(
                            title:
                            fairyTale?.titles?[index].toUpperCase() ??
                                '',
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  const Spacer(),
                                  AnimatedSwitcher(
                                    duration: const Duration(seconds: 3),
                                    child: SizedBox(
                                      key: ValueKey<int>(
                                          currentImageIndex),
                                      height: 250,
                                      child: FadeTransition(
                                        key: ValueKey<int>(
                                            currentImageIndex),
                                        opacity:
                                        const AlwaysStoppedAnimation(
                                            1.0),
                                        child: WItemContainer(
                                          imagePath:
                                          '$dirPath/${fairyTale?.titleId}/images/${fairyTale?.pics?[currentImageIndex]}',
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  WPlayButtons(
                                    isPlay: isPlay,
                                    onStart: () async {
                                      if (isPlay) {
                                        pause();
                                      } else {
                                        play();
                                      }
                                    },
                                    onNext: next,
                                    onPrev: previous,
                                  ),
                                  WProgress(
                                    duration: duration,
                                    position: position,
                                    player: _audioPlayer,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        : Center(
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        height: 60,
                        width: 60,
                        child: Lottie.asset(
                          'assets/animation/loading.json',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      height: 60,
                      width: 60,
                      child: Lottie.asset(
                        'assets/animation/loading.json',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> downloadFile({
    FairyTaleDto? tale,
    required Reference ref,
    required int i,
  }) async {
    try {
      final urlMusic = await ref.getDownloadURL();

      final dir = await getApplicationDocumentsDirectory();
      final pathMusic = '${dir.path}/${tale?.titleId}/${tale?.musics?[i]}';

      await Dio().download(urlMusic, pathMusic);
    } catch (e) {
      if (kDebugMode) {
        print('Error downloading file: $e');
      }
    }
  }

  Future<void> downloadPics({
    FairyTaleDto? tale,
    required Reference ref,
    required int i,
  }) async {
    try {
      final urlPics = await ref.getDownloadURL();

      final dir = await getApplicationDocumentsDirectory();
      final pathPics = '${dir.path}/${tale?.titleId}/images/${tale?.pics?[i]}';

      await Dio().download(urlPics, pathPics);
    } catch (e) {
      if (kDebugMode) {
        print('Error downloading file: $e');
      }
    }
  }

  Future<void> download(FairyTaleDto? tale) async {
    FirebaseStorage storage = FirebaseStorage.instance;

    try {
      int length = tale?.pics?.length ?? 0;
      for (int i = 0; i < length; i++) {
        await downloadPics(
          tale: tale,
          ref: storage.ref().child("${tale?.titleId}/images/${tale?.pics?[i]}"),
          i: i,
        );
      }
      int musicLen = tale?.musics?.length ?? 3;
      for (int i = 0; i < musicLen; i++) {
        await downloadFile(
          tale: tale,
          ref: storage.ref().child("${tale?.titleId}/${tale?.musics?[i]}"),
          i: i,
        );
      }
      setState(() {
        isDownloaded = true;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error downloading music: $e');
      }
      setState(() {
        isDownloaded = false;
      });
    }
  }
}
