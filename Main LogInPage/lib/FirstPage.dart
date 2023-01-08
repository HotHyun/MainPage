import 'package:flutter/material.dart';
import 'LogInPage.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'Main_HomePage.dart';
import 'wallet.dart';
import 'whoareyou.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fire;

class FirstPage extends StatefulWidget{
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
{
  late http.Client httpClient = http.Client();
  late Web3Client ethClient = Web3Client("https://goerli.infura.io/v3/ba7427e86e274343b87c23ab90db57cf", httpClient);
  //var myaddress;

  Future<DeployedContract> loadContract() async{
    String abi = await rootBundle.loadString("assets/abi.json");
    String contractAddress = "0xc798864eD7DCD722DF7AA40ec231600F30A81A7e";
    final contract = DeployedContract(ContractAbi.fromJson(abi, "pamplnet"), EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  //스마트 컨트랙에게 요청을 보내기 위한 기본 함수 2개

  //정보를 읽어올 때 ( gasfee X )
  Future<List<dynamic>> query(String functionName, List<dynamic> args) async{
    print("query");
    final contract = await loadContract();
    final ethfunction = contract.function(functionName);
    List<dynamic> result = await ethClient.call(contract: contract, function: ethfunction, params: args);
    return result;
  }
  var IdList, URIList;

  Future<dynamic> getjson(dynamic jsonURI, int i) async{
    var uriResponse = await http.get(
      Uri.parse(jsonURI),
    );

    var jsonBody = utf8.decode(uriResponse.bodyBytes);
    Map<String, dynamic> json = jsonDecode(jsonBody);
    var attr = json['attributes'];

    setState(() {
      fire.FirebaseFirestore.instance.collection('users').doc(userInfo!.split(" ")[1]).collection('NFT').doc('NFT${i}').set(
          {
            'name' : json['name'].toString(),
            'description' : json['description'].toString(),
            'image' : json['image'].toString(),
            'kind' : attr[0]['value'].toString(),
            'detail' : attr[1]['value'].toString(),
            'day_start' : attr[2]['value'].toString(),
            'day_end' : attr[3]['value'].toString(),
            'host' : attr[4]['value'].toString(),
            'prize' : attr[5]['value'].toString(),
            'like_num' : 0,
            'id' : IdList[i].toString()
          }
      );
    });
    print("json: ${json}");
    //print("attributes(value): ${attr['value']}");
    print("imageURI: ${json['image']}");
  }

  //누군가의 지갑주소를 받아 그 사람이 가진 nft id들을 IdList에 저장
  Future<void> getIdsbyOwner( dynamic address ) async{
    var _IdList = await query("getIdsbyOwner", [EthereumAddress.fromHex(address)]);

    setState(() {
      IdList = _IdList[0];
    });
  }

  //누군가의 지갑주소를 받아서 그사람이 가진 nft들의 jsonURI들을 URIList에 저장
  Future<void> getURIsbyOwner(dynamic address) async{
    var _URIList = await query("getURIsbyOwner",
        [EthereumAddress.fromHex(address)]);

    setState(() {
      URIList = _URIList[0];
    });

    //print("URIList: ${URIList[10]}"); //11번째 nft의 jsonURI 출력
  }

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

  _asyncMethod_Total_1() async
  {

    print("!111111111111111111");
    await getIdsbyOwner(ID!.split(" ")[1]); // IDList에다가 값 집어넣기
    print("111111111111111111111111");
    await getURIsbyOwner(ID!.split(" ")[1]); // URLList에다가 값 집어넣기
    print("@222222222222222222222222");

    for(int i = 0; i < URIList.length; i++)
    {
      print("차은성 ㅈㄴ 바보");
      await getjson(URIList[i], i);
      print(URIList[i]); // attr 이라는 변수에 저장을 한다며
      print(IdList[i]);
    }
    return 1;
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
      await _asyncMethod_Total_1();
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder:
              (context) => Main_HomePage()));
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
    return 1;
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