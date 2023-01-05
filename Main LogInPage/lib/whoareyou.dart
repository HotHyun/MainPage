import 'package:flutter/material.dart';
import 'letsgo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class whoareyou extends StatefulWidget {
  @override
  _whoareyouState createState() => _whoareyouState();
}

class user_Information {
  String? Nickname;

  user_Information(this.Nickname);
}

class _whoareyouState extends State<whoareyou> {

  final NicknameController = TextEditingController();

  static final storage = FlutterSecureStorage();

  String? userInfo = '';
  String? User_Name = '';

  void _add_Information(user_Information information) async
  {
    userInfo = await storage.read(key: "login");
    User_Name = await storage.read(key: "NickName");
    await storage.write(
      key: "NickName",
      value: "NickName " + information.Nickname!,
    );
    setState(() {
      FirebaseFirestore.instance.collection('users').doc(userInfo!.split(" ")[1]).collection('Profile').doc('Nickname').set(
          {'Nickname' : information.Nickname}
      );
      NicknameController.text = '';
    });
  }

  @override
  void dispose() {
    NicknameController.dispose();
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
      onTap: () {
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
                // 공백
                height: 23 * Factor_Height,
              ),
              Container(
                // 사진
                height: 225 * Factor_Height,
                width: 312 * Factor_Height,
                child: Image.asset(
                  'assets/whoareyou.png',
                  height: 225 * Factor_Height,
                  width: 312 * Factor_Height,
                ),
              ),
              Container(
                // 공백
                height: 54 * Factor_Height,
              ),
              Container(
                // '당신은 어떤 사람인가요?' 텍스트
                height: 33 * Factor_Height,
                child: Text(
                  '당신은 어떤 사람인가요?',
                  style: TextStyle(
                    fontSize: 30 * Factor_Height,
                    fontFamily: 'Spoqa-Bold',
                    color: Color(0xFF3C3C3C),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                // 공백
                height: 32 * Factor_Height,
              ),
              Container(
                height: 46 * Factor_Height,
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        '자신을 표현하기 위한 닉네임과',
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
                        '프로필 사진을 설정해주세요!',
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
                // 공백
                height: 54 * Factor_Height,
              ),
              Container(
                height: 53 * Factor_Height,
                width: 300 * Factor_Width,
                child: TextField(
                  controller: NicknameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '닉네임',
                  ),
                ),
              ),
              Container(
                height: 14 * Factor_Height,
              ),
              Container(
                // '앗, 나중에 할게요' 텍스트
                height: 21 * Factor_Height,
              ),
              Container(
                height: 92 * Factor_Height,
              ),
              Container(
                // '이제, 다 왔어요!' 버튼
                height: 53 * Factor_Height,
                child: Container(
                  width: 300 * Factor_Width,
                  child: GestureDetector(
                    onTap: () {
                      // 다음 페이지로 이동하는 부분 navigator 구현
                      _add_Information(user_Information(NicknameController.text));
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  letsgo()));
                      // letsgo 로 넘어감
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
                            '이제, 다 왔어요!',
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
                // 공백
                height: 83 * Factor_Height,
              ),
            ],
          ),
        ),
      ),
    );
  }
}