import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:bring2book/Models/AddComment/AddComment.dart';
import 'package:bring2book/Models/ForgotPasswordModel/ForgotPasswordBean.dart';
import 'package:bring2book/Models/LoginUserModel/LoginUserBean.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class AddCommentBloc {
  final repository = Repository();

  final addComment = PublishSubject<AddComment>();
  Stream<AddComment> get addCommentStream => addComment.stream;

 /* Future<AddComment> addCaseApi(
      String comment, List file, String caseId) async {
    final parameter = {
      'comment': comment,
      'caseId': caseId,
      'file': file,
    };
    print('parameter list is $parameter');

    AddComment addCaseApiResp = await repository.AddCommentMultipart(
      comment,
      caseId,
      file,
    );
    if (addCaseApiResp != null) {
      addComment.sink.add(addCaseApiResp);
    }
    print("MariaMol");
    print(addCaseApiResp);
  }
*/
  Future<AddComment> updateDocuments(
      String comment, List file, String caseId) async {
    print(file);
    final parameter = {'comment': comment, 'caseId': caseId};
    AddComment addCommentRes = await repository.updateDocumentsComment(
      parameter,
      file,
    );
    if (addCommentRes != null) {
      print(addCommentRes.status);
      addComment.sink.add(addCommentRes);
    }
  }

  void dispose() {
    addComment.close();
  }
}
