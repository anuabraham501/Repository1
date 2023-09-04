import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:women/colors.dart';
import 'package:women/services/notification_controller.dart';
import 'package:women/views/home/home.dart';
import 'package:women/views/signin.dart';
import 'package:women/services/auth_methods.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationController.initializeLocalNotifications();

  runApp(const MyApp());
  AuthMethods().signOut();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static const String appName = 'Women\'s App';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Widget> getDefaultRoute() async {
    final user = await AuthMethods().getCurrentUser();
    if (user != null) return const Home();
    return const SignIn();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // The navigator key is necessary to allow to navigate through static methods
      navigatorKey: MyApp.navigatorKey,

      title: MyApp.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primaryColor,
      ),
      home: FutureBuilder(
        future: getDefaultRoute(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
