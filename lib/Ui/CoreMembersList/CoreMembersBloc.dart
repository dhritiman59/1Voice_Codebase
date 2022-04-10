
import 'package:bring2book/Models/GetCoreMember/CoreMemberRequest.dart';
import 'package:bring2book/Models/GetCoreMember/GetCoreMembersModel.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bring2book/Constants/sharedPrefKeys.dart';
class CoreMembersBloc{
  final repository = Repository();
  final getCoreMembers = PublishSubject<GetCoreMembers>();
  final requestCoreMember = PublishSubject<CoreMemberRequest>();
  String loggedUser;
  String userId;
  bool alreadyCoreMember=false;
  Stream<GetCoreMembers> get coreMembersStream => getCoreMembers.stream;
  Stream<CoreMemberRequest> get requestCoreMembersStream => requestCoreMember.stream;
  Future<GetCoreMembers> getCoremembersList(String caseId) async {
    GetCoreMembers model = await repository.getCoreMembers(caseId);

    if (GetCoreMembers != null) {
      print("not null model123");


      getCoreMembers.sink.add(model);


  }}

  Future<CoreMemberRequest> joinCoreMember(String caseId) async {
    final parameter = {
      'caseId':caseId
    };
    CoreMemberRequest model=await repository.requestAsCoreMember(parameter);
    if (model != null) {
      requestCoreMember.sink.add(model);
    }
  }


}