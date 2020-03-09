import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_tencent_ocr/flutter_tencent_ocr.dart';
import 'package:flutter_tencent_ocr/IDCardOCR.dart';

import 'local_config.dart';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import "package:hex/hex.dart";

import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await FlutterTencentOcr.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: test1,
        ),
      ),
    );
  }

  Future test1() async {
//     idCardOCRRequest

    final ByteData imageBytes =
        await rootBundle.load('assets/images/image6.png');

    FlutterTencentOcr.iDCardOCR(
        SecretId,
        SecretKey,
        IDCardOCRRequest.fromParams(
            // imageBase64: base64Encode(imageBytes.buffer.asUint8List()),
            imageUrl: "http://otimg.nongfadai.com/lambda/credit/20191217/5df8971a34c3a334bcbf1fca?Expires=1792572600&OSSAccessKeyId=ViZXnhMBs433o31B&Signature=9uLWogTYBbcMU1tTQNZEsGSTKOw%3D&x-oss-process=image%2Fresize%2Cm_lfit%2Cw_1920%2Ch_1920%2Fquality%2Cq_60%2Fformat%2Cjpg"));
  }

  void httprequest() async {
    Dio dio = Dio();

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (uri) {
        // return "PROXY 192.168.3.13:8888";
        return "PROXY 172.20.0.109:8888";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    var headers = {
      "Host": "ocr.tencentcloudapi.com",
      "X-TC-Action": "IDCardOCR",
      "X-TC-RequestClient": "APIExplorer",
      "X-TC-Timestamp": "1583733267",
      "X-TC-Version": "2018-11-19",
      "X-TC-Region": "ap-guangzhou",
      "X-TC-Language": "zh-CN",
      "Content-Type": "application/json",
      "Authorization":
          "TC3-HMAC-SHA256 Credential=AKIDRSEl0ynCYdU5QU8n7F9rKXUAcswllyHO/2020-03-09/ocr/tc3_request, SignedHeaders=content-type;host, Signature=92ad2a7a5fa599219183abc853600916f0cb332e89d548a394cdd27954d15975",
    };

    var data =
       json.encode( {"ImageUrl": "http://otimg.nongfadai.com/lambda/credit/20191217/5df8971a34c3a334bcbf1fca?Expires=1792572600&OSSAccessKeyId=ViZXnhMBs433o31B&Signature=9uLWogTYBbcMU1tTQNZEsGSTKOw%3D&x-oss-process=image%2Fresize%2Cm_lfit%2Cw_1920%2Ch_1920%2Fquality%2Cq_60%2Fformat%2Cjpg"});

    var res = await dio.post('https://ocr.tencentcloudapi.com/',
        options: Options(headers: headers), data: data);

    // dio.options.headers = headers;`

    // response = await dio.post("https://ocr.tencentcloudapi.com", data: {
    //   "ImageUrl":
    //       "http://otimg.nongfadai.com/lambda/credit/20191217/5df8971a34c3a334bcbf1fca?Expires=1792572600&OSSAccessKeyId=ViZXnhMBs433o31B&Signature=9uLWogTYBbcMU1tTQNZEsGSTKOw%3D&x-oss-process=image%2Fresize%2Cm_lfit%2Cw_1920%2Ch_1920%2Fquality%2Cq_60%2Fformat%2Cjpg"
    // });
    print(res.data.toString());

    // var res = await http.post('https://ocr.tencentcloudapi.com/', headers: headers, body:data );
    // if (res.statusCode != 200) throw Exception('post error: statusCode= ${res.statusCode}');
    // print(res.body);
  }

  Future test() async {
    String service = "ocr";
    String host = "ocr.tencentcloudapi.com";

    String algorithm = "TC3-HMAC-SHA256";

    String timestamp = "${DateTime.now().millisecondsSinceEpoch ~/ 1000}";

    String date = "2020-03-09";

    String canonicalHeaders =
        "content-type:application/json\n" + "host:" + host + "\n";

    String signedHeaders = "content-type;host";

    final ByteData imageBytes =
        await rootBundle.load('assets/images/image6.png');

    Map map = {"ImageBase64": base64Encode(imageBytes.buffer.asUint8List())};

    String payload = json.encode(map);

    var digest = sha256.convert(utf8.encode(payload));

    String HashedRequestPayload = digest.toString();

    String CanonicalRequest = "POST" +
        '\n' +
        "/" +
        '\n' +
        "" +
        '\n' +
        canonicalHeaders +
        '\n' +
        signedHeaders +
        '\n' +
        HashedRequestPayload;

    print("CanonicalRequest : $CanonicalRequest \n\n");

    var digest1 = sha256.convert(utf8.encode(CanonicalRequest));

    String HashedCanonicalRequest = digest1.toString();

    String stringToSign = "TC3-HMAC-SHA256" +
        "\n" +
        timestamp +
        "\n" +
        "$date/$service/tc3_request" +
        "\n" +
        HashedCanonicalRequest;

    print("stringToSign : $stringToSign \n\n");

    String secretKey = SecretKey;
    var SecretDate = hmac256(utf8.encode("TC3$secretKey"), date);
    var secretService = hmac256(SecretDate, "ocr");
    var SecretSigning = hmac256(secretService, "tc3_request");

    String signature =
        HEX.encode(hmac256(SecretSigning, stringToSign)).toLowerCase();

    print("signature : $signature \n\n");

    // ************* 步骤 4：拼接 Authorization *************
    String authorization = algorithm +
        " " +
        "Credential=" +
        SecretId +
        "/" +
        "$date/ocr/tc3_request" +
        ", " +
        "SignedHeaders=" +
        signedHeaders +
        ", " +
        "Signature=" +
        signature;

    print("authorization : $authorization");

    Dio dio = Dio();

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (uri) {
        // return "PROXY 192.168.3.13:8888";
        return "PROXY 172.20.0.109:8888";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    var headers = {
      'Host': 'ocr.tencentcloudapi.com',
      'X-TC-Action': 'IDCardOCR',
      'X-TC-RequestClient': 'APIExplorer',
      'X-TC-Timestamp': timestamp,
      'X-TC-Version': '2018-11-19',
      'X-TC-Region': 'ap-guangzhou',
      'X-TC-Language': 'zh-CN',
      'Content-Type': 'application/json',
      'Authorization': authorization,
    };

    var res = await dio.post('https://ocr.tencentcloudapi.com/',
        options: Options(headers: headers), data: payload);

    print(res.data.toString());
  }


  // Future test() async {
  //   String service = "ocr";
  //   String host = "ocr.tencentcloudapi.com";

  //   String algorithm = "TC3-HMAC-SHA256";

  //   String timestamp = "${DateTime.now().millisecondsSinceEpoch ~/ 1000}";

  //   String date = "2020-03-09";

  //   String canonicalHeaders =
  //       "content-type:application/json\n" + "host:" + host + "\n";

  //   String signedHeaders = "content-type;host";

  //   final ByteData imageBytes =
  //       await rootBundle.load('assets/images/image6.png');

  //   Map map = {"ImageBase64": base64Encode(imageBytes.buffer.asUint8List())};

  //   // Map map = {"CardSide": "","Config": null,"ImageBase64": "","ImageUrl": "http://otimg.nongfadai.com/lambda/credit/20191217/5df8971a34c3a334bcbf1fca?Expires=1792572600&OSSAccessKeyId=ViZXnhMBs433o31B&Signature=9uLWogTYBbcMU1tTQNZEsGSTKOw%3D&x-oss-process=image%2Fresize%2Cm_lfit%2Cw_1920%2Ch_1920%2Fquality%2Cq_60%2Fformat%2Cjpg"};

  //   String payload = json.encode(map);

  //   var digest = sha256.convert(utf8.encode(payload));

  //   String HashedRequestPayload = digest.toString();

  //   String CanonicalRequest = "POST" +
  //       '\n' +
  //       "/" +
  //       '\n' +
  //       "" +
  //       '\n' +
  //       canonicalHeaders +
  //       '\n' +
  //       signedHeaders +
  //       '\n' +
  //       HashedRequestPayload;

  //   print("CanonicalRequest : $CanonicalRequest \n\n");

  //   var digest1 = sha256.convert(utf8.encode(CanonicalRequest));

  //   String HashedCanonicalRequest = digest1.toString();

  //   String stringToSign = "TC3-HMAC-SHA256" +
  //       "\n" +
  //       timestamp +
  //       "\n" +
  //       "$date/$service/tc3_request" +
  //       "\n" +
  //       HashedCanonicalRequest;

  //   print("stringToSign : $stringToSign \n\n");

  //   String secretKey = SecretKey;
  //   var SecretDate = hmac256(utf8.encode("TC3$secretKey"), date);
  //   var secretService = hmac256(SecretDate, "ocr");
  //   var SecretSigning = hmac256(secretService, "tc3_request");

  //   String signature =
  //       HEX.encode(hmac256(SecretSigning, stringToSign)).toLowerCase();

  //   print("signature : $signature \n\n");

  //   // ************* 步骤 4：拼接 Authorization *************
  //   String authorization = algorithm +
  //       " " +
  //       "Credential=" +
  //       SecretId +
  //       "/" +
  //       "$date/ocr/tc3_request" +
  //       ", " +
  //       "SignedHeaders=" +
  //       signedHeaders +
  //       ", " +
  //       "Signature=" +
  //       signature;

  //   print("authorization : $authorization");

  //   Dio dio = Dio();

  //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
  //       (client) {
  //     client.findProxy = (uri) {
  //       // return "PROXY 192.168.3.13:8888";
  //       return "PROXY 172.20.0.109:8888";
  //     };
  //     client.badCertificateCallback =
  //         (X509Certificate cert, String host, int port) {
  //       return true;
  //     };
  //   };

  //   var headers = {
  //     'Host': 'ocr.tencentcloudapi.com',
  //     'X-TC-Action': 'IDCardOCR',
  //     'X-TC-RequestClient': 'APIExplorer',
  //     'X-TC-Timestamp': timestamp,
  //     'X-TC-Version': '2018-11-19',
  //     'X-TC-Region': 'ap-guangzhou',
  //     'X-TC-Language': 'zh-CN',
  //     'Content-Type': 'application/json',
  //     'Authorization': authorization,
  //   };

  //   var res = await dio.post('https://ocr.tencentcloudapi.com/',
  //       options: Options(headers: headers), data: payload);

  //   print(res.data.toString());
  // }

  String sha256Hex(String s) {
    var bytes = utf8.encode(s);

    var digest = sha256.convert(bytes);
    return HEX.encode(digest.bytes).toLowerCase();
  }

  List<int> hmac256(List<int> key, String msgStr) {
    var bytes = utf8.encode(msgStr);

    var hmacSha256 = new Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);

    return digest.bytes;
  }
}
