import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rice_timer/components/rice_timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        backgroundColor: Colors.black,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.majorMonoDisplayTextTheme(
          Typography.whiteMountainView,
        ),
        cardTheme: CardTheme(
            color: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.white))),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                primary: Colors.white, side: BorderSide(color: Colors.white))),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 600;
  CountdownTimerController _controller = CountdownTimerController(endTime: 0);

  @override
  void initState() {
    super.initState();
    _controller = CountdownTimerController(endTime: _endTime);
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _resetTimer() {
    setState(() {
      _endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 600;
      _controller.endTime = _endTime;
      _controller.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      "Big 1",
      "Big 2",
      "Small 1",
      "Small 1",
    ];

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: titles
            .map(
              (title) => Expanded(
                  child: Row(children: [
                RiceTimer(
                  title: title,
                )
              ])),
            )
            .toList(growable: false),
      ),
    ));
  }
}
