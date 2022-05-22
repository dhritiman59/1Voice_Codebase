import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Ui/splash/SplashPage.dart';

FirebaseOptions options = const FirebaseOptions(
  apiKey: "AIzaSyCPJul9Lcbk-2UTzwUzSybIYUilVr8jyic",
  authDomain: "bring2book.firebaseapp.com",
  //authDomain: "https://www.1voices.app/#/",
  databaseURL: "https://bring2book.firebaseio.com",
  projectId: "bring2book",
  storageBucket: "bring2book.appspot.com",
  messagingSenderId: "750567903683",
  appId: "1:750567903683:web:8172472018990a320d2d76",
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  kIsWeb
      ? await Firebase.initializeApp(
          options: options,
        )
      : await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light
        //  statusBarColor: Colors.blue, //or set color with: Color(0xFF0000FF)
        ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
