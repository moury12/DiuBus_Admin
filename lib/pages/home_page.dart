import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transpor_guidance_admin/Authservice/authservice.dart';
import 'package:transpor_guidance_admin/models/schedule_model.dart';
import 'package:transpor_guidance_admin/providers/bus_provider.dart';

import 'drivers_page.dart';
import 'login_page.dart';
import 'notice_page.dart';
import 'schedule_page.dart';
import 'users_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName ='/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
ScheduleModel?scheduleModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title:Row(
          children: [
        Text('DIU BUS',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 15),)
        ]
      ),backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor:Colors.black54 ,
        actions: [
          IconButton(onPressed: (){
            AuthService.logout().then((value) => Navigator.pushReplacementNamed(context, LoginPage.routeName));
          }, icon: Icon(Icons.logout))
        ],
    ),
      body:Consumer<BusProvider>(
          builder: (context, provider, child) {return
      Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView( scrollDirection: Axis.horizontal,
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                InkWell(onTap: (){
                  Navigator.pushNamed(context, SchedulePage.routeName);
                },
                  child: Card(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icon1.png',height: 40,width: 40,),
                      ),
                      Text('Schedule',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600,fontSize: 7)),

                    ],),
                  ),
                ),
                SizedBox(width: 35,),
                InkWell(onTap: (){                  Navigator.pushNamed(context, UserPage.routeName);
                },
                  child: Card(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icon2.png',height: 40,width: 40,),
                      ),
                      Text('Users',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600,fontSize: 7)),

                    ],),
                  ),
                ),
                SizedBox(width: 35,),
                InkWell(onTap: (){
                  Navigator.pushNamed(context, NoticePage.routeName);

                },
                  child: Card(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons3.png',height: 40,width: 40,),
                      ),
                      Text('Notice',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600,fontSize: 7)),

                    ],),
                  ),
                )
              ],),
            ),
          ),
        ),Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView( scrollDirection: Axis.horizontal,
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
              InkWell(onTap: (){
                Navigator.pushNamed(context, DriversPage.routeName);

              },
                child: Card(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/icon4.png',height: 40,width: 40,),
                    ),
                    Text('Drivers',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600,fontSize: 7)),

                  ],),
                ),
              ),
              SizedBox(width: 35,),
              InkWell(
                onTap: (){},
                child: Card(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/icon5.png',height: 40,width: 40,),
                    ),
                    Text('Policy',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600,fontSize: 7)),

                  ],),
                ),
              ),
              SizedBox(width: 20,),
            ],),
          ),
        ),

Expanded(
  child:   ListView.builder(itemCount: provider.scheduleList.length,
  
    itemBuilder: (context, index) {
  
    final s= provider.scheduleList[index];
  
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset('assets/b.jpg',height: 150,width: double.infinity,),
            ListTile(
              title: Text(s.busModel.busName),
              subtitle: Text('${s.startTime}--${s.departureTime}'),
              trailing: Column(
                children: [
                  Text(s.busModel.passengerCategory),
                  Text('${s.busModel.facultyRent.toString()}BDT'),

                ],
              ),
            ),

            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.route,color: Colors.red,),
                Text('${s.from}<>${s.destination}'),
              ],
            ),
          ],
        ),
      ),
    );
  
  },),
)

      ],);})
    );
  }}