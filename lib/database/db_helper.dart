import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transpor_guidance_admin/models/admin_model.dart';
import 'package:transpor_guidance_admin/models/bus_model.dart';
import 'package:transpor_guidance_admin/models/driver_model.dart';
import 'package:transpor_guidance_admin/models/schedule_model.dart';
import 'package:transpor_guidance_admin/models/userModel.dart';

class dbHelper{
  static final db =FirebaseFirestore.instance;
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getAdminInfo(
      String uid) =>
      db.collection(collectionAdmin).doc(uid).snapshots();

  static Future<void> addAdmin(AdminModel adminModel) {
    return db.collection(collectionAdmin).doc(adminModel.adminId).set(adminModel.toMap());
  }
  static Future<void> updateAdminField(String uid, Map<String, dynamic> map) {
    return db.collection(collectionUser).doc(uid).update(map);
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
  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllDriver() =>
      db.collection(collectiondriver).snapshots();

  static Stream<QuerySnapshot<Map<String,dynamic>>> getUserInfo() =>
      db.collection(collectionUser).snapshots();
}