import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transpor_guidance_admin/models/admin_model.dart';
import 'package:transpor_guidance_admin/providers/driver_provider.dart';

class ProfilePageDriver extends StatelessWidget {
  static const String routeName ='/ppdr';
  ProfilePageDriver({Key? key}) : super(key: key);
  String? thumbnailImageLocalPath;
  late DriverProvider userProvider;
  late AdminModel userModel;
@override
Widget build(BuildContext context) {
  final userProvider = Provider.of<DriverProvider>(context);
  return Scaffold(
    appBar: AppBar(backgroundColor: Colors.white,foregroundColor: Colors.black54,elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/logo2.png',height: 50,width: 50,),
            Text('User Profile',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)
          ],
        )),
    body: userProvider.driverModel == null
        ? Center(child: Text('Failed to load user data'),):ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(6),
          child: _headerSection(context, userProvider),
        ),
        Card(elevation: 0,
          child: ListTile(
            leading: const Icon(
              Icons.phone,
              color: Colors.lightBlueAccent,
            ),
            subtitle: Text(
              userProvider.driverModel!.phone.toString()?? 'Not set yet',
              style: TextStyle(color:Colors.black54),
            ),  title: const Text('Phone'),

          ),
        ),
        Card(elevation: 0,
          child: ListTile(
            leading: const Icon(
              Icons.perm_contact_cal_sharp,
              color: Colors.lightBlueAccent,
            ),
            subtitle: Text(
              userProvider.driverModel!.age.toString() ?? 'Not set yet',
              style: TextStyle(color: Colors.black54),
            ),  title: const Text('Age'),

          ),
        ),

      ],
    ),
  );
}
  Container _headerSection(BuildContext context, DriverProvider userProvider) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white),
      child: Center(
        child: SingleChildScrollView(  scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: userProvider.driverModel!.driverImage == null
                        ?

                        ClipOval(
                          child: Image.asset(
                            'assets/s.png',
                            height: 130,
                            width: 130,
                            fit: BoxFit.cover,
                          ),
                        )


                        : ClipOval(
                        child:Image.network(userProvider.driverModel!.driverImage!,
                          height: 100, width: 100,
                        )
                    )),
              ),
              SizedBox(height: 5,),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        userProvider.driverModel!.name ?? 'No Display Name',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),

                  Text(
                    userProvider.driverModel!.email ?? 'No email',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
                  )
                ],
              )
            ],
          )]))));



  }
}
