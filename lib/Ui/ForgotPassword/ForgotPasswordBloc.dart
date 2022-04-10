import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:bring2book/Models/ForgotPasswordModel/ForgotPasswordBean.dart';
import 'package:bring2book/Models/LoginUserModel/LoginUserBean.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordBloc {

  final repository = Repository();


  final forgotPasswordResponse = PublishSubject<ForgotPasswordBean>();
  Stream<ForgotPasswordBean> get loginStream => forgotPasswordResponse.stream;


  StreamController validateForgotPasswordController = StreamController<String>();
  Stream<String> get validateForgotPasswordStream => validateForgotPasswordController.stream;
  StreamSink<String> get validateForgotPasswordSink => validateForgotPasswordController.sink;


  /// get Login details  api call ///


  void initiateForgotPasswordValues({
    email: String,
  }) {
    if (_validationForgotPassword(email: email,)) {
      performForgotPassword(email);
    }
  }

  /*Validation of phoneNumber & password*/
  bool _validationForgotPassword({
    email: String,
  }) {
    if (email.isEmpty) {
      validateForgotPasswordSink.add("Enter username");
      return false;
    } else if(!isEmail(email))
    {
      validateForgotPasswordSink.add("Invalid Email Format");
      return false;
    }
    return true;
  }



  Future<LoginUserBean> performForgotPassword(email) async {

    final parameter = {
      'emailId':email
    };

    ForgotPasswordBean forgotPasswordResp = await repository.postForgotPassword1(parameter);
    if (forgotPasswordResp != null) {
      forgotPasswordResponse.sink.add(forgotPasswordResp);
    }
    print("Maria");
    print(forgotPasswordResp);
  }

  void dispose() {
    forgotPasswordResponse.close();
    validateForgotPasswordController.close();
  }


  bool isEmail(String em) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }


}