
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

final getIt =GetIt.instance;

Future<void> setupServiceLocator() async{

  getIt.registerLazySingleton( ()=> FirebaseAuth.instance );

}