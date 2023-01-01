import 'package:flutter/material.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'whoareyou.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
//import 'package:my_app/utils/helperfunctions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

import 'package:cloud_firestore/cloud_firestore.dart' as fire;


import 'package:flutter/services.dart';

//smart contract address: 0x6554fb48529e85C1d681EB3b256c86b79841E09B
//0x14D58462D7478C6B81bEc5A6A444b12bab7b15Dd
//0xeb6473Fb63Ce3a7C5D3269B22F70aA527a7b04f1
//0x9736B529BB356B2dfFc676cE5dF09419E51BC74a
//0x9dF8961723FeCe25324858224CaF478Cc5046528
//0xBb2123Bed24d1F8cC0AD53540cD9989256F23CcD



class wallet extends StatefulWidget {
  @override
  _walletState createState() => _walletState();
}

class _walletState extends State<wallet> {

  // 클라이언트 생성하고, 스마트컨트랙 연결하고 이것저것 기본 과정

  late http.Client httpClient = http.Client();
  late Web3Client ethClient = Web3Client("https://goerli.infura.io/v3/ba7427e86e274343b87c23ab90db57cf", httpClient);
  var myaddress;

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

  //정보를 바꿀 때 ( gasfee o )
  Future<String> submit(String functionName, List<dynamic> args) async{ //
    print("submit");
    EthPrivateKey credential = EthPrivateKey.fromHex("70eea0d1ee529b2563ac3f6a5a3fd17b73f6c184c7eeb485d74db597d382c064");
    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.sendTransaction(credential, Transaction.callContract(contract: contract, function: ethFunction,
        parameters: args, maxGas: 1000000), chainId: 5);
    return result;
  }

//트렌젝션 보내는 함수들

  var tokenList , totalCount , IdList, URIList;

  // jsonURI를 받아 그 URI에 저장된 json파일 정보를 변수 attr에 저장 (dynamic list로)
  Future<dynamic> getjson(dynamic jsonURI) async{
    var uriResponse = await http.get(
      Uri.parse(jsonURI),
    );

    var jsonBody = utf8.decode(uriResponse.bodyBytes);
    Map<String, dynamic> json = jsonDecode(jsonBody);
    var attr = json['attributes'][0];
/*
    setState(() {
      fire.FirebaseFirestore.instance.collection('users').doc(userInfo!.split(" ")[1]).collection('NFT').add(
          {
            'ID' : attr[0],
            'Name' : attr[1],
            'Kind' : attr[2],

          }
      );
    });*/
    print("json: ${json}");
    print("attributes(value): ${attr['value']}");
    print("imageURI: ${json['image']}");
  }

  //변수 tokenList에 모든 token 정보 저장( json 파일 정보가 아닌 그냥 contract에 저장된 정보)
  Future<void> getTokenList() async{
    var _tokenList = await query("getTokenList", []);

    setState(() {
      tokenList = _tokenList[0];
    });

    print("<TokenList>");
    print(tokenList);
  }


