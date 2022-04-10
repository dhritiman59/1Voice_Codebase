import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:bring2book/Models/AddCaseModel/AddCaseModel.dart';
import 'package:bring2book/Models/BecomeProUserModel/BecomProUserModel.dart';
import 'package:bring2book/Models/ForgotPasswordModel/ForgotPasswordBean.dart';
import 'package:bring2book/Models/LoginUserModel/LoginUserBean.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class BecomeProUserBloc {

  final repository = Repository();


  StreamController validateProUserController = StreamController<String>();
  Stream<String> get validateProUseStream => validateProUserController.stream;
  StreamSink<String> get validateProUseSink => validateProUserController.sink;

  final becomeProUserResponse = PublishSubject<BecomProUserModel>();
  Stream<BecomProUserModel> get becomeProUserStream => becomeProUserResponse.stream;







  void initiateProUserValues(String specialization,String regno, String city, String expNo,String aboutme, String identity,List file) {
    if (_validation(specialization, regno,  city,  expNo,  identity,aboutme, file)) {
      final parameter = {
        'specialization':specialization,
        'regno':regno,
        'city':city,
        'expNo':expNo,
        'aboutMe':aboutme,
        'identity':identity,
      };
      print(parameter);
      print(file);

      becomeProUserApi( specialization, regno,  city,  expNo,  identity, file);
    }
  }

  bool _validation(String specialization,String regno, String city, String expNo, String identity,String aboutme,List file) {



    if (regno.isEmpty) {
      validateProUseSink.add("Enter Register Number");

      return false;
    }
    else if (regno.trim().length>30) {
      validateProUseSink.add(" Register Number Greater Than 30 Characters Not Allowed");

      return false;
    }else if (city.isEmpty) {
      validateProUseSink.add("Enter City");

      return false;
    }
    else if (regno.trim().length>30) {
      validateProUseSink.add(" City Greater Than 30 Characters Not Allowed");

      return false;
    }else if (specialization.isEmpty) {
      validateProUseSink.add("Enter Specialization");

      return false;
    }
    else if (expNo.isEmpty) {
      validateProUseSink.add("Enter Experience");

      return false;
    }
    else if (aboutme.trim().length>150) {
      validateProUseSink.add("About Me Greater than 150 Characters not allowed");

      return false;
    }
    else if (file.length==0 || file[0]==null || file[0]=='null') {
      validateProUseSink.add("Upload file");

      return false;
    }
    return true;
  }



  Future<BecomProUserModel> becomeProUserApi( String specialization,String regno, String city, String expNo, String identity,List file) async
  {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString(SharedPrefKey.USER_ID);
    String type ="2";
    print('this is userid ${prefs.getString(SharedPrefKey.USER_ID)}');

    final parameter = {
      'specialization':specialization,
      'userId':userId,
      'type':type,
      'regno':regno,
      'city':city,
      'expNo':expNo,
      'identity':identity,
    };
    BecomProUserModel becomeProUserApiResp = await repository.becomeProUserApi(parameter, file,);
    if (becomeProUserResponse != null) {
      becomeProUserResponse.sink.add(becomeProUserApiResp);
    }
    print("MariaMol");
    print(becomeProUserResponse);
  }



  void dispose() {
    validateProUserController.close();
    becomeProUserResponse.close();

  }

}