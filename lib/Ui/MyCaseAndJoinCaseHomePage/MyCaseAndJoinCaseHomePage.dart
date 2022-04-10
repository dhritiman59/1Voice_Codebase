import 'package:auto_size_text/auto_size_text.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/styles.dart';
import 'package:bring2book/Models/MyCaseAndJoinCaseModel/JoinedCasesModel.dart';
import 'package:bring2book/Models/MyCaseAndJoinCaseModel/MyCasesModel.dart';
import 'package:bring2book/Ui/AddCase/AddCaseCategoryPage.dart';
import 'package:bring2book/Ui/CaseDetails/CaseDetailsBloc.dart';
import 'package:bring2book/Ui/CaseDetails/CaseDetailsPage.dart';
import 'package:bring2book/Ui/EditCase/EditCaseUi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:share/share.dart';

import 'MyCaseAndJoinCaseHomeBloc.dart';
import 'package:bring2book/Ui/HomePage/CountryStateFilterPage.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

import 'package:cached_network_image/cached_network_image.dart';

class MyCaseAndJoinCaseHomePage extends StatefulWidget {
  MyCaseAndJoinCaseHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyCaseAndJoinCaseHomePageState createState() =>
      _MyCaseAndJoinCaseHomePageState();
}

class _MyCaseAndJoinCaseHomePageState extends State<MyCaseAndJoinCaseHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  MyCaseAndJoinCaseHomeBloc _myCaseAndJoinCaseHomeBloc =
      MyCaseAndJoinCaseHomeBloc();

  Color myCasebBgColor = CustColors.DarkBlue;
  Color myCasebTextColor = Colors.white;
  Color joinedCasebBgColor = Colors.white;
  Color joinedCasebTextColor = CustColors.DarkBlue;
  String mycasejoincasestatus = "1";
  JoinedCasesModel joinedCasesModel = JoinedCasesModel();
  CaseDetailsBloc caseDetailsBloc = CaseDetailsBloc();
  var currentIndex = 0;
  var caseid = "";
  String Join = 'Join';
  String Joinicon = 'assets/images/join_grey_icon.png';

  String bannerImage = 'assets/images/casedetailsHuman.png';

  bool isLoadingMyCases = false;
  bool isLoadingJoinedCases = false;

  bool visibleErrorMyCases = false;
  bool visibleErrorJoinedCases = false;

  TextEditingController _searchTextMyCase = new TextEditingController();
  TextEditingController _searchTextJoinedCase = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _myCaseAndJoinCaseHomeBloc.MyCasesAPI(page: "0");
    _myCaseAndJoinCaseHomeBloc.JoinedCasesAPI(page: "0");
    print('initcall');

    listenApi();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 2,
          child: new Scaffold(
            key: _scaffoldKey,
            backgroundColor: CustColors.DarkBlue,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                MediaQuery.of(context).size.height * 0.30,
              ),
              child: new AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: CustColors.DarkBlue,
                elevation: 0,
                brightness: Brightness.dark,
                flexibleSpace: SafeArea(
                  child: Container(
                    color: Colors.white,
                    child: new Column(
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              "assets/images/forgotbgnew.png",
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.19,
                              gaplessPlayback: true,
                              fit: BoxFit.fill,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: Text(
                                'Cases',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: Styles.casesBoldBlue,
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: new TabBar(
                            indicatorPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            indicatorColor: Colors.transparent,
                            isScrollable: true,
                            onTap: (index) {
                              print(index);
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            tabs: [
                              Container(
                                  width: 120,
                                  height: 40,
                                  child: currentIndex == 0
                                      ? Container(
                                          decoration: BoxDecoration(
                                              color: CustColors.DarkBlue,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Center(
                                              child: Text(
                                            "My Cases",
                                            style: Styles.textBoldwhite18,
                                          )),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Center(
                                              child: Text(
                                            "My Cases",
                                            style: Styles.textHeadNormalBlue13,
                                          )),
                                        )),
                              Container(
                                  width: 120,
                                  height: 40,
                                  child: currentIndex == 1
                                      ? Container(
                                          decoration: BoxDecoration(
                                              color: CustColors.DarkBlue,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Center(
                                              child: Text(
                                            "Joined Cases",
                                            style: Styles.textBoldwhite18,
                                          )),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Center(
                                              child: Text(
                                            "Joined Cases",
                                            style: Styles.textHeadNormalBlue13,
                                          )),
                                        )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body:
                TabBarView(physics: NeverScrollableScrollPhysics(), children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                      child: Container(
                        decoration: BoxDecoration(
                            color: CustColors.LightRose,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                width: double.infinity,
                                child: TextFormField(
                                  onChanged: (text) {
                                    if (text == "") {
                                      setState(() {
                                        visibleErrorMyCases = false;
                                      });
                                      _myCaseAndJoinCaseHomeBloc.MyCasesAPI(
                                          page: "0");
                                    } else if (text.length >= 3) {
                                      setState(() {
                                        visibleErrorMyCases = false;
                                      });
                                      _myCaseAndJoinCaseHomeBloc
                                          .MyCaseSearchAPI(
                                              page: "0", searchTitle: text);
                                    } else {
                                      setState(() {
                                        visibleErrorMyCases = true;
                                      });
                                      //toastMsg('Enter Search Character greater than 3');
                                    }
                                  },
                                  controller: _searchTextMyCase,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search",
                                  ),
                                ),
                              ),
                            ),
                            _searchTextMyCase.text != ""
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          visibleErrorMyCases = false;
                                          _searchTextMyCase.text = "";
                                          _myCaseAndJoinCaseHomeBloc.MyCasesAPI(
                                              page: "0");
                                        });
                                      },
                                      child: Container(
                                        width: 30,
                                        child: Image.asset(
                                            'assets/images/closeSearch.png',
                                            width: 30,
                                            height: 30),
                                      ),
                                    ),
                                  )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Container(
                                width: 20,
                                child: Image.asset(
                                    'assets/images/rosesearch.png',
                                    width: 20,
                                    height: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    visibleErrorMyCases == true
                        ? Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text(
                                  "Atleast 3 Characters Required",
                                  textAlign: TextAlign.left,
                                  style: Styles.errorSearchNamesBlue,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    Flexible(
                      child: StreamBuilder(
                          stream: _myCaseAndJoinCaseHomeBloc
                              .myCaseDetailsRespStream,
                          builder:
                              (context, AsyncSnapshot<MyCasesModel> snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                snapshot.connectionState ==
                                    ConnectionState.none) {
                              return Center(child: ProgressBarDarkBlue());
                            } else if (snapshot.hasData ||
                                snapshot.data.data.data.length != 0) {
                              if (snapshot.data.status == 'error') {
                                return noDataFound();
                              } else if (snapshot.data.data.data.length == 0) {
                                return noDataFound();
                              }
                            } else {
                              return Center(child: ProgressBarDarkBlue());
                            }
                            return NotificationListener(
                              // ignore: missing_return
                              onNotification: (ScrollNotification scrollInfo) {
                                if (!_myCaseAndJoinCaseHomeBloc
                                        .paginationLoading &&
                                    scrollInfo.metrics.pixels ==
                                        scrollInfo.metrics.maxScrollExtent) {
                                  // start loading data
                                  if (snapshot.data.data.currentPage <
                                      snapshot.data.data.totalPages) {
                                    final page =
                                        snapshot.data.data.currentPage + 1;
                                    setState(() {
                                      isLoadingMyCases = true;
                                    });
                                    _myCaseAndJoinCaseHomeBloc.MyCasesAPI(
                                        page: page.toString());
                                  }
                                }
                              },

                              child: RefreshIndicator(
                                color: CustColors.DarkBlue,
                                onRefresh: _pullRefresh,
                                child: ListView.builder(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.data.data.length,
                                  itemBuilder: (context, index) {
                                    if (snapshot.data.data.data[index]
                                            .caseDocument.length !=
                                        0) {
                                      print("insideCasedoc");
                                      if (snapshot.data.data.data[index]
                                                  .caseDocument[0].docType ==
                                              "image/jpeg" ||
                                          snapshot.data.data.data[index]
                                                  .caseDocument[0].docType ==
                                              "image/jpg" ||
                                          snapshot.data.data.data[index]
                                                  .caseDocument[0].docType ==
                                              "image/png") {
                                        print("image/jpeg");
                                        snapshot.data.data.data[index]
                                                .caseNetworkImage =
                                            snapshot.data.data.data[index]
                                                .caseDocument[0].caseDocument
                                                .toString();
                                        snapshot.data.data.data[index]
                                            .bannerImage = '';
                                        snapshot.data.data.data[index]
                                            .caseVideoImage = '';
                                      } else if (snapshot.data.data.data[index]
                                                  .caseDocument[0].docType ==
                                              "video/mp4" ||
                                          snapshot.data.data.data[index]
                                                  .caseDocument[0].docType ==
                                              "video/mov") {
                                        print("video/mp4");
                                        snapshot.data.data.data[index]
                                                .caseVideoImage =
                                            snapshot.data.data.data[index]
                                                .caseDocument[0].caseDocument
                                                .toString();
                                        snapshot.data.data.data[index]
                                            .caseNetworkImage = '';
                                        if (snapshot.data.data.data[index]
                                                .caseCategory
                                                .toString() ==
                                            'Human trafficking') {
                                          snapshot.data.data.data[index]
                                                  .bannerImage =
                                              'assets/images/casedetailsHuman.png';
                                        } else if (snapshot.data.data
                                                .data[index].caseCategory
                                                .toString() ==
                                            'Corruption') {
                                          snapshot.data.data.data[index]
                                                  .bannerImage =
                                              'assets/images/caseDetailCorruptionBanner.png';
                                        } else if (snapshot.data.data
                                                .data[index].caseCategory
                                                .toString() ==
                                            'Environment abusing') {
                                          snapshot.data.data.data[index]
                                                  .bannerImage =
                                              'assets/images/caseDetailEvabsu.png';
                                        } else {
                                          snapshot.data.data.data[index]
                                                  .bannerImage =
                                              'assets/images/casedetailsHuman.png';
                                        }
                                      } else {
                                        if (snapshot.data.data.data[index]
                                                .caseCategory
                                                .toString() ==
                                            'Human trafficking') {
                                          snapshot.data.data.data[index]
                                                  .bannerImage =
                                              'assets/images/casedetailsHuman.png';
                                          snapshot.data.data.data[index]
                                              .caseNetworkImage = "";
                                          snapshot.data.data.data[index]
                                              .caseVideoImage = "";
                                        } else if (snapshot.data.data
                                                .data[index].caseCategory
                                                .toString() ==
                                            'Corruption') {
                                          snapshot.data.data.data[index]
                                                  .bannerImage =
                                              'assets/images/caseDetailCorruptionBanner.png';
                                          snapshot.data.data.data[index]
                                              .caseNetworkImage = "";
                                          snapshot.data.data.data[index]
                                              .caseVideoImage = "";
                                        } else if (snapshot.data.data
                                                .data[index].caseCategory
                                                .toString() ==
                                            'Environment abusing') {
                                          snapshot.data.data.data[index]
                                                  .bannerImage =
                                              'assets/images/caseDetailEvabsu.png';
                                          snapshot.data.data.data[index]
                                              .caseNetworkImage = "";
                                          snapshot.data.data.data[index]
                                              .caseVideoImage = '';
                                        } else {
                                          snapshot.data.data.data[index]
                                              .caseNetworkImage = "";
                                          snapshot.data.data.data[index]
                                              .caseVideoImage = "";
                                          snapshot.data.data.data[index]
                                                  .bannerImage =
                                              'assets/images/casedetailsHuman.png';
                                        }
                                      }
                                    } else {
                                      print("outsideCasedoc");
                                      if (snapshot.data.data.data[index]
                                              .caseCategory
                                              .toString() ==
                                          'Human trafficking') {
                                        snapshot.data.data.data[index]
                                                .bannerImage =
                                            'assets/images/casedetailsHuman.png';
                                        snapshot.data.data.data[index]
                                            .caseNetworkImage = "";
                                        snapshot.data.data.data[index]
                                            .caseVideoImage = "";
                                      } else if (snapshot.data.data.data[index]
                                              .caseCategory
                                              .toString() ==
                                          'Corruption') {
                                        snapshot.data.data.data[index]
                                                .bannerImage =
                                            'assets/images/caseDetailCorruptionBanner.png';
                                        snapshot.data.data.data[index]
                                            .caseNetworkImage = "";
                                        snapshot.data.data.data[index]
                                            .caseVideoImage = "";
                                      } else if (snapshot.data.data.data[index]
                                              .caseCategory
                                              .toString() ==
                                          'Environment abusing') {
                                        snapshot.data.data.data[index]
                                                .bannerImage =
                                            'assets/images/caseDetailEvabsu.png';
                                        snapshot.data.data.data[index]
                                            .caseNetworkImage = "";
                                        snapshot.data.data.data[index]
                                            .caseVideoImage = "";
                                      } else {
                                        snapshot.data.data.data[index]
                                            .caseNetworkImage = "";
                                        snapshot.data.data.data[index]
                                            .caseVideoImage = "";
                                        snapshot.data.data.data[index]
                                                .bannerImage =
                                            'assets/images/casedetailsHuman.png';
                                      }
                                    }

                                    var postedbyName;
                                    var timeconvert = _myCaseAndJoinCaseHomeBloc
                                        .dateconvert(snapshot
                                            .data.data.data[index].createdAt
                                            .toString());

                                    if (snapshot.data.data.data[index]
                                                .userProfile.aliasName !=
                                            null &&
                                        snapshot.data.data.data[index]
                                                .userProfile.aliasFlag ==
                                            1) {
                                      postedbyName =
                                          '${snapshot.data.data.data[index].userProfile.aliasName}';
                                    } else {
                                      postedbyName =
                                          '${snapshot.data.data.data[index].users.displayName}';
                                    }

                                    return ListTile(
                                      onTap: () {
                                        /// Navigate To CaseDetails
                                        var caseid =
                                            snapshot.data.data.data[index].id;
                                        var userid = snapshot
                                            .data.data.data[index].userId;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CaseDetailsPage(
                                                      caseId: caseid.toString(),
                                                      userId: userid,
                                                      caseNetworkImage: snapshot
                                                          .data
                                                          .data
                                                          .data[index]
                                                          .caseNetworkImage,
                                                      bannerImage: snapshot
                                                          .data
                                                          .data
                                                          .data[index]
                                                          .bannerImage,
                                                      caseVideoImage: snapshot
                                                          .data
                                                          .data
                                                          .data[index]
                                                          .caseVideoImage,
                                                    )));
                                      },
                                      /*trailing: PopupMenuButton<String>(
                                            padding: EdgeInsets.zero,
                                            offset: const Offset(0, 40),
                                            icon: Icon(Icons.more_vert),
                                            onSelected: (result) async {
                                              switch (result) {
                                                case 'Delete':
                                                  print('index$index');
                                                  _myCaseAndJoinCaseHomeBloc.deleteMyCase(snapshot.data.data.data[index].id.toString());
                                                  setState(() {
                                                    snapshot.data.data.data.removeAt(index);
                                                  });
                                                  print('click Delete');
                                                  break;
                                                case 'Edit':
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => EditCase(snapshot.data.data.data[index].id.toString())));
                                                  break;
                                              }
                                            },
                                            itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry<String>>[
                                              const PopupMenuItem<String>(
                                                  value: 'Delete',
                                                  child: ListTile(
                                                      title: Text('Delete'))),
                                              const PopupMenuItem<String>(
                                                  value: 'Edit',
                                                  child: ListTile(
                                                      title: Text('Edit'))),
                                            ],
                                          ),*/
                                      title: Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Stack(
                                                children: [
                                                  Container(
                                                      child: snapshot
                                                                  .data
                                                                  .data
                                                                  .data[index]
                                                                  .bannerImage !=
                                                              ""
                                                          ? Container(
                                                              height: 250,
                                                              width: double
                                                                  .infinity,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          5.0),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  color: Colors
                                                                      .red),
                                                              child: Image.asset(
                                                                  snapshot
                                                                      .data
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .bannerImage,
                                                                  fit: BoxFit
                                                                      .cover))
                                                          : CachedNetworkImage(
                                                              imageUrl: snapshot
                                                                  .data
                                                                  .data
                                                                  .data[index]
                                                                  .caseNetworkImage,
                                                              imageBuilder:
                                                                  (context,
                                                                          imageProvider) =>
                                                                      Container(
                                                                height: 250,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  image: DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .cover),
                                                                ),
                                                              ),
                                                              //placeholder: (context, url) => ProgressBarLightRose(),
                                                            )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .bottomEnd,
                                                      child: Container(
                                                        width: 20,
                                                        height: 20,
                                                        child: snapshot
                                                                    .data
                                                                    .data
                                                                    .data[index]
                                                                    .caseTypeFlag ==
                                                                1
                                                            ? Container(
                                                                child:
                                                                    CircleAvatar(
                                                                        radius:
                                                                            18,
                                                                        backgroundColor:
                                                                            Colors
                                                                                .white,
                                                                        child:
                                                                            ClipOval(
                                                                          child:
                                                                              Image.asset(
                                                                            'assets/images/public_icon.png',
                                                                          ),
                                                                        )),
                                                              )
                                                            : Container(
                                                                child:
                                                                    CircleAvatar(
                                                                        radius:
                                                                            18,
                                                                        backgroundColor:
                                                                            Colors
                                                                                .white,
                                                                        child:
                                                                            ClipOval(
                                                                          child:
                                                                              Image.asset(
                                                                            'assets/images/privateIcon.png',
                                                                          ),
                                                                        )),
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .topStart,
                                                    child: Container(
                                                      width: 100,
                                                      height: 100,
                                                      child: snapshot
                                                                  .data
                                                                  .data
                                                                  .data[index]
                                                                  .featuredFlag ==
                                                              2
                                                          ? Container(
                                                              width: 100,
                                                              height: 100,
                                                              child: ClipRRect(
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/featured1.png',
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 0, 0, 0),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: Text(
                                                            '${snapshot.data.data.data[index].caseTitle}',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            softWrap: false,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18.0),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: Text(
                                                            'Posted by $postedbyName  $timeconvert',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            softWrap: false,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 13.0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                PopupMenuButton<String>(
                                                  padding: EdgeInsets.zero,
                                                  offset: const Offset(0, 40),
                                                  icon: Icon(Icons.more_vert),
                                                  onSelected: (result) async {
                                                    switch (result) {
                                                      case 'Delete':
                                                        print('index$index');
                                                        _myCaseAndJoinCaseHomeBloc
                                                            .deleteMyCase(
                                                                snapshot
                                                                    .data
                                                                    .data
                                                                    .data[index]
                                                                    .id
                                                                    .toString());
                                                        setState(() {
                                                          snapshot
                                                              .data.data.data
                                                              .removeAt(index);
                                                        });
                                                        print('click Delete');
                                                        break;
                                                      case 'Edit':
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    EditCase(snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .id
                                                                        .toString())));
                                                        break;
                                                    }
                                                  },
                                                  itemBuilder: (BuildContext
                                                          context) =>
                                                      <PopupMenuEntry<String>>[
                                                    const PopupMenuItem<String>(
                                                        value: 'Delete',
                                                        child: ListTile(
                                                            title: Text(
                                                                'Delete'))),
                                                    const PopupMenuItem<String>(
                                                        value: 'Edit',
                                                        child: ListTile(
                                                            title:
                                                                Text('Edit'))),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 10, 10, 10),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: AutoSizeText(
                                                  '${snapshot.data.data.data[index].caseDescription}',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  minFontSize: 15,
                                                  stepGranularity: 1,
                                                  maxLines: 4,
                                                  textAlign: TextAlign.justify,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
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
                                                            child: Image.asset(
                                                                'assets/images/vote_down_icon.png',
                                                                width: 16,
                                                                height: 16),
                                                            onTap: () {
                                                              print("share");
                                                            },
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(10, 0,
                                                                    10, 0),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child:
                                                                  AutoSizeText(
                                                                '${snapshot.data.data.data[index].rankCount}',
                                                                style: TextStyle(
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
                                                            child: Image.asset(
                                                                'assets/images/vote_up_icon.png',
                                                                width: 16,
                                                                height: 16),
                                                            onTap: () {
                                                              print("up");
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 0, 0),
                                                      alignment:
                                                          Alignment.center,
                                                      width: double.infinity,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(10, 0,
                                                                    0, 0),
                                                            child: InkWell(
                                                              child: Image.asset(
                                                                  'assets/images/commenticonsmall.png',
                                                                  width: 17,
                                                                  height: 17),
                                                              onTap: () {
                                                                print(
                                                                    "commenticonsmall");
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(10, 0,
                                                                    0, 0),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child:
                                                                  AutoSizeText(
                                                                '${snapshot.data.data.data[index].commentCount}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blueGrey,
                                                                    fontSize:
                                                                        10),
                                                                minFontSize: 10,
                                                                maxLines: 1,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: InkWell(
                                                      onTap: () {

                                                        showDialog(context: context,
                                                            builder: (BuildContext context){
                                                              return  AlertDialog(
                                                                title: new Text(
                                                                    "Share Case"),
                                                                content: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                      InkWell(
                                                                        child: Image.asset(
                                                                            'assets/images/mobile-phone.png',
                                                                            width:
                                                                            70,
                                                                            height:
                                                                            70),
                                                                        onTap:
                                                                            () {
                                                                          caseDetailsBloc.shareCase(snapshot
                                                                              .data
                                                                              .data
                                                                              .data[index]
                                                                              .id
                                                                              .toString());

                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                      InkWell(
                                                                        child: Image.asset(
                                                                            'assets/images/social-media.png',
                                                                            width:
                                                                            70,
                                                                            height:
                                                                            70),
                                                                        onTap:
                                                                            () {
                                                                          final RenderBox
                                                                          box =
                                                                          _scaffoldKey.currentContext.findRenderObject();

                                                                          Share.share(
                                                                              "1 VOICES" +
                                                                                  "                                            " +
                                                                                  "                                            " +
                                                                                  snapshot.data.data.data[index].caseTitle +
                                                                                  " Visit: " +
                                                                                  "https://www.1voices.com/cases/${snapshot.data.data.data[index].id}",
                                                                              subject: "                                            " + snapshot.data.data.data[index].caseTitle + "                                            " + snapshot.data.data.data[index].caseDescription,
                                                                              sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);

                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              );
                                                            }
                                                        );

                                                        /*showDialog(
                                                            context: context,
                                                            child:
                                                                new AlertDialog(
                                                              title: new Text(
                                                                  "Share Case"),
                                                              content: Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        InkWell(
                                                                      child: Image.asset(
                                                                          'assets/images/mobile-phone.png',
                                                                          width:
                                                                              70,
                                                                          height:
                                                                              70),
                                                                      onTap:
                                                                          () {
                                                                        caseDetailsBloc.shareCase(snapshot
                                                                            .data
                                                                            .data
                                                                            .data[index]
                                                                            .id
                                                                            .toString());

                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        InkWell(
                                                                      child: Image.asset(
                                                                          'assets/images/social-media.png',
                                                                          width:
                                                                              70,
                                                                          height:
                                                                              70),
                                                                      onTap:
                                                                          () {
                                                                        final RenderBox
                                                                            box =
                                                                            _scaffoldKey.currentContext.findRenderObject();

                                                                        Share.share(
                                                                            "1 VOICES" +
                                                                                "                                            " +
                                                                                "                                            " +
                                                                                snapshot.data.data.data[index].caseTitle +
                                                                                " Visit: " +
                                                                                "https://www.1voices.com/cases/${snapshot.data.data.data[index].id}",
                                                                            subject: "                                            " + snapshot.data.data.data[index].caseTitle + "                                            " + snapshot.data.data.data[index].caseDescription,
                                                                            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);

                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ));*/
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: double.infinity,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              child: Image.asset(
                                                                  'assets/images/shareiconsmall.png',
                                                                  width: 18,
                                                                  height: 18),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    AutoSizeText(
                                                                  'Share',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blueGrey,
                                                                      fontSize:
                                                                          10),
                                                                  minFontSize:
                                                                      10,
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
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
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
                                      // onTap: () =>pubDetails(snapshot.data.data[index]),
                                    );
                                  },
                                ),
                              ),
                            );
                          }),
                    ),
                    isLoadingMyCases
                        ? Center(
                            child: ProgressBarLightRose(),
                          )
                        : Container(),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                      child: Container(
                        decoration: BoxDecoration(
                            color: CustColors.LightRose,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                width: double.infinity,
                                child: TextFormField(
                                  controller: _searchTextJoinedCase,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search",
                                  ),
                                  onChanged: (text) {
                                    if (text == "") {
                                      setState(() {
                                        visibleErrorJoinedCases = false;
                                      });
                                      _myCaseAndJoinCaseHomeBloc.JoinedCasesAPI(
                                          page: "0");
                                    } else if (text.length >= 3) {
                                      setState(() {
                                        visibleErrorJoinedCases = false;
                                      });
                                      _myCaseAndJoinCaseHomeBloc
                                          .JoinedCaseSearchAPI(
                                              page: "0", searchTitle: text);
                                    } else {
                                      setState(() {
                                        visibleErrorJoinedCases = true;
                                      });
                                      //toastMsg('Enter Search Character greater than 3');
                                    }
                                  },
                                ),
                              ),
                            ),
                            _searchTextJoinedCase.text != ""
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          visibleErrorJoinedCases = false;
                                          _searchTextJoinedCase.text = "";
                                          _myCaseAndJoinCaseHomeBloc
                                              .JoinedCasesAPI(page: "0");
                                        });
                                      },
                                      child: Container(
                                        width: 30,
                                        child: Image.asset(
                                            'assets/images/closeSearch.png',
                                            width: 30,
                                            height: 30),
                                      ),
                                    ),
                                  )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Container(
                                width: 20,
                                child: Image.asset(
                                    'assets/images/rosesearch.png',
                                    width: 20,
                                    height: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    visibleErrorJoinedCases == true
                        ? Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text(
                                  "Atleast 3 Characters Required",
                                  textAlign: TextAlign.left,
                                  style: Styles.errorSearchNamesBlue,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    Flexible(
                      child: StreamBuilder(
                          stream: _myCaseAndJoinCaseHomeBloc
                              .joinCaseDetailsRespStream,
                          builder: (context,
                              AsyncSnapshot<JoinedCasesModel> snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                snapshot.connectionState ==
                                    ConnectionState.none) {
                              return Center(child: ProgressBarDarkBlue());
                            } else if (snapshot.hasData) {
                              if (snapshot.data.status == 'error') {
                                return noDataFound();
                              } else if (snapshot.data.data.data.length == 0) {
                                return noDataFound();
                              } else {}
                            } else {
                              return Center(child: ProgressBarDarkBlue());
                            }
                            return NotificationListener(
                              // ignore: missing_return
                              onNotification: (ScrollNotification scrollInfo) {
                                if (!_myCaseAndJoinCaseHomeBloc
                                        .paginationLoading &&
                                    scrollInfo.metrics.pixels ==
                                        scrollInfo.metrics.maxScrollExtent) {
                                  // start loading data
                                  if (snapshot.data.data.currentPage <
                                      snapshot.data.data.totalPages) {
                                    final page =
                                        snapshot.data.data.currentPage + 1;
                                    setState(() {
                                      isLoadingJoinedCases = true;
                                    });
                                    _myCaseAndJoinCaseHomeBloc.JoinedCasesAPI(
                                        page: page.toString());
                                  }
                                }
                              },

                              child: RefreshIndicator(
                                color: CustColors.DarkBlue,
                                onRefresh: _pullRefresh,
                                child: ListView.builder(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.data.data.length,
                                  itemBuilder: (context, index) {
                                    print("gggggggggggggg");
                                    print(snapshot.data.data.data[index]
                                        .userCase.caseDocument);
                                    print("bbbbbbbbb");
                                    if (snapshot.data.data.data[index].userCase
                                            .caseDocument !=
                                        null) {
                                      if (snapshot.data.data.data[index]
                                              .userCase.caseDocument.length !=
                                          0) {
                                        print("insideCasedoc");
                                        if (snapshot
                                                    .data
                                                    .data
                                                    .data[index]
                                                    .userCase
                                                    .caseDocument[0]
                                                    .docType ==
                                                "image/jpeg" ||
                                            snapshot
                                                    .data
                                                    .data
                                                    .data[index]
                                                    .userCase
                                                    .caseDocument[0]
                                                    .docType ==
                                                "image/jpg" ||
                                            snapshot
                                                    .data
                                                    .data
                                                    .data[index]
                                                    .userCase
                                                    .caseDocument[0]
                                                    .docType ==
                                                "image/png") {
                                          print("image/jpeg");
                                          snapshot.data.data.data[index]
                                                  .userCase.caseNetworkImage =
                                              snapshot
                                                  .data
                                                  .data
                                                  .data[index]
                                                  .userCase
                                                  .caseDocument[0]
                                                  .caseDocument
                                                  .toString();
                                          snapshot.data.data.data[index]
                                              .userCase.bannerImage = '';
                                          snapshot.data.data.data[index]
                                              .userCase.caseVideoImage = '';
                                        } else if (snapshot
                                                    .data
                                                    .data
                                                    .data[index]
                                                    .userCase
                                                    .caseDocument[0]
                                                    .docType ==
                                                "video/mp4" ||
                                            snapshot
                                                    .data
                                                    .data
                                                    .data[index]
                                                    .userCase
                                                    .caseDocument[0]
                                                    .docType ==
                                                "video/mov") {
                                          print("video/mp4");
                                          snapshot.data.data.data[index]
                                                  .userCase.caseVideoImage =
                                              snapshot
                                                  .data
                                                  .data
                                                  .data[index]
                                                  .userCase
                                                  .caseDocument[0]
                                                  .caseDocument
                                                  .toString();
                                          snapshot.data.data.data[index]
                                              .userCase.caseNetworkImage = '';
                                          if (snapshot.data.data.data[index]
                                                  .userCase.caseCategory
                                                  .toString() ==
                                              'Human trafficking') {
                                            bannerImage =
                                                'assets/images/casedetailsHuman.png';
                                            snapshot.data.data.data[index]
                                                    .userCase.bannerImage =
                                                'assets/images/casedetailsHuman.png';
                                          } else if (snapshot
                                                  .data
                                                  .data
                                                  .data[index]
                                                  .userCase
                                                  .caseCategory
                                                  .toString() ==
                                              'Corruption') {
                                            bannerImage =
                                                'assets/images/caseDetailCorruptionBanner.png';
                                            snapshot.data.data.data[index]
                                                    .userCase.bannerImage =
                                                'assets/images/caseDetailCorruptionBanner.png';
                                          } else if (snapshot
                                                  .data
                                                  .data
                                                  .data[index]
                                                  .userCase
                                                  .caseCategory
                                                  .toString() ==
                                              'Environment abusing') {
                                            bannerImage =
                                                'assets/images/caseDetailEvabsu.png';
                                            snapshot.data.data.data[index]
                                                    .userCase.bannerImage =
                                                'assets/images/caseDetailEvabsu.png';
                                          } else {
                                            bannerImage =
                                                'assets/images/casedetailsHuman.png';
                                            snapshot.data.data.data[index]
                                                    .userCase.bannerImage =
                                                'assets/images/casedetailsHuman.png';
                                          }
                                        } else {
                                          if (snapshot.data.data.data[index]
                                                  .userCase.caseCategory
                                                  .toString() ==
                                              'Human trafficking') {
                                            snapshot.data.data.data[index]
                                                    .userCase.bannerImage =
                                                'assets/images/casedetailsHuman.png';
                                            snapshot.data.data.data[index]
                                                .userCase.caseNetworkImage = "";
                                            snapshot.data.data.data[index]
                                                .userCase.caseVideoImage = "";
                                          } else if (snapshot
                                                  .data
                                                  .data
                                                  .data[index]
                                                  .userCase
                                                  .caseCategory
                                                  .toString() ==
                                              'Corruption') {
                                            snapshot.data.data.data[index]
                                                    .userCase.bannerImage =
                                                'assets/images/caseDetailCorruptionBanner.png';
                                            snapshot.data.data.data[index]
                                                .userCase.caseNetworkImage = "";
                                            snapshot.data.data.data[index]
                                                .userCase.caseVideoImage = "";
                                          } else if (snapshot
                                                  .data
                                                  .data
                                                  .data[index]
                                                  .userCase
                                                  .caseCategory
                                                  .toString() ==
                                              'Environment abusing') {
                                            snapshot.data.data.data[index]
                                                    .userCase.bannerImage =
                                                'assets/images/caseDetailEvabsu.png';
                                            snapshot.data.data.data[index]
                                                .userCase.caseNetworkImage = "";
                                            snapshot.data.data.data[index]
                                                .userCase.caseVideoImage = '';
                                          } else {
                                            snapshot.data.data.data[index]
                                                .userCase.caseNetworkImage = "";
                                            snapshot.data.data.data[index]
                                                .userCase.caseVideoImage = "";
                                            snapshot.data.data.data[index]
                                                    .userCase.bannerImage =
                                                'assets/images/casedetailsHuman.png';
                                          }
                                        }
                                      }
                                    } else {
                                      print("outsideCasedoc");
                                      if (snapshot.data.data.data[index]
                                              .userCase.caseCategory
                                              .toString() ==
                                          'Human trafficking') {
                                        snapshot.data.data.data[index].userCase
                                                .bannerImage =
                                            'assets/images/casedetailsHuman.png';
                                        snapshot.data.data.data[index].userCase
                                            .caseNetworkImage = "";
                                        snapshot.data.data.data[index].userCase
                                            .caseVideoImage = "";
                                      } else if (snapshot.data.data.data[index]
                                              .userCase.caseCategory
                                              .toString() ==
                                          'Corruption') {
                                        snapshot.data.data.data[index].userCase
                                                .bannerImage =
                                            'assets/images/caseDetailCorruptionBanner.png';
                                        snapshot.data.data.data[index].userCase
                                            .caseNetworkImage = "";
                                        snapshot.data.data.data[index].userCase
                                            .caseVideoImage = "";
                                      } else if (snapshot.data.data.data[index]
                                              .userCase.caseCategory
                                              .toString() ==
                                          'Environment abusing') {
                                        snapshot.data.data.data[index].userCase
                                                .bannerImage =
                                            'assets/images/caseDetailEvabsu.png';
                                        snapshot.data.data.data[index].userCase
                                            .caseNetworkImage = "";
                                        snapshot.data.data.data[index].userCase
                                            .caseVideoImage = "";
                                      } else {
                                        snapshot.data.data.data[index].userCase
                                            .caseNetworkImage = "";
                                        snapshot.data.data.data[index].userCase
                                            .caseVideoImage = "";
                                        snapshot.data.data.data[index].userCase
                                                .bannerImage =
                                            'assets/images/casedetailsHuman.png';
                                      }
                                    }

                                    /*if (snapshot.data.data.data[index].userCase.caseCategory.toString() == 'Human trafficking')
                                        {
                                          bannerImage = 'assets/images/casedetailsHuman.png';
                                          snapshot.data.data.data[index].userCase.bannerImage = 'assets/images/casedetailsHuman.png';
                                        } else if (snapshot.data.data.data[index].userCase.caseCategory.toString() == 'Corruption')
                                        {
                                          bannerImage = 'assets/images/caseDetailCorruptionBanner.png';
                                          snapshot.data.data.data[index].userCase.bannerImage = 'assets/images/caseDetailCorruptionBanner.png';

                                        } else if (snapshot.data.data.data[index].userCase.caseCategory.toString() == 'Environment abusing')
                                        {
                                          bannerImage = 'assets/images/caseDetailEvabsu.png';
                                          snapshot.data.data.data[index].userCase.bannerImage = 'assets/images/caseDetailEvabsu.png';

                                        } else
                                        {
                                          bannerImage = 'assets/images/casedetailsHuman.png';
                                          snapshot.data.data.data[index].userCase.bannerImage = 'assets/images/casedetailsHuman.png';

                                        }
                                        print(bannerImage);
                                        print(snapshot.data.data.data[index].userCase.bannerImage.toString());*/

                                    if (index >
                                        snapshot.data.data.data.length) {
                                      //pagination loader
                                      return Container(
                                        padding: EdgeInsets.only(bottom: 8),
                                        child: snapshot.data.data.currentPage <
                                                snapshot.data.data.totalPages
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : Container(),
                                      );
                                    }
                                    var postedbyName;
                                    var timeconvert = _myCaseAndJoinCaseHomeBloc
                                        .dateconvert(snapshot
                                            .data.data.data[index].createdAt
                                            .toString());

                                    if (snapshot.data.data.data[index].userCase
                                                .userProfile.aliasName !=
                                            null &&
                                        snapshot.data.data.data[index].userCase
                                                .userProfile.aliasFlag ==
                                            1) {
                                      postedbyName =
                                          '${snapshot.data.data.data[index].userCase.userProfile.aliasName}';
                                    } else {
                                      postedbyName =
                                          '${snapshot.data.data.data[index].userCase.users.displayName}';
                                    }

                                    return ListTile(
                                      onTap: () {
                                        /// Navigate To CaseDetails
                                        var caseid = snapshot
                                            .data.data.data[index].userCase.id;
                                        var userid = snapshot
                                            .data.data.data[index].userId;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CaseDetailsPage(
                                                      caseId: caseid.toString(),
                                                      userId: userid,
                                                      caseNetworkImage: snapshot
                                                          .data
                                                          .data
                                                          .data[index]
                                                          .userCase
                                                          .caseNetworkImage,
                                                      bannerImage: snapshot
                                                          .data
                                                          .data
                                                          .data[index]
                                                          .userCase
                                                          .bannerImage,
                                                      caseVideoImage: snapshot
                                                          .data
                                                          .data
                                                          .data[index]
                                                          .userCase
                                                          .caseVideoImage,
                                                    )));
                                      },
                                      title: Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Stack(
                                                children: [
                                                  Container(
                                                      child: snapshot
                                                                  .data
                                                                  .data
                                                                  .data[index]
                                                                  .userCase
                                                                  .bannerImage !=
                                                              ""
                                                          ? Container(
                                                              height: 250,
                                                              width: double
                                                                  .infinity,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          5.0),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  color: Colors
                                                                      .red),
                                                              child: Image.asset(
                                                                  snapshot
                                                                      .data
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .userCase
                                                                      .bannerImage,
                                                                  fit: BoxFit
                                                                      .cover))
                                                          : CachedNetworkImage(
                                                              imageUrl: snapshot
                                                                  .data
                                                                  .data
                                                                  .data[index]
                                                                  .userCase
                                                                  .caseNetworkImage,
                                                              imageBuilder:
                                                                  (context,
                                                                          imageProvider) =>
                                                                      Container(
                                                                height: 250,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  image: DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .cover),
                                                                ),
                                                              ),
                                                              //placeholder: (context, url) => ProgressBarLightRose(),
                                                            )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .bottomEnd,
                                                      child: Container(
                                                        width: 20,
                                                        height: 20,
                                                        child: snapshot
                                                                    .data
                                                                    .data
                                                                    .data[index]
                                                                    .userCase
                                                                    .caseTypeFlag ==
                                                                1
                                                            ? Container(
                                                                child:
                                                                    CircleAvatar(
                                                                        radius:
                                                                            18,
                                                                        backgroundColor:
                                                                            Colors
                                                                                .white,
                                                                        child:
                                                                            ClipOval(
                                                                          child:
                                                                              Image.asset(
                                                                            'assets/images/public_icon.png',
                                                                          ),
                                                                        )),
                                                              )
                                                            : Container(
                                                                child:
                                                                    CircleAvatar(
                                                                        radius:
                                                                            18,
                                                                        backgroundColor:
                                                                            Colors
                                                                                .white,
                                                                        child:
                                                                            ClipOval(
                                                                          child:
                                                                              Image.asset(
                                                                            'assets/images/privateIcon.png',
                                                                          ),
                                                                        )),
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .topStart,
                                                    child: Container(
                                                      width: 100,
                                                      height: 100,
                                                      child: snapshot
                                                                  .data
                                                                  .data
                                                                  .data[index]
                                                                  .userCase
                                                                  .featuredFlag ==
                                                              2
                                                          ? Container(
                                                              width: 100,
                                                              height: 100,
                                                              child: ClipRRect(
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/featured1.png',
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                /* Flexible(
                                                      flex: 1,
                                                      child:Container(
                                                        width: 40.0,
                                                        height: 40.0,
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                                width: 40.0,
                                                                height: 40.0,
                                                                child:
                                                                snapshot.data.data.data[index].userCase.bannerImage!=""
                                                                    ? Container(
                                                                  width: 40.0,
                                                                  height: 40.0,
                                                                  child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(20.0),
                                                                      child: CircleAvatar(radius: 50,
                                                                          backgroundColor: Colors.white,
                                                                          child: ClipOval(
                                                                            child: Image.asset(snapshot.data.data.data[index].userCase.bannerImage,),))
                                                                  ),
                                                                )
                                                                    : CachedNetworkImage(
                                                                  imageUrl:snapshot.data.data.data[index].userCase.caseNetworkImage,
                                                                  imageBuilder: (context, imageProvider) => Container(
                                                                    width: 40.0,
                                                                    height: 40.0,
                                                                    decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      image: DecorationImage(
                                                                          image: imageProvider, fit: BoxFit.cover),
                                                                    ),
                                                                  ),
                                                                  placeholder: (context, url) =>  Container(
                                                                    width: 40.0,
                                                                    height: 40.0,
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(20.0),
                                                                        child: CircleAvatar(radius: 50,
                                                                            backgroundColor: Colors.white,
                                                                            child: ClipOval(
                                                                              child: Image.asset(snapshot.data.data.data[index].userCase.bannerImage,),))
                                                                    ),
                                                                  ),
                                                                )
                                                            ),
                                                            */ /*Container(
                                                              width: 40.0,
                                                              height: 40.0,
                                                              child:
                                                              bannerImage!=""
                                                                  ? Container(
                                                                width: 40.0,
                                                                height: 40.0,
                                                                child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(20.0),
                                                                    child: CircleAvatar(radius: 50,
                                                                        backgroundColor: Colors.white,
                                                                        child: ClipOval(
                                                                          child: Image.asset(bannerImage,),))
                                                                ),
                                                              )
                                                                  : ClipRRect(
                                                                borderRadius: BorderRadius.circular(20.0),
                                                                child: displayProfilePic(snapshot.data.data.data[index].userCase.caseTitle.toString()),
                                                              ),
                                                            ),*/ /*
                                                            Align(
                                                              alignment: AlignmentDirectional.bottomEnd,
                                                              child: Container(width: 20,height: 20,
                                                                child: snapshot.data.data.data[index].userCase.caseTypeFlag==1? CircleAvatar(
                                                                    radius: 18,
                                                                    backgroundColor:
                                                                    Colors.white,
                                                                    child: ClipOval(
                                                                      child: Image.asset(
                                                                        'assets/images/public_icon.png',
                                                                      ),
                                                                    )): CircleAvatar(
                                                                    radius: 18,
                                                                    backgroundColor:
                                                                    Colors.white,
                                                                    child: ClipOval(
                                                                      child: Image.asset(
                                                                        'assets/images/privateIcon.png',
                                                                      ),
                                                                    )),),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),*/
                                                Flexible(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 0, 0, 0),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: Text(
                                                            '${snapshot.data.data.data[index].userCase.caseTitle}',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            softWrap: false,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18.0),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: Text(
                                                            'Posted by $postedbyName  $timeconvert',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            softWrap: false,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 12.0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 10, 10, 10),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: AutoSizeText(
                                                  '${snapshot.data.data.data[index].userCase.caseDescription}',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  minFontSize: 15,
                                                  stepGranularity: 1,
                                                  maxLines: 4,
                                                  textAlign: TextAlign.justify,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
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
                                                            child: joinedCasesModel
                                                                    .data
                                                                    .data[index]
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
                                                              if (joinedCasesModel
                                                                  .data
                                                                  .data[index]
                                                                  .isDownVote) {
                                                                toastMsg(
                                                                    'Already Ranked');
                                                              } else {
                                                                setState(() {
                                                                  if (joinedCasesModel
                                                                              .data
                                                                              .data[
                                                                                  index]
                                                                              .isDownVote ==
                                                                          false &&
                                                                      joinedCasesModel
                                                                              .data
                                                                              .data[index]
                                                                              .isUpVote ==
                                                                          false) {
                                                                    joinedCasesModel
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .userCase
                                                                        .rankCount = joinedCasesModel
                                                                            .data
                                                                            .data[index]
                                                                            .userCase
                                                                            .rankCount -
                                                                        1;
                                                                  } else {
                                                                    joinedCasesModel
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .userCase
                                                                        .rankCount = joinedCasesModel
                                                                            .data
                                                                            .data[index]
                                                                            .userCase
                                                                            .rankCount -
                                                                        2;
                                                                  }

                                                                  joinedCasesModel
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .isDownVote = true;
                                                                  joinedCasesModel
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .isUpVote = false;

                                                                  /*  joinedCasesModel.data.data[index].userCase.rankCount =
                                                                          joinedCasesModel.data.data[index].userCase.rankCount - 1;*/
                                                                });
                                                                caseDetailsBloc
                                                                    .rankDown(
                                                                  joinedCasesModel
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .userCase
                                                                      .id
                                                                      .toString(),
                                                                );
                                                              }
                                                            },
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(10, 0,
                                                                    10, 0),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child:
                                                                  AutoSizeText(
                                                                '${joinedCasesModel.data.data[index].userCase.rankCount}',
                                                                style: TextStyle(
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
                                                            child: joinedCasesModel
                                                                    .data
                                                                    .data[index]
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
                                                              if (joinedCasesModel
                                                                  .data
                                                                  .data[index]
                                                                  .isUpVote) {
                                                                toastMsg(
                                                                    'Already Ranked');
                                                              } else {
                                                                setState(() {
                                                                  if (joinedCasesModel
                                                                              .data
                                                                              .data[
                                                                                  index]
                                                                              .isDownVote ==
                                                                          false &&
                                                                      joinedCasesModel
                                                                              .data
                                                                              .data[index]
                                                                              .isUpVote ==
                                                                          false) {
                                                                    joinedCasesModel
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .userCase
                                                                        .rankCount = joinedCasesModel
                                                                            .data
                                                                            .data[index]
                                                                            .userCase
                                                                            .rankCount +
                                                                        1;
                                                                  } else {
                                                                    joinedCasesModel
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .userCase
                                                                        .rankCount = joinedCasesModel
                                                                            .data
                                                                            .data[index]
                                                                            .userCase
                                                                            .rankCount +
                                                                        2;
                                                                  }
                                                                  joinedCasesModel
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .isUpVote = true;
                                                                  joinedCasesModel
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .isDownVote = false;

                                                                  /* if(joinedCasesModel.data.data[index].userCase.rankCount==-1)
                                                                      {
                                                                        joinedCasesModel.data.data[index].userCase.rankCount =
                                                                            joinedCasesModel.data.data[index].userCase.rankCount + 2;
                                                                        joinedCasesModel.data.data[index].isUpVote = true;
                                                                        joinedCasesModel.data.data[index].isDownVote = false;
                                                                      }
                                                                      else
                                                                        {
                                                                          joinedCasesModel.data.data[index].userCase.rankCount =
                                                                              joinedCasesModel.data.data[index].userCase.rankCount + 1;
                                                                          joinedCasesModel.data.data[index].isUpVote = true;
                                                                          joinedCasesModel.data.data[index].isDownVote = false;
                                                                        }*/
                                                                });
                                                                caseDetailsBloc.rankUp(
                                                                    joinedCasesModel
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .userCase
                                                                        .id
                                                                        .toString());
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 0, 0),
                                                      alignment:
                                                          Alignment.center,
                                                      width: double.infinity,
                                                      child: InkWell(
                                                        onTap: () {
                                                          /// Navigate To CaseDetails
                                                          var caseid =
                                                              joinedCasesModel
                                                                  .data
                                                                  .data[index]
                                                                  .userCase
                                                                  .id;
                                                          var userid =
                                                              joinedCasesModel
                                                                  .data
                                                                  .data[index]
                                                                  .userId;
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          CaseDetailsPage(
                                                                            caseId:
                                                                                caseid.toString(),
                                                                            userId:
                                                                                userid,
                                                                            caseNetworkImage:
                                                                                snapshot.data.data.data[index].userCase.caseNetworkImage,
                                                                            bannerImage:
                                                                                snapshot.data.data.data[index].userCase.bannerImage,
                                                                            caseVideoImage:
                                                                                snapshot.data.data.data[index].userCase.caseVideoImage,
                                                                          )));
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              child: Image.asset(
                                                                  'assets/images/commenticonsmall.png',
                                                                  width: 17,
                                                                  height: 17),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    AutoSizeText(
                                                                  '${joinedCasesModel.data.data[index].userCase.commentCount}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blueGrey,
                                                                      fontSize:
                                                                          10),
                                                                  minFontSize:
                                                                      10,
                                                                  maxLines: 1,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: InkWell(
                                                      onTap: () {

                                                        showDialog(context: context,
                                                            builder: (BuildContext context){
                                                              return  AlertDialog(
                                                                title: new Text(
                                                                    "Share Case"),
                                                                content: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                      InkWell(
                                                                        child: Image.asset(
                                                                            'assets/images/mobile-phone.png',
                                                                            width:
                                                                            70,
                                                                            height:
                                                                            70),
                                                                        onTap:
                                                                            () {
                                                                          caseDetailsBloc.shareCase(joinedCasesModel
                                                                              .data
                                                                              .data[index]
                                                                              .userCase
                                                                              .id
                                                                              .toString());

                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                      InkWell(
                                                                        child: Image.asset(
                                                                            'assets/images/social-media.png',
                                                                            width:
                                                                            70,
                                                                            height:
                                                                            70),
                                                                        onTap:
                                                                            () {
                                                                          final RenderBox
                                                                          box =
                                                                          _scaffoldKey.currentContext.findRenderObject();
                                                                          // imagePaths.add(_caseDetailsModel.data.image[0].caseDocument);
                                                                          // if (imagePaths.isEmpty) {

                                                                          /* await Share.shareFiles(imagePaths,
          text: 'text',
          subject: 'subject',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);*/
                                                                          Share.share(
                                                                              "1 VOICES" +
                                                                                  "                                            " +
                                                                                  "                                            " +
                                                                                  joinedCasesModel.data.data[index].userCase.caseTitle +
                                                                                  " Visit: " +
                                                                                  "https://www.1voices.com/cases/${joinedCasesModel.data.data[index].userCase.id}",
                                                                              subject: "                                            " + joinedCasesModel.data.data[index].userCase.caseTitle + "                                            " + joinedCasesModel.data.data[index].userCase.caseDescription,
                                                                              sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
                                                                          // }
                                                                          /*else {

    }*/
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              );
                                                            }
                                                        );

                                                        /*showDialog(
                                                            context: context,
                                                            child:
                                                                new AlertDialog(
                                                              title: new Text(
                                                                  "Share Case"),
                                                              content: Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        InkWell(
                                                                      child: Image.asset(
                                                                          'assets/images/mobile-phone.png',
                                                                          width:
                                                                              70,
                                                                          height:
                                                                              70),
                                                                      onTap:
                                                                          () {
                                                                        caseDetailsBloc.shareCase(joinedCasesModel
                                                                            .data
                                                                            .data[index]
                                                                            .userCase
                                                                            .id
                                                                            .toString());

                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        InkWell(
                                                                      child: Image.asset(
                                                                          'assets/images/social-media.png',
                                                                          width:
                                                                              70,
                                                                          height:
                                                                              70),
                                                                      onTap:
                                                                          () {
                                                                        final RenderBox
                                                                            box =
                                                                            _scaffoldKey.currentContext.findRenderObject();
                                                                        // imagePaths.add(_caseDetailsModel.data.image[0].caseDocument);
                                                                        // if (imagePaths.isEmpty) {

                                                                        *//* await Share.shareFiles(imagePaths,
          text: 'text',
          subject: 'subject',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);*//*
                                                                        Share.share(
                                                                            "1 VOICES" +
                                                                                "                                            " +
                                                                                "                                            " +
                                                                                joinedCasesModel.data.data[index].userCase.caseTitle +
                                                                                " Visit: " +
                                                                                "https://www.1voices.com/cases/${joinedCasesModel.data.data[index].userCase.id}",
                                                                            subject: "                                            " + joinedCasesModel.data.data[index].userCase.caseTitle + "                                            " + joinedCasesModel.data.data[index].userCase.caseDescription,
                                                                            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
                                                                        // }
                                                                        *//*else {

    }*//*
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ));*/
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: double.infinity,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              child: Image.asset(
                                                                  'assets/images/shareiconsmall.png',
                                                                  width: 18,
                                                                  height: 18),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    AutoSizeText(
                                                                  'Share',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blueGrey,
                                                                      fontSize:
                                                                          10),
                                                                  minFontSize:
                                                                      10,
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
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  /*Expanded(
                                                  flex: 1,
                                                  child: InkWell(
                                                    onTap: () {

                                                      /// Navigate To CaseDetails
                                                      var caseid =joinedCasesModel.data.data[index].userCase.id;
                                                      var userid =
                                                          joinedCasesModel.data.data[index].userId;
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => CaseDetailsPage(
                                                                caseId: caseid.toString(),
                                                                userId: userid,
                                                              )));
                                                    },
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      width: double.infinity,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.fromLTRB(
                                                                10, 0, 0, 0),
                                                            child: InkWell(
                                                              child: Image.asset(
                                                                  Joinicon,
                                                                  width: 18,
                                                                  height: 18),
                                                              onTap: () {

                                                                Join = "leave";
                                                                setState(() {
                                                                  //  Join = 'assets/images/leave_case.png';
                                                                });
                                                                print("join_grey_icon");
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.fromLTRB(
                                                                10, 0, 0, 0),
                                                            child: Align(
                                                              alignment:
                                                              Alignment.center,
                                                              child: AutoSizeText(
                                                                Join,
                                                                style: TextStyle(
                                                                    color:
                                                                    Colors.blueGrey,
                                                                    fontSize: 10),
                                                                minFontSize: 10,
                                                                maxLines: 1,
                                                                textAlign:
                                                                TextAlign.start,
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )*/
                                                ],
                                              ),
                                            ),
                                            Padding(
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
                                      // onTap: () =>pubDetails(snapshot.data.data[index]),
                                    );
                                  },
                                ),
                              ),
                            );
                          }),
                    ),
                    isLoadingJoinedCases
                        ? Center(
                            child: ProgressBarLightRose(),
                          )
                        : Container(),
                  ],
                ),
              ),
            ]),
          ),
        ),
        // Align(
        //   alignment: Alignment.bottomRight,
        //   child: InkWell(
        //     child: Container(
        //         width: 110,
        //         height: 110,
        //         child: Image.asset('assets/images/add_case_icon.png',
        //             width: 110, height: 110)),
        //     onTap: () {
        //       /// Navigate to Add A Case Page

        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => AddCaseCategoryPage()));
        //     },
        //   ),
        // ),
      ],
    );
  }

  void toastMsg(String s) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(s),
      duration: Duration(seconds: 1),
    ));
  }

  Widget noDataFound() {
    return SingleChildScrollView(
      child: Container(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/caseimagedummy.png',
                    width: 250, height: 250),
                Text('No Data Found',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w200,
                        fontSize: 14,
                        color: Colors.blueGrey))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ProgressBarDarkBlue() {
    return Container(
      height: 60.0,
      child: new Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(CustColors.DarkBlue),
      )),
    );
  }

  Widget ProgressBarLightRose() {
    return Container(
      height: 60.0,
      child: new Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(CustColors.Radio),
      )),
    );
  }

  void listenApi() {
    caseDetailsBloc.shareStream.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          toastMsg(data.message);
        });
      } else if ((data.status == "error")) {
        toastMsg(data.message);
      }
    });
    caseDetailsBloc.rankCaseDown.listen((data) {
      if ((data.status == "success")) {
        toastMsg(data.message);
      } else if ((data.status == "error")) {
        print("${data.status}");
      }
    });
    caseDetailsBloc.rankDownCase.listen((data) {
      if ((data.status == "success")) {
        toastMsg(data.message);
      } else if ((data.status == "error")) {
        print("${data.status}");
      }
    });
    _myCaseAndJoinCaseHomeBloc.myCaseDetailsRespStream.listen((data) {
      if ((data.status == "success")) {
        print(" ${data.status}");
        setState(() {
          isLoadingMyCases = false;
        });
      } else if ((data.status == "error")) {
        print("${data.status}");
        setState(() {
          isLoadingMyCases = false;
        });
      }
    });
    _myCaseAndJoinCaseHomeBloc.joinCaseDetailsRespStream.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          isLoadingJoinedCases = false;
        });
        joinedCasesModel = data;
        if (joinedCasesModel.data.data.length != 0) {
          for (int i = 0; i <= joinedCasesModel.data.data.length; i++) {
            if (joinedCasesModel.data.data[i].userCase.rankCase.length != 0) {
              if (joinedCasesModel.data.data[i].userCase.rankCase[0].status ==
                  1) {
                joinedCasesModel.data.data[i].isUpVote = true;
              } else {
                joinedCasesModel.data.data[i].isUpVote = false;
              }
              if (joinedCasesModel.data.data[i].userCase.rankCase[0].status ==
                  2) {
                joinedCasesModel.data.data[i].isDownVote = true;
              } else {
                joinedCasesModel.data.data[i].isDownVote = false;
              }
            }
          }
        }
        print(" ${data.status}");
      } else if ((data.status == "error")) {
        setState(() {
          isLoadingJoinedCases = false;
        });
        print("${data.status}");
      }
    });
    _myCaseAndJoinCaseHomeBloc.deleteMyCaseRespStream.listen((data) {
      if ((data.status == "success")) {
        print(" ${data.status}");
      } else if ((data.status == "error")) {
        print("${data.status}");
      }
    });
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
        style: TextStyle(fontSize: 15, color: Colors.white),
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

  Future<void> _pullRefresh() async {
    setState(() {
      _myCaseAndJoinCaseHomeBloc.MyCasesAPI(page: "0");
      _myCaseAndJoinCaseHomeBloc.JoinedCasesAPI(page: "0");
    });
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
  }
}
