import 'dart:async';

import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:bring2book/Models/RegistrationDataModel/RegistrationBean.dart';
import 'package:bring2book/Models/StatusMessageModel/StatusMessageModel.dart';

import 'package:bring2book/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RegistrationBloc{


  final repository = Repository();
  final isLoading = PublishSubject<bool>();


  final registerResponse = PublishSubject<RegistrationBean>();
  Stream<RegistrationBean> get loginStream => registerResponse.stream;
  Stream<bool> get isLoadingStream => isLoading.stream;

  StreamController validateRegistrationController = StreamController<String>();
  Stream<String> get validateRegistrationStream => validateRegistrationController.stream;
  StreamSink<String> get validateRegistrationSink => validateRegistrationController.sink;
  void initiateRegistrationValues({String latitude,String longitude,String country,String state,String countryCode,String firstName,String lastName, String password, String phoneNo, String email, String confrmPassword,String radioButtonItem,String aliasName,String aliasFlag,String aboutMe}) {
    print('latitude$latitude');
    print('longitude$longitude');
    print('state$state');
    if (_validation( country:country,state:state,countryCode:countryCode,password: password, firstName: firstName,lastName: lastName, phoneNo: phoneNo,email:email,confrmPassword:confrmPassword,radioButtonItem:radioButtonItem,aliasName:aliasName,aboutMe:aboutMe)) {
      performUserRegistration(latitude,longitude,country,state,countryCode,firstName,lastName, password,phoneNo,email,confrmPassword,radioButtonItem,aliasName,aliasFlag,aboutMe);
    }
  }

  bool _validation({String country,String state,String countryCode, String password,String firstName,String lastName, String phoneNo, String email, String confrmPassword, String radioButtonItem,String aliasName,String aboutMe}) {
    print('countryCode$countryCode');
    print('country$country');
    print('state$state');
    if (firstName.isEmpty) {

      validateRegistrationSink.add("Enter FirstName");
      return false;
    }
    else if (lastName.isEmpty) {

      validateRegistrationSink.add("Enter LastName");
      return false;
    }
    else  if (aliasName.isEmpty) {
      validateRegistrationSink.add("Enter Alias Name");
      return false;
    }
    else if(!emailValidate(email))
    {
      validateRegistrationSink.add("Invalid Email Format");
      return false;
    }
    else  if (country.isEmpty) {
      validateRegistrationSink.add("Select Country");
      return false;
    }
    else  if (state.isEmpty) {
      validateRegistrationSink.add("Select State");
      return false;
    }
    else  if (countryCode.isEmpty) {
      validateRegistrationSink.add("Select CountryCode");
      return false;
    }
    else if (phoneNo.isEmpty) {
      validateRegistrationSink.add("Enter phone number");

      return false;
    }
    else if (phoneNo.length != 10) {
      validateRegistrationSink.add("Enter 10 digit phone number");
      return false;
     }
    else if (radioButtonItem.isEmpty) {
      validateRegistrationSink.add("Please Select Gender");

      return false;
    }

    else  if (aboutMe.isEmpty) {
      validateRegistrationSink.add("Enter About Yourself");
      return false;
    }

    else if (password.isEmpty) {
      validateRegistrationSink.add("Enter password");

      return false;
    }
    else if(!validateStructure(password))
    {
      validateRegistrationSink.add("Passwords must contain at least eight characters and 1 special Character, including uppercase, lowercase letters and numbers.");
      return false;
    }
    else if(confrmPassword.isEmpty)
    {
      validateRegistrationSink.add("Enter Confirm password");
      return false;
    }
    else if(confrmPassword!=password)
    {
      validateRegistrationSink.add("Password and Confirm password are same");
      return false;
    }


    return true;
  }

  bool emailValidate(String email) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(email);
  }

  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  Future<RegistrationBean> performUserRegistration(String latitude,String longitude,String country,String state,String countryCode,String firstName,String lastName,String password, String phoneNo, String email, String confrmPassword,String radioButtonItem,String aliasName,String aliasFlag,String aboutMe) async {
    isLoading.sink.add(true);
    print('countryCode$countryCode');

    final parameter = {
      'type': "3",
      'password': password,
      'name': firstName +" "+lastName,
      "firstName": firstName,
      "lastName":lastName,
      'gender': radioButtonItem,
      'emailId': email,
      'phone': phoneNo,
      "country":country,
      "state":state,
      "countryCode":countryCode,
      'aliasFlag':aliasFlag,
      'aliasName':aliasName,
      'aboutMe':aboutMe,
      "latitude":latitude.trim()==""?"1.352083":latitude,
      "longitude":longitude.trim()==""?"103.819839":longitude
    };

    RegistrationBean registrationBean = await repository.postRegisterUser1(parameter);
    if (registrationBean != null) {
      registerResponse.sink.add(registrationBean);
    }
    isLoading.sink.add(false);

    print(registrationBean);
  }

  Future<RegistrationBean> saveUserData(RegistrationBean data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefKey.USER_ID, data.data.data.id.toString());
    prefs.setString(SharedPrefKey.AUTH_TOKEN, data.data.token);
    prefs.setString(SharedPrefKey.EMAIL_ID,data.data.data.emailId);
    prefs.setString(SharedPrefKey.USER_TYPE, data.data.data.userTypeId.toString());


    ///Maria Kurian Changes Begin ///

    prefs.setBool(SharedPrefKey.BANNERAD, true);
    prefs.setString(SharedPrefKey.USER_NAME, data.data.data.displayName);

    ///Maria Kurian Changes Ends ///


    prefs.setBool(SharedPrefKey.isUserLoggedIn, true);
  }




  final updateLatLngResponse = PublishSubject<StatusMessageModel>();
  Stream<StatusMessageModel> get LatLngResponse => updateLatLngResponse.stream;

  Future<StatusMessageModel> performUpdateLatLng(String latitude,String longitude,) async {
    isLoading.sink.add(true);
    print('countryCode$latitude');

    final parameter = {
      'latitude':latitude,
      'longitude':longitude
    };

    StatusMessageModel statusMessageModel = await repository.performUpdateLatLng(parameter);
    if (statusMessageModel != null) {
      updateLatLngResponse.sink.add(statusMessageModel);
    }
    isLoading.sink.add(false);

    print(updateLatLngResponse);
  }



}