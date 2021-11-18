import 'package:cs4750_app/nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
    child: IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'A Lightweight App',
          body: "Let's cut to the chase and get things done.",
          image: buildImage('./assets/images/lightweight.png'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: 'Get Inspired',
          body: 'Infinite quotes to read from, all inspiring.',
          image: buildImage('./assets/images/meditate.png'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: 'Task Management',
          body: 'Built-in task management system to get things done on time.',
          image: buildImage('./assets/images/ontime.png'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: 'Pomodoro Technique',
          body: 'Stay focused and get more done with the built-in pomodoro timer.',
          image: buildImage('./assets/images/focus.png'),
          decoration: getPageDecoration(),
        ),
      ],
      done: Text(
          "Lets Go!",
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Color(0xFFFAF9F9),
          )),
      onDone: () => goToNav(context),
      next: Icon(
          Icons.arrow_forward,
          color: Color(0xFFFAF9F9),
      ),
      dotsDecorator: getDotDecoration(),
      onChange: (index) => print('Page $index selected'),
      globalBackgroundColor: Color(0xFF89B0AE),
      skipFlex: 0,
      nextFlex: 0,
    ),
  );

  void goToNav(context) => Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => Nav()),
  );

  Widget buildImage(String path) =>
      Center(
        child: Image.asset(
          path,
          width: 350,
      ),
      );

  DotsDecorator getDotDecoration() => DotsDecorator(
    activeColor: Color(0xFF555B6E),
    color: Color(0xFFFAF9F9),
    //activeColor: Colors.orange,
    size: Size(10, 10),
    activeSize: Size(22, 10),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );

  PageDecoration getPageDecoration() => PageDecoration(
    contentMargin: EdgeInsets.symmetric(vertical: 20),
    titleTextStyle: GoogleFonts.lora(
        fontSize: 28,
        fontWeight: FontWeight.bold,
    ),
    bodyTextStyle: GoogleFonts.inter(
        fontSize: 20,
    ),
    descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
    imagePadding: EdgeInsets.all(24),
    pageColor: Color(0xFFFAF9F9),
  );
}