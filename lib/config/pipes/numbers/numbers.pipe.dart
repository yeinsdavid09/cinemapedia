import 'package:intl/intl.dart';

class NumbersPipe {
  //#region --------------------------------- Methods ---------------------------------

  static String formatNumber(int number, [int decimals = 0]) {
    return NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'en',
    ).format(number);
  }

  //#endregion
}
