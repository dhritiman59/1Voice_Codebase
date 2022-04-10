import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:bring2book/Constants/styles.dart';
import 'package:bring2book/Ui/BecomeProUser/BecomeProUserFormsPage.dart';
import 'package:bring2book/Ui/base/CustomRadioWidget.dart';
import 'package:bring2book/Ui/base/RadioCustomWidget.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BecomeProUserPage extends StatefulWidget {


  @override
  _BecomeProUserPageState createState() => _BecomeProUserPageState();
}

class _BecomeProUserPageState extends State<BecomeProUserPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // Group Value for Radio Button.
  int id = 1;
  String radioButtonItem='Lawyer';

  @override
  void initState() {
    super.initState();
    print('$id  $radioButtonItem');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
                          height:  MediaQuery.of(context).size.height * 0.20,
                          gaplessPlayback: true,
                          fit: BoxFit.fill,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30.0, top: 30),
                            child: Image.asset(
                              "assets/images/back_arrow.png",
                              width: 20,
                              height: 20,
                              gaplessPlayback: true,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height:MediaQuery.of(context).size.height * 0.60 ,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                            child: Text(
                              "Who are you",
                              textAlign: TextAlign.start,
                              style: Styles.textHeadNormalBlue,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                            child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                              style: Styles.textNormalLightDarkGray,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: RadioCustomWidget(
                                        value: 1,
                                        text: 'Lawyer',
                                        groupValue: id,
                                        onChanged: (val) {
                                          setState(() {
                                            radioButtonItem = 'Lawyer';
                                            id = 1;
                                          });
                                          print('$id  $radioButtonItem');
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: RadioCustomWidget(
                                        value: 3,
                                        text: 'Journalists',
                                        groupValue: id,
                                        onChanged: (val) {
                                          setState(() {
                                            radioButtonItem = 'Journalists';
                                            id = 3;
                                          });
                                          print('$id  $radioButtonItem');
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          15, 0, 15, 0),
                      child:Container(
                        height:MediaQuery.of(context).size.height * 0.15 ,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SubmitFlatButtonWidget(
                            height: 50,
                            width: double.infinity,
                            backgroundColor: CustColors.DarkBlue,
                            buttonText: "Next",
                            buttonTextColor: Colors.white,
                            onpressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BecomeProUserFormsPage(id: id,radioButtonItem:radioButtonItem.toString())));

                            },
                          ),
                        ),
                      ),
                    ),
                  ]),
                ],
              )))
    ]);
  }

  toastMsg(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
    ));
  }

}
