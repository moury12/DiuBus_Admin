import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:transpor_guidance_admin/database/db_helper.dart';
import 'package:transpor_guidance_admin/models_for_driver/driver_model.dart';
class DriverProvider extends ChangeNotifier{
  DriverModel? driverModel;

 Future<void> registerDrivers(DriverModel driverModel) {
   return dbHelper.registerDrivers(driverModel);
 }

  Future<String> uploadImage(String? thumbnailImageLocalPath)async {
    final photoRef= FirebaseStorage.instance.ref().child('driver/${DateTime.now().microsecondsSinceEpoch}');
    final uploadTask=photoRef.putFile(File(thumbnailImageLocalPath!));
    final snapshot= await uploadTask.whenComplete(() => const Text('Upload Sucessfully'));
    return snapshot.ref.getDownloadURL();
  }
}