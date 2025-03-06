import 'package:intl/intl.dart';

String formatDateDDMMYYY(String inputDateString) {
  // Split the input date string
  List<String> dateParts = inputDateString.split('-');

  // Convert the parts to integers

  int year = dateParts[2].length>2 ? int.parse(dateParts[2]):int.parse(dateParts[0]);
  int month = int.parse(dateParts[1]);
  int day = dateParts[2].length>2 ? int.parse(dateParts[0]):int.parse(dateParts[2]);

  // Create a DateTime object
  DateTime date = DateTime(year, month, day);

  // Format the date using the desired format
  String formattedDate = DateFormat('dd-MM-yyyy').format(date);

  return formattedDate;
}
String formatDateYYYYMMDD(String inputDateString) {
  // Split the input date string
  List<String> dateParts = inputDateString.split('-');

  // Convert the parts to integers

  int year = dateParts[2].length>2 ? int.parse(dateParts[2]):int.parse(dateParts[0]);
  int month = int.parse(dateParts[1]);
  int day = dateParts[2].length>2 ? int.parse(dateParts[0]):int.parse(dateParts[2]);

  // Create a DateTime object
  DateTime date = DateTime(year, month, day);

  // Format the date using the desired format
  String formattedDate = DateFormat('yyyy-MM-dd').format(date);

  return formattedDate;
}