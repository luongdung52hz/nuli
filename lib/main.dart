import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nuli_app/features/chat/presentation/controller/ai_chat_controller.dart';
import 'package:provider/provider.dart';
import 'core/di/dependency_injection.dart';
import 'features/auth/presentation/controller/auth_controller.dart';
import 'features/weather/presentation/controller/weather_controller.dart';
import 'firebase_options.dart';
import 'app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  print(' .env loaded successfully');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies();
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => getIt<AuthController>()
            ),
            ChangeNotifierProvider(
                create: (_) => getIt<AiChatController>()
            ),
            ChangeNotifierProvider(
                create: (_) => getIt<WeatherController>()
            ),
          ],
      child: const NuliApp()
      )
  );
}



