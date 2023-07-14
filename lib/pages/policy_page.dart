import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transpor_guidance_admin/providers/bus_provider.dart';

class PolicyPage extends StatelessWidget {
  static const String routeName ='/policy';
  const PolicyPage({Key? key}) : super(key: key);

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
                child: Text('Policy ',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15))),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<BusProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemBuilder:(context, index) {
            final notice = provider.notice[index];
            return Flexible(flex: 1,
              child:
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(height: 400,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                                children: [ Container(   width: double.infinity,
                                  height: 200,

                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(180)

                                  ),
                                  child:notice.image==null?Image.asset('assets/icon5.png',fit: BoxFit.cover,)
                                      : CachedNetworkImage(
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                    imageUrl: notice.image ?? '',
                                    placeholder: (context, url) =>
                                    const Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                  ),
                                ),
                                  Text(
                                    notice.Noticetitle,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                                ),
                                  Text(notice.message,style: TextStyle(color: Colors.black54, fontSize: 8),),
                                  Text(notice.date,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.lightBlue, fontSize: 8),),
                                ],
                              )


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount:provider.notice.length ,
        ),
      ),
    );
  }}
