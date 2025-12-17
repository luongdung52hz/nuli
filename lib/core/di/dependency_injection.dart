import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nuli_app/core/services/auth_service.dart';
import 'package:nuli_app/features/auth/data/repositories/auth_repository.dart';
import 'package:nuli_app/features/auth/data/repositories/user_repository.dart';
import '../../features/auth/presentation/provider/auth_controller.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async
{
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton<GoogleSignIn>(()=> GoogleSignIn());
  getIt.registerLazySingleton<AuthService>
    (()=> AuthService(
          getIt<FirebaseAuth>(),
          getIt<GoogleSignIn>()
      )
  );
  getIt.registerLazySingleton<UserRepository>(()=> UserRepository(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<AuthRepository>(()=>AuthRepository(getIt<AuthService>(),getIt<UserRepository>()));
  getIt.registerFactory<AuthController>(()=> AuthController(getIt<AuthService>()));
}
