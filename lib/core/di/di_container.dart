import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt ls = GetIt.instance;


Future<void> setupDI() async {
  final prefs = await SharedPreferences.getInstance();
  final firebaseApp = Firebase.app();
  final database = FirebaseDatabase.instanceFor(app: firebaseApp, databaseURL: 'https://fairy-tale-uz-default-rtdb.firebaseio.com/');
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  ls.registerSingleton<SharedPreferences>(prefs);
  ls.registerSingleton<DatabaseReference>(ref);


}
