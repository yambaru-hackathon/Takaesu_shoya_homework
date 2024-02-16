import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'タイマー'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
  int ms = 0;
  int second = 0;
  int minute = 0;
  Timer? _timer;
  bool isrunning = false;

  @override
  void initState() {
    super.initState();
  }

  void _toggletimer(){
    if(isrunning){
      _timer?.cancel();
    }
    else{
      _timer = Timer.periodic(
        const Duration(milliseconds: 1),
        (timer){
          setState((){
            if(ms >= 999){
              ms = 0;
              if(second >= 59){
                second = 0;
                minute++;
              }
              else{
                second++;
              }
            }
            else{
              ms++;
            }
          });
        }
      );
    }
    isrunning = !isrunning;
  }
  void _resettimer(){
    setState((){
      minute = 0;
      second = 0;
      ms = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    String printminute = minute.toString().padLeft(2, '0');
    String printsecond = second.toString().padLeft(2, '0');
    String printms = (ms ~/ 10).toString().padLeft(2, '0');
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$printminute:$printsecond.$printms',
              style: const TextStyle(fontSize: 80),
            ),
            ElevatedButton(
              onPressed: _toggletimer,
              child: Text(
                !isrunning ? 'start' : 'stop',
                style: TextStyle(
                  color: isrunning ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ), 
            ),
            ElevatedButton(
              onPressed: _resettimer,
              child: const Text(
                'reset',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )
              ),
            )
          ],
        )
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
