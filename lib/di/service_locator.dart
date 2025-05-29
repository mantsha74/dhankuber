
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

import '../data/repository/fd_repository.dart';
import '../data/repositoryImpl/fd_repository_Impl.dart';

final getIt =GetIt.instance;

Future<void> setupServiceLocator() async{

  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);

  getIt.registerLazySingleton<FDRepository>(
        () => FDRepositoryImpl(getIt<FirebaseFirestore>()),
  );

}