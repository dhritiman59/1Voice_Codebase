import 'package:auto_size_text/auto_size_text.dart';
import 'package:bring2book/Constants/CheckInternet.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Ui/AddCase/UploadCaseDocuments.dart';
import 'package:bring2book/Ui/CardListPage/CardListPage.dart';
import 'package:bring2book/Ui/Donation/DonationBloc.dart';
import 'package:bring2book/Ui/SignInScreen/SignInActivity.dart';
import 'package:bring2book/Ui/TermsAndPrivacy/PlatformTermsBloc.dart';
import 'package:bring2book/Ui/TermsAndPrivacy/PrivacyPolicyBloc.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DonationPage extends StatefulWidget {
  final String caseId;
  final String caseTitle;
  final String valueFrom;
  DonationPage(this.caseId, this.valueFrom,this.caseTitle);


  @override
  _State createState() => _State(caseId: caseId,valueFrom: valueFrom,caseTitle: caseTitle);
}

class _State extends State<DonationPage> {
  final String caseId;
  final String valueFrom;
  final String caseTitle;
  bool visibility = false;
  DonationBloc bloc=DonationBloc();
  TextEditingController amount = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _State({this.caseId,this.valueFrom,this.caseTitle});

  @override
  void initState() {
    super.initState();
    listen();
  }

  @override
  Widget build(BuildContext context) {
    return
        // SafeArea(
        //     child:
        Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.all(0),
              child: Stack(
                children: [
                  ListView(
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            "assets/images/forgotbgnew.png",
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.20,
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
                                child: Text("Donation",
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
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                height: 50,
                                child: new TextField(
                                  keyboardType: TextInputType.number,
                                  controller: amount,
                                  textAlign: TextAlign.left,
                                  decoration: new InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: CustColors.TextGray,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                        color: CustColors.TextGray,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    hintText: 'Enter Amount',
                                  ),
                                ),
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
                                int amt;
                                if(amount.text!=''){
                                  amt=int.parse(amount.text.toString());
                                }

                                if(amount.text.trim()==''){
                                toastMsg('Enter Amount');
                              }
                              else if(amt>10000){
                                print(amt);
                                toastMsg('Enter Amount less than 10000');

                              }
                              else{
                                setState(() {
                                  visibility = true;
                                });
                                print('valuefrom'+valueFrom);
                                if(valueFrom=='0'){
                                /*  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CardListPage(caseId.toString(), '0',amt,'')));*/
                                 // bloc.postGeneralDonation(amount.text);
                                }
                                else{
                               /*   Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CardListPage(caseId.toString(), '1',amt,caseTitle)));*/

                                }
                              }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: visibility,
                    child: Container(
                      color: Colors.white70,
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
    //);
  }

  toastMsg(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
    ));
  }

  void listen() {
    bloc.caseDonation.listen((value) {
      if ((value.status == "success")) {
        setState(() {
          visibility = false;
        });
        toastMsg(value.message);
        Future.delayed(Duration(seconds: 1)).then((_) async {
          Navigator.pop(context, true);
        });

      } else if ((value.status == "error")) {
        toastMsg(value.message);
      }
    });
    bloc.generalDonation.listen((value) {
      if ((value.status == "success")) {
        toastMsg(value.message);
        Future.delayed(Duration(seconds: 1)).then((_) async {
          Navigator.of(context).pop(null);
          });


      } else if ((value.status == "error")) {
        toastMsg(value.message);
      }
    });
  }


}
