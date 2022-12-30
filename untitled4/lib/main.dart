import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Jeongmin_s_App(),
        ),
      ),
    );
  }
}

class Jeongmin_s_App extends StatefulWidget {
  const Jeongmin_s_App({Key? key}) : super(key: key);

  @override
  State<Jeongmin_s_App> createState() => _Jeongmin_s_AppState();
}

class _Jeongmin_s_AppState extends State<Jeongmin_s_App> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children: [
            Container(
                color: Colors.red
            ),
            Text(
              '허정민',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 30,
              ),
            ),
            Container(
              color: Colors.black,
            ),
          ],
        ),
    );
  }
}
