import 'package:b_tech_project/pages/home_page.dart';
import 'package:b_tech_project/pages/registration_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:b_tech_project/repository/user_repository.dart';
import 'package:b_tech_project/pages/splash_screen.dart';
import 'pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    MultiProvider(child: MyApp(), providers: [
      ChangeNotifierProvider(
        create: (_) => UserRepository(),
      ),
    ]),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      home: _showScreen(context),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return _showScreen(context);
  }
}

Widget _showScreen(BuildContext context) {
  print(context.watch<UserRepository>().appState);
  switch (context.watch<UserRepository>().appState) {
    case AppState.authenticating:
      print(context.watch<UserRepository>().appState);

      return SplashScreen();
    case AppState.unauthenticated:
      print(context.watch<UserRepository>().appState);

      return LogInPage();
    case AppState.initial:
      print(context.watch<UserRepository>().appState);

      return SplashScreen();
    case AppState.authenticated:
      print(context.watch<UserRepository>().appState);

      return HomePage();
    case AppState.unauthorised:
      // ignore: avoid_print
      print(context.watch<UserRepository>().appState);
      return SplashScreen();
  }
}
