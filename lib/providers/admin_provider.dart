import 'package:flutter/cupertino.dart';
import 'package:transpor_guidance_admin/database/db_helper.dart';
import 'package:transpor_guidance_admin/models/admin_model.dart';

class AdminProvider extends ChangeNotifier{
  AdminModel? adminModel;
 Future<void> addAdmin(AdminModel adminModel) {
   return dbHelper.addAdmin(adminModel);
 }

}