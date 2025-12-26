import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nuli_app/core/services/article_service.dart';
import 'package:nuli_app/core/services/auth_service.dart';
import 'package:nuli_app/core/services/chat_ai_service.dart';
import 'package:nuli_app/core/services/location_service.dart';
import 'package:nuli_app/core/services/weather_service.dart';
import 'package:nuli_app/features/auth/data/repositories/auth_repository.dart';
import 'package:nuli_app/features/auth/data/repositories/user_repository.dart';
import 'package:nuli_app/features/chat/presentation/controller/ai_chat_controller.dart';
import 'package:nuli_app/features/weather/data/repositories/weather_repository.dart';
import 'package:nuli_app/features/weather/presentation/pages/weather_screen.dart';
import '../../features/article/data/repositories/article_repository.dart';
import '../../features/article/presentation/controller/article_controller.dart';
import '../../features/auth/presentation/controller/auth_controller.dart';
import '../../features/chat/data/repositories/ai_chat_repository.dart';
import '../../features/weather/presentation/controller/weather_controller.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async
{
  //Auth
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton<GoogleSignIn>(()=> GoogleSignIn());
  getIt.registerLazySingleton<AuthService>
    (()=> AuthService(getIt<FirebaseAuth>(), getIt<GoogleSignIn>()));
  getIt.registerLazySingleton<UserRepository>(()=> UserRepository(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<AuthRepository>(()=> AuthRepository(getIt<AuthService>(),getIt<UserRepository>()));
  getIt.registerFactory<AuthController>(()=> AuthController(getIt<AuthService>(),getIt<AuthRepository>()));

  //ChatAI
  getIt.registerLazySingleton<AiChatService>(() => AiChatService());
  getIt.registerLazySingleton<AiChatRepository>(()=> AiChatRepository(getIt<AiChatService>()));
  getIt.registerFactory<AiChatController>(()=> AiChatController(getIt<AiChatRepository>()));

  //Weather
  getIt.registerLazySingleton<WeatherService>(()=> WeatherService());
  getIt.registerLazySingleton<LocationService>(()=> LocationService());
  getIt.registerLazySingleton<WeatherRepository>(()=> WeatherRepository(getIt<WeatherService>()));
  getIt.registerFactory<WeatherController>(()=> WeatherController(getIt<WeatherRepository>(),getIt<LocationService>()));

  getIt.registerLazySingleton<ArticleService>(()=> ArticleService());
  getIt.registerLazySingleton<ArticleRepository>(()=> ArticleRepository(getIt<ArticleService>()));
  getIt.registerFactory<ArticleController>(()=> ArticleController(getIt<ArticleRepository>()));
}
