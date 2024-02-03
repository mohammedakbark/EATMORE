import 'package:eatmore/firebase_options.dart';
import 'package:eatmore/view%20model/authentication.dart';
import 'package:eatmore/view%20model/controller.dart';
import 'package:eatmore/view%20model/database.dart';
import 'package:eatmore/view/usersplashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Authentication>(create: (_) => Authentication()),
        ChangeNotifierProvider<Database>(create: (_) => Database()),
        ChangeNotifierProvider<Controller>(create: (_) => Controller())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
            // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const UserSplash()),
    );
  }
}
