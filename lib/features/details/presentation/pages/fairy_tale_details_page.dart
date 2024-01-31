import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nihol_app/core/resources/enums.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/di/di_container.dart';
import '../../../../firebase_options.dart';
import '/features/qr_scanner/data/model/fairy_tale_dto.dart';
import '/core/widgets/w_appbar.dart';
import '/core/widgets/w_background.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../qr_scanner/presentation/bloc/fairy_tale_bloc.dart';
import '../widgets/w_play_buttons.dart';
import '../widgets/w_progress.dart';

@RoutePage()
class FairyTalePage extends StatefulWidget implements AutoRouteWrapper {
  final String? qrCode;
  final FairyTaleBloc bloc;

  const FairyTalePage({super.key, required this.qrCode, required this.bloc});

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
  final AudioPlayer _audioPlayer = AudioPlayer();
  late FairyTaleDto? fairyTale = const FairyTaleDto();
  late List<String> images;
  late List<String> playlist;
  int currentTrackIndex = 0;
  int currentImageIndex = 0;
  late bool isPlay = false;
  late bool isDownloaded = false;
  static const String basePath = 'assets/fairy_tale/';
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

    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
        totalSeconds = d.inSeconds;
        count = totalSeconds ~/ images.length;
        t = totalSeconds ~/ images.length;
      });
    });
    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        position = p;
        if (p.inSeconds == count) {
          count = count + t;
          currentImageIndex = (currentImageIndex + 1) % images.length;
        }
        if (p.inSeconds == 0) {
          currentImageIndex = 0;
        }
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
    //audioPlayer.stop();
    initPrefs();
  }

  void initPrefs() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('music') ?? true) {
      //backgroundMusicPlay();
    }
  }

  @override
  void dispose() {
    super.dispose();
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
    final dir = await getApplicationDocumentsDirectory();
    final path =
        '${dir.path}/${fairyTale?.titleId}/${fairyTale?.musics?[index]}';

    await _audioPlayer.play(DeviceFileSource(path));

    setState(() {
      isPlay = true;
    });
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
                    await downloadMusic(state.fairyTale);
                    setState(() {
                      fairyTale = state.fairyTale;
                      index = state.fairyTale?.qrCodes
                              ?.indexOf(widget.qrCode ?? '') ??
                          0;
                      playlist = state.fairyTale?.musics ?? [];
                      images = state.fairyTale?.pics ?? [];
                    });
                  }
                },
                builder: (context, state) {
                  if (state.status == Statuses.success) {
                    return Container(
                      color: Colors.black.withOpacity(0.30000001192092896),
                      child: Column(
                        children: [
                          WAppBar(
                            title:
                                fairyTale?.titles?[index].toUpperCase() ?? '',
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Spacer(),
                                  AnimatedSwitcher(
                                    duration: const Duration(seconds: 3),
                                    child: SizedBox(
                                      key: ValueKey<int>(currentImageIndex),
                                      height: 250,
                                      child: FadeTransition(
                                        key: ValueKey<int>(currentImageIndex),
                                        opacity:
                                            const AlwaysStoppedAnimation(1.0),
                                        child: Container(),
                                        // WItemContainer(
                                        //   imagePath:
                                        //       '$basePath${fairyTale?.titleId}/pages/${images[currentImageIndex]}',
                                        // ),
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(),
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

  Future<bool> downloadFile(
      {FairyTaleDto? tale, required Reference ref, required int i}) async {
    try {
      final url = await ref.getDownloadURL();

      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/${tale?.titleId}/${tale?.musics?[i]}';

      await Dio().download(url, path);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> downloadMusic(FairyTaleDto? tale) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      for (int i = 0; i < 3; i++) {
        await downloadFile(
          tale: tale,
          ref: storage.ref().child("${tale?.titleId}/${tale?.musics?[i]}"),
          i: i,
        );
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