  //지금까지 mint된 총 nft 개수를 totalCount에 저장
  Future<void> getTotalCount() async{
    var _totalCount = await query("getTotalCount", []);

    setState(() {
      totalCount = _totalCount[0];
    });

    print("<Total Count>");
    print(totalCount);
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

  var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
          name: 'My App',
          description: 'An app for converting pictures to NFT',
          url: 'https://pamplnet.org',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ]));

  var _session, _uri, _signature;

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
    userInfo = await storage.read(key: "MetaMask");
    print(userInfo);
  }

  loginUsingMetamask(BuildContext context) async {
    if (!connector.connected) { //만약 연결됬다면 myaddress라는 변수에 현재 연결된 메타마스크 주소 읽어옴
      try {
        var session = await connector.createSession(
            chainId: 5,
            onDisplayUri: (uri) async {
              _uri = uri;
              await launchUrlString(uri, mode: LaunchMode.externalApplication);
            });
        myaddress = session.accounts[0];
        print(session.chainId);
        setState(() {
          _session = session;
        });
      } catch (exp) {
        print(exp);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    connector.on(
        'connect',
            (session) => setState(
              () {
            _session = _session;
          },
        ));
    connector.on(
        'session_update',
            (payload) => setState(() {
          _session = payload;
          print(_session.accounts[0]);
          print(_session.chainId);
        }));
    connector.on(
        'disconnect',
            (payload) => setState(() {
          _session = null;
        }));

    final deviceWidth = MediaQuery.of(context).size.width;
    final standardDeviceWidth = 375;
    final Factor_Width = deviceWidth / standardDeviceWidth;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceHeight = 812;
    final Factor_Height = deviceHeight / standardDeviceHeight;

    bool isconnected = false;

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
                height: 29 * Factor_Height,
              ),
              Container(
                height: 52 * Factor_Height,
              ),
              Container(
                // 사진
                height: 205 * Factor_Height,
                width: 312 * Factor_Height,
                child: Image.asset(
                  'assets/wallet.png',
                  height: 205 * Factor_Height,
                  width: 312 * Factor_Height,
                ),
              ),
              Container(
                // 공백
                height: 47 * Factor_Height,
              ),
              Container(
                // '가상 지갑 연동' 텍스트
                height: 35 * Factor_Height,
                child: Text(
                  '가상 지갑 연동',
                  style: TextStyle(
                    fontSize: 32 * Factor_Height,
                    fontFamily: 'Spoqa-Bold',
                    color: Color(0xFF3C3C3C),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                // 공백
                height: 19 * Factor_Height,
              ),
              Container(
                height: 46 * Factor_Height,
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        'NFT 서비스를 이용하기 위해서는',
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
                        'NFT를 보관할 지갑이 필요합니다!',
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
                height: 63 * Factor_Height,
              ),
              Container(
                // MetaMask 버튼
                height: 53 * Factor_Height,
                child: GestureDetector(

                  onTap: () {
                    if(_session == null) {
                      print("_session: null");
                      loginUsingMetamask(context);

                      //getTokenList();
                      //print("!!!!!!!!!!!!!!!!!!!!!");
                    }// metamask 웹 페이지로 넘어가도록 추후 구현
                    else
                      {
                        print("!111111111111111111");
                        getIdsbyOwner(myaddress); // IDList에다가 값 집어넣기
                        print("111111111111111111111111");
                        getURIsbyOwner(myaddress); // URLList에다가 값 집어넣기
                        print("@222222222222222222222222");
                      }//print("_session: !null");
                    //print(_session);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Color(0xFFD9D9D9),
                    ),
                    width: 300 * Factor_Width,
                    child: Row(
                      children: <Widget>[
                        Container(width: 7 * Factor_Width),
                        Container(
                          //MetaMask 연동 이미지
                          // 사진
                          height: 25 * Factor_Height,
                          width: 25 * Factor_Height,
                          child: Image.asset(
                            'assets/metamask_logo.png',
                            height: 25 * Factor_Height,
                            width: 25 * Factor_Height,
                          ),
                        ),
                        Container(width: 10 * Factor_Width),
                        Container(
                          child: Center(
                            child: Text(
                              'MetaMask',
                              style: TextStyle(
                                fontSize: 15 * Factor_Height,
                                fontFamily: 'Spoqa-Bold',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Container(
                height: 13 * Factor_Height,
              ),

              Container(
                // MetaMask 지갑이 없다면? 버튼
                height: 53 * Factor_Height,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                whoareyou())); // metamask 웹 페이지로 넘어가도록 추후 구현
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Color(0xFFD9D9D9),
                    ),
                    width: 300 * Factor_Width,
                    child: Row(
                      children: <Widget>[
                        Container(width: 7 * Factor_Width),
                        Container(
                          //MetaMask 연동 이미지
                          // 사진
                          height: 25 * Factor_Height,
                          width: 25 * Factor_Height,
                          child: Image.asset(
                            'assets/metamask_connect.png',
                            height: 25 * Factor_Height,
                            width: 25 * Factor_Height,
                          ),
                        ),
                        Container(width: 10 * Factor_Width),
                        Container(
                          child: Center(
                            child: Text(
                              'MetaMask 지갑이 없다면?',
                              style: TextStyle(
                                fontSize: 15 * Factor_Height,
                                fontFamily: 'Spoqa-Bold',
                                color: Colors.black,
                              ),
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
                height: 61 * Factor_Height,
              ),

              Container(
                // 다음으로 버튼

                height: 53 * Factor_Height,
                child: Container(
                  height: 53 * Factor_Height,
                  width: 300 * Factor_Width,
                  child: GestureDetector(
                    onTap: () async {
                      await storage.write(
                        key: "MetaMask",
                        value: "ID " + _session.accounts[0],
                      );
                      //_session = true; //디버깅용, 추후 삭제 바람

                      if(_session!=null)
                        {
                          for(int i = 0; i < URIList.length; i++)
                          {
                            print("차은성 ㅈㄴ 바보");
                            print(URIList[i]);
                            getjson(URIList[i]); // attr 이라는 변수에 저장을 한다며
                            print(IdList[i]);
                          }
                          Navigator.push( // 연동된 경우 true를 return하는 isconnected가 true일 경우 다음으로 버튼을 눌렀을 때 다음 페이지로 넘어가고, false일 경우 버튼을 눌렀을 때 반응이 없도록 설계
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => whoareyou()));
                        }
                      // whoareyou 페이지로 넘어감
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
                            '다음으로',
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
            ],
          ),
        ),
      ),
    );
  }
}