import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
const designations=[
  'Operation Head',
  'In charge Officer',
  'Student Ticketing officer',
'Driver',
  'Other'
];
const subDistricts=[
'DSC     ',
 ' Adabor',
  'Badda',
  'Banani',
  'Bangshal',
  'Bimanbandar',
  'Bsahantek',
  'Cantonment',
  'Chalkbazar',
  'Darus-Salam',
  'Demra',
  'Dhanmondi',
  'Gulshan',
  'Jattrabari',
  'Kafrul',
  'Mirpur',
  'Mohammadpur',
  'Mugda',
  'Pallabi',
  'Paltan',
  'Shahbag',
  'Uttara',
  'Wari',
  'Narayanganj',
  'Nobinogor Savar'
];
showMsg(BuildContext context, String msg) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(margin: EdgeInsets.all(5),
      content: Text(msg),backgroundColor: Colors.tealAccent.shade200,
      behavior: SnackBarBehavior.floating,));
abstract class NotificationType {
  static const String feedback = 'New Feedback';
  static const String request = 'New Request';
  static const String user = 'user';
}
abstract class NotificationuserType {
  static const String Notice = 'New Notice';
  static const String request = 'Accept Request';
  static const String deny = 'deny Request';
}
getFormattedDate(DateTime dt, {String pattern = 'dd/MM/yyyy'}) =>
    DateFormat(pattern).format(dt);