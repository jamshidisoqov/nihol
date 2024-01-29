import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nihol_app/core/resources/enums.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/features/qr_scanner/data/model/fairy_tale_dto.dart';
import '/core/widgets/w_appbar.dart';
import '/core/widgets/w_background.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../qr_scanner/presentation/bloc/fairy_tale_bloc.dart';
import '../widgets/w_play_buttons.dart';
import '../widgets/w_progress.dart';

@RoutePage()
class FairyTalePage extends StatefulWidget {
  final String? qrCode;
  final FairyTaleState state;

  const FairyTalePage({super.key, required this.qrCode, required this.state});

  @override
  State<FairyTalePage> createState() => _FairyTalePageState();
}

class _FairyTalePageState extends State<FairyTalePage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late FairyTaleDto? fairyTale;
  late List<String> images;
  late List<String> playlist;
  int currentTrackIndex = 0;
  int currentImageIndex = 0;
  int currentMusicIndex = 0;
  late bool isPlay = false;
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
    fairyTale = widget.state.fairyTale;
    index = widget.state.fairyTale?.qrCodes?.indexOf(widget.qrCode ?? '') ?? 0;
    playlist = fairyTale?.musics ?? [];
    images = fairyTale?.pics ?? [];
    currentMusicIndex = index;
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
    audioPlayer.stop();
    initPrefs();
  }

  void initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('music') ?? true) {
      backgroundMusicPlay();
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
    _audioPlayer.play(AssetSource(
        'fairy_tale/${fairyTale?.titleId}/${playlist[currentMusicIndex]}'));
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

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Future<void> next() async {
    currentMusicIndex = (currentMusicIndex + 1) % playlist.length;
    await stop();
    await play();
  }

  Future<void> previous() async {
    currentMusicIndex = (currentMusicIndex - 1) % playlist.length;
    if (currentMusicIndex < 0) {
      currentMusicIndex = playlist.length - 1;
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
              Container(
                color: Colors.black.withOpacity(0.30000001192092896),
                child: Column(
                  children: [
                    WAppBar(
                      title: fairyTale?.titles?[currentMusicIndex]
                          .toUpperCase() ??
                          '',
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
