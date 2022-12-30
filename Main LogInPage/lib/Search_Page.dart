import 'package:flutter/material.dart';

class Search_Page extends StatefulWidget {
  @override
  State<Search_Page> createState() => _Search_PageState();
}

class _Search_PageState extends State<Search_Page> {

  var _NextController1 = TextEditingController();

  @override
  void dispose()
  {
    _NextController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final standardDeviceWidth = 375;
    final Factor_Width = deviceWidth / standardDeviceWidth;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceHeight = 812;
    final Factor_Height = deviceHeight / standardDeviceHeight;

    return GestureDetector(
      onTap: ()
      {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0 * Factor_Height, horizontal: 17.0 * Factor_Width),
              height: 34.0 * Factor_Height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFFD9D9D9),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0 * Factor_Height),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Color(0xFF8E8E8E),),
                    Container(width: 6.0 * Factor_Width),
                    Container(
                      width: 275 * Factor_Width,
                      child: TextField(
                        controller: _NextController1,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 15 * Factor_Width,
                            fontFamily: "Spoqa-Regular",
                            color: Color(0xFF979797),
                          ),
                          hintText: '검색'
                        ),
                        style: TextStyle(
                          fontSize: 14.4 * Factor_Width,
                          fontFamily: "Spoqa-Regular",
                          color: Color(0xFF3C3C3C),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 652 * Factor_Height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset('assets/Group 45.png', height: 233 * Factor_Height, width: 350 * Factor_Height),
                  ),
                  Container(height: 17 * Factor_Height),
                  Container(
                    height: 42 * Factor_Height,
                    child: Column(
                      children: [
                        Expanded(
                          child: Text(
                            '다른 사람들의 프로필을 구경해보세요 !!',
                            style: TextStyle(
                              fontSize: 15 * Factor_Height,
                              fontFamily: 'Spoqa-Medium',
                              color: Color(0xFF2C2C2C),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '검색 버튼에 조회하고 싶은 사람의 이름을 적어보세요 !!',
                            style: TextStyle(
                              fontSize: 15 * Factor_Height,
                              fontFamily: 'Spoqa-Medium',
                              color: Color(0xFF2C2C2C),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
