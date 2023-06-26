import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transpor_guidance_admin/providers/userProvider.dart';

class UserPage extends StatelessWidget {
  static const String routeName ='/user';
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('users'),),
     body: Consumer<UserProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemBuilder:(context, index) {
            final user = provider.userList[index];
            return ListTile(
              leading: Container(   width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(180)

                ),
                child:user.imageUrl==null?Image.asset('assets/icon2.png',fit: BoxFit.cover,)
                    : CachedNetworkImage(
                  width: 50,
                  height: 50,
                  imageUrl: user.imageUrl ?? '',
                  placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                ),
              ),
              title: Text(
                  user.name??'No  Name'
              ),
              subtitle: Text(user.email),
              trailing: Text(user.versityId??''),
            );
          },
          itemCount:provider.userList.length ,
        ),
      ),
    );
  }}
