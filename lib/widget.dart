import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskCardWidget extends StatelessWidget {
  final String title;
  final String desc;

  TaskCardWidget({this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0,
      ),
      margin: EdgeInsets.only(
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 0,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "(Unnamed Task)",
            style: TextStyle(
              color: Color(0xFF555B6E),
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10.0,
            ),
            child: Text(
              desc ?? "No Description Added.",
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF86829D),
                height: 1.5,

              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TodoWidget extends StatelessWidget {
  final String text;
  final bool isChecked;
  TodoWidget({this.text, this.isChecked});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
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
              color: isChecked ? Color(0xFF89B0AE) : Colors.transparent,
              borderRadius: BorderRadius.circular(6.0),
              border: isChecked ? null : Border.all(
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
          Flexible(
            child: Text(
                text ?? "Unnamed Todo",
                style: TextStyle(
                  color: isChecked ? Color(0xFF555B6E) : Color(0XFF86829D),
                  fontSize: 16.0,
                  fontWeight: isChecked ? FontWeight.bold : FontWeight.w500,
            ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class ProgressIcons extends StatelessWidget {
  final int total;
  final int done;

  const ProgressIcons({this.total, this.done});

  @override
  Widget build(BuildContext context) {
    final iconSize = 50.0;

    final doneIcon = Icon(
      Icons.beenhere,
      color: Color(0xFFFFD6BA),
      size: iconSize,
    );

    final notDoneIcon = Icon(
      Icons.beenhere_outlined,
      color: Color(0xFFFFD6BA),
      size: iconSize,
    );

    List<Icon> icons = [];

    for(int i = 0; i < total; i++){
      if(i < done){
        icons.add(doneIcon);
      }else {
        icons.add(notDoneIcon);
      }
    }

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: icons,
      ),
    );
  }

}

class PomodoroButton extends StatelessWidget {
  final Function onTap;
  final String text;
  PomodoroButton({this.onTap, this.text});

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Color(0xFF555B6E),
    primary: Color(0xFFBEE3DB),
    minimumSize: Size(200, 35),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: ElevatedButton(
        style: raisedButtonStyle,
          onPressed: onTap,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
      ),
    );
  }
}

class Quote extends StatelessWidget {

  var quote = "";
  var author = "";
  var bgColor;

  Quote({this.bgColor, this.quote, this.author});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      padding: EdgeInsets.only(
        left: 30,
        right: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Spacer(),
          Image.asset(
            "assets/images/quote.png",
            height: 30,
            width: 30,
            color: Color(0xFFFAF9F9),
          ),
          SizedBox(height: 30,),
          Text(
            quote ?? "Unknown Quote",
            style: GoogleFonts.lato(
              color: Color(0xFFFAF9F9),
              fontSize: 30,

            ),

          ),
          SizedBox(height: 30,),
          Text(
            author ?? "Unknown",
            style: GoogleFonts.lato(
              color: Color(0xFFFAF9F9),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Spacer(),
          Image.asset(
            "assets/images/logo.png",
            height: 200,
            width: 200,
            color: Color(0xFFFAF9F9),
          ),
        ],
      ),
    );
  }
}

