import 'package:auto_size_text/auto_size_text.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:bring2book/Ui/CaseDetails/CaseDetailsBloc.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bring2book/Models/GetComments/GetCommentsModel.dart';
import 'package:bring2book/Models/CaseDetails/CaseDetailsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:bring2book/Ui/ViewMore//ViewMoreBloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:bring2book/Ui/AddComment/AddCommentBloc.dart';
import 'dart:io';

class ViewMoreUi extends StatefulWidget {
  String caseId;
  ViewMoreUi(this.caseId);

  @override
  _State createState() => _State();
}

class _State extends State<ViewMoreUi> {
  var durationFromV;

  AddCommentBloc bloc1 = AddCommentBloc();
  String caseId;
  String id, userTypeId;
  bool coreMember = false;
  bool isAdmin = false;
  bool visibility = false;
  CaseDetailsBloc bloc2 = CaseDetailsBloc();
  final List<String> _galleryImagePathList = [];
  ViewMoreBloc bloc = ViewMoreBloc();
  final TextEditingController _txtCtrl = TextEditingController();
  bool visible = true;
  TextEditingController amount = TextEditingController();
  CaseDetailsModel _caseDetailsModel;
  GetCommentsModel model = GetCommentsModel();

  TextEditingController commentReport = TextEditingController();
  TextEditingController commentUserReport = TextEditingController();
  StateSetter myReportComment1, myReportUserComment1;

  final FocusNode _commentFocus = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String fileName;
  FilePickerResult paths;
  int count;
  List<String> extensions;
  bool isLoadingPath = false;
  FileType fileType;

  bool firstButtonClick = true;

