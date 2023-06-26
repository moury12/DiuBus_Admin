import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transpor_guidance_admin/pages/add_bus_info.dart';
import 'package:transpor_guidance_admin/pages/notification_page.dart';
import 'package:transpor_guidance_admin/providers/bus_provider.dart';
import 'package:transpor_guidance_admin/providers/driver_provider.dart';
import 'package:transpor_guidance_admin/providers/userProvider.dart';

import 'home_page.dart';
class DashboardPage extends StatefulWidget {
  static const String routeName ='/dash';
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
@override
  void didChangeDependencies() {
  Provider.of<BusProvider>(context,listen: false).getAllBus();
  Provider.of<BusProvider>(context,listen: false).getAllSchedule();
  Provider.of<DriverProvider>(context,listen: false).getAllDriver();
  Provider.of<UserProvider>(context,listen: false).getUserInfo();

    super.didChangeDependencies();
  }
int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: CurvedNavigationBar(items:[
        Icon(Icons.home,size: 25,color: Colors.white,),
        Icon(Icons.add_circle,size: 25,color: Colors.white,),
        Icon(Icons.notifications,size: 25,color: Colors.white,)
      ],color: Colors.blue.shade200,backgroundColor: Colors.transparent,buttonBackgroundColor: Colors.red.shade200,
index: index,
        height: 60,
        onTap: (selectedIndex){
        setState(() {
          index=selectedIndex;
        });
        },
      ),
      body: getSelectedPage(index: index),
    );
  }

 Widget getSelectedPage({required int index}) {
    Widget widget;
    switch(index){
      case 0:
        widget =HomePage();
        break;
      case 1:
        widget =AddBusPage();
        break;
      case 2:
        widget =NotificationPage();
        break;
      default:
        widget =HomePage();
        break;
    }
    return widget;
  }
}

