import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/di/dependency_injection.dart';
import 'features/auth/presentation/provider/auth_controller.dart';
import 'firebase_options.dart';
import 'app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies();
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => getIt<AuthController>()
            ),
          ],
      child: const NuliApp()
      )
  );
}



