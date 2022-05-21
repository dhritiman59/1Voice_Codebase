import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Ui/AddCard/AddCardBloc.dart';
import 'package:bring2book/Ui/AddCard/credit_card_model.dart' as model;
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart' as creditCard;


import 'credit_card_form.dart';

class AddCardUi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddCardUiState();
  }
}

class AddCardUiState extends State<AddCardUi> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final creditCard.MaskedTextController _cardNumberController =
      creditCard.MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      creditCard.MaskedTextController(mask: '00/00');
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cvvCodeController =
      creditCard.MaskedTextController(mask: '0000');

  AddCardBlock bloc = AddCardBlock();
  @override
  void initState() {
    super.initState();
    listen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Credit Card View Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: //SafeArea(
            //   child:
            ListView(
          children: <Widget>[
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
                        Navigator.of(context).pop();
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
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 10.0, right: 30.0, top: 30),
                      child: Text("Add Card",
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
    //Closed on sat 21 may due to exception
           // creditCard.CreditCardWidget(
             // cardNumber: cardNumber,
              //expiryDate: expiryDate,
              //cardHolderName: cardHolderName,
              //cvvCode: cvvCode,
              //showBackView: isCvvFocused,
            //),
            // Expanded(
            //   child:
            // SingleChildScrollView(
            //   child:
            CreditCardForm(
              themeColor: CustColors.DarkBlue,
              onCreditCardModelChange: onCreditCardModelChange,
              cardHolderNameController: _cardHolderNameController,
              cardNumberController: _cardNumberController,
              expiryDateController: _expiryDateController,
              cvvCodeController: _cvvCodeController,
            ),
            // ),
            //  ),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
            //   child: Container(
            //     height: MediaQuery.of(context).size.height * 0.15,
            //     child: Align(
            //       alignment: Alignment.bottomCenter,
            //       child:
            SubmitFlatButtonWidget(
              height: 50,
              width: double.infinity,
              backgroundColor: CustColors.DarkBlue,
              buttonText: "Add Card",
              buttonTextColor: Colors.white,
              onpressed: () {
                String msg = bloc.validate(
                    _expiryDateController.text.toString(),
                    _cvvCodeController.text.toString(),
                    _cardNumberController.text.toString(),
                    _cardHolderNameController.text.toString());
                if (msg == null) {
                  String cardNumber =
                      _cardNumberController.text.toString().replaceAll(' ', '');
                  bloc.addCardApi(
                      cardNumber,
                      _cvvCodeController.text.toString(),
                      bloc.month.toString(),
                      bloc.fourDigitsYear.toString());
                } else {
                  toastMsg(msg);
                }
              },
            ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      //  ),
    );
  }

  toastMsg(String msg) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  void onCreditCardModelChange(model.CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  void listen() {
    bloc.addCard.listen((value) {
      if ((value.status == "success")) {
        toastMsg('Card is added successfully');
        Future.delayed(const Duration(seconds: 1)).then((_) {
          Navigator.pop(context, true);
        });
      } else if ((value.status == "error")) {
        toastMsg(value.message);
      }
    });
  }
}
