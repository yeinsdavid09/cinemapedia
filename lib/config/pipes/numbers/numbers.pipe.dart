import 'package:intl/intl.dart';

class NumbersPipe {
  //#region --------------------------------- Methods ---------------------------------

  static String formatNumber(int number) {
    return NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en',
    ).format(number);
  }

  //#endregion
}
