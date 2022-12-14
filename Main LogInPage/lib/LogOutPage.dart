import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'LogInPage.dart';

class LogOutPage extends StatefulWidget {

  final String? URL;
  final String? ID;
  LogOutPage({this.URL, this.ID});

  @override
  State<LogOutPage> createState() => _LogOutPageState();
}

class _LogOutPageState extends State<LogOutPage> {
  static final storage = FlutterSecureStorage();

  String? URL;
  String? ID;
  @override
  void initState()
  {
    super.initState();
    URL = widget.URL;
    ID = widget.ID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("URL : " + URL!, style: TextStyle(fontFamily: 'Spoqa-Bold', fontSize: 12.0)),
              Container(height:5),
              Text("MetaMask ID : " + ID!, style: TextStyle(fontFamily: 'Spoqa-Bold', fontSize: 10.0)),
              Container(height: 5),
              Text("로그아웃 하시겠습니까?", style: TextStyle(fontFamily: 'Spoqa-Bold', fontSize: 30.0)),
              Container(height: 10),
              FloatingActionButton.extended(
                onPressed: (){
                  storage.delete(key: "login");
                  storage.delete(key: "MetaMask");
                  storage.delete(key: "NickName");
                  storage.delete(key: "is_Finish");
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => LogInPage()
                    ),
                  );
                },
                backgroundColor: Colors.redAccent,
                label: Text('Log Out', style: TextStyle(fontFamily: 'Spoqa-Bold', fontSize: 24.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
