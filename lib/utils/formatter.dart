import 'package:intl/intl.dart';

class Formatters {
  static String formatCurrency(int? money) {
    final formatCurrency =
        NumberFormat.currency(symbol: 'Rp ', decimalDigits: 0, locale: 'in');
    return formatCurrency.format(money);
  }

  static String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('dd-MM-yyyy HH:mm').format(date);
  }

  static String formatLongMonthDateTime(DateTime date) {
    return DateFormat('dd MMM yyyy HH:mm').format(date);
  }

  static String getTime(DateTime expiredIn) {
    DateTime date = DateTime.now();
    return DateFormat('HH:mm').format(date);
  }

  static String getDay() {
    DateTime date = DateTime.now();
    return DateFormat('d').format(date);
  }

  static String getMonth() {
    DateTime date = DateTime.now();
    return DateFormat('M').format(date);
  }

  static String getYear() {
    DateTime date = DateTime.now();
    return DateFormat('yyyy').format(date);
  }

  static String formatFullDate(String date) {
    return DateFormat.yMMMMEEEEd('idn').format(DateTime.parse(date));
  }

  static String formatFullTime(String date) {
    return DateFormat('H.m').format(DateTime.parse(date));
  }

  static DateTime stringToDate(String date) {
    return DateFormat("dd-MM-yyyy HH:mm").parse(date);
  }

  static String formatListToString(List? list) {
    String dataList = list.toString();
    String replace1 = dataList.replaceAll("[", "");
    String replace2 = replace1.replaceAll("]", "");
    String replace3 = replace2.replaceAll(" ", "");
    return replace3;
  }

  static String inCaps(String value) =>
      '${value[0].toUpperCase()}${value.substring(1)}';
  static String allInCaps(String value) => value.toUpperCase();
  static String capitalizeFirstofEach(String value) => value
      .split(" ")
      .map((str) => str[0].toUpperCase() + str.substring(1))
      .join(" ");
}
