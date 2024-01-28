/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/CaveatBrush-Regular.ttf
  String get caveatBrushRegular => 'assets/fonts/CaveatBrush-Regular.ttf';

  /// List of all assets
  List<String> get values => [caveatBrushRegular];
}

class $AssetsJpgGen {
  const $AssetsJpgGen();

  /// File path: assets/jpg/background.jpg
  AssetGenImage get background =>
      const AssetGenImage('assets/jpg/background.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [background];
}

class $AssetsPngGen {
  const $AssetsPngGen();

  /// File path: assets/png/back_button.png
  AssetGenImage get backButton =>
      const AssetGenImage('assets/png/back_button.png');

  /// File path: assets/png/board.png
  AssetGenImage get board => const AssetGenImage('assets/png/board.png');

  /// File path: assets/png/cancel_button.png
  AssetGenImage get cancelButton =>
      const AssetGenImage('assets/png/cancel_button.png');

  /// File path: assets/png/facebook_button.png
  AssetGenImage get facebookButton =>
      const AssetGenImage('assets/png/facebook_button.png');

  /// File path: assets/png/more_app_button.png
  AssetGenImage get moreAppButton =>
      const AssetGenImage('assets/png/more_app_button.png');

  /// File path: assets/png/next_button.png
  AssetGenImage get nextButton =>
      const AssetGenImage('assets/png/next_button.png');

  /// File path: assets/png/pause_button.png
  AssetGenImage get pauseButton =>
      const AssetGenImage('assets/png/pause_button.png');

  /// File path: assets/png/play_button.png
  AssetGenImage get playButton =>
      const AssetGenImage('assets/png/play_button.png');

  /// File path: assets/png/previus_button.png
  AssetGenImage get previusButton =>
      const AssetGenImage('assets/png/previus_button.png');

  /// File path: assets/png/question.png
  AssetGenImage get question => const AssetGenImage('assets/png/question.png');

  /// File path: assets/png/rate_button.png
  AssetGenImage get rateButton =>
      const AssetGenImage('assets/png/rate_button.png');

  /// File path: assets/png/search_button.png
  AssetGenImage get searchButton =>
      const AssetGenImage('assets/png/search_button.png');

  /// File path: assets/png/setting_button.png
  AssetGenImage get settingButton =>
      const AssetGenImage('assets/png/setting_button.png');

  /// File path: assets/png/share_button.png
  AssetGenImage get shareButton =>
      const AssetGenImage('assets/png/share_button.png');

  /// File path: assets/png/sound_on.png
  AssetGenImage get soundOn => const AssetGenImage('assets/png/sound_on.png');

  /// File path: assets/png/splash_conainer.png
  AssetGenImage get splashConainer =>
      const AssetGenImage('assets/png/splash_conainer.png');

  /// File path: assets/png/yes_button.png
  AssetGenImage get yesButton =>
      const AssetGenImage('assets/png/yes_button.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        backButton,
        board,
        cancelButton,
        facebookButton,
        moreAppButton,
        nextButton,
        pauseButton,
        playButton,
        previusButton,
        question,
        rateButton,
        searchButton,
        settingButton,
        shareButton,
        soundOn,
        splashConainer,
        yesButton
      ];
}

class Assets {
  Assets._();

  static const String backgroundMusic = 'assets/background_music.mp3';
  static const String click = 'assets/click.mp3';
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsJpgGen jpg = $AssetsJpgGen();
  static const $AssetsPngGen png = $AssetsPngGen();

  /// List of all assets
  static List<String> get values => [backgroundMusic, click];
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
