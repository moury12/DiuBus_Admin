import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:transpor_guidance_admin/database/db_helper.dart';
import 'package:transpor_guidance_admin/models/bus_model.dart';
import 'package:transpor_guidance_admin/models/schedule_model.dart';

class BusProvider extends ChangeNotifier{
  List<BusModel> busList=[];
  List<ScheduleModel>scheduleList=[];
  Future<void> addBus(BusModel busModel) {
    return dbHelper.addBus(busModel);
  }
  Future<String> uploadImage(String? thumbnailImageLocalPath)async {
    final photoRef= FirebaseStorage.instance.ref().child('Images/${DateTime.now().microsecondsSinceEpoch}');
    final uploadTask=photoRef.putFile(File(thumbnailImageLocalPath!));
    final snapshot= await uploadTask.whenComplete(() => const Text('Upload Sucessfully'));
    return snapshot.ref.getDownloadURL();
  }
  getAllBus(){
    dbHelper.getAllBus().listen((snapshot) {
      busList=List.generate(snapshot.docs.length, (index) => BusModel.fromMap(snapshot.docs[index].data()));
      busList.sort((cat1, cat2)=>cat1.busName.compareTo(cat2.busName));
      notifyListeners();
    });
  }
  getAllSchedule(){
    dbHelper.getAllSchedule().listen((snapshot) {
      scheduleList=List.generate(snapshot.docs.length, (index) => ScheduleModel.fromMap(snapshot.docs[index].data()));

      notifyListeners();
    });
  }
  Future<void> addSchedule(ScheduleModel schedule) {
    return dbHelper.addSchedule(schedule);
  }

}