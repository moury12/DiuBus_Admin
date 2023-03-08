import 'package:flutter/material.dart';
import 'package:transpor_guidance_admin/database/db_helper.dart';
import 'package:transpor_guidance_admin/models_for_driver/driver_model.dart';
class DriverProvider extends ChangeNotifier{
  DriverModel? driverModel;

 Future<void> registerDrivers(DriverModel driverModel) {
   return dbHelper.registerDrivers(driverModel);
 }
}