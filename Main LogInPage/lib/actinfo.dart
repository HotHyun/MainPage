import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'infolist.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';

Act thisact = Act.def(); //default 생성자로 생성
extraAct thisextraact = extraAct.def();

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
            home: thisact,
            debugShowCheckedModeBanner: false,
          );
        }
    );
  }
}


void imagetoactinfo(String path, BuildContext context){ //image를 눌렀을 때 그 이미지에 맞는 actinfo를 가져오는 함수

  var tempact = Act.def();

  if(allactlist.length==0) makeactlist(); // allactlist가 만들어지기 전에 함수를 호출한 경우 for문이 안돌아감

  for(int i = 0; i < allactlist.length; i++){

    if(path == allactlist[i]['image_path']){ //imagepath 같으면

      var curact = allactlist[i];

      tempact.activity_name = curact['activity_name'];
      tempact.application_available = curact['application_available']; //활동 이름
      tempact.application_period = curact['application_period']; //시작 날짜
      tempact.category = curact['category'];
      tempact.email = curact['e-mail'];
      tempact.participating_grade = curact['participating_grade'];
      tempact.operation_department = curact['operation_department'];
      tempact.operation_period = curact['operation_period'];
      tempact.image_path = curact['image_path'];
      tempact.PAM = curact['pam'];

      break;

    }

  }

  Navigator.push(
      context,
      CupertinoPageRoute(builder:
          (context) => actinfo(tempact)));


  //복사 생성자 호출 및 widget 빌드

  return;

}


class actinfo extends StatefulWidget {



  actinfo(Act act){ //값 넣어주기


    thisact.activity_name = act.activity_name;
    thisact.application_available = act.application_available;
    thisact.application_period = act.application_period;
    thisact.category= act.category;
    thisact.email = act.email;
    thisact.participating_grade= act.participating_grade;
    thisact.operation_department = act.operation_department;
    thisact.operation_period = act.operation_period;
    thisact.image_path = act.image_path;
    thisact.PAM = act.PAM;

  }

  @override
  _actinfoState createState() => _actinfoState();
}

