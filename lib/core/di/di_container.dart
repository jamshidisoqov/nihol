import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/qr_scanner/data/datasource/remote_data_source.dart';
import '../../features/qr_scanner/data/repo/fairy_tale_repo_impl.dart';
import '../../features/qr_scanner/domain/repo/fairy_tale_repo.dart';
import '../../features/qr_scanner/domain/usecases/get_qr_codes.dart';
import '../../features/qr_scanner/domain/usecases/get_tales.dart';
import '../../features/qr_scanner/presentation/bloc/fairy_tale_bloc.dart';

GetIt ls = GetIt.instance;

Future<void> setupDI() async {
  final prefs = await SharedPreferences.getInstance();
  // final firebaseApp = Firebase.app();
  // final database = FirebaseDatabase.instanceFor(
  //     app: firebaseApp,
  //     databaseURL: 'https://fairy-tale-uz-default-rtdb.firebaseio.com/');
  // DatabaseReference ref = FirebaseDatabase.instance.ref();
  ls.registerSingleton<SharedPreferences>(prefs);
  //ls.registerSingleton<DatabaseReference>(ref);

  /// Bloc
  ls.registerFactory<FairyTaleBloc>(
    () => FairyTaleBloc(
      getQRCodes: ls(),
      getTales: ls(),
    ),
  );

  /// repositories
  ls.registerLazySingleton<FairyTaleRepo>(
    () => FairyTaleRepoImpl(
      remoteSource: ls(),
    ),
  );

  /// use cases
  ls.registerLazySingleton<GetQRCodes>(() => GetQRCodes(repo: ls()));
  ls.registerLazySingleton<GetTales>(() => GetTales(repo: ls()));

  /// data sources
  ls.registerLazySingleton<FairyTaleRemoteDataSource>(
      () => FairyTaleRemoteDataSourceImpl());
}
