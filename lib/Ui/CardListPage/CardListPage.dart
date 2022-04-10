import 'package:auto_size_text/auto_size_text.dart';
import 'package:bring2book/Constants/CheckInternet.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/styles.dart';
import 'package:bring2book/Models/CardListModel/CardListModel.dart';
import 'package:bring2book/Ui/AddCard/AddCardUi.dart';
import 'package:bring2book/Ui/AddCase/UploadCaseDocuments.dart';
import 'package:bring2book/Ui/Donation/DonationBloc.dart';
import 'package:bring2book/Ui/PaymentUi/PaymentFailed.dart';
import 'package:bring2book/Ui/PaymentUi/PaymentSuccessFul.dart';
import 'package:bring2book/Ui/SignInScreen/SignInActivity.dart';
import 'package:bring2book/Ui/TermsAndPrivacy/PlatformTermsBloc.dart';
import 'package:bring2book/Ui/TermsAndPrivacy/PrivacyPolicyBloc.dart';
import 'package:bring2book/Ui/base/CustomRadioWidget.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

import 'CardListBloc.dart';

class CardListPage extends StatefulWidget {
  final String caseId;
  final String caseTitle;
  final String valueFrom;
  CardListPage(this.caseId, this.valueFrom, this.caseTitle);

  @override
  _State createState() => _State(
      caseId: caseId, valueFrom: valueFrom, caseTitle: caseTitle);
}

class _State extends State<CardListPage> {
  final String caseTitle;
  final String caseId;
  final String valueFrom;
  String donationAmount="0";
  String cardId = '';
  bool checked = false;
  bool visibility = true;
  int id = 0;
  CardListBloc bloc = CardListBloc();
  DonationBloc bloc1 = DonationBloc();
  TextEditingController amount = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  CardListModel cardListModel = CardListModel();

  String radioButtonItem;
  _State({this.caseId, this.valueFrom,this.caseTitle});

