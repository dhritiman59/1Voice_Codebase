import 'package:bring2book/Constants/CheckInternet.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:bring2book/Constants/styles.dart';
import 'package:bring2book/Ui/ForgotPassword/ForgotPasswordPage.dart';
import 'package:bring2book/Ui/LandingPage/MainLandingPage.dart';
import 'package:bring2book/Ui/Registration/Registration.dart';
import 'package:bring2book/Ui/SignInScreen/SignInActivityBloc.dart';
import 'package:bring2book/Ui/TermsAndPrivacy/PlatformTermsPage.dart';
import 'package:bring2book/Ui/TermsAndPrivacy/PrivacyPolicyPage.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import 'package:shared_preferences/shared_preferences.dart';

class SignInActivity extends StatefulWidget {
  final String frompage;

  const SignInActivity({this.frompage});

  @override
  _SignInActivityState createState() => _SignInActivityState();
}

class _SignInActivityState extends State<SignInActivity> {
  bool commonProgressVisible = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        "750567903683-e8qb0and7heg5811oij21qeumnkae4d8.apps.googleusercontent.com",
  );
  bool isUserSignedIn = false;
  final bool _initialized = false;
  final bool _error = false;
  bool viewEmailVisible = true;

  bool viewRowlVisible = false;

  bool isLoggedIn = false;
  String name;
  String email;
  String usrEmail = ' ';
  String imageUrl;
  String socialId;
  bool _isLoggedIn = false;
  Map userProfile;
  final CheckInternet _checkInternet = CheckInternet();

  var bottomSheetController;
  bool visible = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _userLoginUserName = TextEditingController();
  final TextEditingController _userLoginPassword = TextEditingController();
  final SignInBloc _loginBloc = SignInBloc();
  final FocusNode _fullNameFocus = FocusNode();

  StateSetter mystate1;

  String profileImage = 'http://www.w3.org/2005/10/profile';

  @override
  void initState() {
    super.initState();
    getStringValuesSF();
    _loginBloc.validateLoginStream.listen((event) {
      print('event is got $event');
      setState(() {
        visible = false;
      });
      toastMsg(event);
    });
    listen();
    socialLoginListen();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SizedBox(
                height: height,
                width: width,
                child: Column(children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: height * 0.44,
                    child: Image.asset(
                      "assets/images/signInBg.png",
                      gaplessPlayback: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(mainAxisSize: MainAxisSize.min, children: <
                          Widget>[
                        SubmitFlatButtonWidget(
                          height: 47,
                          width: double.infinity,
                          backgroundColor: CustColors.DarkBlue,
                          buttonText: "Sign in",
                          buttonTextColor: Colors.white,
                          onpressed: () {
                            //getStringValuesSF();
                            displayBottomSheet(context);
                          },
                        ),
                        RichText(
                          maxLines: 2,
                          text: TextSpan(
                            children: <TextSpan>[
                              const TextSpan(
                                text: "Don't have account?  ",
                                style: Styles.textNormalLightDarkGray,
                              ),
                              TextSpan(
                                  text: 'Sign Up',
                                  style: Styles.signUpBoldBlue,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegistrationPage()),
                                      );
                                    }),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: const Text(
                            'OR',
                            style: TextStyle(
                                fontSize: 16, color: CustColors.OffWhite),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: SubmitFlatButtonWidget(
                            onpressed: () {
                              _checkInternet.check().then((intenet) {
                                if (intenet != null && intenet) {
                                  _loginWithFB();
                                } else {
                                  toastMsg('No internet connection');
                                }
                              });
                            },
                            height: 47,
                            width: double.infinity,
                            backgroundColor: CustColors.FacebookBlue,
                            buttonText: "Sign-in with Facebook",
                            buttonTextColor: Colors.white,
                          ),
                        ),
                        SubmitFlatButtonWidget(
                          onpressed: () {
                            _checkInternet.check().then((intenet) {
                              if (intenet != null && intenet) {
                                if (kIsWeb) {
                                  googleSignInWeb().then((result) {
                                    print(result);
                                    if (result != null) {
                                      _loginBloc.postSocialLogin(
                                          name, socialId, email);
                                      Fluttertoast.showToast(
                                          msg: email,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 2);
                                    } else if (result == null) {
                                      setState(() {
                                        commonProgressVisible = false;
                                      });
                                    }
                                  });
                                } else {
                                  signInWithGoogle().then((result) {
                                    print(result);
                                    if (result != null) {
                                      _loginBloc.postSocialLogin(
                                          name, socialId, email);
                                      Fluttertoast.showToast(
                                          msg: email,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 2);
                                    } else if (result == null) {
                                      setState(() {
                                        commonProgressVisible = false;
                                      });
                                    }
                                  });
                                }
                              } else {
                                toastMsg('No internet connection');
                              }
                            });

                            /* setState(() {
                                  commonProgressVisible = true;
                                });
                                signInWithGoogle().then((result) {
                                  print(result);
                                  if (result != null) {
                                    _loginBloc.postSocialLogin(
                                        name, socialId, email);
                                    Fluttertoast.showToast(
                                        msg: email,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 2);
                                  } else if (result == null) {
                                    setState(() {
                                      commonProgressVisible = false;
                                    });
                                  }
                                });*/
                          },
                          height: 47,
                          width: double.infinity,
                          backgroundColor: CustColors.LightGray,
                          buttonText: "Sign-in with Google",
                          buttonTextColor: CustColors.DarkBlue,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Column(children: [
                            RichText(
                              text: const TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'By Signing in you Agreeing to our  ',
                                    style: Styles.textNormalLightDarkGray,
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              maxLines: 2,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Platform  Terms',
                                      style: Styles.signUpBoldBlue,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlatFormTermsPage()));
                                          print('Terms of Service"');
                                        }),
                                  const TextSpan(
                                    text: ' and ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                      text: 'Privacy Policy',
                                      style: Styles.signUpBoldBlue,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PrivacyPolicyPage()));
                                          print('Privacy Policy"');
                                        }),
                                ],
                              ),
                            ),
                          ]),
                        )
                      ])),
                ]))),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
          child: Visibility(
              visible: commonProgressVisible,
              child: Center(
                child: Container(
                    margin: const EdgeInsets.only(top: 50, bottom: 30),
                    child: const CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(CustColors.DarkBlue),
                    )),
              )),
        ),
      ],
    );
  }

  final facebookLogin = FacebookLogin();

  _loginWithFB() async {
    // ignore: unnecessary_statements
    facebookLogin.loginBehavior = FacebookLoginBehavior.webOnly;
    final result = await facebookLogin.logIn(['email']);
// Let's force the users to login using the login dialog based on WebViews. Yay!

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token'));
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          _loginBloc.postSocialLogin(profile["name"], profile["id"],
              profile["email"] /*, profile[""]*/);
          _isLoggedIn = true;
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false);
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false);
        break;
    }
  }

  _logout() {
    facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  void displayBottomSheet(BuildContext context) {
    bottomSheetController = showModalBottomSheet(
        backgroundColor: Colors.black.withOpacity(0),
        elevation: 0,
        isScrollControlled: true,
        barrierColor: Colors.black.withAlpha(1),
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter mystate) {
              mystate1 = mystate;
              return Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Stack(children: [
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                        top: 25,
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.60,
                            color: Colors.white,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Sign in",
                                      style: TextStyle(
                                        color: CustColors.DarkBlue,
                                        fontSize: 26.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Visibility(
                                    visible: viewEmailVisible,
                                    child: TextFieldWidgetSignUp(
                                      textInputType: TextInputType.emailAddress,
                                      controller: _userLoginUserName,
                                      height: 50,
                                      focusNode: _fullNameFocus,
                                      onSubmitted: (text) {
                                        _fullNameFocus.unfocus();
                                      },
                                      width: double.infinity,
                                      backgroundColor: CustColors.LightRose,
                                      alignment: TextAlign.start,
                                      hintText: "Email",
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: viewRowlVisible,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 25.0,
                                            right: 10.0,
                                            left: 20.0,
                                            bottom: 0.0),
                                        child: SizedBox(
                                          width: 40.0,
                                          height: 40.0,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://static.toiimg.com/photo/729755517.cms',
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.asset(
                                                      'assets/images/dummy_image_user.png',
                                                      width: 40,
                                                      height: 40),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 22.0,
                                        ),
                                        child: Text(usrEmail,
                                            style: const TextStyle(
                                              color: CustColors.DarkBlue,
                                              fontSize: 12.0,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: TextFieldWidgetForgot(
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      controller: _userLoginPassword,
                                      height: 50,
                                      width: double.infinity,
                                      backgroundColor: CustColors.LightRose,
                                      alignment: TextAlign.start,
                                      obscureText: true,
                                      hintText: "Password",
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: viewRowlVisible,
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 25.0,
                                            right: 5.0,
                                            left: 20.0,
                                            bottom: 0.0),
                                        child: SizedBox(
                                          height: 18,
                                          width: 18,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            backgroundImage: AssetImage(
                                                'assets/images/account.png'),
                                            radius: 20,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          print("clicked");
                                          mystate(() {
                                            print(viewEmailVisible);
                                            if (viewRowlVisible) {
                                              viewRowlVisible = false;
                                            }
                                            if (!viewEmailVisible) {
                                              viewEmailVisible = true;
                                              print(viewEmailVisible);
                                            }
                                          });
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                            top: 22.0,
                                          ),
                                          child: Text("Use another account",
                                              style: TextStyle(
                                                color: CustColors.DarkBlue,
                                                fontSize: 12.0,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: SubmitFlatButtonWidget(
                                    height: 50,
                                    width: double.infinity,
                                    backgroundColor: CustColors.DarkBlue,
                                    buttonText: "Sign in",
                                    buttonTextColor: Colors.white,
                                    onpressed: () {
                                      mystate(() {
                                        visible = true;
                                      });
                                      _checkInternet.check().then((intenet) {
                                        if (intenet != null && intenet) {
                                          String userName;
                                          if (viewRowlVisible) {
                                            userName = usrEmail;
                                          } else {
                                            userName = _userLoginUserName.text;
                                          }
                                          print(userName);
                                          _loginBloc.initiateLoginValues(
                                              username: userName.toString(),
                                              password: _userLoginPassword.text
                                                  .toString());
                                        } else {
                                          toastMsg('No internet connection');
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 15, 10, 10),
                                  child: RichText(
                                    maxLines: 2,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Forgot Password ?',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: CustColors.DarkBlue,
                                                fontSize: 15),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                print(' Sign Up');
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ForgotPasswordPage()),
                                                );
                                              }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Visibility(
                                visible: visible,
                                child: Center(
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 50, bottom: 30),
                                      child: const CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                CustColors.Radio),
                                      )),
                                )),
                          ),
                        ],
                      ),
                    ),
                    myImage("assets/images/loginDarkBlueDownArrow.png"),
                  ]));
            },
          );
        });
  }

  Positioned myImage(String myimage) {
    return Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Center(
        child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image(height: 45, width: 45, image: AssetImage(myimage)),
            )),
      ),
    );
  }

  void listen() {
    print("Normal Login========");
    _loginBloc.loginStream.listen((data) {
      if ((data.status == "success")) {
        mystate1(() {
          visible = false;
        });
        _loginBloc.saveUser(data);
        // toastMsg(data.message);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const MainLandingPage(frompage: "0")),
            ModalRoute.withName("/MainLandingPage"));
      } else if ((data.status == "error")) {
        mystate1(() {
          visible = false;
        });
        String msg = data.message;
        toastMsg(msg);
      }
    });
  }

  toastMsg(String msg) {
    print(msg);
    /*_scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
    ));*/
    Fluttertoast.showToast(
        msg: "          " + msg + "          ",
        fontSize: 14,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        timeInSecForIosWeb: 6);
  }

  Future<String> googleSignInWeb() async {
    setState(() {
      visible = false;
      commonProgressVisible = true;
    });
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    final User user = (await _auth.signInWithPopup(googleProvider)).user;
    print("signed in " + user.displayName);
    setState(() {
      name = user.displayName;
      email = user.email;
      imageUrl = user.photoURL;
      socialId = user.uid;
      visible = false;
      commonProgressVisible = false;
    });
    return "$user";
  }

  Future<String> signInWithGoogle() async {
    setState(() {
      visible = false;
      commonProgressVisible = true;
    });
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    print('googleSignInAccount succeeded: $googleSignInAccount');
    setState(() {
      visible = false;
      commonProgressVisible = false;
    });
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    print('signInWithGoogle succeeded: $googleSignInAuthentication');
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    if (user != null) {
      // Checking if email and name is null
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);
      name = user.displayName;
      email = user.email;
      imageUrl = user.photoURL;
      socialId = user.uid;
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      print('signInWithGoogle succeeded: $user');
      print(user.emailVerified);
      return '$user';
    }
    return null;
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool(SharedPrefKey.isUserLoggedIn);
    if (isLoggedIn) {
      displayBottomSheet(context);
      String emailId = prefs.getString(SharedPrefKey.EMAIL_ID);
      String profilePic = prefs.getString(SharedPrefKey.PROFILE_IMAGE);
      setState(() {
        usrEmail = emailId;
        viewRowlVisible = true;
        viewEmailVisible = false;
        if (profilePic != null) {
          profileImage = profilePic;
        }
      });
    } else {
      setState(() {
        viewRowlVisible = false;
        viewEmailVisible = true;
      });
    }
  }

  void socialLoginListen() {
    print("social Login");
    _loginBloc.SocialLoginResponse.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          visible = false;
          commonProgressVisible = false;
        });
        _loginBloc.saveUser1(data);
        //toastMsg(data.message);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const MainLandingPage(frompage: "0")),
            ModalRoute.withName("/MainLandingPage"));
      } else if ((data.status == "error")) {
        setState(() {
          visible = false;
          commonProgressVisible = false;
        });
        String msg = data.message;
        toastMsg(msg);
      }
    });
  }
}
