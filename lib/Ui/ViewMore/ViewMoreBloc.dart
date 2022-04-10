import 'package:bring2book/Models/CaseDonationModel/CaseDonationModel.dart';
import 'package:bring2book/Models/GeneralDonation/GeneralDonationModel.dart';
import 'package:bring2book/Models/NotificationModel/NotificationModel.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bring2book/Models/GetComments/GetCommentsModel.dart';
class ViewMoreBloc{
  final repository = Repository();
  final notificationList = PublishSubject<GetCommentsModel>();
  Stream<GetCommentsModel> get NotificationStream => notificationList.stream;
  bool paginationLoading = false;
  GetCommentsModel paginationNotification;
  /*Future<NotificationModel> getNotificationList( {String page}) async {
    final parameter = {
      'page':page,
    };

    NotificationModel notificationModel =
    await repository.getNotificationList(parameter);
    if (notificationModel != null) {
      notificationList.sink.add(notificationModel);
    }
    print(notificationModel);
  }*/
  Future getAllComments1(String caseId,String page) async {
    paginationLoading = true;
    Map<String, String> queryParams = {'page': page};

    print('Maria$queryParams');

    paginationLoading = true;
    GetCommentsModel responseJoinCase =
    await repository.getComments1(caseId, queryParams);

    if (responseJoinCase != null) {
      if (responseJoinCase.status == 'error') {
        notificationList.sink.add(responseJoinCase);
      } else {
        if (responseJoinCase.data.currentPage > 0) {
          print('Minnu');
          if (paginationNotification.data.data != null) {
            if (responseJoinCase.data.data.length != 0) {
            /*  for (int i = 0; i <= responseJoinCase.data.data.length; i++) {
                if (responseJoinCase.data.data[i].rankComment[0].status == 1) {
                  responseJoinCase.data.data[i].isUpVote = true;
                } else {
                  responseJoinCase.data.data[i].isUpVote = false;
                }
                if (responseJoinCase.data.data[i].rankComment[0].status == 2) {
                  responseJoinCase.data.data[i].isDownVote = true;
                } else {
                  responseJoinCase.data.data[i].isDownVote = false;
                }
              }*/
            }
            paginationNotification.data.data.addAll(responseJoinCase.data.data);

          }

          paginationNotification.data.currentPage = responseJoinCase.data.currentPage;
          paginationNotification.data.totalPages = responseJoinCase.data.totalPages; //to pagination page change
          notificationList.sink.add(paginationNotification);
          print('MinnuMaria');
        } else {
          /*for (int i = 0; i <= responseJoinCase.data.data.length; i++) {
            if (responseJoinCase.data.data[i].rankComment[0].status == 1) {
              responseJoinCase.data.data[i].isUpVote = true;
            } else {
              responseJoinCase.data.data[i].isUpVote = false;
            }
            if (responseJoinCase.data.data[i].rankComment[0].status == 2) {
              responseJoinCase.data.data[i].isDownVote = true;
            } else {
              responseJoinCase.data.data[i].isDownVote = false;
            }
          }*/
          paginationNotification = responseJoinCase;
          notificationList.sink.add(paginationNotification); // jsonEncode != .toString()
          print('MinnuMariaKurian');
        }
      }
    }

    paginationLoading = false;
  }
}