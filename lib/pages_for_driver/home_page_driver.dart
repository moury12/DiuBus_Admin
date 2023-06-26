import 'package:flutter/material.dart';
import 'package:transpor_guidance_admin/Authservice/authservice.dart';
import 'package:transpor_guidance_admin/pages/login_page.dart';



class HomePageDriver extends StatelessWidget {
  static const String routeName ='/homedr';

const HomePageDriver({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Row(crossAxisAlignment: CrossAxisAlignment.center,
      children: [Image.asset('assets/logo2.png',height: 30,width: 30,),
        SizedBox(width: 3,),
        Text('Dashboard',style: TextStyle(fontSize: 18),),
      ],
    ),
      actions: [
        IconButton(onPressed: (){
          AuthService.logout().then((value) => Navigator.pushReplacementNamed(context, LoginPage.routeName));
        }, icon: Icon(Icons.logout))
      ],
      backgroundColor: Colors.white,foregroundColor: Colors.black54,elevation: 0,),
  );
}
}