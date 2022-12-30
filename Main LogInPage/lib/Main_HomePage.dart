import 'package:flutter/material.dart';

import 'Home_Page.dart';
import 'Search_Page.dart';
import 'Request_Page.dart';
import 'Request_Information.dart';
import 'Profile_Page.dart';
import 'package:flutter/services.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'LogOutPage.dart';


class MyApp extends StatelessWidget
{
  static final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context)
  {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __)
      {
        return MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.white,
          ),
          darkTheme: ThemeData.dark(),
          themeMode: currentMode,
          home: Main_HomePage(),
          debugShowCheckedModeBanner: false,
        );
      }
    );
  }
}

class Main_HomePage extends StatefulWidget {

  @override
  State<Main_HomePage> createState() => _Main_HomePageState();
}

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  int? num;
  EmptyAppBar({this.num});

  @override
  Widget build(BuildContext context) {
    if(num == 3)
    {
      return AppBar(backgroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const <Color>[
                Color.fromRGBO(205, 0, 81, 0.6),
                Color.fromRGBO(205, 0, 81, 0.8),
              ],
            ),
          ),
        ),
        elevation: 0,
      );
    }
    else
      {
        return AppBar(elevation: 0, backgroundColor: Colors.transparent,);
      }
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}

class _Main_HomePageState extends State<Main_HomePage> {

  static final storage = FlutterSecureStorage();

  var _index = 0;
  var _pages = [
    Home_Page(),
    Search_Page(),
    Request_Information(),
    Profile_Page(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (_index != 1 && _index != 3) ? AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () async {
            String? userInfo = '';
            String? ID = '';
            userInfo = await storage.read(key: "login");
            ID = await storage.read(key: "MetaMask");
            print(userInfo);
            print(ID);

            if(userInfo != null)
            {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder:
                    (context) => LogOutPage(
                  URL: userInfo!.split(" ")[1],
                      ID: ID!.split(" ")[1],
                )),
              );
            }
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const <Color>[
                Color.fromRGBO(205, 0, 81, 0.6),
                Color.fromRGBO(205, 0, 81, 0.8),
              ],
            ),
          ),
        ),
        title: Text(
          'PAM+NET',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Spoqa-Medium',
          ),
        ),
        centerTitle: true,
      )
          : EmptyAppBar(num: _index),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Spoqa-Medium',
        ),
        selectedLabelStyle: TextStyle(
          fontFamily: 'Spoqa-Medium',
        ),
        selectedItemColor: Color(0xFFCD0051),
        unselectedItemColor: Color(0xFFC9C9C9),
        onTap: (index)
        {
          setState(() {
            if(index != 2)
              {
                _index = index;
              }
            else
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder:
                      (context) => Request_Page()),
                );
              }
          });
        },
        currentIndex: _index,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: '홈',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: '검색',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: '요청',
            icon: Icon(Icons.add_circle),
          ),
          BottomNavigationBarItem(
            label: '프로필',
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}