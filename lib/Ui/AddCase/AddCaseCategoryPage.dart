import 'package:auto_size_text/auto_size_text.dart';
import 'package:bring2book/Constants/CheckInternet.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/styles.dart';
import 'package:bring2book/Constants/text_string.dart';
import 'package:bring2book/Ui/AddCase/AddCasePage.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AddCaseBloc.dart';

class AddCaseCategoryPage extends StatefulWidget {
  AddCaseCategoryPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddCaseCategoryPageState createState() => _AddCaseCategoryPageState();
}

class _AddCaseCategoryPageState extends State<AddCaseCategoryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  CheckInternet _checkInternet = CheckInternet();
  AddCaseBloc _addCaseBloc = AddCaseBloc();
  bool visible = false;
  bool visiblePublic = true;
  bool visiblePrivate = false;

  TextEditingController privateCategoryName = new TextEditingController();

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            body: Padding(
                padding: EdgeInsets.all(0),
                child: Stack(
                  children: [
                    ListView(children: <Widget>[
                      Stack(
                        children: [
                          Image.asset(
                            "assets/images/forgotbgnew.png",
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.19,
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
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 30),
                                  child: Image.asset("assets/images/back_arrow.png",
                                    width: 20,
                                    height: 17,
                                    gaplessPlayback: true,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 30.0, top: 30),
                                child: Text("Add Case",
                                    style: new TextStyle(
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
                        height: MediaQuery.of(context).size.height * 0.60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
                              child: Text(
                                "Choose a case category",
                                style: Styles.textHeadNormalBlue25,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(30, 15, 40, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: AutoSizeText(

                                  //'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                                  TextString.addCaseTitle,
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                  minFontSize: 10,
                                  stepGranularity: 1,
                                  maxLines: 4,
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
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
                                            privateCasebTextColor = CustColors.DarkBlue;
                                            publicPrivatecasestatus = "1";
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
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
                                            privateCasebBgColor = CustColors.DarkBlue;
                                            privateCasebTextColor = Colors.white;

                                            publicPrivatecasestatus = "2";
                                            publicPrivatecasename = "Human trafficking";
                                            print('publicPrivatecasestatus$publicPrivatecasestatus publicPrivatecasename$publicPrivatecasename');
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 150,
                              child: Stack(
                                children: [
                                  Visibility(
                                    visible: visiblePublic,
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                                      child: Align(
                                                        alignment: Alignment.center,
                                                        child: AutoSizeText(
                                                          'Human trafficking',
                                                          style: Styles.addCaseCategoryNamesBlue,
                                                          minFontSize: 10,
                                                          stepGranularity: 10,
                                                          maxLines: 2,
                                                          textAlign: TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  human_trafficiking_icon = 'assets/images/public_human_active.png';
                                                  corruption_icon = 'assets/images/public_curroption_inactive.png';
                                                  environmental_icon = 'assets/images/public_environment_inactive.png';
                                                  others_icon = 'assets/images/others_inactive.png';
                                                  publicPrivatecasestatus = "1";
                                                  publicPrivatecasename = "Human trafficking";
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
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                                      child: Align(
                                                        alignment: Alignment.center,
                                                        child: AutoSizeText('Corruption',
                                                          style: Styles.addCaseCategoryNamesBlue,
                                                          minFontSize: 10,
                                                          stepGranularity: 10,
                                                          maxLines: 4,
                                                          textAlign: TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  human_trafficiking_icon = 'assets/images/public_human_inactive.png';
                                                  corruption_icon = 'assets/images/public_curroption_active.png';
                                                  environmental_icon = 'assets/images/public_environment_inactive.png';
                                                  others_icon = 'assets/images/others_inactive.png';
                                                  publicPrivatecasestatus = "1";
                                                  publicPrivatecasename = "Corruption";
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
                                                    Image.asset(
                                                        environmental_icon,
                                                        width: 70,
                                                        height: 70),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(0, 10, 0, 5),
                                                      child: Align(
                                                        alignment: Alignment.center,
                                                        child: AutoSizeText('Environment abusing',
                                                          style: Styles.addCaseCategoryNamesBlue,
                                                          minFontSize: 10,
                                                          stepGranularity: 10,
                                                          maxLines: 4,
                                                          textAlign: TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  human_trafficiking_icon = 'assets/images/public_human_inactive.png';
                                                  corruption_icon = 'assets/images/public_curroption_inactive.png';
                                                  environmental_icon = 'assets/images/public_environment_active.png';
                                                  others_icon = 'assets/images/others_inactive.png';
                                                  publicPrivatecasestatus = "1";
                                                  publicPrivatecasename = "Environment abusing";
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
                                                    Image.asset(
                                                        others_icon,
                                                        width: 70,
                                                        height: 70),
                                                    Padding(
                                                      padding:
                                                      EdgeInsets.fromLTRB(0, 10, 0, 5),
                                                      child: Align(
                                                        alignment:
                                                        Alignment.center,
                                                        child: AutoSizeText(
                                                          'Others',
                                                          style: Styles.addCaseCategoryNamesBlue,
                                                          minFontSize: 10,
                                                          stepGranularity: 10,
                                                          maxLines: 4,
                                                          textAlign:
                                                          TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  human_trafficiking_icon = 'assets/images/public_human_inactive.png';
                                                  corruption_icon = 'assets/images/public_curroption_inactive.png';
                                                  environmental_icon = 'assets/images/public_environment_inactive.png';
                                                  others_icon = 'assets/images/others_active.png';
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
                                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child:  Row(
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
                                                    Padding(
                                                      padding:
                                                      EdgeInsets.fromLTRB(0, 10, 0, 5),
                                                      child: Align(
                                                        alignment:
                                                        Alignment.center,
                                                        child: AutoSizeText(
                                                          'Human trafficking',
                                                          style: Styles.addCaseCategoryNamesBlue,
                                                          minFontSize: 10,
                                                          stepGranularity: 10,
                                                          maxLines: 2,
                                                          textAlign:
                                                          TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  human_trafficiking_icon = 'assets/images/public_human_active.png';
                                                  corruption_icon = 'assets/images/public_curroption_inactive.png';
                                                  environmental_icon = 'assets/images/public_environment_inactive.png';
                                                  others_icon = 'assets/images/others_inactive.png';
                                                  publicPrivatecasestatus = "2";
                                                  publicPrivatecasename = "Human trafficking";
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
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                                      child: Align(
                                                        alignment:
                                                        Alignment.center,
                                                        child: AutoSizeText(
                                                          'Corruption',
                                                          style: Styles.addCaseCategoryNamesBlue,
                                                          minFontSize: 10,
                                                          stepGranularity: 10,
                                                          maxLines: 4,
                                                          textAlign:
                                                          TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  human_trafficiking_icon = 'assets/images/public_human_inactive.png';
                                                  corruption_icon = 'assets/images/public_curroption_active.png';
                                                  environmental_icon = 'assets/images/public_environment_inactive.png';
                                                  others_icon = 'assets/images/others_inactive.png';
                                                  publicPrivatecasestatus = "2";
                                                  publicPrivatecasename = "Corruption";
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
                                                    Image.asset(
                                                        environmental_icon,
                                                        width: 70,
                                                        height: 70),
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                                      child: Align(
                                                        alignment:
                                                        Alignment.center,
                                                        child: AutoSizeText(
                                                          'Environment abusing',
                                                          style: Styles.addCaseCategoryNamesBlue,
                                                          minFontSize: 10,
                                                          stepGranularity: 10,
                                                          maxLines: 4,
                                                          textAlign:
                                                          TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  human_trafficiking_icon = 'assets/images/public_human_inactive.png';
                                                  corruption_icon = 'assets/images/public_curroption_inactive.png';
                                                  environmental_icon = 'assets/images/public_environment_active.png';
                                                  others_icon = 'assets/images/others_inactive.png';
                                                  publicPrivatecasestatus = "2";
                                                  publicPrivatecasename = "Environment abusing";
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
                                                    Image.asset(
                                                        others_icon,
                                                        width: 70,
                                                        height: 70),
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                                      child: Align(
                                                        alignment:
                                                        Alignment.center,
                                                        child: AutoSizeText(
                                                          'Others',
                                                          style: Styles.addCaseCategoryNamesBlue,
                                                          minFontSize: 10,
                                                          stepGranularity: 10,
                                                          maxLines: 4,
                                                          textAlign:
                                                          TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  human_trafficiking_icon = 'assets/images/public_human_inactive.png';
                                                  corruption_icon = 'assets/images/public_curroption_inactive.png';
                                                  environmental_icon = 'assets/images/public_environment_inactive.png';
                                                  others_icon = 'assets/images/others_active.png';
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



                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Container(
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
                                if (publicPrivatecasestatus == "2") {
                                 /* if (privateCategoryName.text
                                      .toString()
                                      .isEmpty) {
                                    toastMsg("Enter Category Name");
                                  } else*/ {
                                   // publicPrivatecasename = privateCategoryName.text.toString();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddCasePage(
                                                caseTypeFlag: publicPrivatecasestatus.toString(),
                                                caseCategory: publicPrivatecasename.toString())));
                                  }
                                } else if (publicPrivatecasestatus == "1") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddCasePage(
                                              caseTypeFlag: publicPrivatecasestatus.toString(),
                                              caseCategory: publicPrivatecasename.toString())));
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                      child: Visibility(
                          visible: visible,
                          child: Center(
                            child: Container(
                                margin: EdgeInsets.only(top: 50, bottom: 30),
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
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
      duration: Duration(seconds: 1),
    ));
  }
}