  @override
  void initState() {
    super.initState();
    bloc.getCardList();
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
                      /*Container(
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
                      )*/
                      valueFrom == '1'
                          ? Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 20, right: 20),
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          flex: 1,
                                          child: Container(
                                            width: 60.0,
                                            height: 60.0,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: displayProfilePic(caseTitle),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 5,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    caseTitle,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    style: TextStyle(
                                                        color: CustColors.blueLight,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18.0),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      4, 10, 10, 10),
                                                  child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: AutoSizeText(
                                                      'Write wishes...',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14),
                                                      minFontSize: 10,
                                                      stepGranularity: 1,
                                                      maxLines: 4,
                                                      textAlign: TextAlign.justify,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      width: 60.0,
                                      height: 60.0,
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(20.0),
                                        child: displayProfilePic('General Donation'),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                             'General Donation' ,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: TextStyle(
                                                  color: CustColors.blueLight,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                4, 10, 10, 10),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: AutoSizeText(
                                                'Write wishes...',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14),
                                                minFontSize: 10,
                                                stepGranularity: 1,
                                                maxLines: 4,
                                                textAlign: TextAlign.justify,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20,top: 15),
                        child: Container(
                          height: 50,
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            controller: amount,
                            onChanged: (val)
                            {
                              setState(() {
                                donationAmount = val;
                              });
                            },
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 20),
                        child: Text(
                          'Select Payment Method',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              color: CustColors.blueLight,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                      ),
                      StreamBuilder(
                          stream: bloc.cardList,
                          builder: (context, AsyncSnapshot<CardListModel> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.status == 'error') {
                                return noDataFound();
                              } else if (snapshot.data.data.length == 0) {
                                return noDataFound();
                              } else {}
                            } else {
                              return Center(child: ProgressBarDarkBlue());
                            }
                            return ListView.builder(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              scrollDirection: Axis.vertical,
                              primary: false,
                              shrinkWrap: true,
                              itemCount: snapshot.data.data.length,
                              itemBuilder: (context, index) {
                                cardId = snapshot.data.data[0].id;
                                return Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: InkWell(
                                    onTap: () {
                                      setChangeRadioState(
                                          index, snapshot.data.data[index]);
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Container(
                                              color: CustColors.LightRose,
                                              child: Row(
                                                children: <Widget>[
                                                  CustomRadioWidget(
                                                    value: index,
                                                    groupValue: id,
                                                    onChanged: (val) {
                                                      setState(() {
                                                        setChangeRadioState(
                                                            index,
                                                            snapshot
                                                                .data.data[index]);
                                                      });
                                                    },
                                                  ),
                                                  Container(
                                                    width: 60.0,
                                                    height: 60.0,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: Container(
                                                        child: new Image.asset(
                                                            'assets/images/card.png',
                                                            width: 30,
                                                            height: 30),
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 5,
                                                    child: Padding(
                                                      padding: EdgeInsets.fromLTRB(
                                                          10, 0, 0, 0),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            width: double.infinity,
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'XXXX XXXX XXXX ' +
                                                                      snapshot
                                                                          .data
                                                                          .data[
                                                                              index]
                                                                          .last4,
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
                                                                      fontSize:
                                                                          14.0),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          left: 20),
                                                                  child: InkWell(
                                                                    onTap: () {
                                                                      bloc.deleteCardFromList(
                                                                          snapshot
                                                                              .data
                                                                              .data[
                                                                                  index]
                                                                              .id);
                                                                      visibility = true;
                                                                      setState(() {
                                                                        snapshot
                                                                            .data
                                                                            .data
                                                                            .removeAt(
                                                                                index);
                                                                      });
                                                                    },
                                                                    child: Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left: 10),
                                                                      child:
                                                                          Container(
                                                                        child: new Image
                                                                                .asset(
                                                                            'assets/images/delete.png',
                                                                            width:
                                                                                15,
                                                                            height:
                                                                                15),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.fromLTRB(
                                                                    4, 10, 10, 0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: AutoSizeText(
                                                                snapshot
                                                                    .data
                                                                    .data[index]
                                                                    .brand,
                                                                style: TextStyle(
                                                                    color:
                                                                        Colors.grey,
                                                                    fontSize: 14),
                                                                minFontSize: 10,
                                                                stepGranularity: 1,
                                                                maxLines: 4,
                                                                textAlign: TextAlign
                                                                    .justify,
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
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child:
                                // Expanded(
                                //   flex: 1,
                                // child:
                                Container(
                              height: 30,
                              width: 100,
                              child: RaisedButton(
                                //     disabledColor: Colors.red,
                                // disabledTextColor: Colors.black,
                                textColor: Colors.white,
                                color: CustColors.greenProfileEmailVerifiedText,
                                onPressed: () {
                                  setState(() {
                                    callAddCard();


                                  });
                                },
                                child: Text('Add Card'),
                              ),
                            ),
                          ),
                          //),
                          // Expanded(
                          //   flex: 2,
                          //child:
                          Container(
                            child: Container(),
                          ),
                          // ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "",
                                style: Styles.textDonationLightDarkGray,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  '',
                                  style: Styles.textDonationLightDarkGray,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Donation Received",
                                style: Styles.textHeadNormalBlue17,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  '₹' +donationAmount.toString(),
                                  style: Styles.textHeadNormalBlue17,
                                ),
                              ),
                            )
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
                                buttonText: "Send Your Donation",
                                buttonTextColor: Colors.white,
                                onpressed: () {
                                  print(checked);
                                  int amt;
                                  if(numberValidator(amount.text.trim())==false)
                                  {
                                    toastMsg('Enter Valid Numeric Amount');
                                  }
                                  else if(isNumeric(amount.text.trim())==false)
                                  {
                                    toastMsg('Enter Valid Numeric Amount');
                                  }
                                  else if(amount.text.trim()!=''){
                                    amt=int.parse(amount.text.toString());
                                  }

                                  if(amount.text.trim()==''){
                                    toastMsg('Enter Amount');
                                  }
                                  else if(amt>10000)
                                  {
                                    print(amt);
                                    toastMsg('Enter Amount less than 10000');

                                  }
                                  else{
                                    print('valuefrom' + valueFrom);
                                    if (valueFrom == '0') {
                                      if (checked) {
                                        bloc1.postGeneralDonation(
                                            amt.toString(), radioButtonItem);
                                      } else {
                                        print(cardId);
                                        if(cardId!='')
                                          {
                                            print('cardId');
                                            bloc1.postGeneralDonation(
                                                amt.toString(), cardId);
                                          }
                                        else
                                          {
                                            toastMsg('Enter Card Details Or Select Card!!');
                                          }

                                      }
                                    }
                                    else {
                                      if (checked) {
                                        bloc1.caseDonationApi(
                                            caseId, amt.toString(), radioButtonItem);
                                      } else {
                                        bloc1.caseDonationApi(
                                            caseId, amt.toString(), cardId);
                                      }
                                    }
                                  }

                                }),
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
    bloc.cardList.listen((value) {
      if ((value.status == "success")) {
        setState(() {
          visibility = false;
        });
      } else if ((value.status == "error")) {
        setState(() {
          visibility = false;
        });
      }
    });
    bloc1.generalDonation.listen((value) {
      if ((value.status == "success")) {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentSuccessFul(value.message)
          ),
        );
        toastMsg(value.message);
      } else if ((value.status == "error")) {
       /* Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentFailed(value.message)
          ),
        );*/
       toastMsg('Payment failed');
      }
    });
    bloc1.caseDonation.listen((value) {
      if ((value.status == "success")) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentSuccessFul(value.message)
          ),
        );
        toastMsg(value.message);
      } else if ((value.status == "error")) {
        toastMsg('Payment failed');
       /* Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentFailed(value.message)
          ),
        );*/
      }
    });
    bloc.deleteCard.listen((value) {
      if ((value.status == "success")) {
        bloc.getCardList();
        setState(() {
          visibility = false;
        });
        toastMsg('Card is deleted successfully');
      } else if ((value.status == "error")) {
        setState(() {
          visibility = false;
        });
        toastMsg('Card is not deleted successfully');
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

  ProgressBarDarkBlue() {}

  Widget noDataFound() {
    return SingleChildScrollView(
      child: Container(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/images/atm.png', width: 120, height: 120),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text('No Card Found',
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
      ),
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

  void setChangeRadioState(int index, Datum data) {
    setState(() {
      id = index;
      checked = true;
      radioButtonItem = data.id;
    });
  }

  void callAddCard() async {
    final callApi = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AddCardUi()));
    if (callApi == true) {
      print('commented ');
      bloc.getCardList();
    }
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  bool isInteger(num value) => (value % 1) == 0;
  bool numberValidator(String value) {
    String patttern = r'[0-9]';
    RegExp regExp = new RegExp(patttern);
    String value1 =value.replaceAll(' ', '');
    print('trimmed value');
    print(value1.trim());
    if (regExp.hasMatch(value1))
    {
      print('true');
      return true;
    }
    else
    {
      print('false');
      return false;
    }

  }


}
