import 'package:chatapp/Presination/Contro/BlocAuth/BlocAuth.dart';
import 'package:chatapp/Presination/Screen/ChatApp.dart';
import 'package:chatapp/Presination/Screen/RegistorScreen.dart';
import 'package:chatapp/Presination/Screen/WelcomeScrean.dart';
import 'package:chatapp/Presination/Screen/login.dart';
import 'package:chatapp/Provider/ChatMicOrSend.dart';
import 'package:chatapp/Provider/UserData.dart';
import 'package:chatapp/Serves/GetIt.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {

    WidgetsFlutterBinding.ensureInitialized();
  MyGetit().init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(BlocProvider(
    create: (context) => getIt<BlocAuth>(),
    child: ChangeNotifierProvider(
        create: (BuildContext context) => Chatmicorsend(),
        child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UserProvider(),
      child: MaterialApp(
        theme: ThemeData(
          iconButtonTheme: IconButtonThemeData(),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Chatapp();
              }
              return Welcomescreen();
            }),
        routes: {
          LoginScreen.screenRoute: (context) => LoginScreen(),
          Registorscreen.screenRoute: (context) => Registorscreen(
                isUpdate: false,
                data: {},
              ),
          Welcomescreen.screenRoute: (context) => Welcomescreen(),
        },
      ),
    );
  }
}
