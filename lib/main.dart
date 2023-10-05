import 'dart:async';

import 'package:flutter/material.dart';
import 'package:painter_practice/smily_painter.dart';
import 'package:painter_practice/speedo_meter_painter.dart';
import 'package:painter_practice/watch_painter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color? color = Colors.yellow;
  double _counter = 0;
  double _smileStrength = 0.3;
  double _radiusDecider = 0.7;
  bool isDigits = false;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      _counter < 1 ? _counter += 0.1 : _counter = 0.1;
      setState(() {
        _smileStrength > -0.25 ? _smileStrength -= 0.05 : _smileStrength = 0.25;
        if (_counter <= 0.5) {
          _radiusDecider -= 0.1;
        } else {
          _radiusDecider += 0.1;
        }
        if (_radiusDecider >= 0.7) {
          _radiusDecider -= 0.1;
        }
        if (_radiusDecider == 0) {
          _radiusDecider = 0.1;
        }
        if (_smileStrength == 0) _smileStrength = -0.05;
        color = Color.lerp(Colors.yellow, Colors.red, _counter);
      });
    });
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        isDigits = !isDigits;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var Size(:width, :height) = MediaQuery.sizeOf(context);
    height -= kToolbarHeight;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: width * 0.2,
                  height: height * 0.35,
                  child: CustomPaint(
                    painter: SmileyPainter(
                      faceColor: color,
                      smileStrength: _smileStrength,
                      eyeBallRadiusDecider: _radiusDecider,
                    ),
                  ),
                ),
                SizedBox(
                  width: 300, //width * 0.2,
                  height: 300, //height * 0.35,
                  child: CustomPaint(
                    painter:
                        WatchPainter(now: DateTime.now(), isDigits: isDigits),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 500,
                  height: 500,
                  child: CustomPaint(
                    painter: SpeedoMeterPainter(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
