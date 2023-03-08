import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transpor_guidance_admin/models/admin_model.dart';
import 'package:transpor_guidance_admin/models/bus_model.dart';
import 'package:transpor_guidance_admin/models/schedule_model.dart';
import 'package:transpor_guidance_admin/models_for_driver/driver_model.dart';

class dbHelper{
  static final db =FirebaseFirestore.instance;

  static Future<void> addAdmin(AdminModel adminModel) {
    return db.collection(collectionAdmin).doc(adminModel.adminId).set(adminModel.toMap());
  }

  static Future<void> registerDrivers(DriverModel driverModel) {
    return db.collection(collectiondriver).doc(driverModel.driverId).set(driverModel.toMap());
  }

  static Future<void> addBus(BusModel busModel) {
    return db.collection(collectionBus).doc(busModel.busId).set(busModel.toMap());
  }
  static Stream<QuerySnapshot<Map<String,dynamic>>>getAllBus()=>
      db.collection(collectionBus).snapshots();

  static Future<void> addSchedule(ScheduleModel schedule) {
    return db.collection(collectionSchedule).doc(schedule.id).set(schedule.toMap());

  }
  static Stream<QuerySnapshot<Map<String,dynamic>>>getAllSchedule()=>
      db.collection(collectionSchedule).snapshots();
}