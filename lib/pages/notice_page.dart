import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:transpor_guidance_admin/providers/bus_provider.dart';

class NoticePage extends StatefulWidget {
  static const String routeName = '/notice';
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  final titleController = TextEditingController();
  final msgController = TextEditingController();
  @override
  void dispose() {
  titleController.dispose();
  msgController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
      Row(
        children: [
          Image.asset('assets/logo2.png',height: 70,width: 70,),
          Center(child: Text('Notice',style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 15))),
        ],
      ),
        backgroundColor: Colors.white,elevation: 0,foregroundColor: Colors.black54,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller:titleController ,
              decoration: InputDecoration(hintText: 'Heading..',icon: Icon(Icons.wysiwyg_rounded,color: Colors.blueAccent.shade100,),),

            ),
          ), Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller:msgController ,
              decoration: InputDecoration(
                hintText: 'Description..',border: OutlineInputBorder(),
                //icon: Icon(Icons.mark_as_unread,color: Colors.redAccent.shade100,),
              ),
maxLines: 7,

            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            FloatingActionButton.small(heroTag: 1,
              onPressed: (){},backgroundColor:Colors.redAccent.shade100 ,
            child: Icon(Icons.image_outlined,color:Colors.white ),
            ),  FloatingActionButton.small(heroTag: 2,
              onPressed: (){},backgroundColor:Colors.redAccent.shade100 ,
            child: Icon(Icons.file_present,color:Colors.white ),
            ),  FloatingActionButton.small(heroTag: 3,
              onPressed: (){},backgroundColor:Colors.redAccent.shade100 ,
            child: Icon(Icons.send,color:Colors.white ),
            ),
          ],)
        ],
      ),
        );
  }


}