  @override
  void initState() {
    super.initState();
    getData();
    bloc2.getCaseDetails(widget.caseId);
    bloc.getAllComments1(widget.caseId, '0');
    listen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSizeAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Stack(
            children: [
              Column(
                children: [
                  Flexible(
                    child: Container(
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height * 0.84,
                      child: StreamBuilder(
                          stream: bloc.notificationList,
                          builder: (context,
                              AsyncSnapshot<GetCommentsModel> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.status == 'error') {
                                return noDataFound();
                              } else if (snapshot.data.data.data.isEmpty) {
                                return noDataFound();
                              } else {}
                            } else {
                              return Center(child: ProgressBarDarkBlue());
                            }

                            return NotificationListener(
                              // ignore: missing_return
                              onNotification: (ScrollNotification scrollInfo) {
                                if (!bloc.paginationLoading &&
                                    scrollInfo.metrics.pixels ==
                                        scrollInfo.metrics.maxScrollExtent) {
                                  // start loading data
                                  if (snapshot.data.data.currentPage <
                                      snapshot.data.data.totalPages) {
                                    final page =
                                        snapshot.data.data.currentPage + 1;

                                    bloc.getAllComments1(
                                        widget.caseId, page.toString());
                                  }
                                }
                              },

                              child: SingleChildScrollView(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data.data.data.length,
                                  itemBuilder: (context, pos) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    width: 50.0,
                                                    height: 50.0,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: snapshot
                                                                      .data
                                                                      .data
                                                                      .data[pos]
                                                                      .userProfile
                                                                      .aliasName !=
                                                                  null &&
                                                              snapshot
                                                                      .data
                                                                      .data
                                                                      .data[pos]
                                                                      .userProfile
                                                                      .aliasFlag ==
                                                                  1
                                                          ? displayProfilePic(
                                                              snapshot
                                                                  .data
                                                                  .data
                                                                  .data[pos]
                                                                  .userProfile
                                                                  .aliasName)
                                                          : displayProfilePic(
                                                              snapshot
                                                                  .data
                                                                  .data
                                                                  .data[pos]
                                                                  .userProfile
                                                                  .displayName),
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 5,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 0, 0, 0),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: snapshot
                                                                          .data
                                                                          .data
                                                                          .data[
                                                                              pos]
                                                                          .userProfile
                                                                          .aliasName !=
                                                                      null &&
                                                                  snapshot
                                                                          .data
                                                                          .data
                                                                          .data[
                                                                              pos]
                                                                          .userProfile
                                                                          .aliasFlag ==
                                                                      1
                                                              ? Text(
                                                                  snapshot
                                                                      .data
                                                                      .data
                                                                      .data[pos]
                                                                      .userProfile
                                                                      .aliasName,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  softWrap:
                                                                      false,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16.0),
                                                                )
                                                              : Text(
                                                                  snapshot
                                                                      .data
                                                                      .data
                                                                      .data[pos]
                                                                      .userProfile
                                                                      .displayName,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  softWrap:
                                                                      false,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16.0),
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 0,
                                                  child:
                                                      PopupMenuButton<String>(
                                                    padding: EdgeInsets.zero,
                                                    offset: const Offset(0, 40),
                                                    icon: const Icon(
                                                        Icons.more_vert),
                                                    onSelected: (result) async {
                                                      switch (result) {
                                                        case 'Report comment':
                                                          if (int.parse(id) ==
                                                              model
                                                                  .data
                                                                  .data[pos]
                                                                  .userId) {
                                                            return toastMsg(
                                                                "Can't Report Yourself");
                                                          } else {
                                                            return showDialog(
                                                              barrierDismissible:
                                                                  false,
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title: Row(
                                                                    children: [
                                                                      const Expanded(
                                                                        flex: 5,
                                                                        child: Text(
                                                                            'Reason for reporting'),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child: IconButton(
                                                                            icon: const Icon(
                                                                              Icons.clear,
                                                                              color: Colors.black87,
                                                                              size: 24,
                                                                            ),
                                                                            onPressed: () {
                                                                              commentReport.text = "";
                                                                              Navigator.pop(context);
                                                                            }),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  content: StatefulBuilder(builder: (BuildContext
                                                                          context,
                                                                      StateSetter
                                                                          myReportComment) {
                                                                    myReportComment1 =
                                                                        myReportComment;
                                                                    return Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 0, right: 0, top: 5),
                                                                                child: Container(
                                                                                  color: CustColors.LightRose,
                                                                                  width: 250,
                                                                                  height: 150,
                                                                                  padding: const EdgeInsets.all(0.0),
                                                                                  child: ConstrainedBox(
                                                                                    constraints: const BoxConstraints(
                                                                                      maxHeight: 150.0,
                                                                                    ),
                                                                                    child: Scrollbar(
                                                                                      child: SingleChildScrollView(
                                                                                        scrollDirection: Axis.vertical,
                                                                                        reverse: true,
                                                                                        child: SizedBox(
                                                                                          height: 150.0,
                                                                                          child: TextField(
                                                                                            onChanged: (text) {
                                                                                              myReportComment1(() {});
                                                                                            },
                                                                                            controller: commentReport,
                                                                                            maxLines: 250,
                                                                                            onSubmitted: (text) {
                                                                                              _commentFocus.unfocus();
                                                                                            },
                                                                                            decoration: InputDecoration(
                                                                                              fillColor: CustColors.LightRose,
                                                                                              border: OutlineInputBorder(
                                                                                                borderRadius: BorderRadius.circular(5.0),
                                                                                                borderSide: const BorderSide(
                                                                                                  color: CustColors.TextGray,
                                                                                                  style: BorderStyle.solid,
                                                                                                ),
                                                                                              ),
                                                                                              hintText: 'Type here…..',
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        commentReport.text.trim() ==
                                                                                ''
                                                                            ? const Padding(
                                                                                padding: EdgeInsets.only(top: 8.0, left: 2),
                                                                                child: Align(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    child: Text(
                                                                                      ' * Enter a message',
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Formular',
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 12,
                                                                                        color: Colors.red,
                                                                                      ),
                                                                                    )),
                                                                              )
                                                                            : Container(),
                                                                      ],
                                                                    );
                                                                  }),
                                                                  actions: [
                                                                    FlatButton(
                                                                      color: CustColors
                                                                          .DarkBlue,
                                                                      child: const Text(
                                                                          'Submit'),
                                                                      onPressed:
                                                                          () {
                                                                        if (commentReport.text.trim() ==
                                                                            "") {
                                                                        } else {
                                                                          bloc2.reportComments(
                                                                              commentReport.text.toString(),
                                                                              snapshot.data.data.data[pos].caseId,
                                                                              snapshot.data.data.data[pos].id);
                                                                          commentReport.text =
                                                                              '';
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        }
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          }

                                                          break;
                                                        case 'Report User':
                                                          print('click Edit');
                                                          if (int.parse(id) ==
                                                              model
                                                                  .data
                                                                  .data[pos]
                                                                  .userId) {
                                                            return toastMsg(
                                                                "Can't Report Yourself");
                                                          } else {
                                                            return showDialog(
                                                              barrierDismissible:
                                                                  false,
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title: Row(
                                                                    children: [
                                                                      const Expanded(
                                                                        flex: 5,
                                                                        child: Text(
                                                                            'Reason for reporting'),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child: IconButton(
                                                                            icon: const Icon(
                                                                              Icons.clear,
                                                                              color: Colors.black87,
                                                                              size: 24,
                                                                            ),
                                                                            onPressed: () {
                                                                              commentUserReport.text = "";
                                                                              Navigator.pop(context);
                                                                            }),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  content: StatefulBuilder(builder: (BuildContext
                                                                          context,
                                                                      StateSetter
                                                                          myReportUserComment) {
                                                                    myReportUserComment1 =
                                                                        myReportUserComment;
                                                                    return Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 0, right: 0, top: 5),
                                                                                child: Container(
                                                                                  color: CustColors.LightRose,
                                                                                  width: 250,
                                                                                  height: 150,
                                                                                  padding: const EdgeInsets.all(0.0),
                                                                                  child: ConstrainedBox(
                                                                                    constraints: const BoxConstraints(
                                                                                      maxHeight: 150.0,
                                                                                    ),
                                                                                    child: Scrollbar(
                                                                                      child: SingleChildScrollView(
                                                                                        scrollDirection: Axis.vertical,
                                                                                        reverse: true,
                                                                                        child: SizedBox(
                                                                                          height: 150.0,
                                                                                          child: TextField(
                                                                                            onChanged: (text) {
                                                                                              myReportUserComment1(() {});
                                                                                            },
                                                                                            controller: commentUserReport,
                                                                                            maxLines: 250,
                                                                                            onSubmitted: (text) {
                                                                                              _commentFocus.unfocus();
                                                                                            },
                                                                                            decoration: InputDecoration(
                                                                                              fillColor: CustColors.LightRose,
                                                                                              border: OutlineInputBorder(
                                                                                                borderRadius: BorderRadius.circular(5.0),
                                                                                                borderSide: const BorderSide(
                                                                                                  color: CustColors.TextGray,
                                                                                                  style: BorderStyle.solid,
                                                                                                ),
                                                                                              ),
                                                                                              hintText: 'Type here…..',
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        commentUserReport.text.trim() ==
                                                                                ''
                                                                            ? const Padding(
                                                                                padding: EdgeInsets.only(top: 8.0, left: 2),
                                                                                child: Align(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    child: Text(
                                                                                      ' * Enter a message',
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Formular',
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 12,
                                                                                        color: Colors.red,
                                                                                      ),
                                                                                    )),
                                                                              )
                                                                            : Container(),
                                                                      ],
                                                                    );
                                                                  }),
                                                                  actions: [
                                                                    FlatButton(
                                                                      color: CustColors
                                                                          .DarkBlue,
                                                                      child: const Text(
                                                                          'Submit'),
                                                                      onPressed:
                                                                          () {
                                                                        if (commentUserReport.text.trim() ==
                                                                            "") {
                                                                        } else {
                                                                          bloc2.reportUserComment(
                                                                              commentUserReport.text.toString(),
                                                                              snapshot.data.data.data[pos].userId,
                                                                              snapshot.data.data.data[pos].caseId);
                                                                          commentUserReport.text =
                                                                              '';
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        }
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          }

                                                          break;
                                                        case 'Delete Comment':
                                                          print('click Edit');
                                                          bloc2.deleteComment(
                                                              snapshot
                                                                  .data
                                                                  .data
                                                                  .data[pos]
                                                                  .id);
                                                          setState(() {
                                                            snapshot
                                                                .data.data.data
                                                                .removeAt(pos);
                                                          });

                                                          break;
                                                        case 'Block User':
                                                          print('click Edit');
                                                          bloc2.blockUser(
                                                              snapshot
                                                                  .data
                                                                  .data
                                                                  .data[pos]
                                                                  .userId);
                                                          break;
                                                      }
                                                    },
                                                    itemBuilder: (BuildContext
                                                            context) =>
                                                        isAdmin
                                                            ? <
                                                                PopupMenuEntry<
                                                                    String>>[
                                                                const PopupMenuItem<
                                                                        String>(
                                                                    value:
                                                                        'Delete Comment',
                                                                    child: ListTile(
                                                                        title: Text(
                                                                            'Delete Comment'))),
                                                                const PopupMenuItem<
                                                                        String>(
                                                                    value:
                                                                        'Block User',
                                                                    child: ListTile(
                                                                        title: Text(
                                                                            'Block User'))),
                                                              ]
                                                            : <
                                                                PopupMenuEntry<
                                                                    String>>[
                                                                const PopupMenuItem<
                                                                        String>(
                                                                    value:
                                                                        'Report comment',
                                                                    child: ListTile(
                                                                        title: Text(
                                                                            'Report comment'))),
                                                                const PopupMenuItem<
                                                                        String>(
                                                                    value:
                                                                        'Report User',
                                                                    child: ListTile(
                                                                        title: Text(
                                                                            'Report User'))),
                                                              ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 10, 10),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: AutoSizeText(
                                                  snapshot.data.data.data[pos]
                                                      .comment,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14),
                                                  minFontSize: 10,
                                                  stepGranularity: 1,
                                                  maxLines: 4,
                                                  textAlign: TextAlign.justify,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: snapshot
                                                      .data
                                                      .data
                                                      .data[pos]
                                                      .commentFile
                                                      .isNotEmpty
                                                  ? SizedBox(
                                                      height: 50,
                                                      //  color: Colors.blue,
                                                      child: ListView.builder(
                                                          reverse: true,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          shrinkWrap: true,
                                                          itemCount: snapshot
                                                              .data
                                                              .data
                                                              .data[pos]
                                                              .commentFile
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            print(snapshot
                                                                .data
                                                                .data
                                                                .data[pos]
                                                                .commentFile
                                                                .length);
                                                            var imgUrl = snapshot
                                                                .data
                                                                .data
                                                                .data[pos]
                                                                .commentFile[
                                                                    index]
                                                                .commentFile;

                                                            print(
                                                                'image url is $imgUrl');

                                                            return GestureDetector(
                                                              child: Container(
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/doc.jpg',
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  //'assets/images/userimagedummy.png',
                                                                  //  width: 50,
                                                                  //   height: 50
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                launchURL(
                                                                    imgUrl);
                                                              },
                                                            );
                                                          }
                                                          //}
                                                          ),
                                                    )
                                                  : Container(),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 10, 10),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: double.infinity,
                                                      child: Row(
                                                        children: [
                                                          InkWell(
                                                            child: snapshot
                                                                    .data
                                                                    .data
                                                                    .data[pos]
                                                                    .isDownVote
                                                                ? Image.asset(
                                                                    'assets/images/coloredDown.png',
                                                                    width: 16,
                                                                    height: 16)
                                                                : Image.asset(
                                                                    'assets/images/vote_down_icon.png',
                                                                    width: 16,
                                                                    height: 16),
                                                            onTap: () {
                                                              // _onSelected(pos);
                                                              if (snapshot
                                                                  .data
                                                                  .data
                                                                  .data[pos]
                                                                  .isDownVote) {
                                                                toastMsg(
                                                                    'Already Ranked');
                                                              } else {
                                                                setState(() {
                                                                  if (snapshot
                                                                              .data
                                                                              .data
                                                                              .data[
                                                                                  pos]
                                                                              .isDownVote ==
                                                                          false &&
                                                                      snapshot
                                                                              .data
                                                                              .data
                                                                              .data[pos]
                                                                              .isUpVote ==
                                                                          false) {
                                                                    snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            pos]
                                                                        .rankCount = snapshot
                                                                            .data
                                                                            .data
                                                                            .data[pos]
                                                                            .rankCount -
                                                                        1;
                                                                  } else {
                                                                    snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            pos]
                                                                        .rankCount = snapshot
                                                                            .data
                                                                            .data
                                                                            .data[pos]
                                                                            .rankCount -
                                                                        2;
                                                                  }

                                                                  snapshot
                                                                      .data
                                                                      .data
                                                                      .data[pos]
                                                                      .isDownVote = true;
                                                                  snapshot
                                                                      .data
                                                                      .data
                                                                      .data[pos]
                                                                      .isUpVote = false;

                                                                  snapshot
                                                                      .data
                                                                      .data
                                                                      .data[pos]
                                                                      .rankCount = snapshot
                                                                          .data
                                                                          .data
                                                                          .data[
                                                                              pos]
                                                                          .rankCount -
                                                                      1;
                                                                  bloc2.rankComments(
                                                                      snapshot
                                                                          .data
                                                                          .data
                                                                          .data[
                                                                              pos]
                                                                          .id,
                                                                      snapshot
                                                                          .data
                                                                          .data
                                                                          .data[
                                                                              pos]
                                                                          .caseId,
                                                                      '2');

                                                                  snapshot
                                                                      .data
                                                                      .data
                                                                      .data[pos]
                                                                      .isDownVote = true;
                                                                  snapshot
                                                                      .data
                                                                      .data
                                                                      .data[pos]
                                                                      .isUpVote = false;
                                                                });
                                                                bloc2.rankComments(
                                                                    snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            pos]
                                                                        .id,
                                                                    snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            pos]
                                                                        .caseId,
                                                                    '2');
                                                              }
                                                            },
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    10,
                                                                    0,
                                                                    10,
                                                                    0),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child:
                                                                  AutoSizeText(
                                                                snapshot
                                                                    .data
                                                                    .data
                                                                    .data[pos]
                                                                    .rankCount
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .blueGrey,
                                                                    fontSize:
                                                                        10),
                                                                minFontSize: 10,
                                                                maxLines: 1,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            child: snapshot
                                                                    .data
                                                                    .data
                                                                    .data[pos]
                                                                    .isUpVote
                                                                ? Image.asset(
                                                                    'assets/images/coloredUp.png',
                                                                    width: 16,
                                                                    height: 16)
                                                                : Image.asset(
                                                                    'assets/images/vote_up_icon.png',
                                                                    width: 16,
                                                                    height: 16),
                                                            onTap: () {
                                                              // _onSelected(pos);
                                                              if (snapshot
                                                                  .data
                                                                  .data
                                                                  .data[pos]
                                                                  .isUpVote) {
                                                                toastMsg(
                                                                    'Already Ranked');
                                                              } else {
                                                                setState(() {
                                                                  if (snapshot
                                                                              .data
                                                                              .data
                                                                              .data[
                                                                                  pos]
                                                                              .isDownVote ==
                                                                          false &&
                                                                      snapshot
                                                                              .data
                                                                              .data
                                                                              .data[pos]
                                                                              .isUpVote ==
                                                                          false) {
                                                                    snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            pos]
                                                                        .rankCount = snapshot
                                                                            .data
                                                                            .data
                                                                            .data[pos]
                                                                            .rankCount +
                                                                        1;
                                                                  } else {
                                                                    snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            pos]
                                                                        .rankCount = snapshot
                                                                            .data
                                                                            .data
                                                                            .data[pos]
                                                                            .rankCount +
                                                                        2;
                                                                  }

                                                                  snapshot
                                                                      .data
                                                                      .data
                                                                      .data[pos]
                                                                      .isUpVote = true;
                                                                  snapshot
                                                                      .data
                                                                      .data
                                                                      .data[pos]
                                                                      .isDownVote = false;

                                                                  if (snapshot
                                                                          .data
                                                                          .data
                                                                          .data[
                                                                              pos]
                                                                          .rankCount ==
                                                                      -1) {
                                                                    snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            pos]
                                                                        .isUpVote = true;
                                                                    snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            pos]
                                                                        .isDownVote = false;
                                                                    snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            pos]
                                                                        .rankCount = snapshot
                                                                            .data
                                                                            .data
                                                                            .data[pos]
                                                                            .rankCount +
                                                                        2;
                                                                    bloc2.rankComments(
                                                                        snapshot
                                                                            .data
                                                                            .data
                                                                            .data[
                                                                                pos]
                                                                            .id,
                                                                        snapshot
                                                                            .data
                                                                            .data
                                                                            .data[pos]
                                                                            .caseId,
                                                                        '1');
                                                                  } else {
                                                                    snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            pos]
                                                                        .isUpVote = true;
                                                                    snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            pos]
                                                                        .isDownVote = false;
                                                                    snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            pos]
                                                                        .rankCount = snapshot
                                                                            .data
                                                                            .data
                                                                            .data[pos]
                                                                            .rankCount +
                                                                        1;
                                                                    bloc2.rankComments(
                                                                        snapshot
                                                                            .data
                                                                            .data
                                                                            .data[
                                                                                pos]
                                                                            .id,
                                                                        snapshot
                                                                            .data
                                                                            .data
                                                                            .data[pos]
                                                                            .caseId,
                                                                        '1');
                                                                  }
                                                                });
                                                                bloc2.rankComments(
                                                                    snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            pos]
                                                                        .id,
                                                                    snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            pos]
                                                                        .caseId,
                                                                    '1');
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 10, 10, 10),
                                              child: Divider(
                                                height: 1,
                                                color: Colors.grey,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 0, top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              height: 55,
                              padding: const EdgeInsets.only(
                                  left: 0, right: 0, bottom: 0, top: 0),
                              child: TextField(
                                controller: _txtCtrl,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(2000),
                                ],
                                maxLines: 300,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 2, right: 0, bottom: 15),
                                    child: InkWell(
                                      onTap: () {
                                        _openFileExplorer();
                                      },
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image.asset(
                                              'assets/images/commentDoc.png',
                                              width: 30,
                                              height: 30),
                                        ),
                                      ),
                                    ),
                                  ),
                                  hintText: "Enter a comment...",
                                  hintStyle: const TextStyle(fontSize: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(16),
                                  fillColor: CustColors.LightRose,
                                ),
                              ),
                            ),
                          ],
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            child: SizedBox(
                              height: 45,
                              width: 45,
                              child: Image.asset(
                                  'assets/images/chat_send_icon.png'),
                            ),
                            onTap: () {
                              if (firstButtonClick == true) {
                                setState(() {
                                  firstButtonClick = false;
                                });
                                if (bloc2.caseStatus == '4') {
                                  setState(() {
                                    firstButtonClick = true;
                                  });
                                  toastMsg('This Case is already rejected');
                                } else if (bloc2.caseStatus == '2') {
                                  setState(() {
                                    firstButtonClick = true;
                                  });
                                  toastMsg('This Case is not accepted');
                                } else {
                                  if (_txtCtrl.text.trim().toString().isEmpty) {
                                    setState(() {
                                      firstButtonClick = true;
                                    });
                                    toastMsg("Enter Comment");
                                  } else if (_txtCtrl.text.length > 300) {
                                    setState(() {
                                      firstButtonClick = true;
                                    });
                                    toastMsg(
                                        "Comment Greater than 300 Characters not allowed");
                                  } else {
                                    var newList = _galleryImagePathList;
                                    List<bool> isFilesizeValid = [];
                                    List<bool> videofilesincluded = [];
                                    bool isValidFiles = true;
                                    print(newList);
                                    if (newList.isEmpty) {
                                      setState(() {
                                        visible = true;
                                      });
                                      bloc1.updateDocuments(
                                          _txtCtrl.text.toString(),
                                          _galleryImagePathList,
                                          widget.caseId);
                                    } else {
                                      if (newList.length > 10) {
                                        setState(() {
                                          firstButtonClick = true;
                                        });
                                        toastMsg(
                                            "More than 10 Files Can't be Upload");
                                      } else {
                                        for (int i = 0;
                                            i < newList.length;
                                            i++) {
                                          var completePath =
                                              (newList[i].toString());
                                          var fileNameExtension =
                                              (completePath.split('.').last);
                                          final f = File(newList[i]);
                                          int sizeInBytes = f.lengthSync();
                                          double sizeInMb =
                                              sizeInBytes / (1024 * 1024);

                                          if (sizeInMb > 100) {
                                            setState(() {
                                              firstButtonClick = true;
                                            });
                                            toastMsg(
                                                'Greater than 100Mb not supported');
                                          } else if (fileNameExtension ==
                                                  "mp4" ||
                                              fileNameExtension == "MP4") {
                                            videofilesincluded.add(true);
                                            VideoPlayerController ctlVideo;
                                            ctlVideo = VideoPlayerController
                                                .file(
                                                    File(newList[i].toString()))
                                              ..initialize().then((_) {
                                                print(durationFromV);
                                                // Get Video Duration in Milliseconds
                                                durationFromV = ctlVideo
                                                    .value.duration.inMinutes;
                                                print(
                                                    'durationFromV$durationFromV');

                                                if (durationFromV >= 3) {
                                                  isFilesizeValid.add(false);
                                                } else {
                                                  isFilesizeValid.add(true);
                                                }
                                                print(isFilesizeValid);
                                                print(videofilesincluded);

                                                if (isFilesizeValid.length ==
                                                    videofilesincluded.length) {
                                                  for (var element
                                                      in isFilesizeValid) {
                                                    print('element  $element');
                                                    if (element == false) {
                                                      isValidFiles = false;
                                                    }
                                                  }
                                                  if (isValidFiles == false) {
                                                    setState(() {
                                                      _galleryImagePathList
                                                          .clear();
                                                      newList.clear();
                                                    });
                                                    setState(() {
                                                      firstButtonClick = true;
                                                    });
                                                    toastMsg(
                                                        'Video Duration greater than 3 min cant be upload');
                                                  } else {
                                                    print(
                                                        'file size ok upload hurayyyyyyyyyyyy');
                                                    setState(() {
                                                      visible = true;
                                                    });
                                                    bloc1.updateDocuments(
                                                        _txtCtrl.text
                                                            .toString(),
                                                        _galleryImagePathList,
                                                        widget.caseId);
                                                  }
                                                }
                                              });
                                          }
                                        }
                                        if (videofilesincluded.isEmpty) {
                                          print(
                                              'Files uploaded sucess without video hurayyyyyyyyyyyy');
                                          setState(() {
                                            visible = true;
                                          });
                                          bloc1.updateDocuments(
                                              _txtCtrl.text.toString(),
                                              _galleryImagePathList,
                                              widget.caseId);
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            })
                      ],
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: visible,
                child: Container(
                  color: Colors.white70,
                  child: const Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(CustColors.DarkBlue)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    //);
  }

  Widget PreferredSizeAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        MediaQuery.of(context).size.height * 0.18,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: Column(
            children: [
              SafeArea(
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/bg.png",
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.15,
                      gaplessPlayback: true,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop(null);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 30),
                                child: Image.asset(
                                  "assets/images/back_arrow.png",
                                  width: 20,
                                  height: 17,
                                  gaplessPlayback: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 30.0, top: 30),
                              child: Text("Comments",
                                  style: TextStyle(
                                    color: CustColors.DarkBlue,
                                    fontSize: 18.0,
                                    fontFamily: 'Formular',
                                  )),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
    );
  }

  toastMsg(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 1),
    ));
  }

  void listen() {
    bloc1.addComment.listen((data) {
      if ((data.status == "success")) {
        print(data.message);
        setState(() {
          _txtCtrl.text = '';
          _galleryImagePathList.clear();
          visible = false;
          firstButtonClick = true;
        });
        toastMsg(data.message);

        Future.delayed(const Duration(seconds: 1)).then((_) {
          bloc.getAllComments1(widget.caseId, '0');
        });
      } else if ((data.status == "error")) {
        print(data.message);
        toastMsg(data.message);
        setState(() {
          _txtCtrl.text = '';
          _galleryImagePathList.clear();
          visible = false;
          firstButtonClick = true;
        });
      }
    });
    bloc2.deleteComments.listen((data) {
      if (data != null) {
        if ((data.status == "success")) {
          toastMsg('Deleted successfully');
        } else if ((data.status == "error")) {
          toastMsg('');
        }
      }
    });
    bloc2.blockUsers.listen((data) {
      if (data != null) {
        if ((data.status == "success")) {
          toastMsg('Blocked successfully');
        } else if ((data.status == "error")) {
          toastMsg('');
        }
      }
    });
    bloc2.reportUser.listen((data) {
      if (data != null) {
        if ((data.status == "success")) {
          toastMsg(data.message);
        } else if ((data.status == "error")) {
          toastMsg(data.message);
        }
      }
    });
    bloc2.reportComment.listen((data) {
      if (data != null) {
        if ((data.status == "success")) {
          toastMsg(data.message);
        } else if ((data.status == "error")) {
          toastMsg(data.message);
        }
      }
    });
    bloc2.rankComment.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          toastMsg(data.message);
        });
      } else if ((data.status == "error")) {
        toastMsg(data.message);
      }
    });
    bloc.notificationList.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          visibility = false;
          visible = false;
          model = data;
          if (model.data.data.isNotEmpty) {
            for (int i = 0; i <= model.data.data.length; i++) {
              if (model.data.data[i].rankComment[0].status == 1) {
                model.data.data[i].isUpVote = true;
              } else {
                model.data.data[i].isUpVote = false;
              }
              if (model.data.data[i].rankComment[0].status == 2) {
                model.data.data[i].isDownVote = true;
              } else {
                model.data.data[i].isDownVote = false;
              }
            }
          }
        });
      } else if ((data.status == "error")) {}
    });
    bloc2.details.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          //       visibility = false;
          visible = false;
          _caseDetailsModel = CaseDetailsModel();
          _caseDetailsModel = data;
          //       caseTitle = _caseDetailsModel.data.usersRef.caseTitle;
          //       caseDescription = _caseDetailsModel.data.usersRef.caseDescription;
          //       Category = _caseDetailsModel.data.usersRef.caseCategory;
          //       createdAt = _caseDetailsModel.data.usersRef.createdAt
          //           .toString()
          //           .substring(0, 10);
          //       name = _caseDetailsModel.data.usersRef.users.displayName;

          //       if (caseDescription.length > 50) {
          //         firstHalf = caseDescription.substring(0, 50);
          //         secondHalf = caseDescription.substring(50, caseDescription.length);
          //       } else {
          //         firstHalf = caseDescription;
          //         secondHalf = "";
          //       }
          //     });
          //   } else if ((data.status == "error")) {
          //     setState(() {
          //       // visible = false;
        });
        //     print("error ");
        //     String msg = data.message;
        //     toastMsg(msg);
        if (_caseDetailsModel.data.usersRef.coreGroup.isNotEmpty) {
          for (int i = 0;
              i <= _caseDetailsModel.data.usersRef.coreGroup.length;
              i++) {
            if (_caseDetailsModel.data.usersRef.coreGroup[i].userId
                    .toString() ==
                id) {
              if (_caseDetailsModel.data.usersRef.coreGroup[i].status == 1) {
                coreMember = true;
                if (_caseDetailsModel.data.usersRef.coreGroup[i].isAdmin == 1) {
                  isAdmin = true;
                }
              } else {
                coreMember = false;
              }
            }
          }
        }
      }
    });
  }

  ProgressBarDarkBlue() {}

  Widget noDataFound() {
    return SingleChildScrollView(
      child: Container(
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.68,
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/no_comments.png',
                  width: 100,
                  height: 100,
                  color: CustColors.DarkBlue,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text('No Comments Found',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                          color: Colors.blueGrey)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ProgressBarLightRose() {
    return const SizedBox(
      height: 60.0,
      child: Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(CustColors.Radio),
      )),
    );
  }

  setProfileName(name) {
    String text = name.substring(0, 1);
    return CircularProfileAvatar(
      '',
      radius: 100, // sets radius, default 50.0
      backgroundColor:
          Colors.transparent, // sets background color, default Colors.white
      borderWidth: 10, // sets border, default 0.0
      initialsText: Text(
        text.toUpperCase(),
        style: const TextStyle(fontSize: 15, color: Colors.white),
      ), // sets initials text, set your own style, default Text('')
      borderColor:
          CustColors.DarkBlue, // sets border color, default Colors.white
      elevation:
          5.0, // sets elevation (shadow of the profile picture), default value is 0.0
      //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
      cacheImage: true, // allow widget to cache image against provided url
      onTap: () {
        print('adil');
      }, // sets on tap
      showInitialTextAbovePicture:
          true, // setting it true will show initials text above profile picture, default false
    );
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userTypeId = prefs.getString(SharedPrefKey.USER_TYPE);
    id = prefs.getString(SharedPrefKey.USER_ID);
  }

  Widget displayProfilePic(String displayName) {
    String text = displayName.substring(0, 1);
    return CircularProfileAvatar(
      '',
      radius: 100, // sets radius, default 50.0
      backgroundColor:
          Colors.transparent, // sets background color, default Colors.white
      borderWidth: 10, // sets border, default 0.0
      initialsText: Text(
        text.toUpperCase(),
        style: const TextStyle(fontSize: 15, color: Colors.white),
      ), // sets initials text, set your own style, default Text('')
      borderColor:
          CustColors.DarkBlue, // sets border color, default Colors.white
      elevation:
          5.0, // sets elevation (shadow of the profile picture), default value is 0.0
      //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
      cacheImage: true, // allow widget to cache image against provided url
      onTap: () {
        print('adil');
      }, // sets on tap
      showInitialTextAbovePicture:
          true, // setting it true will show initials text above profile picture, default false
    );
  }

  launchURL(String link) async {
    final urlLink = Uri.encodeFull(link);
    if (await canLaunch(urlLink)) {
      await launch(urlLink);
    } else {
      throw 'Could not launch $urlLink';
    }
  }

  void _openFileExplorer() async {
    setState(() => isLoadingPath = true);
    try {
      paths = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc', 'mp4'],
      );
      print(paths);
      for (int i = 0; i < paths.count; i++) {
        _galleryImagePathList.add(paths.paths.toList()[i].toString());
        print(_galleryImagePathList);
      }
      count = _galleryImagePathList.length;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      isLoadingPath = false;
      fileName = paths != null ? paths.paths.toString() : '...';
    });
  }
}
