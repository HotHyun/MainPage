import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:polygon_clipper/polygon_border.dart';
import 'Profile_Edit_Page.dart';

class Profile_Page extends StatefulWidget {
  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> with TickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState(){
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _Build_First(),
          _Build_Second(),
        ],
      ),
    );
  }

  Widget _Build_First()
  {
    final deviceWidth = MediaQuery.of(context).size.width;
    final standardDeviceWidth = 375;
    final Factor_Width = deviceWidth/standardDeviceWidth;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceHeight = 812;
    final Factor_Height = deviceHeight/standardDeviceHeight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 244 * Factor_Height,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: (145 * Factor_Height + 28.6),
                        color: Colors.white,
                      ),
                      Container(
                        height: (145 * Factor_Height + 28.6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: const <Color>[
                              Color.fromRGBO(205, 0, 81, 0.6),
                              Color.fromRGBO(205, 0, 81, 0.8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 57 * Factor_Height,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 128 * Factor_Height,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0 * Factor_Width),
                height: 120 * Factor_Height,
                width: 120 * Factor_Height,
                child: Container(
                  child: ClipPolygon(
                    sides: 6,
                    borderRadius: 15.0, // Default 0.0 degrees
                    rotate: 90.0, // Default 0.0 degrees
                    child: Image.asset('assets/NFT_1.png', height: 91 * Factor_Height, width: 91 * Factor_Height),
                  ),
                  decoration: ShapeDecoration(
                    shape: PolygonBorder(
                      sides: 6,
                      borderRadius: 15.0,
                      rotate: 90.0,
                      border: BorderSide(color: Color(0xFFFAFAFA), width: 6),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          height: 30 * Factor_Height,
          margin: EdgeInsets.symmetric(horizontal: 18.0 * Factor_Width),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '최대현',
                style: TextStyle(
                  fontFamily: 'Spoqa-Bold',
                  fontSize: 24 * Factor_Height,
                ),
              ),
              Spacer(),
              Container(height: 18 * Factor_Height, width: 16 * Factor_Height, child: Image.asset('assets/coins 1.png')),
              Container(width : 5 * Factor_Height),
              Container(
                height: 23 * Factor_Height,
                width: 75 * Factor_Height,
                child: Text(
                  'PAM 320',
                  style: TextStyle(
                    fontFamily: 'Spoqa-Bold',
                    fontSize: 18 * Factor_Height,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18.0 * Factor_Width),
          height: 18 * Factor_Height,
          child: Text(
            '@choidaedae',
            style: TextStyle(
              fontFamily: 'Spoqa-Medium',
              fontSize: 14 * Factor_Height,
              color: Color(0xFF7C7C7C),
            ),
          ),
        ),
        Container(
          height: 24 * Factor_Height,
        ),
        Container(
          height: 45 * Factor_Height,
          margin: EdgeInsets.symmetric(horizontal: 18.0 * Factor_Width),
          child: Expanded(
            child: Text(
              '안녕하세요, 개발자의 꿈을 꾸고 있는 최대현이라고 합니다!',
              style: TextStyle(
                fontFamily: 'Spoqa-Medium',
                fontSize: 16 * Factor_Height,
              ),
            ),
          ),
        ),
        Container(
          height: 16 * Factor_Height,
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder:
                  (context) => Profile_Edit_Page()),
            );
          },
          child: Container(
            height: 30 * Factor_Height,
            margin: EdgeInsets.symmetric(horizontal: 18.0 * Factor_Width),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFE9E9E9),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Center(
                child: Text(
                  '프로필 편집',
                  style: TextStyle(
                    fontFamily: 'Spoqa-Medium',
                    fontSize: 15 * Factor_Height,
                    color: Color(0xFF2C2C2C),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 14 * Factor_Height,
        ),
        Container(
          height: 70 * Factor_Height,
          margin: EdgeInsets.symmetric(horizontal: 11.0 * Factor_Width),
          child: Row(
            children: [
              Container(
                child: ClipPolygon(
                  sides: 6,
                  borderRadius: 15.0, // Default 0.0 degrees
                  rotate: 90.0, // Default 0.0 degrees
                  boxShadows: [
                    PolygonBoxShadow(color: Colors.grey, elevation: 5.0),
                  ],
                  child: Image.asset('assets/NFT_1.png', height: 91 * Factor_Height, width: 91 * Factor_Height),
                ),
              ),
              Container(
                child: ClipPolygon(
                  sides: 6,
                  borderRadius: 15.0, // Default 0.0 degrees
                  rotate: 90.0, // Default 0.0 degrees
                  boxShadows: [
                    PolygonBoxShadow(color: Colors.grey, elevation: 5.0),
                  ],
                  child: Image.asset('assets/NFT_2.png', height: 91 * Factor_Height, width: 91 * Factor_Height),
                ),
              ),
              Container(
                child: ClipPolygon(
                  sides: 6,
                  borderRadius: 15.0, // Default 0.0 degrees
                  rotate: 90.0, // Default 0.0 degrees
                  boxShadows: [
                    PolygonBoxShadow(color: Colors.grey, elevation: 5.0),
                  ],
                  child: Image.asset('assets/NFT_3.png', height: 91 * Factor_Height, width: 91 * Factor_Height),
                ),
              ),
              Container(
                child: ClipPolygon(
                  sides: 6,
                  borderRadius: 15.0, // Default 0.0 degrees
                  rotate: 90.0, // Default 0.0 degrees
                  boxShadows: [
                    PolygonBoxShadow(color: Colors.grey, elevation: 5.0),
                  ],
                  child: Image.asset('assets/NFT_4.png', height: 91 * Factor_Height, width: 91 * Factor_Height),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 5 * Factor_Height,
        ),
      ],
    );
  }

  Widget _Build_Second()
  {
    final deviceWidth = MediaQuery.of(context).size.width;
    final standardDeviceWidth = 375;
    final Factor_Width = deviceWidth/standardDeviceWidth;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceHeight = 812;
    final Factor_Height = deviceHeight/standardDeviceHeight;

    return Container(
      height: 50 * Factor_Height,
      child: TabBar(
        isScrollable: false,
        tabs: [
          Container(
            width: 187.5 * Factor_Width,
            alignment: Alignment.center,
            child: Image.asset('assets/Resume_Icon.png', height: 30 * Factor_Height, width: 30 * Factor_Height),
          ),
          Container(
            width: 187.5 * Factor_Width,
            alignment: Alignment.center,
            child: Image.asset('assets/NFT_Icon.png', height: 30 * Factor_Height, width: 30 * Factor_Height),
          ),
        ],
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        labelColor: Colors.black,
        unselectedLabelColor: Color(0xFFDCDCDC),
        controller: _tabController,
      ),
    );
  }
  Widget _Build_Third()
  {
    return Container();
  }
  Widget _Build_Fourth()
  {
    return Container();
  }
  Widget _NFT_Third()
  {
    return Container();
  }
}
