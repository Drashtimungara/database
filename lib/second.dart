import 'package:database/main.dart';
import 'package:database/third%20page.dart';
import 'package:flutter/material.dart';

class sec extends StatefulWidget {


  @override
  State<sec> createState() => _secState();
}

class _secState extends State<sec> {
  List<Map> list = [];
  List<Map> list1 = [];
  bool s=false;
  bool t=false;
  bool d=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  get() async {
    print("hello");
    String sql = "select * from Student";
    await first.database!.rawQuery(sql).then((value) {
      list = value;
      list1=list;
      print(list);
      t=true;
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           title: (d)?TextField(
             onChanged: (value) {
                 list=list1.where((element) => element['contact'].toString().contains(value)).toList();
                 setState(() {

                 });
             },
             cursorColor: Colors.white,
           ):Text("View data"),
          actions: [
            IconButton(onPressed: () {
                  d=!d;
                  setState(() {

                  });
            }, icon:(d)?Icon(Icons.close):Icon(Icons.search))
          ],
        ),
        body:(t)? ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text("${list[index]['name']}"),
                subtitle: Text("${list[index]['contact']}"),
                trailing: PopupMenuButton(
                    itemBuilder: (context) =>
                    [ PopupMenuItem(
                        child: InkWell(onTap: () {
                          String sql = "delete from Student where id = '${list[index]['id']}'";
                          first.database!.rawDelete(sql);
                          print(sql);
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) {
                            return sec();
                          },));
                          setState(() {

                          });
                        },
                          child: Row(
                            children: [
                              Icon(Icons.delete),
                              Text("Delete")
                            ],
                          ),
                        )),
                      PopupMenuItem(
                          child: InkWell(onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) {
                              return first(list[index]['id'],list[index]['Name'],list[index]['Email'],list[index]['Contact']);
                            },));
                          },
                            child: Row(
                              children: [
                                Icon(Icons.edit),
                                Text("Edit")
                              ],
                            ),
                          )),
                    ]),
              ),
            );
          },
        ):CircularProgressIndicator());
  }
}
