
import 'package:bring2book/Models/CoreMemberSelection/CoreMemberSelection.dart';
import 'package:bring2book/Models/GetCoreMember/CoreMemberRequest.dart';
import 'package:bring2book/Models/GetCoreMember/GetCoreMembersModel.dart';
import 'package:bring2book/Models/PrivateRequestAccept/PrivateRequestAccept.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class CoreMembersRequestBloc{
  final repository = Repository();
  final getCoreMembers = PublishSubject<CoreMemberSelection>();
  final requestCoreMember = PublishSubject<CoreMemberRequest>();
  final privateRequest = PublishSubject<PrivateRequestAccept>();
  Stream<CoreMemberSelection> get coreMembersStream => getCoreMembers.stream;
  Stream<CoreMemberRequest> get requestCoreMembersStream => requestCoreMember.stream;
  Stream<PrivateRequestAccept> get privateRequestAccept => privateRequest.stream;
  Future<CoreMemberSelection> getCoremembersList(String caseId) async {
    CoreMemberSelection model = await repository.getCoreMembersSelectionList(caseId);
    if (CoreMemberSelection != null) {
      print("not null model");
      getCoreMembers.sink.add(model);
    }

  }

  Future<CoreMemberRequest> joinCoreMember(String caseId) async {
    final parameter = {
      'caseId':caseId
    };
    CoreMemberRequest model=await repository.requestAsCoreMember(parameter);
    if (model != null) {
      requestCoreMember.sink.add(model);
    }
  }

  Future<PrivateRequestAccept> acceptRequest(int id) async {
    PrivateRequestAccept model = await repository.acceptRequest(id.toString());
    if (CoreMemberSelection != null) {
      print("not null model");
      privateRequest.sink.add(model);
    }
  }
}