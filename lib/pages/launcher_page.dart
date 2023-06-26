

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transpor_guidance_admin/Authservice/authservice.dart';
import 'package:transpor_guidance_admin/models/admin_model.dart';
import 'package:transpor_guidance_admin/pages/dashboard_page.dart';

import 'login_page.dart';
class LauncherPage extends StatefulWidget {
  static const String routeName ='/';
   LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
late AdminModel adminModel;

  @override
  Widget build(BuildContext context) {
     Future.delayed(Duration.zero,(){
      if(AuthService.currentUser!=null){
       route();
      }
      else{
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
     });
    return Scaffold(
      body: Center(
        child:
            Image.asset('assets/logo2.png',
              height:100,width: 100,),



      ),
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('Admins')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('isAdmin') == true) {
         Navigator.pushReplacementNamed(context, DashboardPage.routeName);
        }else{
          //Navigator.pushReplacementNamed(context, .routeName);

        }
      }else {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);

      }
    }

    );
  }
}
