import 'package:intl/intl.dart';

extension NumberFormatterExt on num {
  String toSmartCurrency() {
    if (this <= 0) return r"$0";

    final formatter = NumberFormat.compactSimpleCurrency(
      locale: 'en_US',
      decimalDigits: 1,
    );

    return formatter.format(this);
  }

  /// 22000000 -> $22,000,000
  String toFullCurrency() {
    if (this <= 0) return r"$0";
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: r'$',
      decimalDigits: 0,
    );
    return formatter.format(this);
  }
}
