import 'package:bring2book/Models/AddCardModel/AddCardModel.dart';
import 'package:bring2book/Models/CaseDonationModel/CaseDonationModel.dart';
import 'package:bring2book/Models/GeneralDonation/GeneralDonationModel.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class AddCardBlock{
  var fourDigitsYear;
  int month,year;
  final repository = Repository();
  final addCard = PublishSubject<AddCardModel>();
  Stream<AddCardModel> get addCardStream => addCard.stream;
  Future<AddCardModel> addCardApi(String cardNo,String cvc,String expMnth, String expYr) async {
    final parameter = {
      "cardNo":cardNo,
      "cvc":cvc,
      "expMnth":expMnth,
      "expYr":expYr
    };
    AddCardModel model =
    await repository.addCard(parameter);
    if (model != null) {
      addCard.sink.add(model);
    }


  }


  String validate(String expMnthYr, String cvv, String number, String name) {
    if (name.isEmpty) {
      return 'Please enter card holder name ';
    }
    if (number.isEmpty) {
      return 'Please enter card number ';
    }
    if (number.length!=19) {
      return 'Please enter valid card number ';
    }
      if (expMnthYr.isEmpty) {
        return 'Please enter expiry date ';
      }

      if (expMnthYr.contains(new RegExp(r'(\/)'))) {
        var split = expMnthYr.split(new RegExp(r'(\/)'));
        // The value before the slash is the month while the value to right of
        // it is the year.
        month = int.parse(split[0]);
        year = int.parse(split[1]);

      }
      else { // Only the month was entered
        month = int.parse(expMnthYr.substring(0, (expMnthYr.length)));
        year = -1; // Lets use an invalid year intentionally
      }


      if ((month < 1) || (month > 12)) {
        // A valid month is between 1 (January) and 12 (December)
        return 'Expiry month is invalid';
      }

      fourDigitsYear = convertYearTo4Digits(year);
      if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
        // We are assuming a valid year should be between 1 and 2099.
        // Note that, it's valid doesn't mean that it has not expired.
        return 'Expiry year is invalid';
      }

      if (!hasDateExpired(month, year)) {
        return "Card has expired";
      }
      if (cvv.isEmpty) {
        return "Please enter cvv";
      }

      if (cvv.length < 3 || cvv.length > 4) {
        return "CVV is invalid";
      }
      return null;

  }

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



}