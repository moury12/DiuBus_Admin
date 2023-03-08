import 'package:flutter/material.dart';
const designations=[
  'Operation Head',
  'In charge Officer',
  'Student Ticketing officer',
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