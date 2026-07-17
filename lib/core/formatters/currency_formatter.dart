import 'package:intl/intl.dart';

abstract class CurrencyFormatter {
  static String format(double amount, {String symbol = r'$', int decimalDigits = 2}) {
    return NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalDigits,
    ).format(amount);
  }

  static String formatWithoutSymbol(double amount, {int decimalDigits = 2}) {
    return NumberFormat.decimalPatternDigits(
      decimalDigits: decimalDigits,
    ).format(amount);
  }

  static String short(double amount, {String symbol = r'$'}) {
    if (amount >= 1000000) {
      return '$symbol${(amount / 1000000).toStringAsFixed(1)}M';
    }
    if (amount >= 1000) {
      return '$symbol${(amount / 1000).toStringAsFixed(1)}K';
    }
    return format(amount, symbol: symbol);
  }
}
