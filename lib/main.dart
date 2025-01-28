import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:monapp/models/app_user.dart';
import 'package:monapp/providers/auth_provider.dart';
import 'package:monapp/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:monapp/screens/welcome/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          secondary: Colors.deepOrange,
          primary: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: Consumer(
        builder: (context, ref, child) {
          final AsyncValue<AppUser?> user = ref.watch(authProvider);

          return user.when(
            data: (value) {
              if (value == null) {
                return const WelcomeScreen();
              }
              return ProfileScreen(user: value);
            },
            error: (error, _) => const Text('Error loading auth status...'),
            loading: () => const Text("Loading...")
          );
        }
      )
    );
  }
}