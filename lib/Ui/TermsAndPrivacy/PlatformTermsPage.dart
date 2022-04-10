import 'package:bring2book/Constants/CheckInternet.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Ui/SignInScreen/SignInActivity.dart';
import 'package:bring2book/Ui/TermsAndPrivacy/PlatformTermsBloc.dart';
import 'package:flutter/material.dart';

class PlatFormTermsPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<PlatFormTermsPage> {
  CheckInternet _checkInternet = CheckInternet();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PlatFormTermsBloc _platFormTermsBloc = new PlatFormTermsBloc();
  String text = ' ';
  bool visibility = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(0),
        child: ListView(
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/images/forgotbgnew.png",
                  width: double.infinity,
                  height: 110,
                  gaplessPlayback: true,
                  fit: BoxFit.fill,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).maybePop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 30),
                        child: Image.asset(
                          "assets/images/back_arrow.png",
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
                      child: Text("Terms and Conditions",
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
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
              child: Text(text,
                  style: new TextStyle(
                    color: CustColors.Grey,
                  )),
            ),
            Visibility(
              visible: visibility,
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Center(
                  child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          CustColors.DarkBlue)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _checkInternet.check().then((intenet) {
      if (intenet != null && intenet) {
        // Internet Present Case
        _platFormTermsBloc.getPlatFormTerms();
      } else {
        toastMsg('No internet connection');
      }
    });

    listen();
  }

  void listen() {
    _platFormTermsBloc.termsAndPolicy.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          visibility = false;
          text = data.data.terms;
        });
      } else if ((data.status == "error")) {
        setState(() {
          // visible = false;
        });
        print("error ");
        String msg = data.message;
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
