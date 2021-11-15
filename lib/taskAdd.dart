
import 'package:cs4750_app/database.dart';
import 'package:cs4750_app/task.dart';
import 'package:cs4750_app/todoModel.dart';
import 'package:cs4750_app/widget.dart';
import 'package:flutter/material.dart';

class TaskAdd extends StatefulWidget {
  final Task task;
  TaskAdd({@required this.task});

  @override
  _TaskAddState createState() => _TaskAddState();
}

class _TaskAddState extends State<TaskAdd> {

  DatabaseHelper _dbHelper = DatabaseHelper();

  int _taskId = 0;
  String _taskTitle = "";

  @override
  void initState() {
    if(widget.task != null){
      _taskTitle = widget.task.title;
      _taskId = widget.task.id;
    }
  }

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

                                  if(widget.task == null){

                                    Task _newTask = Task(
                                        title: value
                                    );

                                    await _dbHelper.insertTask(_newTask);
                                  }else {

                                  }
                                }
                              },
                              controller: TextEditingController()..text = _taskTitle,
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
                  FutureBuilder(
                    initialData: [],
                    future: _dbHelper.getTodos(_taskId),
                    builder: (context, snapshot) {
                      return Expanded(
                        child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index){
                          return GestureDetector(
                            onTap: () {

                            },
                            child: TodoWidget(
                              text: snapshot.data[index].title,
                              isChecked: snapshot.data[index].isChecked == 0 ? false : true,

                            ),
                          );
                        },
                      ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          margin: EdgeInsets.only(
                            right: 12.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: Color(0xFF89B0AE),
                              width: 1.5,
                            ),
                          ),
                          child: Image(
                            image: AssetImage(
                                'assets/images/check_icon.png'
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onSubmitted: (value) async {
                              if(value != ""){

                                if(widget.task != null){
                                  DatabaseHelper _dbHelper = DatabaseHelper();

                                  TodoModel _newTodo = TodoModel(
                                      title: value,
                                    isChecked: 0,
                                    taskId: widget.task.id,
                                  );

                                  await _dbHelper.insertTodo(_newTodo);
                                  setState(() {});
                                }
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Enter Todo Item..",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
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
