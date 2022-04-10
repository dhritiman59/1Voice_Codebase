import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/styles.dart';
import 'package:bring2book/Ui/SignInScreen/SignInActivity.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ForgotPasswordBloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  ForgotPasswordBloc _forgotPasswordBloc = ForgotPasswordBloc();
  bool visible = false;
  final TextEditingController _userforgotPasswordEmail =
      TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _forgotPasswordBloc.validateForgotPasswordStream.listen((event) {
      print('event is got $event');
      setState(() {
        visible = false;
      });
      toastMsg(event);
    });
    listen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        height: MediaQuery.of(context).size.height * 0.20,
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
                    height: MediaQuery.of(context).size.height * 0.60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                          child: Text(
                            "Forgot Password ?",
                            style: Styles.textHeadNormalBlue,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                          child: Text(
                            "Enter your Email Id",
                            style: Styles.textHeadNormalBlue13,
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 2.5,
                          padding: EdgeInsets.only(
                            top: 20,
                          ),
                          child: TextFieldWidgetForgot(
                            obscureText: false,
                            controller: _userforgotPasswordEmail,
                            textInputType: TextInputType.emailAddress,
                            height: 50,
                            width: double.infinity,
                            backgroundColor: CustColors.LightRose,
                            alignment: TextAlign.start,
                            hintText: "Email",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SubmitFlatButtonWidget(
                          height: 50,
                          width: double.infinity,
                          backgroundColor: CustColors.DarkBlue,
                          buttonText: "Submit",
                          buttonTextColor: Colors.white,
                          onpressed: () {
                            setState(() {
                              visible = true;
                            });
                            _forgotPasswordBloc.initiateForgotPasswordValues(
                                email:
                                    _userforgotPasswordEmail.text.toString());
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

  void listen() {
    print("Normal Login========");
    _forgotPasswordBloc.loginStream.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          visible = false;
        });
        toastMsg(data.message);
        Future.delayed(Duration(seconds: 1)).then((_) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => SignInActivity(
                        frompage: "0",
                      )));
        });
        toastMsg("Success");
      } else if ((data.status == "error")) {
        setState(() {
          visible = false;
        });
        String msg = data.message;
        toastMsg(msg);
      }
    });
  }

  toastMsg(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
    ));
  }
}
