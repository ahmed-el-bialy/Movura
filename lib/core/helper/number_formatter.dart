import 'package:intl/intl.dart';

extension NumberFormatterExt on num {

  String toSmartCurrency() {
    // تأمين لو القيمة صفر أو سالبة
    if (this <= 0) return r"$0";

    final formatter = NumberFormat.compactSimpleCurrency(
      locale: 'en_US', // عشان يطلع علامة الـ $ والـ M و B بالإنجليزية
      decimalDigits: 1, // عدد الأرقام العشرية بعد النقطة (مثلاً 22.0M)
    );

    return formatter.format(this);
  }

  /// إذا كنت تريد عرض الرقم كاملاً ولكن بفواصل فقط بدون اختصار حروف
  /// 22000000 -> $22,000,000
  String toFullCurrency() {
    if (this <= 0) return r"$0";
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: r'$',
      decimalDigits: 0, // مش محتاجين قروش وأرقام عشرية في ميزانية الأفلام
    );
    return formatter.format(this);
  }
}