import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_tencent_ocr/flutter_tencent_ocr.dart';
import 'package:flutter_tencent_ocr/IDCardOCR.dart';
import 'package:flutter_tencent_ocr/GeneralOCRRequest.dart';

import 'local_config.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _message = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('腾讯OCR'),
          ),
          body: Column(children: <Widget>[
            Expanded(flex: 1, child: Text(_message)),
            Expanded(
              flex: 1,
              child: ListView(children: <Widget>[
                OutlineButton(
                  onPressed: idCardOCR,
                  child: Text("身份证识别"),
                ),
                OutlineButton(
                  onPressed: bankOCR,
                  child: Text("银行卡"),
                ),
                OutlineButton(
                  onPressed: bizLicenseOCR,
                  child: Text("营业执照"),
                ),
                OutlineButton(
                  onPressed: otherOCR,
                  child: Text("其他识别"),
                ),
              ]),
            )
          ])),
    );
  }

  Future idCardOCR() async {
    final ByteData imageBytes =
        await rootBundle.load('assets/images/image6.png');

    FlutterTencentOcr.iDCardOCR(
      SecretId,
      SecretKey,
      IDCardOCRRequest.fromParams(
          config: IDCardOCRConfig.fromParams(reshootWarn: true),
          imageBase64: base64Encode(imageBytes.buffer.asUint8List())),
    ).then((onValue) {
      setState(() {
        _message = onValue.toString();
      });
    }).catchError(
      (error) {
        setState(() {
          _message = error;
        });
      },
    );
  }

  Future bankOCR() async {
    final ByteData imageBytes =
        await rootBundle.load('assets/images/bank.jpeg');

    FlutterTencentOcr.bankCardOCR(
      SecretId,
      SecretKey,
      GeneralOCRRequest.fromParams(
          imageBase64: base64Encode(imageBytes.buffer.asUint8List())),
    ).then((onValue) {
      setState(() {
        _message = onValue.toString();
      });
    }).catchError(
      (error) {
        setState(() {
          _message = error;
        });
      },
    );
  }

  Future bizLicenseOCR() async {
    final ByteData imageBytes = await rootBundle.load('assets/images/biz.png');

    FlutterTencentOcr.bizLicenseOCR(
      SecretId,
      SecretKey,
      GeneralOCRRequest.fromParams(
          imageBase64: base64Encode(imageBytes.buffer.asUint8List())),
    ).then((onValue) {
      setState(() {
        _message = onValue.toString();
      });
    }).catchError(
      (error) {
        setState(() {
          _message = error;
        });
      },
    );
  }

  Future otherOCR() async {
    
    final ByteData imageBytes = await rootBundle.load('assets/images/biz.png');

    Map map = {"ImageBase64": base64Encode(imageBytes.buffer.asUint8List())};

    FlutterTencentOcr.ocrRequest(
            SecretId, SecretKey, "BizLicenseOCR", jsonEncode(map))
        .then((onValue) {
      setState(() {
        _message = onValue.toString();
      });
    }).catchError(
      (error) {
        setState(() {
          _message = error;
        });
      },
    );
  }
}
