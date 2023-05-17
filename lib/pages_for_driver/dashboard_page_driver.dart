import 'package:flutter/material.dart';

import '../Authservice/authservice.dart';
import '../pages/login_page.dart';

class DashboardDriverPage extends StatefulWidget {
  static const String routeName ='/dashdr';
  const DashboardDriverPage({Key? key}) : super(key: key);

  @override
  State<DashboardDriverPage> createState() => _DashboardDriverPageState();
}

class _DashboardDriverPageState extends State<DashboardDriverPage> {

  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(crossAxisAlignment: CrossAxisAlignment.center,
        children: [Image.asset('assets/icon4.png',height: 40,width: 40,),
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
    );}}
