// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/cupertino.dart' as _i9;
import 'package:flutter/foundation.dart' as _i6;
import 'package:nihol_app/features/details/presentation/pages/fairy_tale_details_page.dart'
    as _i1;
import 'package:nihol_app/features/home/presentation/pages/home_page.dart'
    as _i2;
import 'package:nihol_app/features/qr_scanner/data/model/fairy_tale_dto.dart'
    as _i8;
import 'package:nihol_app/features/qr_scanner/presentation/bloc/fairy_tale_bloc.dart'
    as _i7;
import 'package:nihol_app/features/qr_scanner/presentation/pages/qr_scanner_page.dart'
    as _i3;
import 'package:nihol_app/features/splash/presentation/pages/splash_page.dart'
    as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    FairyTaleRoute.name: (routeData) {
      final args = routeData.argsAs<FairyTaleRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.WrappedRoute(
            child: _i1.FairyTalePage(
          key: args.key,
          qrCode: args.qrCode,
          bloc: args.bloc,
          dirPath: args.dirPath,
          has: args.has,
          fairyTaleLocal: args.fairyTaleLocal,
          isBackgroundMusicOn: args.isBackgroundMusicOn,
        )),
      );
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.HomePage(
          key: args.key,
          prefs: args.prefs,
        ),
      );
    },
    QScannerRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.QScannerPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SplashPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.FairyTalePage]
class FairyTaleRoute extends _i5.PageRouteInfo<FairyTaleRouteArgs> {
  FairyTaleRoute({
    _i6.Key? key,
    required String? qrCode,
    required _i7.FairyTaleBloc bloc,
    required String dirPath,
    required bool has,
    _i8.FairyTaleDto? fairyTaleLocal,
    required bool isBackgroundMusicOn,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          FairyTaleRoute.name,
          args: FairyTaleRouteArgs(
            key: key,
            qrCode: qrCode,
            bloc: bloc,
            dirPath: dirPath,
            has: has,
            fairyTaleLocal: fairyTaleLocal,
            isBackgroundMusicOn: isBackgroundMusicOn,
          ),
          initialChildren: children,
        );

  static const String name = 'FairyTaleRoute';

  static const _i5.PageInfo<FairyTaleRouteArgs> page =
      _i5.PageInfo<FairyTaleRouteArgs>(name);
}

class FairyTaleRouteArgs {
  const FairyTaleRouteArgs({
    this.key,
    required this.qrCode,
    required this.bloc,
    required this.dirPath,
    required this.has,
    this.fairyTaleLocal,
    required this.isBackgroundMusicOn,
  });

  final _i6.Key? key;

  final String? qrCode;

  final _i7.FairyTaleBloc bloc;

  final String dirPath;

  final bool has;

  final _i8.FairyTaleDto? fairyTaleLocal;

  final bool isBackgroundMusicOn;

  @override
  String toString() {
    return 'FairyTaleRouteArgs{key: $key, qrCode: $qrCode, bloc: $bloc, dirPath: $dirPath, has: $has, fairyTaleLocal: $fairyTaleLocal, isBackgroundMusicOn: $isBackgroundMusicOn}';
  }
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i5.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i9.Key? key,
    required _i10.SharedPreferences prefs,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(
            key: key,
            prefs: prefs,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<HomeRouteArgs> page =
      _i5.PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.key,
    required this.prefs,
  });

  final _i9.Key? key;

  final _i10.SharedPreferences prefs;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, prefs: $prefs}';
  }
}

/// generated route for
/// [_i3.QScannerPage]
class QScannerRoute extends _i5.PageRouteInfo<void> {
  const QScannerRoute({List<_i5.PageRouteInfo>? children})
      : super(
          QScannerRoute.name,
          initialChildren: children,
        );

  static const String name = 'QScannerRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SplashPage]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
