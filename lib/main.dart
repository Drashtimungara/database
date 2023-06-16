import 'package:database/second.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'main.dart';

void main() {
print("hello");
  // List l=["one","two","three","four","five"];
  // List l1=l.where((element) => element.toString().contains("f")).toList();
  // print(l1);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: first(),
  ));
}

class first extends StatefulWidget {
  static Database? database;
  int? id;
  String? name;
  String? contact;
  String? email;


  first([this.id, this.name,  this.contact, this.email]);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.id != null) {
      t1.text=widget.name!;
    }
    get();
  }

  get() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'First.db');

// open the database
    first.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Student (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT, email TEXT, contact TEXT)');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Base"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
                controller: t1,
                decoration: InputDecoration(
                    hintText: "Enter Name",
                    label: Text(
                      "Name",
                    ),
                    border: OutlineInputBorder())),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
                controller: t2,
                decoration: InputDecoration(
                    hintText: "Enter Email",
                    label: Text(
                      "Email",
                    ),
                    border: OutlineInputBorder())),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
                controller: t3,
                decoration: InputDecoration(
                    hintText: "Enter Contact",
                    label: Text(
                      "Contact",
                    ),
                    border: OutlineInputBorder())),
          ),
          ElevatedButton(
              onPressed: () {
                String name = t1.text;
                String email = t2.text;
                String contact = t3.text;
                if (widget.id != null) {
                  String sql =
                      "update Student set name='$name',email='$email',contact='$contact' where id='${widget.id}'";
                  first.database!.rawUpdate(sql);
                  print(sql);
                  setState(() {});
                } else {
                  String sql =
                      "insert into Student values(null,'$name','$email','$contact')";
                  first.database!.rawInsert(sql);
                  print(sql);
                  setState(() {});
                }
              },
              child: Text("SUMBIT")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return sec();
                  },
                ));
              },
              child: Text("VIEW")),
          ElevatedButton(onPressed: () {}, child: Text("UPLOD PHOTO"))
        ],
      ),
    );
  }
}
