import 'package:flutter/cupertino.dart';
import 'package:transpor_guidance_admin/Authservice/authservice.dart';
import 'package:transpor_guidance_admin/database/db_helper.dart';
import 'package:transpor_guidance_admin/models/admin_model.dart';

class AdminProvider extends ChangeNotifier{
  AdminModel? adminModel;
 Future<void> addAdmin(AdminModel adminModel) {
   return dbHelper.addAdmin(adminModel);
 }
  getUserInfo(){
    dbHelper.getAdminInfo(AuthService.currentUser!.uid).listen((snapshot) {
      if(snapshot.exists){
        adminModel=AdminModel.fromMap(snapshot.data()!);
        notifyListeners();
      }
    });
  }
  Future<void>updateUserField( String felid, dynamic value){
    return dbHelper.updateAdminField(AuthService.currentUser!.uid, {felid:value});
  }
}