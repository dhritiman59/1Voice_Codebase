
import 'package:bring2book/Models/GetUserDetailsModel/GetUserDetailsModel.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPageBloc {
  final repository = Repository();

  final getUserDetailsResponse = PublishSubject<GetUserDetailsModel>();
  Stream<GetUserDetailsModel> get getUserDetailsStream => getUserDetailsResponse.stream;








  Future<GetUserDetailsModel> getUserDetails() async {
    GetUserDetailsModel getUserDetailsResp = await repository.getUserDetails();
    if (getUserDetailsResp != null) {
      getUserDetailsResponse.sink.add(getUserDetailsResp);
    }
    print("Maria");
    print(getUserDetailsResp);
  }


  getSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String senderid=prefs.getString(SharedPrefKey.USER_ID);
    print('bannerad showAlert $senderid');
    return senderid.toString();
  }

  dateconvert(String Format) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'");
    DateTime dateTime = dateFormat.parse(Format);

    DateFormat dateFormatterMonDay = DateFormat("MMMM, dd yyyy");
    String monDaystring = dateFormatterMonDay.format(dateTime);

    return monDaystring;
  }


  void dispose() {
    getUserDetailsResponse.close();
  }

}