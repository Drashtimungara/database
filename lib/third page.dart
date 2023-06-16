import 'package:database/main.dart';
import 'package:database/second.dart';
import 'package:flutter/material.dart';

class trd extends StatefulWidget {
  int id;
  String name;
  String email;
  String contact;
  trd(this.id,this.name,this.email,this.contact);



  @override
  State<trd> createState() => _trdState();
}

class _trdState extends State<trd> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.id!=null)
      {
        t1.text = widget.name ;
        t2.text = widget.email ;
        t3.text = widget.contact ;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Data Base"),),
      body: Column(children: [
        TextField(controller: t1,
            ),
        TextField(controller: t2,
            ),
        TextField(controller: t3,
            ),
        ElevatedButton(onPressed: () {
          String name = t1.text;
          String email = t2.text;
          String contact = t3.text;


        }, child:Text("Edit")),
        ElevatedButton(onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) {
            return sec();
          },));
        }, child:Text("View"))
      ],),
    );
  }
}
