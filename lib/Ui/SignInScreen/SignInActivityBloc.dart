import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:bring2book/Models/LoginUserModel/LoginUserBean.dart';
import 'package:bring2book/Models/SocialLogin/SocialLoginMdl.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SignInBloc {
  final repository = Repository();
  bool isLodingInBloc = false;

  bool isSocialLogin = false;
  final loginResponse = PublishSubject<LoginUserBean>();
  Stream<LoginUserBean> get loginStream => loginResponse.stream;
//SocialLogin response
  Stream<SocialLoginMdl> get SocialLoginResponse => socialLogingg.stream;
  StreamController validateLoginController = StreamController<String>();
  Stream<String> get validateLoginStream => validateLoginController.stream;
  StreamSink<String> get validateLoginSink => validateLoginController.sink;

  final isLoading = PublishSubject<bool>();

  final socialLogingg = PublishSubject<SocialLoginMdl>();

  /// get Login details  api call ///

  void initiateLoginValues({
    username = String,
    password = String,
  }) {
    if (_validation(
      password: password,
      username: username,
    )) {
      performUserLogin(username, password);
    }
  }

  /*Validation of username & password*/
  bool _validation({
    password = String,
    username = String,
  }) {
    if (username.isEmpty) {
      validateLoginSink.add("Enter username");
      return false;
    } else if (password.isEmpty) {
      validateLoginSink.add("Enter password");

      return false;
    }
    /*else if (!isEmail(username)) {
      validateLoginSink.add("Invalid Email Format");
      return false;
    }*/
    return true;
  }

  Future<LoginUserBean> performUserLogin(
      String username, String password1) async {
    final parameter = {
      'username': username,
      'password': password1,
    };

    LoginUserBean loginDetailsResp = await repository.postLoginUser1(parameter);
    if (loginDetailsResp != null) {
      loginResponse.sink.add(loginDetailsResp);
    }
    print("Maria");
    print(loginDetailsResp);
  }

  void dispose() {
    loginResponse.close();
    validateLoginController.close();
  }

  Future<LoginUserBean> saveUser(LoginUserBean loginUserBean) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        SharedPrefKey.USER_ID, loginUserBean.data.data.id.toString());
    prefs.setString(SharedPrefKey.AUTH_TOKEN, loginUserBean.data.token);
    prefs.setString(SharedPrefKey.EMAIL_ID, loginUserBean.data.data.emailId);
    prefs.setString(
        SharedPrefKey.USER_TYPE, loginUserBean.data.data.userTypeId.toString());

    prefs.setBool(SharedPrefKey.BANNERAD, true);

    prefs.setString(
        SharedPrefKey.USER_NAME, loginUserBean.data.data.displayName);

    prefs.setBool(SharedPrefKey.isUserLoggedIn, true);
  }

  Future<SocialLoginMdl> saveUser1(SocialLoginMdl loginUserBean) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        SharedPrefKey.USER_ID, loginUserBean.data.data.id.toString());
    prefs.setString(SharedPrefKey.AUTH_TOKEN, loginUserBean.data.token);
    prefs.setString(
        SharedPrefKey.USER_TYPE, loginUserBean.data.data.userTypeId.toString());

    prefs.setBool(SharedPrefKey.BANNERAD, true);
    prefs.setString(
        SharedPrefKey.USER_NAME, loginUserBean.data.data.displayName);
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  postSocialLogin(String name, String id, String email) async {
    String aliasName;
    String fullName = name;
    var names = fullName.split(' ');
    String firstName = names[0];
    String lastName = fullName.substring(names[0].length);
    print(firstName);
    print(lastName);

    final parameter = {
      "socialId": id,
      "emailId": email,
      "firstName": firstName,
      "lastName": lastName,
      "displayName": name
    };

    isLodingInBloc = true;
    isLoading.add(isLodingInBloc);
    isSocialLogin = true;
    print("testtttttttttttt");
    SocialLoginMdl socialMdl = await repository.postSocialLogin1(parameter);
    print("alp testtttttttttttttttt");
    if (socialMdl != null) {
      print("Social login entered==========");
      socialLogingg.sink.add(socialMdl);
      isLodingInBloc = false;
      isLoading.add(isLodingInBloc);
    }
  }
}