class _actinfoState extends State<actinfo> {

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final standardDeviceWidth = 375;
    final Factor_Width = deviceWidth / standardDeviceWidth;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceHeight = 812;
    final Factor_Height = deviceHeight / standardDeviceHeight;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0, //버튼 - default 옵션으로 pop하게
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.center,
              end: Alignment.bottomRight,
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
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        //child:Expanded(
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Container(
                  height: 26 * Factor_Height,
                ),
                Container(
                  // # 진행중  #공모전/대회
                  height: 30 * Factor_Height,
                  child: Row(
                    children: <Widget>[
                      Container(
                          width: Factor_Width * 33
                      ),
                      Text(
                        //'#' + thisact.widget.application_available! + ' #' + this.widget.category!,
                        '#' + thisact.application_available! + ' #' + thisact.category!,
                        style: TextStyle(
                          fontSize: 25.5 * Factor_Height,
                          fontFamily: 'Spoqa-Bold',
                          color: Color(0xFF3C3C3C),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 17 * Factor_Height,
                ),
                Container(
                  //활동 사진 들어갈 곳
                  height: 254 * Factor_Height,
                  child: Image.asset(
                    //this.widget.image_path!,
                    'assets/'+thisact.image_path!,
                    height: 254 * Factor_Height,
                    width: 296 * Factor_Width,
                  ),
                ),
                Container(
                  height: 30 * Factor_Height,
                ),
                Container(
                  height: 80 * Factor_Height,
                  child: Text(
                    //this.widget.activity_name!,
                    thisact.activity_name!,
                    style: TextStyle(
                      fontSize: 32 * Factor_Height,
                      fontFamily: 'Spoqa-Bold',
                      color: Color(0xFF3C3C3C),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: 20 * Factor_Height,
                ),
                Container(
                  height: 83 * Factor_Height, //"신청 기간"
                  child: Column(
                    children: [
                      Container(
                          height: 28 * Factor_Height,
                          child: Row(
                            children: [
                              Container(
                                width: 33 * Factor_Width,
                              ),
                              Text(
                                '신청 기간',
                                style: TextStyle(
                                  fontSize: 24.5 * Factor_Height,
                                  fontFamily: 'Spoqa-Bold',
                                  color: Color(0xFF3C3C3C),
                                ),
                              ),
                            ],
                          )),
                      Container(height: 10 * Factor_Height),
                      Container(
                          height: 18 * Factor_Height,
                          child: Row(
                            children: [
                              Container(
                                width: 33 * Factor_Width,
                              ),
                              Text(
                                //this.widget.application_period!,
                                thisact.application_period!,
                                style: TextStyle(
                                  fontSize: 17.5 * Factor_Height,
                                  fontFamily: 'Spoqa-Medium',
                                  color: Color(0xFF3C3C3C),
                                ),
                              ),
                            ],
                          )),
                      Container(height: 10 * Factor_Height),
                    ],
                  ),
                ),
                Container(
                  height: 40 * Factor_Height,
                ),
                Container(
                  height: 83 * Factor_Height, //"활동 기간"
                  child: Column(
                    children: [
                      Container(
                          height: 28 * Factor_Height,
                          child: Row(
                            children: [
                              Container(
                                width: 33 * Factor_Width,
                              ),
                              Text(
                                '활동 기간',
                                style: TextStyle(
                                  fontSize: 24.5 * Factor_Height,
                                  fontFamily: 'Spoqa-Bold',
                                  color: Color(0xFF3C3C3C),
                                ),
                              ),
                            ],
                          )),
                      Container(height: 10 * Factor_Height),
                      Container(
                          height: 18 * Factor_Height,
                          child: Row(
                            children: [
                              Container(
                                width: 33 * Factor_Width,
                              ),
                              Text(
                                //this.widget.operation_period!,
                                thisact.operation_period!,
                                style: TextStyle(
                                  fontSize: 17.5 * Factor_Height,
                                  fontFamily: 'Spoqa-Medium',
                                  color: Color(0xFF3C3C3C),
                                ),
                              ),
                            ],
                          )),
                      Container(height: 10 * Factor_Height),
                    ],
                  ),
                ),
                Container(
                  height: 40 * Factor_Height,
                ),
                Container(
                  height: 83 * Factor_Height, //"참여 학년"
                  child: Column(
                    children: [
                      Container(
                          height: 28 * Factor_Height,
                          child: Row(
                            children: [
                              Container(
                                width: 33 * Factor_Width,
                              ),
                              Text(
                                '참여 학년',
                                style: TextStyle(
                                  fontSize: 24.5 * Factor_Height,
                                  fontFamily: 'Spoqa-Bold',
                                  color: Color(0xFF3C3C3C),
                                ),
                              ),
                            ],
                          )),
                      Container(height: 10 * Factor_Height),
                      Container(
                          height: 18 * Factor_Height,
                          child: Row(
                            children: [
                              Container(
                                width: 33 * Factor_Width,
                              ),
                              Text(
                                //this.widget.participating_grade!,
                                thisact.participating_grade!,
                                style: TextStyle(
                                  fontSize: 17.5 * Factor_Height,
                                  fontFamily: 'Spoqa-Medium',
                                  color: Color(0xFF3C3C3C),
                                ),
                              ),
                            ],
                          )),
                      Container(height: 10 * Factor_Height),
                    ],
                  ),
                ),
                Container(
                  height: 40 * Factor_Height,
                ),
                Container(
                  height: 83 * Factor_Height, //활동기간, 연락처 등 그룹으로 구현, row 필요
                  child: Column(
                    children: [
                      Container(
                          height: 28 * Factor_Height,
                          child: Row(
                            children: [
                              Container(
                                width: 33 * Factor_Width,
                              ),
                              Text(
                                '담당 기관',
                                style: TextStyle(
                                  fontSize: 24.5 * Factor_Height,
                                  fontFamily: 'Spoqa-Bold',
                                  color: Color(0xFF3C3C3C),
                                ),
                              ),
                            ],
                          )),
                      Container(height: 10 * Factor_Height),
                      Container(
                          height: 18 * Factor_Height,
                          child: Row(
                            children: [
                              Container(
                                width: 33 * Factor_Width,
                              ),
                              Text(
                                //this.widget.operation_department!,
                                thisact.operation_department!,
                                style: TextStyle(
                                  fontSize: 17.5 * Factor_Height,
                                  fontFamily: 'Spoqa-Medium',
                                  color: Color(0xFF3C3C3C),
                                ),
                              ),
                            ],
                          )),
                      Container(height: 10 * Factor_Height),
                    ],
                  ),
                ),
                Container(
                  height: 40 * Factor_Height,
                ),
                /*
                Container(
                  height: 83 * Factor_Height, //"연락처"
                  child: Column(
                    children: [
                      Container(
                          height: 28 * Factor_Height,
                          child: Row(
                            children: [
                              Container(
                                width: 33 * Factor_Width,
                              ),
                              Text(
                                '연락처',
                                style: TextStyle(
                                  fontSize: 24.5 * Factor_Height,
                                  fontFamily: 'Spoqa-Bold',
                                  color: Color(0xFF3C3C3C),
                                ),
                              ),
                            ],
                          )),
                      Container(height: 10 * Factor_Height),
                      Container(
                          height: 18 * Factor_Height,
                          child: Row(
                            children: [
                              Container(
                                width: 33 * Factor_Width,
                              ),
                              Text(
                                '054-279-9002',
                                style: TextStyle(
                                  fontSize: 17.5 * Factor_Height,
                                  fontFamily: 'Spoqa-Medium',
                                  color: Color(0xFFCFCFCF),
                                ),
                              ),
                            ],
                          )),
                      Container(height: 10 * Factor_Height),
                      Container(
                          child:
                          Divider(color: Color(0XFFCFCFCF), indent: 28, endIndent: 28, thickness: 2.0))
                    ],
                  ),
                ),
                Container(
                  height: 40 * Factor_Height,
                ),
                */
                Container(
                  height: 83 * Factor_Height, //"이메일"
                  child: Column(
                    children: [
                      Container(
                          height: 28 * Factor_Height,
                          child: Row(
                            children: [
                              Container(
                                width: 33 * Factor_Width,
                              ),
                              Text(
                                '연락처',
                                style: TextStyle(
                                  fontSize: 24.5 * Factor_Height,
                                  fontFamily: 'Spoqa-Bold',
                                  color: Color(0xFF3C3C3C),
                                ),
                              ),
                            ],
                          )),
                      Container(height: 10 * Factor_Height),
                      Container(
                          height: 22 * Factor_Height,
                          child: Row(
                            children: [
                              Container(
                                width: 33 * Factor_Width,
                              ),
                              Text(
                                //this.widget.email!,
                                thisact.email!,
                                style: TextStyle(
                                  fontSize: 17.5 * Factor_Height,
                                  fontFamily: 'Spoqa-Medium',
                                  color: Color(0xFF3C3C3C),
                                ),
                              ),
                            ],
                          )),
                      Container(height: 10 * Factor_Height),
                    ],
                  ),
                ),
                Container(
                  height: 33 * Factor_Height,
                ),
                Container(
                  // '신청하기' 버튼
                  height: 53 * Factor_Height,
                  child: Container(
                    width: 300 * Factor_Width,
                    child: GestureDetector(
                      onTap: () {
                        launchUrlString("https://pams.postech.ac.kr/postech/client/index.do");
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
                              '신청하기',
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
                  height: 33 * Factor_Height,
                ),
              ],
            ),
          ],
        ),
      ),

      //  ),
    );
  }
}

class extrainfo extends StatefulWidget {


  extrainfo(extraAct act){ //값 넣어주기

    thisextraact.activity_name = act.activity_name;
    thisextraact.application_link = act.application_link;
    thisextraact.detail_link = act.detail_link;
    thisextraact.image_path= act.image_path;

  }

  @override
  _extrainfoState createState() => _extrainfoState();
}

class _extrainfoState extends State<extrainfo> {

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final standardDeviceWidth = 375;
    final Factor_Width = deviceWidth / standardDeviceWidth;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceHeight = 812;
    final Factor_Height = deviceHeight / standardDeviceHeight;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0, //버튼 - default 옵션으로 pop하게
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.center,
              end: Alignment.bottomRight,
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
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        //child:Expanded(
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Container(
                  height: 26 * Factor_Height,
                ),
                Container(
                  // # 진행중  #공모전/대회
                  height: 30 * Factor_Height,
                  child: Row(
                    children: <Widget>[
                      Container(
                          width: Factor_Width * 33
                      ),
                      Text(
                        '#창업 & 공모전',
                        style: TextStyle(
                          fontSize: 25.5 * Factor_Height,
                          fontFamily: 'Spoqa-Bold',
                          color: Color(0xFF3C3C3C),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 17 * Factor_Height,
                ),
                Container(
                  //활동 사진 들어갈 곳
                  height: 254 * Factor_Height,
                  child: Image.asset(
                    'assets/'+thisextraact.image_path!,
                    height: 254 * Factor_Height,
                    width: 296 * Factor_Width,
                  ),
                ),
                Container(
                  height: 10 * Factor_Height,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 37.5 * Factor_Width),
                  height: 80 * Factor_Height,
                  child: Text(
                    thisextraact.activity_name!,
                    style: TextStyle(
                      fontSize: 32 * Factor_Height,
                      fontFamily: 'Spoqa-Bold',
                      color: Color(0xFF3C3C3C),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: 40 * Factor_Height,
                ),
                Container(
                  // 상세정보 확인 버튼
                  height: 53 * Factor_Height,
                  child: Container(
                    width: 300 * Factor_Width,
                    child: GestureDetector(
                      onTap: () {
                        launchUrlString(thisextraact.detail_link!);
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
                              '더 자세히 알아보기 ',
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
                  height: 33 * Factor_Height,
                ),
                Container(
                  // '지원하러 가기' 버튼
                  height: 53 * Factor_Height,
                  child: Container(
                    width: 300 * Factor_Width,
                    child: GestureDetector(
                      onTap: () {
                        launchUrlString(thisextraact.application_link!);
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
                              '지원하러 가기',
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
              ],
            ),
          ],
        ),
      ),

      //  ),
    );
  }
}