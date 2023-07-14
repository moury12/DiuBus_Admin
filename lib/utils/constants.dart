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
        .showSnackBar(SnackBar(margin: EdgeInsets.all(10),
      content: Row(
        children: [  Image.asset(
          'assets/logo2.png',
          height: 50,
          width: 50,
        ),
          Text(msg,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black54),),
        ],
      ),
      backgroundColor: Colors.lightBlueAccent.shade100.withOpacity(0.5),
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
const serverKey ='AAAARRE404c:APA91bFM_-fURUYfiyez5r8lbjP8pfd3wVfly5jwYCBFD5HxqHZZ6Xdj2s6pnZJ1H6OnhC1oh59dQXCD5wBnstT8j-3kAWHVp8XNdjly9FViRW48ABNJXR8vhzOwypssKDPhs6xHNhbg';