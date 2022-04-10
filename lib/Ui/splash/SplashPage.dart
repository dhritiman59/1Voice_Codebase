import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:bring2book/Ui/NotificationUi/NotificationPage.dart';
import 'package:bring2book/Ui/SignInScreen/SignInActivity.dart';
import 'package:bring2book/Ui/walkThrough/WalkThroughPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SplashPage> {
  String AUTH_TOKEN;
  bool isWalked = false;
  bool push = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "navigator");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustColors.DarkBlue,
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Image.asset('assets/images/onevoicessplashfinal.png'),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      push = true;
      print('${push}onMessage:$message');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NotificationPage()));
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      push = true;

      print('${push}onResume:$message');

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NotificationPage()));
    });

    if (push == false) {
      startSplashScreenTimer();
    }
  }

  void startSplashScreenTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AUTH_TOKEN = prefs.getString(SharedPrefKey.AUTH_TOKEN);
    isWalked = prefs.getBool(SharedPrefKey.isWalked);
    print('AUTH_TOKEN $AUTH_TOKEN And isWalked $isWalked');

    print(isWalked);
    if (AUTH_TOKEN == null || AUTH_TOKEN == '') {
      if (isWalked == null || !isWalked) {
        print('WalkThroughPage');
        Timer(
            const Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const WalkThroughPage())));
      } else if (isWalked) {
        print('SignInActivity');
        Timer(
            const Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => SignInActivity(
                      frompage: "0",
                    ))));
      }
    } else {
      print('SignInActivity');
      Timer(
          const Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => SignInActivity(
                    frompage: "0",
                  ))));

      /*print('MainLandingPage');
        Timer(Duration(seconds: 3), () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MainLandingPage(frompage:"0"))));*/
    }
  }

  void await_navigateToItemDetail(Map<String, dynamic> message) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationPage()),
    );
  }
}
