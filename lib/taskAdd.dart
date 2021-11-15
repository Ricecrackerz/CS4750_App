
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
  String _taskDescription = "";

  FocusNode _titleFocus;
  FocusNode _descriptionFocus;
  FocusNode _todoFocus;

  bool _contentVisible = false;

  @override
  void initState() {
    if(widget.task != null){
      _contentVisible = true;

      _taskTitle = widget.task.title;
      _taskDescription = widget.task.description;
      _taskId = widget.task.id;
    }

    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();

    super.dispose();
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
                              focusNode: _titleFocus,
                              onSubmitted: (value) async {

                                if(value != ""){

                                  if(widget.task == null){

                                    Task _newTask = Task(
                                        title: value
                                    );

                                    _taskId = await _dbHelper.insertTask(_newTask);
                                    setState(() {
                                      _contentVisible = true;
                                      _taskTitle = value;
                                    });
                                  }else {
                                    await _dbHelper.updateTaskTitle(_taskId, value);
                                  }
                                  _descriptionFocus.requestFocus();
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
                  Visibility(
                    visible: _contentVisible,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12.0,),
                      child: TextField(
                        focusNode: _descriptionFocus,
                        onSubmitted: (value) async {
                          if(value != ""){
                            if(_taskId != 0){
                              await _dbHelper.updateTaskDescription(_taskId, value);
                              _taskDescription = value;
                            }
                          }
                          setState(() {});
                          _todoFocus.requestFocus();
                        },
                        controller: TextEditingController()..text = _taskDescription,
                        decoration: InputDecoration(
                          hintText: "Enter Task Description..",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTodos(_taskId),
                      builder: (context, snapshot) {
                        return Expanded(
                          child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index){
                            return GestureDetector(
                              onTap: () async {
                                if(snapshot.data[index].isChecked == 0){
                                  await _dbHelper.updateTodo(snapshot.data[index].id, 1);
                                }else {
                                  await _dbHelper.updateTodo(snapshot.data[index].id, 0);
                                }
                                setState(() {});
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
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: Padding(
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
                              focusNode: _todoFocus,
                              controller: TextEditingController().. text = "",
                              onSubmitted: (value) async {
                                if(value != ""){

                                  if(_taskId != 0){
                                    DatabaseHelper _dbHelper = DatabaseHelper();

                                    TodoModel _newTodo = TodoModel(
                                        title: value,
                                      isChecked: 0,
                                      taskId: _taskId,
                                    );

                                    await _dbHelper.insertTodo(_newTodo);
                                    setState(() {});
                                    _todoFocus.requestFocus();
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
                  ),
                ],
              ),
              Visibility(
                visible: _contentVisible,
                child: Positioned(
                  bottom: 24.0,
                  right: 24.0,
                  child: GestureDetector(
                    onTap: () async {
                      if(_taskId !=0) {
                        await _dbHelper.deleteTask(_taskId);
                        Navigator.pop(context);
                      }
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
              ),
              Visibility(
                visible: !_contentVisible,
                child: Container(
                  margin: EdgeInsets.only(
                      top: 0.0,
                      left: 275.0,
                  ),
                  child: Image(
                    image: AssetImage(
                      "assets/images/new_task_pal.png",
                    ),
                    height: 150.0,
                    width: 150.0,
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
