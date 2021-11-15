import 'package:cs4750_app/database.dart';
import 'package:cs4750_app/taskAdd.dart';
import 'package:cs4750_app/widget.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {

  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: 24.0,
          ),
          color: Color(0xFFFAF9F9),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 67.0,
                  left: 75.0,
                ),
                child: Text(
                    "My Tasks",
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: Color(0xFF555B6E),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 32.0,
                      bottom: 32.0,
                    ),
                    child: Image(
                      image: AssetImage(
                        'assets/images/mascot.png'
                      ),
                      height: 70,
                      width: 70,
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTasks(),
                      builder: (context, snapshot) {
                        return ScrollConfiguration(
                          behavior: NoGlowBehaviour(),
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                              itemBuilder: (context, index){
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => TaskAdd(
                                      task: snapshot.data[index],
                                    ))
                                    ).then((value) {
                                      setState(() {});
                                    });
                                  },
                                  child: TaskCardWidget(
                                    title: snapshot.data[index].title,
                                    desc: snapshot.data[index].description,
                                  ),
                                );
                              },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 5.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => TaskAdd(task: null),
                    ),
                    ).then((value) {
                      setState(() {
                      });
                    }
                    );
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFBEE3DB),
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    child: Image(
                      image: AssetImage(
                        "assets/images/add_icon.png"
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
