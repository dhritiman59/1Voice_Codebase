import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/styles.dart';
import 'package:bring2book/Ui/LandingPage/MainLandingPage.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bring2book/Ui/ProfileHomePage/ProfileDetailsBloc.dart';
import 'package:flutter/widgets.dart';

class PaymentSuccessFul extends StatefulWidget {
  String msg;
  PaymentSuccessFul(this.msg);





  @override
  _PaymentSuccessFulState createState() => _PaymentSuccessFulState();
}

class _PaymentSuccessFulState extends State<PaymentSuccessFul> {



  @override
  void initState() {
    super.initState();



  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: EdgeInsets.all(0),
            child:
            Stack(
              children: [
                ListView(
                    children: <Widget>[
                      Stack(
                        children: [
                          Image.asset(
                            "assets/images/forgotbgnew.png",
                            width: double.infinity,
                            height:  MediaQuery.of(context).size.height * 0.19,
                            gaplessPlayback: true,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                      Container(height:MediaQuery.of(context).size.height * 0.70 ,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/success.png",
                              width: 150,
                              height: 150,
                            ),Padding(
                              padding:EdgeInsets.fromLTRB(30,30,30,0),
                              child:Text(
                                "Payment SuccessFul",
                                style: Styles.textHeadNormalBlue25,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                              child: Text( widget.msg,
                                textAlign: TextAlign.center,
                                style: Styles.textDonationLightDarkGray,
                              ),
                            ),Padding(
                              padding:EdgeInsets.fromLTRB(10,0,10,0),
                              child:Container(
                                height:MediaQuery.of(context).size.height * 0.20,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SubmitFlatButtonWidget(
                                    height: 50,
                                    width: double.infinity,
                                    backgroundColor: CustColors.DarkBlue,
                                    buttonText: "Home",
                                    buttonTextColor: Colors.white,
                                    onpressed: () {

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MainLandingPage(frompage:"0")
                                        ),
                                      );




                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ]),


              ],

            )
        )
    );

  }



}