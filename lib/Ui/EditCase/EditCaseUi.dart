import 'package:bring2book/Models/EditCaseModel/EditCaseModel.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:bring2book/Constants/CheckInternet.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/styles.dart';
import 'package:bring2book/Ui/AddCase/AddCaseBloc.dart';
import 'package:bring2book/Ui/EditCase/EditCaseBloc.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bring2book/Models/CountryListModel/CountryListModel.dart';
import 'package:bring2book/Models/StateListModel/StateListModel.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'package:bring2book/Ui/LandingPage/MainLandingPage.dart';

class EditCase extends StatefulWidget {
  String caseId;
  EditCase(this.caseId);

  @override
  _EditCaseState createState() => _EditCaseState(caseId);
}

class _EditCaseState extends State<EditCase> {
  List<Images> images;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AddCaseBloc _addCaseBloc = AddCaseBloc();
  final EditCaseBloc _editCaseBloc = EditCaseBloc();

  final CheckInternet _checkInternet = CheckInternet();
  bool visible = true;
  bool visiblePublic = true;
  bool visiblePrivate = false;
  bool visibleActiveButton = true;
  bool visibileDocuments = true;
  String caseId = "";

  int charLength = 0;

  bool viewDoc = false;

  TextEditingController caseTitle = TextEditingController();
  TextEditingController caseDescription = TextEditingController();

  TextEditingController CountryCase = TextEditingController();
  TextEditingController StateCase = TextEditingController();

  String countryId = '';

  String fileName;
  FilePickerResult paths;
  Map<String, String> docpaths;
  Map<String, String> mergedArrayOfFiles;
  final List<String> _galleryDocPathList = [];
  List<String> extensions;
  bool isLoadingPath = false;
  bool isLoadingImagePath = false;
  FileType fileType;
  var durationFromV;

  Color publicColor = CustColors.DarkBlue;
  Color publicbTextColor = Colors.white;
  Color privateCasebBgColor = Colors.white;
  Color privateCasebTextColor = CustColors.DarkBlue;
  String publicPrivatecasestatus = "1";
  String publicPrivatecasename = "Human trafficking";
  String human_trafficiking_icon = 'assets/images/public_human_active.png';
  String corruption_icon = 'assets/images/public_curroption_inactive.png';
  String environmental_icon = 'assets/images/public_environment_inactive.png';
  String others_icon = 'assets/images/others_inactive.png';

  StateSetter mycountry1, mystate1;

  bool isLoadingCountry = false;
  bool isLoadingState = false;

  bool firstButtonClick = true;

  _EditCaseState(String caseId);

