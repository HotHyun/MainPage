import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'wallet.dart';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'Main_HomePage.dart';

import 'LogOutPage.dart';

class LogInPage extends StatefulWidget{
  @override
  _LogInPageState createState() => _LogInPageState();
}

class POSTECH_Information
{
  String? URL;

  POSTECH_Information(this.URL);
}

List<String> URL = [];
List<String> URL_Split = [];
List<int> check = [0];

class _LogInPageState extends State<LogInPage>
{
  var _NextController1 = TextEditingController();

  String? userInfo = "";

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
    print(userInfo);
  }

  @override
  void dispose()
  {
    _NextController1.dispose();
    super.dispose();
  }

  void _add_Information(POSTECH_Information information)
  {
    setState(() {
      FirebaseFirestore.instance.collection('UGRP').add(
        {'URL' : information.URL}
      );
      _NextController1.text = '';
    });
  }

  Future _callAPI(String URL) async {
    var url = Uri.parse(
      'http://3.35.47.46/pams/' + URL,
    );
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if(response.body == '{}')
      {
        _NextController1.text = "";
      }
    else
      {
        await storage.write(
          key: "login",
          value: "URL " + URL,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder:
              (context) => wallet()),
        );
      }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final standardDeviceWidth = 375;
    final Factor_Width = deviceWidth/standardDeviceWidth;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceHeight = 812;
    final Factor_Height = deviceHeight/standardDeviceHeight;
    return GestureDetector(
      onTap: ()
      {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 29 * Factor_Height,
              ),
              Container(
                height: 50 * Factor_Height,
              ),
              Container(
                height: 205 * Factor_Height,
                width: 312 * Factor_Height,
                child: Image.asset(
                  'assets/LogIn.png',
                  height: 205 * Factor_Height,
                  width: 312 * Factor_Height,
                ),
              ),
              Container(
                height: 45 * Factor_Height,
              ),
              Container(
                height: 39 * Factor_Height,
                child: Text(
                  '환영합니다!',
                  style: TextStyle(
                    fontSize: 32 * Factor_Height,
                    fontFamily: 'Spoqa-Bold',
                    color: Color(0xFF3C3C3C),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: 23 * Factor_Height,
              ),
              Container(
                height: 46 * Factor_Height,
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        '본인 확인, 계정 생성을 위해 POVIS',
                        style: TextStyle(
                          fontSize: 18 * Factor_Height,
                          fontFamily: 'Spoqa-Medium',
                          color: Color(0xFF797979),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'ID와 Password를 작성해주세요!',
                        style: TextStyle(
                          fontSize: 18 * Factor_Height,
                          fontFamily: 'Spoqa-Medium',
                          color: Color(0xFF797979),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 93 * Factor_Height,
              ),
              Container(
                height: 32 * Factor_Height,
                child: Row(
                  children: [
                    Container(
                      width: 54 * Factor_Width,
                    ),
                    Container(
                      height: 32 * Factor_Width,
                      width: 32 * Factor_Width,
                      child: Image.asset(
                        'assets/ID.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: Factor_Width * 27
                    ),
                    Container(
                      width: 200 * Factor_Width,
                      child: TextField(
                        controller: _NextController1,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFBFBFBF),
                            )
                          ),
                        hintStyle: TextStyle(
                          fontSize: 14.4 * Factor_Width,
                          fontFamily: "Spoqa-Regular",
                          color: Color(0xFF818181),
                        ),
                        hintText: "URL을 입력해주세요",
                        ),
                        style: TextStyle(
                          fontSize: 14.4 * Factor_Width,
                          fontFamily: "Spoqa-Regular",
                          color: Color(0xFF3C3C3C),
                        ),
                      ),
                    ),
                    Container(
                      width: 62 * Factor_Width,
                    ),
                  ],
                ),
              ),
              Container(
                height: 34 * Factor_Height,
              ),
              Container(
                height: 80 * Factor_Height,
              ),
              Container(
                height: 53 * Factor_Height,
                child: Container(
                  width: 300 * Factor_Width,
                  child: GestureDetector(
                    onTap:()
                    {

                      URL.clear();
                      URL_Split.clear();
                      URL.add(_NextController1.text);
                      URL_Split = URL[0].split("=");
                      URL = URL_Split[1].split("&");
                      _NextController1.text = '';
                      _callAPI(URL[0]);
                      _add_Information(POSTECH_Information(URL[0]));
                      URL.clear();
                      URL_Split.clear();

                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder:
                            (context) => wallet()),
                      ); // 일단 넣어놓기 서버 안열리면 쓰게*/
                    },
                    child: Stack(
                      children: [
                        Center(
                          child: Opacity(
                            opacity: 0.73,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFCD0051),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              width: 300 * Factor_Width,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            '계정 생성하기',
                            style: TextStyle(
                              fontSize: 17 * Factor_Width,
                              fontFamily: 'Spoqa-Bold',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 83 * Factor_Height,
              ),
            ] ,
          ),
        ),
      ),
    );
  }
}
