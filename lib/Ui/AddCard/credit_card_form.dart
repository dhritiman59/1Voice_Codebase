import 'package:bring2book/Constants/colorConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'credit_card_model.dart' as model;
import 'flutter_credit_card.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm(
      {Key key,
      this.cardNumber,
      this.expiryDate,
      this.cardHolderName,
      this.cvvCode,
      @required this.onCreditCardModelChange,
      this.themeColor,
      this.textColor = Colors.black,
      this.cursorColor,
      this.localizedText = const LocalizedText(),
      this.cardHolderNameController,
      this.expiryDateController,
      this.cvvCodeController,
      this.cardNumberController})
      : assert(localizedText != null),
        super(key: key);

  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final void Function(model.CreditCardModel) onCreditCardModelChange;
  final Color themeColor;
  final Color textColor;
  final Color cursorColor;
  final LocalizedText localizedText;
  final MaskedTextController cardNumberController;
  final TextEditingController expiryDateController;
  final TextEditingController cardHolderNameController;
  final TextEditingController cvvCodeController;

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;
  bool isCvvFocused = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Color themeColor;

  void Function(model.CreditCardModel) onCreditCardModelChange;
  model.CreditCardModel creditCardModel;

  FocusNode cvvFocusNode = FocusNode();

  void textFieldFocusDidChange() {
    creditCardModel.isCvvFocused = cvvFocusNode.hasFocus;
    onCreditCardModelChange(creditCardModel);
  }

  void createCreditCardModel() {
    cardNumber = widget.cardNumber ?? '';
    expiryDate = widget.expiryDate ?? '';
    cardHolderName = widget.cardHolderName ?? '';
    cvvCode = widget.cvvCode ?? '';

    creditCardModel = model.CreditCardModel(
        cardNumber, expiryDate, cardHolderName, cvvCode, isCvvFocused);
  }

  @override
  void initState() {
    super.initState();

    createCreditCardModel();

    onCreditCardModelChange = widget.onCreditCardModelChange;

    cvvFocusNode.addListener(textFieldFocusDidChange);

    widget.cardNumberController.addListener(() {
      setState(() {
        cardNumber = widget.cardNumberController.text;
        creditCardModel.cardNumber = cardNumber;
        onCreditCardModelChange(creditCardModel);
      });
    });

    widget.expiryDateController.addListener(() {
      setState(() {
        expiryDate = widget.expiryDateController.text;
        creditCardModel.expiryDate = expiryDate;
        onCreditCardModelChange(creditCardModel);
      });
    });

    widget.cardHolderNameController.addListener(() {
      setState(() {
        cardHolderName = widget.cardHolderNameController.text;
        creditCardModel.cardHolderName = cardHolderName;
        onCreditCardModelChange(creditCardModel);
      });
    });

    widget.cvvCodeController.addListener(() {
      setState(() {
        cvvCode = widget.cvvCodeController.text;
        creditCardModel.cvvCode = cvvCode;
        onCreditCardModelChange(creditCardModel);
      });
    });
  }

  @override
  void didChangeDependencies() {
    themeColor = CustColors.Radio ?? CustColors.Radio;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: CustColors.Radio.withOpacity(0.8),
        primaryColorDark: themeColor,
      ),
      child: Form(
        key: _scaffoldKey,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
              child: Container(
                color: CustColors.LightRose,
                child: TextFormField(
                  controller: widget.cardHolderNameController,
                  cursorColor: widget.cursorColor ?? themeColor,
                  style: const TextStyle(
                    color: CustColors.Grey,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: widget.localizedText.cardHolderLabel,
                    hintText: widget.localizedText.cardHolderHint,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                color: CustColors.LightRose,
                child: TextFormField(
                  controller: widget.cardNumberController,
                  cursorColor: widget.cursorColor ?? themeColor,
                  style: const TextStyle(
                    color: CustColors.Grey,
                  ),
                  decoration: InputDecoration(
                    hoverColor: CustColors.Radio,
                    border: const OutlineInputBorder(),
                    labelText: widget.localizedText.cardNumberLabel,
                    hintText: widget.localizedText.cardNumberHint,
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
              child: Container(
                color: CustColors.LightRose,
                child: TextFormField(
                  controller: widget.expiryDateController,
                  cursorColor: widget.cursorColor ?? themeColor,
                  style: const TextStyle(
                    color: CustColors.Grey,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: widget.localizedText.expiryDateLabel,
                    hintText: widget.localizedText.expiryDateHint,
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
              child: Container(
                color: CustColors.LightRose,
                child: TextField(
                  focusNode: cvvFocusNode,
                  controller: widget.cvvCodeController,
                  cursorColor: widget.cursorColor ?? themeColor,
                  style: const TextStyle(
                    color: CustColors.Grey,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: widget.localizedText.cvvLabel,
                    hintText: widget.localizedText.cvvHint,
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  onChanged: (String text) {
                    setState(() {
                      cvvCode = text;
                    });
                  },
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
            //   child: Container(
            //     height: MediaQuery.of(context).size.height * 0.15,
            //     child: Align(
            //       alignment: Alignment.bottomCenter,
            //       child: SubmitFlatButtonWidget(
            //         height: 50,
            //         width: double.infinity,
            //         backgroundColor: CustColors.DarkBlue,
            //         buttonText: "Add Card",
            //         buttonTextColor: Colors.white,
            //         onpressed: () {
            //           String msg = bloc.validate(
            //               widget.expiryDateController.text.toString(),
            //               widget.cvvCodeController.text.toString(),
            //               widget.cardNumberController.text.toString(),
            //               widget.cardHolderNameController.text.toString());
            //           if (msg == null) {
            //             String cardNumber = widget.cardNumberController.text
            //                 .toString()
            //                 .replaceAll(' ', '');
            //             bloc.addCardApi(
            //                 cardNumber,
            //                 widget.cvvCodeController.text.toString(),
            //                 bloc.month.toString(),
            //                 bloc.fourDigitsYear.toString());
            //           } else {
            //             toastMsg(msg);
            //           }
            //         },
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  /// Convert the two-digit year to four-digit year if necessary
  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return !(month == null || year == null) && isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is less than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently, is greater than card's
    // year
    return fourDigitsYear < now.year;
  }

  toastMsg(String msg) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }
}
