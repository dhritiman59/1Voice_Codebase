import 'package:bring2book/Models/GetUserDetailsModel/GetUserDetailsModel.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:bring2book/Models/ProfileImageUploadModel/ProfileImageUpload.dart';
import 'package:bring2book/Models/EditProfileModel/EditProfileModel.dart';
import 'package:bring2book/Models/ChangePasswordModel/ChangePasswordModel.dart';
import 'package:bring2book/Models/ResendEmailModel/ResendEmailModel.dart';

import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class ProfileDetailsBloc {

  final repository = Repository();


  final getUserDetailsResponse = PublishSubject<GetUserDetailsModel>();
  Stream<GetUserDetailsModel> get getUserDetailsStream => getUserDetailsResponse.stream;



  final profileImageResponse = PublishSubject<ProfileImageUpload>();
  Stream<ProfileImageUpload> get profileImageStream => profileImageResponse.stream;


  final changePasswordResponse = PublishSubject<ChangePasswordModel>();
  Stream<ChangePasswordModel> get changePasswordStream => changePasswordResponse.stream;



  final editProfileResponse = PublishSubject<EditProfileModel>();
  Stream<EditProfileModel> get editProfileStream => editProfileResponse.stream;



  final emailVerifyResponse = PublishSubject<ResendEmailModel>();
  Stream<ResendEmailModel> get emailVerifyStream => emailVerifyResponse.stream;



  final editAliasNameProfileResponse = PublishSubject<EditProfileModel>();
  Stream<EditProfileModel> get editAliasNameProfileStream => editAliasNameProfileResponse.stream;



  Future<GetUserDetailsModel> getUserDetails() async {
    GetUserDetailsModel getUserDetailsResp = await repository.getUserDetails();
    if (getUserDetailsResp != null) {
      getUserDetailsResponse.sink.add(getUserDetailsResp);
    }
    print("Maria");
    print(getUserDetailsResp);
  }

  Future<ResendEmailModel> performEmailVerify() async {
    ResendEmailModel emailVerifyResp = await repository.performEmailVerify();
    if (emailVerifyResp != null) {
      emailVerifyResponse.sink.add(emailVerifyResp);
    }
    print("Maria");
    print(emailVerifyResp);
  }




  Future<ProfileImageUpload> profileImageUploadApi(List file) async
  {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString(SharedPrefKey.USER_ID);
    print('this is userid ${prefs.getString(SharedPrefKey.USER_ID)}');

    final parameter = {
      'userId':userId,
    };
    ProfileImageUpload profileImageApiResp = await repository.profileImageUploadApi(parameter, file,);
    if (profileImageApiResp != null) {
      profileImageResponse.sink.add(profileImageApiResp);
    }
    print("profileImageResponse MariaMol");
    print(profileImageResponse);
  }





  Future<ChangePasswordModel> performChangePassword(email,oldpassword,newpassword) async {

    final parameter = {
      'emailId':email,
      'oldpassword':oldpassword,
      'newpassword':newpassword
    };

    ChangePasswordModel changePasswordResp = await repository.performChangePassword(parameter);
    if (changePasswordResp != null) {
      changePasswordResponse.sink.add(changePasswordResp);
    }
    print("changePasswordResp Maria");
    print(changePasswordResp);
  }


  Future<EditProfileModel> performEditProfile(
      country, state,
      countryCode,firstName,lastName,displayName,gender,dob,
      phone, String aliasName, bool checkBoxAliasValue,aboutMe) async {
     String aliasFlag;
    if(checkBoxAliasValue){
      aliasFlag='1';
     }
    else{
      aliasFlag='2';
    }
    final parameter = {
      "firstName": firstName,
      "lastName":lastName,
      "country": country,
      "state":state,
      "countryCode":countryCode,
      //'displayName':displayName,
      'gender':gender,
      'dob':dob,
      'phone':phone,
      'aliasName':aliasName,
      'aboutMe' : aboutMe,
      'aliasFlag':aliasFlag,
    };

    EditProfileModel editProfileResp = await repository.performEditProfile(parameter);
    if (editProfileResp != null) {
      editProfileResponse.sink.add(editProfileResp);
    }
    print("changePasswordResp Maria");
    print(editProfileResp);
  }



  Future<EditProfileModel> performEditAliasNameProfile(displayName,String aliasName,String aliasFlag) async {

    final parameter = {
      'displayName':displayName,
      'aliasName':aliasName,
      'aliasFlag':aliasFlag,
    };

    EditProfileModel editAliasProfileResp = await repository.performEditProfile(parameter);
    if (editAliasProfileResp != null) {
      editAliasNameProfileResponse.sink.add(editAliasProfileResp);
    }
    print("editAliasProfileResp");
    print(editAliasProfileResp);
  }



  void dispose() {
    editAliasNameProfileResponse.close();
    emailVerifyResponse.close();
    changePasswordResponse.close();
    profileImageResponse.close();
    getUserDetailsResponse.close();
    editProfileResponse.close();

  }






}