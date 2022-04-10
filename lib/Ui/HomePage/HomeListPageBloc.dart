import 'dart:async';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:bring2book/Models/Follow/Follow.dart';
import 'package:bring2book/Models/JoinLeaveCase/JoinLeaveCaseModel.dart';
import 'package:bring2book/Models/RankUpDown/RankCaseDown.dart';
import 'package:bring2book/Models/RankUpDown/RankUpDown.dart';
import 'package:bring2book/Models/Share/ShareModel.dart';
import 'package:bring2book/Models/UpdateFcmToken/UpdateDeviceId.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeListPageBloc {
  final repository = Repository();
  final joinResponse = PublishSubject<JoinLeaveCaseModel>();
  final leaveResponse = PublishSubject<JoinLeaveCaseModel>();
  final rankUpDown = PublishSubject<RankUpDown>();
  final rankCaseDown = PublishSubject<RankCaseDown>();
  final follow = PublishSubject<Follow>();
  final share = PublishSubject<ShareModel>();
  Stream<JoinLeaveCaseModel> get joinStream => joinResponse.stream;
  Stream<JoinLeaveCaseModel> get leaveStream => leaveResponse.stream;
  Stream<RankUpDown> get rank => rankUpDown.stream;
  Stream<RankCaseDown> get rankDownCase => rankCaseDown.stream;
  Stream<Follow> get follow_him => follow.stream;
  Stream<ShareModel> get shareStream => share.stream;
  StreamController validateCaseDetailsController = StreamController<String>();
  Stream<String> get validateTermsStream =>
      validateCaseDetailsController.stream;
  StreamSink<String> get validateTermsSink =>
      validateCaseDetailsController.sink;

  String bannerImage = 'assets/images/caseDetailCorruptionBanner.png';
  bool isArrowVisible = true;



  Future<JoinLeaveCaseModel> joinCase(String id) async {
    final parameter = {
      'caseId': id,
    };

    JoinLeaveCaseModel joinLeaveCaseModel =
    await repository.postJoin(parameter);
    if (joinLeaveCaseModel != null) {
      joinResponse.sink.add(joinLeaveCaseModel);
    }
    print("Maria");
    print(joinLeaveCaseModel);
  }

  Future<JoinLeaveCaseModel> leaveCase(String id) async {
    final parameter = {
      'caseId': id,
    };

    JoinLeaveCaseModel joinLeaveCaseModel =
    await repository.postLeave(parameter);
    if (joinLeaveCaseModel != null) {
      leaveResponse.sink.add(joinLeaveCaseModel);
    }
    print("Maria");
    print(joinLeaveCaseModel);
  }


  Future<void> rankDown(String id) async {
    final parameter = {
      'caseId': id,
    };
    RankCaseDown model = await repository.rankDown(parameter);
    if (RankCaseDown != null) {
      print("not null model");
      rankCaseDown.sink.add(model);
    }

    print(RankCaseDown);
  }

  Future<void> rankUp(String id) async {
    final parameter = {
      'caseId': id,
    };
    RankUpDown model = await repository.rankUp(parameter);
    if (RankUpDown != null) {
      print("not null model");
      rankUpDown.sink.add(model);
    }

    print(RankUpDown);
  }



  Future<void> shareCase(String id) async {
    final parameter = {
      "heading": "Shared Case",
      "message": "Just See this Case",
      "caseId": id,
    };
    ShareModel model = await repository.share(parameter);
    if (model != null) {
      print("not null model");
      share.sink.add(model);
    }

    print(Follow);
  }

  Future<void> updateFcm(String token) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final parameter = {
      'device_id':token
    };
    DeviceIdModel deviceIdModel = await repository.updateDeviceId(parameter);

    if(deviceIdModel.status=="success")
      {
        prefs.setString(SharedPrefKey.OLD_FCM_TOKEN, token);
      }

    String old_fcm = prefs.getString(SharedPrefKey.OLD_FCM_TOKEN);
    print(old_fcm);
    print(deviceIdModel);
    print(deviceIdModel.status+'deviceId');
  }


}
