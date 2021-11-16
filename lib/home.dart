import 'dart:convert';

import 'package:cs4750_app/quoteModel.dart';
import 'package:cs4750_app/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:random_color/random_color.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var api = "https://type.fit/api/quotes";

  Future<List<dynamic>> getPost() async {
    final response = await http.get(Uri.parse('$api'));
    return postFromJson(response.body);
  }

  List<dynamic> postFromJson(String str){
    List<dynamic> jsonData = json.decode(str);
    jsonData.shuffle();
    return jsonData;
  }

  RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: getPost(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              return ErrorWidget(snapshot.error);
            }
            return PageView.builder(itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                var quoteModel = snapshot.data[index];
              return Quote(
                quote: quoteModel["text"],
                author: quoteModel["author"],
                bgColor: _randomColor.randomColor(
                  colorHue: ColorHue.multiple(
                    colorHues: [ColorHue.blue, ColorHue.purple, ColorHue.orange],
                  ),
                ),
              );
            });
          }else {
            return CircularProgressIndicator();
          }
        }
      ),
    );
  }
}
