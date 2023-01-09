import 'package:flutter/material.dart';
import 'Main_HomePage.dart';
import 'package:flutter/cupertino.dart';

class NFT_Reservation extends StatefulWidget {
  @override
  State<NFT_Reservation> createState() => _NFT_ReservationState();
}

class _NFT_ReservationState extends State<NFT_Reservation> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final standardDeviceWidth = 375;
    final Factor_Width = deviceWidth/standardDeviceWidth;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceHeight = 812;
    final Factor_Height = deviceHeight/standardDeviceHeight;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 27 * Factor_Height,
            ),
            Container(
              height: 98 * Factor_Height,
            ),
            Container(
              height: 233 * Factor_Height,
              width: 350 * Factor_Height,
              child: Image.asset(
                'assets/NFT_Reservation_Check.png',
                height: 233 * Factor_Height,
                width: 350 * Factor_Height,
              ),
            ),
            Container(
              height: 70 * Factor_Height,
            ),
            Container(
              height: 31 * Factor_Height,
              child: Text(
                'NFT 제작 요청 완료!!',
                style: TextStyle(
                  fontSize: 25 * Factor_Height,
                  fontFamily: 'Spoqa-Bold',
                  color: Color(0xFF3C3C3C),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 44 * Factor_Height,
            ),
            Container(
              height: 48 * Factor_Height,
              child: Column(
                children: [
                  Expanded(
                    child: Text(
                      '빠른 시일 내에 담당자가',
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
                      'NFT를 제작해드릴 것 입니다!',
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
              height: 25 * Factor_Height,
            ),
            Container(
              height: 46 * Factor_Height,
              child: Column(
                children: [
                  Expanded(
                    child: Text(
                      '구글 폼을 작성하지 않으신 분들은 뒤로가기',
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
                      '버튼을 눌러 꼭 작성해주시길 바랍니다 !',
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
              height : 51 * Factor_Height,
            ),
            Container(
              height: 53 * Factor_Height,
              child: Container(
                width: 300 * Factor_Width,
                child: GestureDetector(
                  onTap:()
                  {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(builder:
                          (context) => Main_HomePage()),
                    );
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
                          '홈화면으로 가기',
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
    );
  }
}
