
import 'package:cs4750_app/database.dart';
import 'package:cs4750_app/task.dart';
import 'package:cs4750_app/widget.dart';
import 'package:flutter/material.dart';

class TaskAdd extends StatefulWidget {

  @override
  _TaskAddState createState() => _TaskAddState();
}

class _TaskAddState extends State<TaskAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                    top: 24.0,
                    bottom: 6.0,
                  ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                        },
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Image(
                                image: AssetImage(
                                  'assets/images/back_arrow_icon.png'
                                ),
                              height: 25,
                              width: 25,
                            ),
                          ),
                        ),
                        Expanded(
                            child: TextField(
                              onSubmitted: (value) async {

                                if(value != ""){
                                  DatabaseHelper _dbHelper = DatabaseHelper();

                                  Task _newTask = Task(
                                    title: value
                                  );

                                 await _dbHelper.insertTask(_newTask);
                                }
                              },
                                decoration: InputDecoration(
                                  hintText: "Enter Task Title..",
                                  border: InputBorder.none,
                                ),
                              style: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF555B6E)
                              ),
                            ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.0,),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Task Description..",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                      ),
                    ),
                  ),
                  TodoWidget(
                    text: "Todo Task",
                    isChecked: true,
                  ),
                  TodoWidget(
                    text: "Todo Task",
                    isChecked: false,
                  ),
                  TodoWidget(
                    text: "Todo Task",
                    isChecked: false,
                  ),
                  TodoWidget(
                    text: "Todo Task",
                    isChecked: false,
                  ),
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 24.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => TaskAdd()
                    ),
                    );
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFD6BA),
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    child: Image(
                      image: AssetImage(
                          "assets/images/delete_icon.png"
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
