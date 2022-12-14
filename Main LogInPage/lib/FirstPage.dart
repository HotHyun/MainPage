import 'package:flutter/material.dart';
import 'LogInPage.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'Main_HomePage.dart';
import 'wallet.dart';
import 'whoareyou.dart';

class FirstPage extends StatefulWidget{
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
{
  String? userInfo = '';
  String? ID = '';
  String? NickName = '';
  String? is_Finish = '';

  static final storage = new FlutterSecureStorage();

  @override
  void initState()
  {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async
  {
    userInfo = await storage.read(key: "login");
    ID = await storage.read(key: "MetaMask");
    NickName = await storage.read(key: "NickName");
    is_Finish = await storage.read(key: "is_Finish");
    print(userInfo);
    print(ID);
    print(NickName);
    print(is_Finish);

    if((userInfo != null) && (ID != null) && (NickName != null) && (is_Finish != null))
    {
      Timer(Duration(seconds: 2), (){
        Navigator.pushReplacement(
            context,
            CupertinoPageRoute(builder:
                (context) => Main_HomePage()));
      });
    }
    else
      {
        Timer(Duration(seconds: 2), (){

            Navigator.pushReplacement(
                context,
                CupertinoPageRoute(builder:
                    (context) => LogInPage()));
        });
      }
  }

  @override
  Widget build(BuildContext context)
  {
    final deviceWidth = MediaQuery.of(context).size.width;
    final standardDeviceWidth = 375;
    final Factor_Width = deviceWidth/standardDeviceWidth;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceHeight = 812;
    final Factor_Height = deviceHeight/standardDeviceHeight;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: Factor_Height * 32
            ),
            Container(
              height: Factor_Height * 304
            ),
            Container(
              child: Image.asset(
                'assets/LoGo.png',
                height: 140 * Factor_Height,
                width: 140 * Factor_Height,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: 207 * Factor_Height,
            ),
            Container(
              height: 30 * Factor_Height,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'from',
                      style: TextStyle(
                        fontFamily: 'Spoqa-Medium',
                        fontSize: (30*Factor_Height)/2,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'PAMS POSTECH',
                      style: TextStyle(
                        fontFamily: 'Spoqa-Bold',
                        color: Color(0xFFCD0051),
                        fontSize: (30*Factor_Height)/2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 99 * Factor_Height,
            ),
          ],
        ),
      ),
    );
  }
}