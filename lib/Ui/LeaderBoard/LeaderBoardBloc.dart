import 'package:bring2book/Models/CaseDonationModel/CaseDonationModel.dart';
import 'package:bring2book/Models/GeneralDonation/GeneralDonationModel.dart';
import 'package:bring2book/Models/LeaderBoardModel/LeaderBoardModel.dart';
import 'package:bring2book/Models/NotificationModel/NotificationModel.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class LeaderBloc{
  final repository = Repository();
  final leaderBoardList = PublishSubject<LeaderModel>();
  Stream<LeaderModel> get leaderBoardStream => leaderBoardList.stream;
  bool paginationLoading = false;
  LeaderModel paginationLeaderModel;
  /*Future<LeaderModel> getLeaderBoardList( {String page}) async {
    Map<String, String> queryParams = {'page': page};

    LeaderModel leaderModel =
    await repository.getLeaderBoardList(queryParams);
    if (leaderModel != null) {
      leaderBoardList.sink.add(leaderModel);
    }
    print(leaderModel);
  }*/
  Future getLeaderBoardList({String page}) async {
    paginationLoading = true;
    Map<String, String> queryParams = {'page': page};

    print('Maria$queryParams');

    paginationLoading = true;
    LeaderModel responseMyFollowers = await repository.getLeaderBoardList(queryParams);

    if (responseMyFollowers != null) {
      if (responseMyFollowers.status == 'error') {
        leaderBoardList.sink.add(responseMyFollowers);
      } else {
        if (responseMyFollowers.data.currentPage > 0) {
          if (paginationLeaderModel.data.data != null) {
            paginationLeaderModel.data.data.addAll(responseMyFollowers.data.data);
            print('Minnu');
          }

          paginationLeaderModel.data.currentPage = responseMyFollowers.data.currentPage;
          paginationLeaderModel.data.totalPages = responseMyFollowers.data.totalPages; //to pagination page change
          leaderBoardList.sink.add(paginationLeaderModel);
          print('MinnuMaria');
        } else {
          paginationLeaderModel = responseMyFollowers;
          leaderBoardList.sink.add(paginationLeaderModel); // jsonEncode != .toString()
          print('MinnuMariaKurian');
        }
      }
    }

    paginationLoading = false;
  }


}