import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transpor_guidance_admin/providers/userProvider.dart';

class UserPage extends StatefulWidget {
  static const String routeName ='/user';
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String name="";
  final TextEditingController searchBarTech = TextEditingController();
  @override
  void dispose() {
searchBarTech.dispose();
super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        foregroundColor: Colors.black54,
        title: Row(
          children: [
            Image.asset(
              'assets/logo2.png',
              height: 70,
              width: 70,
            ),
            Center(
                child: Text('Users ',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15))),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
     body: Column(
       children: [Padding(
         padding: const EdgeInsets.all(8.0),
         child: TextField(
controller:searchBarTech ,

           onChanged: (value) {
             setState(() {
               name =value;
             });
           },
           decoration: InputDecoration(
             hoverColor: Colors.white12,
             border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
               suffixIcon:  IconButton(icon: Icon(Icons.cancel,color: Colors.lightBlueAccent,),onPressed: (){
                 setState(() {
                   searchBarTech.clear();
                   name="";

                 });
               },),
               prefixIcon: Icon(Icons.search,color: Colors.black,),
               hintText: 'Search user name here..',hintStyle: TextStyle(
             color: Colors.black54, fontSize: 10
           )
           ),
         ),
       ),
       Flexible(flex: 1,
          child: Consumer<UserProvider>(
            builder: (context, provider, child) => ListView.builder(
              itemBuilder:(context, index) {
                final user = provider.userList[index];
                return
                name.isEmpty?
                ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(180),


                      child:user.imageUrl==null?Image.asset('assets/icon2.png',fit: BoxFit.cover,)
                          : CachedNetworkImage(
                        width: 70,
                        height: 80,
                        fit: BoxFit.cover,
                        imageUrl: user.imageUrl ?? '',
                        placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    ),
                    title: Text(
                      user.name??'No  Name',maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black54),
                    ),
                    subtitle: Text(user.email,style: TextStyle(color:Colors.blue.shade200,fontSize: 8),),
                    trailing: Text(user.versityId??'',style: TextStyle(color:Colors.redAccent.shade100,fontSize: 8),),

                  ):user.name.toString().toLowerCase().startsWith(name.toLowerCase())?ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(180),


                    child:user.imageUrl==null?Image.asset('assets/icon2.png',fit: BoxFit.cover,)
                        : CachedNetworkImage(
                      width: 70,
                      height: 80,
                      fit: BoxFit.cover,
                      imageUrl: user.imageUrl ?? '',
                      placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    ),
                  ),
                  title: Text(
                    user.name??'No  Name',maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black54),
                  ),
                  subtitle: Column(
                    children: [
                      Text(user.email,style: TextStyle(color:Colors.blue.shade200,fontSize: 8),),
                      Text(user.department??"",style: TextStyle(color:Colors.black45,fontWeight:FontWeight.bold,fontSize: 8),),
                    ],
                  ),
                  trailing: Text(user.versityId??'',style: TextStyle(color:Colors.redAccent.shade100,fontSize: 8),),

                ):SizedBox.shrink();
              },
              itemCount:provider.userList.length ,
            ),
          ),
        ),
       ],
     ),
    );
  }}
