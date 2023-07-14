import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transpor_guidance_admin/providers/driver_provider.dart';

class DriversPage extends StatelessWidget {
  static const String routeName ='/driver';
  const DriversPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black54,
        title: Row(
          children: [
            Image.asset(
              'assets/logo2.png',
              height: 70,
              width: 70,
            ),
            Center(
                child: Text('Drivers ',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15))),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
body: Consumer<DriverProvider>(
  builder: (context, provider, child) => ListView.builder(
    itemBuilder:(context, index) {
      final user = provider.driverList[index];
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(

          child: ListTile(
            leading: Container(   width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(180)

              ),
              child:user.driverImage==null?Image.asset('assets/icon2.png',fit: BoxFit.cover,)
                  : CachedNetworkImage(
                width: 50,
                height: 50,
                imageUrl: user.driverImage ?? '',
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error),
              ),
            ),
            title: Text(
                user.name??'No  Name',maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black54)
            ),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.email,style: TextStyle(color:Colors.blue.shade300,fontSize: 10),),
                Text(user.phone.toString(),style: TextStyle(color:Colors.red.shade400,fontSize: 8),),
              ],
            ),

          ),
        ),
      );
    },
    itemCount:provider.driverList.length ,
  ),
),
    );
  }}
