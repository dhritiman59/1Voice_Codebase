import 'package:bring2book/Models/CaseDonationModel/CaseDonationModel.dart';
import 'package:bring2book/Models/GeneralDonation/GeneralDonationModel.dart';
import 'package:bring2book/Models/NotificationModel/NotificationModel.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class NotificationBloc{
  final repository = Repository();
  final notificationList = PublishSubject<NotificationModel>();
  Stream<NotificationModel> get NotificationStream => notificationList.stream;
  bool paginationLoading = false;
  NotificationModel paginationNotification;
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
  Future getNotificationList({String page}) async {
    paginationLoading = true;
    Map<String, String> queryParams = {'page': page};

    print('Maria$queryParams');

    paginationLoading = true;
    NotificationModel responseMyFollowers = await repository.getNotificationList(queryParams);

    if (responseMyFollowers != null) {
      if (responseMyFollowers.status == 'error') {
        notificationList.sink.add(responseMyFollowers);
      } else {
        if (responseMyFollowers.data.currentPage > 0) {
          if (paginationNotification.data.data != null) {
            paginationNotification.data.data.addAll(responseMyFollowers.data.data);
            print('Minnu');
          }

          paginationNotification.data.currentPage = responseMyFollowers.data.currentPage;
          paginationNotification.data.totalPages = responseMyFollowers.data.totalPages; //to pagination page change
          notificationList.sink.add(paginationNotification);
          print('MinnuMaria');
        } else {
          paginationNotification = responseMyFollowers;
          notificationList.sink.add(paginationNotification); // jsonEncode != .toString()
          print('MinnuMariaKurian');
        }
      }
    }

    paginationLoading = false;
  }

}