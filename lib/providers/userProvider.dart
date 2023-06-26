import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:transpor_guidance_admin/Authservice/authservice.dart';
import 'package:transpor_guidance_admin/database/db_helper.dart';
import 'package:transpor_guidance_admin/models/userModel.dart';

class UserProvider extends ChangeNotifier{
UserModel? userModel;
List<UserModel> userList = [];

getUserInfo() {
  dbHelper.getUserInfo().listen((snapshot) {
    userList = List.generate(snapshot.docs.length,
            (index) => UserModel.fromMap(snapshot.docs[index].data()));
    notifyListeners();
  });
}
}