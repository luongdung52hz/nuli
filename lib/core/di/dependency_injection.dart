import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nuli_app/core/services/auth_service.dart';
import 'package:nuli_app/core/services/chat_ai_service.dart';
import 'package:nuli_app/features/auth/data/repositories/auth_repository.dart';
import 'package:nuli_app/features/auth/data/repositories/user_repository.dart';
import 'package:nuli_app/features/chat/presentation/controller/ai_chat_controller.dart';
import '../../features/auth/presentation/controller/auth_controller.dart';
import '../../features/chat/data/repositories/ai_chat_repository.dart';

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
  getIt.registerLazySingleton<AiChatService>(() => AiChatService());
  getIt.registerLazySingleton<UserRepository>(()=> UserRepository(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<AuthRepository>(()=>AuthRepository(getIt<AuthService>(),getIt<UserRepository>()));
  getIt.registerFactory<AuthController>(()=> AuthController(getIt<AuthService>(),getIt<AuthRepository>()));
  getIt.registerLazySingleton<AiChatRepository>(()=> AiChatRepository(getIt<AiChatService>()));
  getIt.registerFactory<AiChatController>(()=>AiChatController(getIt<AiChatRepository>()));
}
