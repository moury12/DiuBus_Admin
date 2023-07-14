import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transpor_guidance_admin/Authservice/authservice.dart';
import 'package:transpor_guidance_admin/models/feedback_model.dart';
import 'package:transpor_guidance_admin/models/schedule_model.dart';
import 'package:transpor_guidance_admin/pages/policy_page.dart';
import 'package:transpor_guidance_admin/providers/bus_provider.dart';
import 'package:transpor_guidance_admin/utils/constants.dart';

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
ScheduleModel? scheduleModel;
FeedbackModel? feedbackModel;
late BusProvider busProvider;
@override
  void didChangeDependencies() {
  busProvider = Provider.of<BusProvider>(context, listen: false);

    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final id= ModalRoute.of(context)!.settings.arguments as String?;
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
      SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
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
                  onTap: (){Navigator.pushNamed(context, PolicyPage.routeName);},
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
          ),Divider(),
            //Text("--------Schedule------",style: TextStyle(fontSize: 12,color: Colors.black54),),
Container(width: 380,height: 260,
  child:   ListView.builder(scrollDirection: Axis.horizontal,
    itemCount: provider.scheduleList.length,

    itemBuilder: (context, index) {

    final s= provider.scheduleList[index];

    return Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8),
        child: Stack(
          children: [
            Card(
              child: Container(width: 300,
                child: Column(mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Image.asset('assets/b.jpg',height: 150,width: double.infinity,),
                    ListTile(
                      title: Text(s.busModel.busName),
                      subtitle: Text('${s.startTime}--${s.departureTime}',style: TextStyle(fontSize: 12),),
                      trailing: Column(
                        children: [
                          Text(s.busModel.passengerCategory),
                          Text('${s.busModel.studentRent.toString()}BDT',style: TextStyle(fontSize: 12,color: Colors.black54),),

                        ],
                      ),
                    ),

                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.route,color: Colors.red,),
                        Text('${s.from}<>${s.destination}',style: TextStyle(color: Colors.black54),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned( right:0,bottom: 5,
              child: FloatingActionButton.small(
                onPressed: (){
                busProvider.deleteScheduleByid(s.id);
                showMsg(context, "Schedule has been deleted");
                print(s.id);
              }, child: Icon(Icons.delete)
              ,backgroundColor: Colors.redAccent.shade100,foregroundColor: Colors.white,
              heroTag: 344,),
            )
          ],
        ),
    );

  },),
), Divider(),
            //Text("--------Feedback------",style: TextStyle(fontSize: 12,color: Colors.black54),),
            Container(
              height: 150,width: 380,
              child: ListView.builder(scrollDirection: Axis.horizontal,
                itemCount: provider.feedlist.length,

                itemBuilder: (context, index) {
                  final f= provider.feedlist[index];
                  return Container(height: 200,width: 280,
                    child: Card(
                      child: ListTile(
                        tileColor: id==null? null : id==f.commentId?Colors.lightBlue.shade100:null ,

                        leading: ClipRRect(borderRadius: BorderRadius.circular(90),
                          child: Image.network(f.userModel.imageUrl??'',errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.account_circle,color: Colors.blueAccent.shade100,size: 50,);
                          },height: 40,width: 40, fit: BoxFit.cover,),
                        ),
                        title: Text(
                         ' \n${f.userModel.email}',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),maxLines: 2,),
                        subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [SizedBox(height: 8,),
                            Text("${f.comment}",style: TextStyle(fontSize: 10,),maxLines: 4,),
                            Text("${f.date}",style: TextStyle(fontSize: 8,color: Colors.blue),),
                          ],
                        ),
                        //trailing: Text(f.date),
                      ),
                    ),
                  );
                }, ),
            )
        ],),
      );})
    );
  }}