  @override
  void initState() {
    super.initState();
    _editCaseBloc.getCaseDetails(widget.caseId);
    _addCaseBloc.CountryListAPI(page: "0", searchTitle: '');
    listen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.all(0),
            child: Stack(
              children: [
                ListView(children: <Widget>[
                  Stack(
                    children: [
                      Image.asset(
                        "assets/images/forgotbgnew.png",
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.15,
                        gaplessPlayback: true,
                        fit: BoxFit.fill,
                      ),
                      Row(
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
                            child: Text("Edit Case",
                                style: TextStyle(
                                  color: CustColors.DarkBlue,
                                  fontSize: 18.0,
                                  fontFamily: 'Formular',
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: CasesFlatButtonWidget(
                                  height: 40,
                                  width: 120,
                                  backgroundColor: publicColor,
                                  buttonText: "Public",
                                  buttonTextColor: publicbTextColor,
                                  onpressed: () {
                                    setState(() {
                                      visiblePublic = true;
                                      visiblePrivate = false;
                                      publicColor = CustColors.DarkBlue;
                                      publicbTextColor = Colors.white;
                                      privateCasebBgColor = Colors.white;
                                      privateCasebTextColor =
                                          CustColors.DarkBlue;
                                      publicPrivatecasestatus = "1";
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: CasesFlatButtonWidget(
                                    height: 40,
                                    width: 130,
                                    backgroundColor: privateCasebBgColor,
                                    buttonText: "Private",
                                    buttonTextColor: privateCasebTextColor,
                                    onpressed: () {
                                      setState(() {
                                        visiblePublic = false;
                                        visiblePrivate = true;
                                        publicColor = Colors.white;
                                        publicbTextColor = CustColors.DarkBlue;
                                        privateCasebBgColor =
                                            CustColors.DarkBlue;
                                        privateCasebTextColor = Colors.white;

                                        publicPrivatecasestatus = "2";
                                        publicPrivatecasename =
                                            "Human trafficking";
                                        print(
                                            'publicPrivatecasestatus$publicPrivatecasestatus publicPrivatecasename$publicPrivatecasename');
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          child: Stack(
                            children: [
                              Visibility(
                                visible: visiblePublic,
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                    human_trafficiking_icon,
                                                    width: 70,
                                                    height: 70),
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 10, 0, 5),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: AutoSizeText(
                                                      'Human trafficking',
                                                      style: Styles
                                                          .addCaseCategoryNamesBlue,
                                                      minFontSize: 10,
                                                      stepGranularity: 10,
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              human_trafficiking_icon =
                                                  'assets/images/public_human_active.png';
                                              corruption_icon =
                                                  'assets/images/public_curroption_inactive.png';
                                              environmental_icon =
                                                  'assets/images/public_environment_inactive.png';
                                              others_icon =
                                                  'assets/images/others_inactive.png';
                                              publicPrivatecasestatus = "1";
                                              publicPrivatecasename =
                                                  "Human trafficking";
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                Image.asset(corruption_icon,
                                                    width: 70, height: 70),
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 10, 0, 5),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: AutoSizeText(
                                                      'Corruption',
                                                      style: Styles
                                                          .addCaseCategoryNamesBlue,
                                                      minFontSize: 10,
                                                      stepGranularity: 10,
                                                      maxLines: 4,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              human_trafficiking_icon =
                                                  'assets/images/public_human_inactive.png';
                                              corruption_icon =
                                                  'assets/images/public_curroption_active.png';
                                              environmental_icon =
                                                  'assets/images/public_environment_inactive.png';
                                              others_icon =
                                                  'assets/images/others_inactive.png';
                                              publicPrivatecasestatus = "1";
                                              publicPrivatecasename =
                                                  "Corruption";
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                Image.asset(environmental_icon,
                                                    width: 70, height: 70),
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 10, 0, 5),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: AutoSizeText(
                                                      'Environment abusing',
                                                      style: Styles
                                                          .addCaseCategoryNamesBlue,
                                                      minFontSize: 10,
                                                      stepGranularity: 10,
                                                      maxLines: 4,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              human_trafficiking_icon =
                                                  'assets/images/public_human_inactive.png';
                                              corruption_icon =
                                                  'assets/images/public_curroption_inactive.png';
                                              environmental_icon =
                                                  'assets/images/public_environment_active.png';
                                              others_icon =
                                                  'assets/images/others_inactive.png';
                                              publicPrivatecasestatus = "1";
                                              publicPrivatecasename =
                                                  "Environment abusing";
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                Image.asset(others_icon,
                                                    width: 70, height: 70),
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 10, 0, 5),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: AutoSizeText(
                                                      'Others',
                                                      style: Styles
                                                          .addCaseCategoryNamesBlue,
                                                      minFontSize: 10,
                                                      stepGranularity: 10,
                                                      maxLines: 4,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              human_trafficiking_icon =
                                                  'assets/images/public_human_inactive.png';
                                              corruption_icon =
                                                  'assets/images/public_curroption_inactive.png';
                                              environmental_icon =
                                                  'assets/images/public_environment_inactive.png';
                                              others_icon =
                                                  'assets/images/others_active.png';
                                              publicPrivatecasestatus = "1";
                                              publicPrivatecasename = "others";
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: visiblePrivate,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 20, 10, 0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                    human_trafficiking_icon,
                                                    width: 70,
                                                    height: 70),
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 10, 0, 5),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: AutoSizeText(
                                                      'Human trafficking',
                                                      style: Styles
                                                          .addCaseCategoryNamesBlue,
                                                      minFontSize: 10,
                                                      stepGranularity: 10,
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              human_trafficiking_icon =
                                                  'assets/images/public_human_active.png';
                                              corruption_icon =
                                                  'assets/images/public_curroption_inactive.png';
                                              environmental_icon =
                                                  'assets/images/public_environment_inactive.png';
                                              others_icon =
                                                  'assets/images/others_inactive.png';
                                              publicPrivatecasestatus = "2";
                                              publicPrivatecasename =
                                                  "Human trafficking";
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                Image.asset(corruption_icon,
                                                    width: 70, height: 70),
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 10, 0, 5),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: AutoSizeText(
                                                      'Corruption',
                                                      style: Styles
                                                          .addCaseCategoryNamesBlue,
                                                      minFontSize: 10,
                                                      stepGranularity: 10,
                                                      maxLines: 4,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              human_trafficiking_icon =
                                                  'assets/images/public_human_inactive.png';
                                              corruption_icon =
                                                  'assets/images/public_curroption_active.png';
                                              environmental_icon =
                                                  'assets/images/public_environment_inactive.png';
                                              others_icon =
                                                  'assets/images/others_inactive.png';
                                              publicPrivatecasestatus = "2";
                                              publicPrivatecasename =
                                                  "Corruption";
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                Image.asset(environmental_icon,
                                                    width: 70, height: 70),
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 10, 0, 5),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: AutoSizeText(
                                                      'Environment abusing',
                                                      style: Styles
                                                          .addCaseCategoryNamesBlue,
                                                      minFontSize: 10,
                                                      stepGranularity: 10,
                                                      maxLines: 4,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              human_trafficiking_icon =
                                                  'assets/images/public_human_inactive.png';
                                              corruption_icon =
                                                  'assets/images/public_curroption_inactive.png';
                                              environmental_icon =
                                                  'assets/images/public_environment_active.png';
                                              others_icon =
                                                  'assets/images/others_inactive.png';
                                              publicPrivatecasestatus = "2";
                                              publicPrivatecasename =
                                                  "Environment abusing";
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                Image.asset(others_icon,
                                                    width: 70, height: 70),
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 10, 0, 5),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: AutoSizeText(
                                                      'Others',
                                                      style: Styles
                                                          .addCaseCategoryNamesBlue,
                                                      minFontSize: 10,
                                                      stepGranularity: 10,
                                                      maxLines: 4,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              human_trafficiking_icon =
                                                  'assets/images/public_human_inactive.png';
                                              corruption_icon =
                                                  'assets/images/public_curroption_inactive.png';
                                              environmental_icon =
                                                  'assets/images/public_environment_inactive.png';
                                              others_icon =
                                                  'assets/images/others_active.png';
                                              publicPrivatecasestatus = "2";
                                              publicPrivatecasename = "others";
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: SizedBox(
                            height: 58,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              reverse: true,
                              child: SizedBox(
                                height: 58.0,
                                child: TextField(
                                  controller: caseTitle,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: CustColors.TextGray,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: CustColors.TextGray,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    hintText: 'Title',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: Container(
                            height: 130,
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
                                    height: 130.0,
                                    child: TextField(
                                      onChanged: _onChanged,
                                      controller: caseDescription,
                                      maxLines: 2000,
                                      decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: CustColors.TextGray,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                            color: CustColors.TextGray,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        hintText: 'Description',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: AutoSizeText(
                              '$charLength of 2000 characters used',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 8),
                              minFontSize: 10,
                              stepGranularity: 1,
                              maxLines: 1,
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Select Country"),
                                    content: StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter mycountry) {
                                      mycountry1 = mycountry;
                                      return SizedBox(
                                        width: double.maxFinite,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 5, 5, 10),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: CustColors.LightRose,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                                width: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 0, 5, 0),
                                                        width: double.infinity,
                                                        child: TextFormField(
                                                          onChanged: (text) {
                                                            _addCaseBloc
                                                                .CountryListAPI(
                                                                    page: '0',
                                                                    searchTitle:
                                                                        text);
                                                          },
                                                          textAlign:
                                                              TextAlign.left,
                                                          decoration:
                                                              const InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText: "Search",
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: SizedBox(
                                                        width: double.infinity,
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
                                            Flexible(
                                              child: StreamBuilder(
                                                  stream: _addCaseBloc
                                                      .countryListStream,
                                                  builder: (context,
                                                      AsyncSnapshot<
                                                              CountryListModel>
                                                          snapshot) {
                                                    if (snapshot.connectionState ==
                                                            ConnectionState
                                                                .waiting ||
                                                        snapshot.connectionState ==
                                                            ConnectionState
                                                                .none) {
                                                      return Center(
                                                          child:
                                                              ProgressBarLightRose());
                                                    } else if (snapshot
                                                            .hasData ||
                                                        snapshot.data.data.data
                                                            .isNotEmpty) {
                                                      if (snapshot
                                                              .data.status ==
                                                          'error') {
                                                        return noDataFound();
                                                      } else if (snapshot.data
                                                          .data.data.isEmpty) {
                                                        return noDataFound();
                                                      }
                                                    } else {
                                                      return Center(
                                                          child:
                                                              ProgressBarDarkBlue());
                                                    }
                                                    return NotificationListener(
                                                      // ignore: missing_return
                                                      onNotification:
                                                          (ScrollNotification
                                                              scrollInfo) {
                                                        if (!_addCaseBloc
                                                                .paginationLoading &&
                                                            scrollInfo.metrics
                                                                    .pixels ==
                                                                scrollInfo
                                                                    .metrics
                                                                    .maxScrollExtent) {
                                                          // start loading data
                                                          if (snapshot.data.data
                                                                  .currentPage <
                                                              snapshot.data.data
                                                                  .totalPages) {
                                                            final page = snapshot
                                                                    .data
                                                                    .data
                                                                    .currentPage +
                                                                1;
                                                            mycountry1(() {
                                                              isLoadingCountry =
                                                                  true;
                                                            });
                                                            _addCaseBloc
                                                                .CountryListAPI(
                                                                    page: page
                                                                        .toString(),
                                                                    searchTitle:
                                                                        '');
                                                          }
                                                        }
                                                      },

                                                      child: ListView.builder(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 0, 0),
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemCount: snapshot.data
                                                            .data.data.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          /*if ((index+1) == snapshot.data.data.data.length ) {//pagination loader
                                                              return Container(
                                                                padding: EdgeInsets.only(bottom: 10),
                                                                child: snapshot.data.data.currentPage +1 < snapshot.data.data.totalPages
                                                                    ? Center(child: ProgressBarDarkBlue(),) :  Container(),
                                                              );
                                                            }*/

                                                          return ListTile(
                                                            onTap: () {
                                                              /// Navigate To CaseDetails
                                                              countryId = snapshot
                                                                  .data
                                                                  .data
                                                                  .data[index]
                                                                  .id
                                                                  .toString();
                                                              var name =
                                                                  snapshot
                                                                      .data
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .name;
                                                              print(countryId);
                                                              print(name);
                                                              _addCaseBloc.StateListAPI(
                                                                  page: "0",
                                                                  searchTitle:
                                                                      '',
                                                                  countryId:
                                                                      countryId
                                                                          .toString());
                                                              setState(() {
                                                                StateCase.text =
                                                                    '';
                                                                CountryCase
                                                                        .text =
                                                                    name;
                                                              });

                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            title: Container(
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            10),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          AutoSizeText(
                                                                        snapshot
                                                                            .data
                                                                            .data
                                                                            .data[index]
                                                                            .name,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 13),
                                                                        minFontSize:
                                                                            10,
                                                                        stepGranularity:
                                                                            1,
                                                                        maxLines:
                                                                            4,
                                                                        textAlign:
                                                                            TextAlign.justify,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            5,
                                                                            3,
                                                                            5,
                                                                            3),
                                                                    child:
                                                                        Divider(
                                                                      height: 1,
                                                                      color: Colors
                                                                          .white54,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            // onTap: () =>pubDetails(snapshot.data.data[index]),
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  }),
                                            ),
                                            isLoadingCountry
                                                ? Center(
                                                    child:
                                                        ProgressBarLightRose(),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      );
                                    }),
                                  );
                                });

                            /*showDialog(
                                  context: context,
                                  child: new AlertDialog(
                                    title: new Text("Select Country"),
                                    content: StatefulBuilder(
                                      builder: (BuildContext context, StateSetter mycountry) {
                                        mycountry1 = mycountry;
                                        return Container(
                                          width: double.maxFinite,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
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
                                                              _addCaseBloc.CountryListAPI( page: '0', searchTitle: text);
                                                            },
                                                            textAlign: TextAlign.left,
                                                            decoration: InputDecoration(
                                                              border: InputBorder.none,
                                                              hintText: "Search",
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          width: double.infinity,
                                                          child: Image.asset('assets/images/rosesearch.png',
                                                              width: 20, height: 20),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: StreamBuilder(
                                                    stream: _addCaseBloc.countryListStream,
                                                    builder: (context, AsyncSnapshot<CountryListModel> snapshot) {
                                                      if (snapshot.connectionState ==
                                                          ConnectionState.waiting ||
                                                          snapshot.connectionState == ConnectionState.none) {
                                                        return Center(child: ProgressBarLightRose());
                                                      } else
                                                      if (snapshot.hasData ||
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
                                                          if (!_addCaseBloc.paginationLoading &&
                                                              scrollInfo.metrics.pixels ==
                                                                  scrollInfo.metrics.maxScrollExtent) {
                                                            // start loading data
                                                            if (snapshot.data.data.currentPage <
                                                                snapshot.data.data.totalPages) {
                                                              final page = snapshot.data.data.currentPage + 1;
                                                              mycountry1(() {
                                                                isLoadingCountry = true;
                                                              });
                                                              _addCaseBloc.CountryListAPI( page: page.toString(), searchTitle: '');
                                                            }
                                                          }
                                                        },

                                                        child: ListView.builder(
                                                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                          scrollDirection: Axis.vertical,
                                                          shrinkWrap: true,
                                                          itemCount: snapshot.data.data.data.length,
                                                          itemBuilder: (context, index) {
                                                            */ /*if ((index+1) == snapshot.data.data.data.length ) {//pagination loader
                                                              return Container(
                                                                padding: EdgeInsets.only(bottom: 10),
                                                                child: snapshot.data.data.currentPage +1 < snapshot.data.data.totalPages
                                                                    ? Center(child: ProgressBarDarkBlue(),) :  Container(),
                                                              );
                                                            }*/ /*

                                                            return ListTile(
                                                              onTap: () {
                                                                /// Navigate To CaseDetails
                                                                countryId = snapshot.data.data.data[index].id.toString();
                                                                var name = snapshot.data.data.data[index].name;
                                                                print(countryId);
                                                                print(name);
                                                                _addCaseBloc.StateListAPI( page: "0", searchTitle: '', countryId: countryId.toString());
                                                                setState(() {
                                                                  StateCase.text='';
                                                                  CountryCase.text=name;
                                                                });

                                                                Navigator.pop(context);
                                                              },
                                                              title: Container(
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                      EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                                      child: Align(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: AutoSizeText(
                                                                          '${snapshot.data.data.data[index].name}',
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 13),
                                                                          minFontSize: 10,
                                                                          stepGranularity: 1,
                                                                          maxLines: 4,
                                                                          textAlign: TextAlign.justify,
                                                                          overflow: TextOverflow.ellipsis,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                      EdgeInsets.fromLTRB(5, 3, 5, 3),
                                                                      child: Divider(
                                                                        height: 1,
                                                                        color: Colors.white54,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              // onTap: () =>pubDetails(snapshot.data.data[index]),
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    }),
                                              ),
                                              isLoadingCountry
                                                  ? Center(
                                                child: ProgressBarLightRose(),)
                                                  : Container(),
                                            ],
                                          ),
                                        );
                                      }

                                    ),
                                  ));*/
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: SizedBox(
                              height: 45,
                              child: TextField(
                                controller: CountryCase,
                                textAlign: TextAlign.left,
                                enabled: false,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10.0),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: CustColors.TextGray,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: CustColors.TextGray,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  hintText: 'Select your Country',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              CountryCase.text == '' || CountryCase.text.isEmpty
                                  ? false
                                  : true,
                          child: InkWell(
                            onTap: () {
                              print(countryId);
                              if (countryId == '' ||
                                  countryId == null ||
                                  countryId == "null") {
                                print('sdg');
                                toastMsg(
                                    "Select a country before selecing state");
                              } else {
                                print('countryId');

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Select State"),
                                        content: StatefulBuilder(builder:
                                            (BuildContext context,
                                                StateSetter mystate) {
                                          mystate1 = mystate;
                                          return SizedBox(
                                            width: double.maxFinite,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 5, 5, 10),
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            color:
                                                                CustColors
                                                                    .LightRose,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5))),
                                                    width: double.infinity,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          flex: 3,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    10,
                                                                    0,
                                                                    5,
                                                                    0),
                                                            width:
                                                                double.infinity,
                                                            child:
                                                                TextFormField(
                                                              onChanged:
                                                                  (text) {
                                                                print(
                                                                    countryId);

                                                                _addCaseBloc.StateListAPI(
                                                                    page: "0",
                                                                    searchTitle:
                                                                        text,
                                                                    countryId:
                                                                        countryId);
                                                              },
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    "Search",
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: SizedBox(
                                                            width:
                                                                double.infinity,
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
                                                Flexible(
                                                  child: StreamBuilder(
                                                      stream: _addCaseBloc
                                                          .stateListStream,
                                                      builder: (context,
                                                          AsyncSnapshot<
                                                                  StateListModel>
                                                              snapshot) {
                                                        if (snapshot.connectionState ==
                                                                ConnectionState
                                                                    .waiting ||
                                                            snapshot.connectionState ==
                                                                ConnectionState
                                                                    .none) {
                                                          return Center(
                                                              child:
                                                                  ProgressBarLightRose());
                                                        } else if (snapshot
                                                                .hasData ||
                                                            snapshot
                                                                .data
                                                                .data
                                                                .data
                                                                .isNotEmpty) {
                                                          if (snapshot.data
                                                                  .status ==
                                                              'error') {
                                                            return noDataFound();
                                                          } else if (snapshot
                                                              .data
                                                              .data
                                                              .data
                                                              .isEmpty) {
                                                            return noDataFound();
                                                          }
                                                        } else {
                                                          return Center(
                                                              child:
                                                                  ProgressBarDarkBlue());
                                                        }
                                                        return NotificationListener(
                                                          // ignore: missing_return
                                                          onNotification:
                                                              (ScrollNotification
                                                                  scrollInfo) {
                                                            if (!_addCaseBloc
                                                                    .paginationLoading &&
                                                                scrollInfo
                                                                        .metrics
                                                                        .pixels ==
                                                                    scrollInfo
                                                                        .metrics
                                                                        .maxScrollExtent) {
                                                              // start loading data
                                                              if (snapshot
                                                                      .data
                                                                      .data
                                                                      .currentPage <
                                                                  snapshot
                                                                      .data
                                                                      .data
                                                                      .totalPages) {
                                                                final page = snapshot
                                                                        .data
                                                                        .data
                                                                        .currentPage +
                                                                    1;
                                                                mystate1(() {
                                                                  isLoadingState =
                                                                      true;
                                                                });
                                                                _addCaseBloc.StateListAPI(
                                                                    page: page
                                                                        .toString(),
                                                                    searchTitle:
                                                                        '',
                                                                    countryId:
                                                                        countryId);
                                                              }
                                                            }
                                                          },

                                                          child:
                                                              ListView.builder(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    0, 0, 0, 0),
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            shrinkWrap: true,
                                                            itemCount: snapshot
                                                                .data
                                                                .data
                                                                .data
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              /*if ((index+1) == snapshot.data.data.data.length ) {//pagination loader
                                                                return Container(
                                                                  padding: EdgeInsets.only(bottom: 10),
                                                                  child: snapshot.data.data.currentPage +1 < snapshot.data.data.totalPages
                                                                      ? Center(child: ProgressBarDarkBlue(),) :  Container(),
                                                                );
                                                              }*/

                                                              return ListTile(
                                                                onTap: () {
                                                                  /// Navigate To CaseDetails
                                                                  var countryId =
                                                                      snapshot
                                                                          .data
                                                                          .data
                                                                          .data[
                                                                              index]
                                                                          .countryId;
                                                                  var name =
                                                                      snapshot
                                                                          .data
                                                                          .data
                                                                          .data[
                                                                              index]
                                                                          .name;
                                                                  print(
                                                                      countryId);
                                                                  print(name);
                                                                  StateCase
                                                                          .text =
                                                                      name;
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                title:
                                                                    Container(
                                                                  child: Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            10),
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              AutoSizeText(
                                                                            snapshot.data.data.data[index].name,
                                                                            style:
                                                                                const TextStyle(color: Colors.black, fontSize: 13),
                                                                            minFontSize:
                                                                                10,
                                                                            stepGranularity:
                                                                                1,
                                                                            maxLines:
                                                                                4,
                                                                            textAlign:
                                                                                TextAlign.justify,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const Padding(
                                                                        padding: EdgeInsets.fromLTRB(
                                                                            5,
                                                                            3,
                                                                            5,
                                                                            3),
                                                                        child:
                                                                            Divider(
                                                                          height:
                                                                              1,
                                                                          color:
                                                                              Colors.white54,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                // onTap: () =>pubDetails(snapshot.data.data[index]),
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      }),
                                                ),
                                                isLoadingState
                                                    ? Center(
                                                        child:
                                                            ProgressBarLightRose(),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          );
                                        }),
                                      );
                                    });

                                /*showDialog(
                                      context: context,
                                      child: new AlertDialog(
                                        title: new Text("Select State"),
                                        content: StatefulBuilder(
                                            builder: (BuildContext context, StateSetter mystate) {
                                              mystate1 = mystate;
                                              return  Container(
                                                width: double.maxFinite,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
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
                                                                    print(countryId);


                                                                    _addCaseBloc.StateListAPI( page: "0", searchTitle: text, countryId:  countryId);


                                                                  },
                                                                  textAlign: TextAlign.left,
                                                                  decoration: InputDecoration(
                                                                    border: InputBorder.none,
                                                                    hintText: "Search",
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                width: double.infinity,
                                                                child: Image.asset('assets/images/rosesearch.png',
                                                                    width: 20, height: 20),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: StreamBuilder(
                                                          stream: _addCaseBloc.stateListStream,
                                                          builder: (context, AsyncSnapshot<StateListModel> snapshot) {
                                                            if (snapshot.connectionState ==
                                                                ConnectionState.waiting ||
                                                                snapshot.connectionState == ConnectionState.none) {
                                                              return Center(child: ProgressBarLightRose());
                                                            } else
                                                            if (snapshot.hasData ||
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
                                                                if (!_addCaseBloc.paginationLoading &&
                                                                    scrollInfo.metrics.pixels ==
                                                                        scrollInfo.metrics.maxScrollExtent) {
                                                                  // start loading data
                                                                  if (snapshot.data.data.currentPage <
                                                                      snapshot.data.data.totalPages) {
                                                                    final page = snapshot.data.data.currentPage + 1;
                                                                    mystate1(() {
                                                                      isLoadingState = true;
                                                                    });
                                                                    _addCaseBloc.StateListAPI( page: page.toString(), searchTitle: '', countryId: countryId);
                                                                  }
                                                                }
                                                              },

                                                              child: ListView.builder(
                                                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                                scrollDirection: Axis.vertical,
                                                                shrinkWrap: true,
                                                                itemCount: snapshot.data.data.data.length,
                                                                itemBuilder: (context, index) {
                                                                  */ /*if ((index+1) == snapshot.data.data.data.length ) {//pagination loader
                                                                return Container(
                                                                  padding: EdgeInsets.only(bottom: 10),
                                                                  child: snapshot.data.data.currentPage +1 < snapshot.data.data.totalPages
                                                                      ? Center(child: ProgressBarDarkBlue(),) :  Container(),
                                                                );
                                                              }*/ /*

                                                                  return ListTile(
                                                                    onTap: () {
                                                                      /// Navigate To CaseDetails
                                                                      var countryId = snapshot.data.data.data[index].countryId;
                                                                      var name = snapshot.data.data.data[index].name;
                                                                      print(countryId);
                                                                      print(name);
                                                                      StateCase.text=name;
                                                                      Navigator.pop(context);
                                                                    },
                                                                    title: Container(
                                                                      child: Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                            EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                                            child: Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: AutoSizeText(
                                                                                '${snapshot.data.data.data[index].name}',
                                                                                style: TextStyle(
                                                                                    color: Colors.black,
                                                                                    fontSize: 13),
                                                                                minFontSize: 10,
                                                                                stepGranularity: 1,
                                                                                maxLines: 4,
                                                                                textAlign: TextAlign.justify,
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                            EdgeInsets.fromLTRB(5, 3, 5, 3),
                                                                            child: Divider(
                                                                              height: 1,
                                                                              color: Colors.white54,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    // onTap: () =>pubDetails(snapshot.data.data[index]),
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                                    isLoadingState
                                                        ? Center(child: ProgressBarLightRose(),)
                                                        : Container(),
                                                  ],
                                                ),
                                              );
                                            }
                                        ),
                                      ));*/
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: SizedBox(
                                height: 45,
                                child: TextField(
                                  controller: StateCase,
                                  textAlign: TextAlign.left,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10.0),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: CustColors.TextGray,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: CustColors.TextGray,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    hintText: 'Select your State',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: visibleActiveButton,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                              child: Column(
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Visibility(
                                            visible: visibileDocuments,
                                            child: const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 20, 20, 20),
                                              child: Text("Files",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontFamily: 'Formular',
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: viewDoc == true
                                              ? ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: images.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    String docpdficon;

                                                    var completePath =
                                                        images[index]
                                                                .caseDocument
                                                                .toString() +
                                                            "/" +
                                                            images[index]
                                                                .docType
                                                                .toString();

                                                    var fileNameExtension =
                                                        (completePath
                                                            .split('/')
                                                            .last);

                                                    var filepathname =
                                                        (completePath
                                                            .split('/')
                                                            .last);

                                                    print(filepathname +
                                                        "55555555555555555555555555555555555555555555555555555555555");

                                                    if (fileNameExtension ==
                                                            "pdf" ||
                                                        fileNameExtension ==
                                                            "PDF") {
                                                      docpdficon =
                                                          'assets/images/pdf_icon_addCase.png';
                                                    } else if (fileNameExtension ==
                                                            "doc" ||
                                                        fileNameExtension ==
                                                            "docx") {
                                                      docpdficon =
                                                          'assets/images/doc_icon_AddCase.png';
                                                    } else if (fileNameExtension ==
                                                            "jpg" ||
                                                        fileNameExtension ==
                                                            "jpeg" ||
                                                        fileNameExtension ==
                                                            "png" ||
                                                        fileNameExtension ==
                                                            "PNG") {
                                                      docpdficon =
                                                          'assets/images/image_icon2.png';
                                                    } else {
                                                      docpdficon =
                                                          'assets/images/play_icon.png';
                                                    }

                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          20, 10, 10, 10),
                                                      child: SizedBox(
                                                        height: 60,
                                                        child: Row(
                                                          children: <Widget>[
                                                            Flexible(
                                                              flex: 1,
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0.0),
                                                                  child: Image.asset(
                                                                      docpdficon,
                                                                      width: 45,
                                                                      height:
                                                                          45),
                                                                ),
                                                              ),
                                                            ),
                                                            Flexible(
                                                              flex: 2,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        10,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 3,
                                                                      child:
                                                                          SizedBox(
                                                                        child:
                                                                            Text(
                                                                          filepathname,
                                                                          maxLines:
                                                                              2,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          softWrap:
                                                                              false,
                                                                          style: const TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 15.0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                        onTap:
                                                                            () {
                                                                          print(
                                                                              images);
                                                                          print(
                                                                              index);
                                                                          print(images[index]
                                                                              .id
                                                                              .toString());
                                                                          _editCaseBloc.deleteEditCaseDocs(images[index]
                                                                              .id
                                                                              .toString());
                                                                          setState(
                                                                              () {
                                                                            images.removeAt(index);
                                                                          });
                                                                        },
                                                                        child: Image
                                                                            .asset(
                                                                          "assets/images/deletenewicon.png",
                                                                          height:
                                                                              23,
                                                                          width:
                                                                              23,
                                                                        )),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )
                                              : const Text(""),
                                        ),
                                        ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: _galleryDocPathList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            String docpdficon;

                                            var completePath =
                                                _galleryDocPathList[index]
                                                    .toString();

                                            var fileNameExtension =
                                                (completePath.split('/').last);

                                            var filepathname =
                                                (completePath.split('/').last);

                                            print(filepathname +
                                                "55555555555555555555555555555555555555555555555555555555555");

                                            if (fileNameExtension == "pdf" ||
                                                fileNameExtension == "PDF") {
                                              docpdficon =
                                                  'assets/images/pdf_icon_addCase.png';
                                            } else if (fileNameExtension ==
                                                    "doc" ||
                                                fileNameExtension == "docx") {
                                              docpdficon =
                                                  'assets/images/doc_icon_AddCase.png';
                                            } else if (fileNameExtension ==
                                                    "jpg" ||
                                                fileNameExtension == "jpeg" ||
                                                fileNameExtension == "png" ||
                                                fileNameExtension == "PNG") {
                                              docpdficon =
                                                  'assets/images/image_icon2.png';
                                            } else {
                                              docpdficon =
                                                  'assets/images/play_icon.png';
                                            }

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 10, 10),
                                              child: SizedBox(
                                                height: 60,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      flex: 1,
                                                      child: SizedBox(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      0.0),
                                                          child: Image.asset(
                                                              docpdficon,
                                                              width: 45,
                                                              height: 45),
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 2,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 0, 0, 0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 3,
                                                              child: SizedBox(
                                                                child: Text(
                                                                  filepathname,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  softWrap:
                                                                      false,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15.0),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: IconButton(
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .cancel,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 23,
                                                                  ),
                                                                  onPressed: () =>
                                                                      setState(
                                                                          () {
                                                                        _galleryDocPathList
                                                                            .removeAt(index);
                                                                      })),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        InkWell(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, bottom: 10),
                                            child: Center(
                                              child: Container(
                                                width: 140.0,
                                                height: 32.0,
                                                decoration: const BoxDecoration(
                                                    color: CustColors.DarkGreen,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50))),
                                                child: Center(
                                                    child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                        'assets/images/open_gallery_icon.png',
                                                        width: 15,
                                                        height: 15),
                                                    const Text(
                                                      " Upload Documents",
                                                      style: Styles
                                                          .homeCategoryNameswhite,
                                                    ),
                                                  ],
                                                )),
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            _openFileExplorer();
                                          },
                                        ),
                                      ],
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
                  continueButtonClick(),
                ]),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                  child: Visibility(
                      visible: visible,
                      child: Center(
                        child: Container(
                            margin: const EdgeInsets.only(top: 50, bottom: 30),
                            child: const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  CustColors.DarkBlue),
                            )),
                      )),
                ),
              ],
            )));
  }

  toastMsg(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 1),
    ));
  }

  Widget continueButtonClick() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SubmitFlatButtonWidget(
            height: 50,
            width: double.infinity,
            backgroundColor: CustColors.DarkBlue,
            buttonText: "Continue",
            buttonTextColor: Colors.white,
            onpressed: () {
              if (firstButtonClick == true) {
                setState(() {
                  firstButtonClick = false;
                  visible = true;
                });
                print(caseTitle.text.toString() + "");
                print(caseDescription.text.toString() + "");
                print(publicPrivatecasestatus + "");
                print(publicPrivatecasename + "");
                print(CountryCase.text.toString() + "");
                print(StateCase.text.toString() + "");

                if (caseTitle.text.toString().isEmpty) {
                  toastMsg("Enter Case Title");
                  setState(() {
                    firstButtonClick = true;
                    visible = false;
                  });
                } else if (caseDescription.text.toString().isEmpty) {
                  toastMsg("Enter Case Description");
                  setState(() {
                    firstButtonClick = true;
                    visible = false;
                  });
                } else if (CountryCase.text.toString().isEmpty) {
                  toastMsg("Enter Country");
                  setState(() {
                    firstButtonClick = true;
                    visible = false;
                  });
                } else if (StateCase.text.toString().isEmpty) {
                  toastMsg("Enter State");
                  setState(() {
                    firstButtonClick = true;
                    visible = false;
                  });
                } else if (caseTitle.text.length > 75) {
                  toastMsg("Case Title Greater Than 75 Characters Not Allowed");
                  setState(() {
                    firstButtonClick = true;
                    visible = false;
                  });
                } else if (caseDescription.text.length > 2000) {
                  toastMsg(
                      "Case Description Greater Than 2000 Characters Not Allowed");
                  setState(() {
                    firstButtonClick = true;
                    visible = false;
                  });
                } else if (charLength < 150) {
                  toastMsg("Case Description should be minimum 150 Characters");
                  setState(() {
                    firstButtonClick = true;
                    visible = false;
                  });
                } else {
                  setState(() {
                    firstButtonClick = false;
                    visible = true;
                  });
                  if (_galleryDocPathList.isNotEmpty) {
                    var newList = _galleryDocPathList;
                    List<bool> isFilesizeValid = [];
                    List<bool> videofilesincluded = [];
                    bool isValidFiles = true;
                    // var index = -1;
                    print(newList);
                    if (newList.isEmpty) {
                      toastMsg('Please Upload files');
                      setState(() {
                        firstButtonClick = true;
                        visible = false;
                      });
                    } else {
                      if (_galleryDocPathList.length > 2) {
                        toastMsg("More than 2 Files Can't be Upload");
                        setState(() {
                          firstButtonClick = true;
                          visible = false;
                        });
                      } else {
                        for (int i = 0; i < _galleryDocPathList.length; i++) {
                          var completePath =
                              (_galleryDocPathList[i].toString());
                          var fileNameExtension =
                              (completePath.split('.').last);
                          final f = File(_galleryDocPathList[i]);
                          int sizeInBytes = f.lengthSync();
                          double sizeInMb = sizeInBytes / (1024 * 1024);

                          if (sizeInMb > 150) {
                            setState(() {
                              firstButtonClick = true;
                            });
                            toastMsg('Greater than 150Mb not supported');
                          } else if (fileNameExtension == "mp4" ||
                              fileNameExtension == "MP4") {
                            videofilesincluded.add(true);
                            VideoPlayerController ctlVideo;
                            ctlVideo = VideoPlayerController.file(
                                File(paths.paths.toList()[i].toString()))
                              ..initialize().then((_) {
                                print(durationFromV);
                                // Get Video Duration in Milliseconds
                                durationFromV =
                                    ctlVideo.value.duration.inMinutes;
                                print('durationFromV$durationFromV');

                                if (durationFromV >= 3) {
                                  isFilesizeValid.add(false);
                                } else {
                                  isFilesizeValid.add(true);
                                }
                                print(isFilesizeValid);
                                print(videofilesincluded);

                                if (isFilesizeValid.length ==
                                    videofilesincluded.length) {
                                  for (var element in isFilesizeValid) {
                                    print('element  $element');
                                    if (element == false) {
                                      isValidFiles = false;
                                    }
                                  }
                                  if (isValidFiles == false) {
                                    setState(() {
                                      firstButtonClick = true;
                                    });
                                    toastMsg(
                                        'Video Duration greater than 3 min cant be upload');
                                  } else {
                                    //toastMsg(' success with video');
                                    print(
                                        'file size ok upload hurayyyyyyyyyyyy');
                                    setState(() {
                                      visible = true;
                                    });
                                    _editCaseBloc.uploadEditCaseDocs(
                                        caseId, newList);
                                  }
                                }
                              });
                          }
                        }
                        if (videofilesincluded.isEmpty) {
                          // toastMsg('Files uploaded sucess without video');
                          print(
                              'Files uploaded sucess without video hurayyyyyyyyyyyy');
                          setState(() {
                            visible = true;
                          });
                          _editCaseBloc.uploadEditCaseDocs(caseId, newList);
                        }
                      }
                    }
                  } else {
                    print("99999999999999999999999");
                    print(_galleryDocPathList.length);
                    print("99999999999999999999999");
                  }

                  setState(() {
                    visible = true;
                    _editCaseBloc.updateEditMyCase(
                        caseId,
                        caseTitle.text.toString(),
                        caseDescription.text.toString(),
                        publicPrivatecasestatus,
                        publicPrivatecasename,
                        CountryCase.text.toString(),
                        StateCase.text.toString());
                  });
                }
              }
            },
          ),
        ),
      ),
    );
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
                const Text('No Data Found',
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
    return const SizedBox(
      height: 60.0,
      child: Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(CustColors.DarkBlue),
      )),
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

  _onChanged(String value) {
    setState(() {
      charLength = value.length;
    });
  }

  void listen() {
    _editCaseBloc.details.listen((data) {
      if (data != null) {
        if ((data.status == "success")) {
          caseId = data.data.usersRef.id.toString();
          caseTitle.text = data.data.usersRef.caseTitle.toString();
          caseDescription.text = data.data.usersRef.caseDescription.toString();
          charLength = caseDescription.text.length;

          CountryCase.text = data.data.usersRef.country.toString();
          StateCase.text = data.data.usersRef.state.toString();

          if (data.data.usersRef.caseTypeFlag == 1) {
            visiblePublic = true;
            visiblePrivate = false;
            publicColor = CustColors.DarkBlue;
            publicbTextColor = Colors.white;
            privateCasebBgColor = Colors.white;
            privateCasebTextColor = CustColors.DarkBlue;
            publicPrivatecasestatus = "1";
          } else {
            visiblePublic = false;
            visiblePrivate = true;
            publicColor = Colors.white;
            publicbTextColor = CustColors.DarkBlue;
            privateCasebBgColor = CustColors.DarkBlue;
            privateCasebTextColor = Colors.white;
            publicPrivatecasestatus = "2";
          }

          if (data.data.usersRef.caseCategory == "Human trafficking") {
            human_trafficiking_icon = 'assets/images/public_human_active.png';
            corruption_icon = 'assets/images/public_curroption_inactive.png';
            environmental_icon =
                'assets/images/public_environment_inactive.png';
            others_icon = 'assets/images/others_inactive.png';
            publicPrivatecasename = "Human trafficking";
          } else if (data.data.usersRef.caseCategory == "Corruption") {
            human_trafficiking_icon = 'assets/images/public_human_inactive.png';
            corruption_icon = 'assets/images/public_curroption_active.png';
            environmental_icon =
                'assets/images/public_environment_inactive.png';
            others_icon = 'assets/images/others_inactive.png';
            publicPrivatecasename = "Corruption";
          } else if (data.data.usersRef.caseCategory == "Environment abusing") {
            human_trafficiking_icon = 'assets/images/public_human_inactive.png';
            corruption_icon = 'assets/images/public_curroption_inactive.png';
            environmental_icon = 'assets/images/public_environment_active.png';
            others_icon = 'assets/images/others_inactive.png';
            publicPrivatecasename = "Environment abusing";
          } else if (data.data.usersRef.caseCategory == "others") {
            human_trafficiking_icon = 'assets/images/public_human_inactive.png';
            corruption_icon = 'assets/images/public_curroption_inactive.png';
            environmental_icon =
                'assets/images/public_environment_inactive.png';
            others_icon = 'assets/images/others_active.png';
            publicPrivatecasename = "others";
          } else {
            human_trafficiking_icon = 'assets/images/public_human_active.png';
            corruption_icon = 'assets/images/public_curroption_inactive.png';
            environmental_icon =
                'assets/images/public_environment_inactive.png';
            others_icon = 'assets/images/others_inactive.png';
            publicPrivatecasename = "Human trafficking";
          }

          if (data.data.usersRef.caseDocument.isNotEmpty) {
            images = data.data.usersRef.caseDocument;
            print("1234567890000000000000000000000000000");
            print(images.length);
            print("1234567890000000000000000000000000000");

            setState(() {
              viewDoc = true;
            });
          } else {
            viewDoc = false;
            visibileDocuments = false;
          }

          setState(() {
            visible = false;
          });
        } else if ((data.status == "error")) {
          toastMsg(data.message);
          setState(() {
            visible = false;
          });
        }
      }
    });
    _editCaseBloc.editCaseStream.listen((data) {
      if ((data.status == "success")) {
        print(data.status);
        print("uploadCaseStream");
        /*setState(() {
          visible = false;
        });*/
        if (_galleryDocPathList.isEmpty) {
          toastMsg(data.message);
          Future.delayed(const Duration(seconds: 0)).then((_) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const MainLandingPage(frompage: "1")),
                ModalRoute.withName("/MainLandingPage"));
          });
        }
      } else if ((data.status == "error")) {
        toastMsg(data.message);
        setState(() {
          firstButtonClick = true;
          visible = false;
        });
      }
    });

    _editCaseBloc.uploadCaseStream.listen((data) {
      if ((data.status == "success")) {
        print("uploadCaseStream");
        print(data.status);
        toastMsg(data.message);
        /*setState(() {
          visible = false;
        });*/
        if (_galleryDocPathList.isNotEmpty) {
          Future.delayed(const Duration(seconds: 1)).then((_) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const MainLandingPage(frompage: "1")),
                ModalRoute.withName("/MainLandingPage"));
          });
        }
      } else if ((data.status == "error")) {
        toastMsg(data.message);
        setState(() {
          firstButtonClick = true;
          visible = false;
        });
      }
    });

    _editCaseBloc.deleteCaseStream.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          visible = false;
        });
        print(data.status);
        toastMsg(data.message);
      } else if ((data.status == "error")) {
        toastMsg(data.message);
        setState(() {
          visible = false;
        });
      }
    });
    _addCaseBloc.countryListStream.listen((data) {
      if ((data.status == "success")) {
        print(" ${data.status.toString()}countryListStream");

        mycountry1(() {
          isLoadingCountry = false;
        });
        print(" ${data.status}");
      } else if ((data.status == "error")) {
        print(" ${data.status.toString()}countryListStream");
        mycountry1(() {
          isLoadingCountry = false;
        });
        print(data.status);
      }
    });
    _addCaseBloc.stateListStream.listen((data) {
      if ((data.status == "success")) {
        mystate1(() {
          isLoadingState = false;
        });
        print(" ${data.status}");
      } else if ((data.status == "error")) {
        mystate1(() {
          isLoadingState = false;
        });
        print(data.status);
      }
    });
  }

  void _openFileExplorer() async {
    VideoPlayerController _controller;

    try {
      paths = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc', 'mp4', 'docx', 'jpeg'],
      );
      print('DocPaths$paths');
      if (paths != null) {
        setState(() {
          visibileDocuments = true;
          visibleActiveButton = true;
        });
        for (int i = 0; i < paths.count; i++) {
          {
            _galleryDocPathList.add(paths.paths.toList()[i].toString());
            print(_galleryDocPathList);
          }
        }
      }
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
