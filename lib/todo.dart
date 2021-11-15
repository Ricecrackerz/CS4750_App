import 'package:cs4750_app/widget.dart';
import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 32.0,
          ),
          color: Color(0xFFFAF9F9),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
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
                  TaskCardWidget(
                    title: "Get Started!",
                    desc: "Hello! Welcome to Productivity Pal! My name is Pete and this is what a default task looks like. You can edit or delete these tasks!",
                  ),
                  TaskCardWidget(
                      title: "Get Started!",
                      desc: "",
                  ),
                ],
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
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
            ],
          ),
        ),
      ),
    );
  }
}
