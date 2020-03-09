/*
 * @Description: 腾讯ocr
 * @Author: MrLiuYS
 * @Date: 2020-03-05 10:25:14
 * @LastEditors: MrLiuYS
 * @LastEditTime: 2020-03-09 13:56:41
 */
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:hex/hex.dart';

import 'IDCardOCR.dart';

class FlutterTencentOcr {
  static const MethodChannel _channel =
      const MethodChannel('flutter_tencent_ocr');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future iDCardOCR(
    String secretId,
    String secretKey,
    IDCardOCRRequest idCardOCRRequest,
  ) async {
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

    Map requestMap = generateRequestMap(secretId, secretKey, idCardOCRRequest);

    var res = await dio.request('https://ocr.tencentcloudapi.com/',
        options: Options(
          headers: requestMap["headers"],
          method: "POST",
        ),
        data: requestMap["body"]);

    print(res.data.toString());
  }

  /// 生成Authorization
  static Map generateRequestMap(
    String secretId,
    String secretKey,
    IDCardOCRRequest requestData, {
    String service = "ocr",
    String host = "ocr.tencentcloudapi.com",
    String algorithm = "TC3-HMAC-SHA256",
    String contentType = "application/json",
    String action = "IDCardOCR",
    String version = "2018-11-19",
    String region = "ap-guangzhou",
  }) {
    DateTime nowTime = DateTime.now();
    String date =
        "${nowTime.year}-${nowTime.month.toString().padLeft(2, '0')}-${nowTime.day.toString().padLeft(2, '0')}";
    String timestamp = "${nowTime.millisecondsSinceEpoch ~/ 1000}";

    // ************* 步骤 1：拼接规范请求串 *************
    String httpRequestMethod = "POST";
    String canonicalUri = "/";
    String canonicalQueryString = "";
    String canonicalHeaders = "content-type:$contentType\nhost:$host\n";

    String signedHeaders = "content-type;host";

    // var data =
    //   '{"ImageUrl":"http://otimg.nongfadai.com/lambda/credit/20191217/5df8971a34c3a334bcbf1fca?Expires=1792572600&OSSAccessKeyId=ViZXnhMBs433o31B&Signature=9uLWogTYBbcMU1tTQNZEsGSTKOw%3D&x-oss-process=image%2Fresize%2Cm_lfit%2Cw_1920%2Ch_1920%2Fquality%2Cq_60%2Fformat%2Cjpg"}';

    // Map map = {
    //   "ImageUrl":
    //       "http://otimg.nongfadai.com/lambda/credit/20191217/5df8971a34c3a334bcbf1fca?Expires=1792572600&OSSAccessKeyId=ViZXnhMBs433o31B&Signature=9uLWogTYBbcMU1tTQNZEsGSTKOw%3D&x-oss-process=image%2Fresize%2Cm_lfit%2Cw_1920%2Ch_1920%2Fquality%2Cq_60%2Fformat%2Cjpg"
    // };

    String payloadJson =json.encode(requestData.toJson());

    print("payloadJson :  $payloadJson\n\n");

    var payload = sha256.convert(utf8.encode(payloadJson));

    String hashedRequestPayload = payload.toString();

    String canonicalRequest = httpRequestMethod +
        '\n' +
        canonicalUri +
        '\n' +
        canonicalQueryString +
        '\n' +
        canonicalHeaders +
        '\n' +
        signedHeaders +
        '\n' +
        hashedRequestPayload;

    print("canonicalRequest : $canonicalRequest \n\n");

    // ************* 步骤 2：拼接待签名字符串 *************
    String credentialScope = "$date/$service/tc3_request";

    var hashedCanonicalRequest = sha256.convert(utf8.encode(canonicalRequest));

    String stringToSign = algorithm +
        "\n" +
        timestamp +
        "\n" +
        credentialScope +
        "\n" +
        hashedCanonicalRequest.toString();

    print("stringToSign : $stringToSign \n\n");

    // ************* 步骤 3：计算签名 *************

    var secretDate = hmac256(utf8.encode("TC3$secretKey"), date);
    var secretService = hmac256(secretDate, service);
    var secretSigning = hmac256(secretService, "tc3_request");

    String signature =
        HEX.encode(hmac256(secretSigning, stringToSign)).toLowerCase();

    print("signature : $signature \n\n");

    // ************* 步骤 4：拼接 Authorization *************
    String authorization = algorithm +
        " " +
        "Credential=" +
        secretId +
        "/" +
        credentialScope +
        ", " +
        "SignedHeaders=" +
        signedHeaders +
        ", " +
        "Signature=" +
        signature;

    print("authorization : $authorization");

    var headers = {
      'Host': host,
      'X-TC-Action': action,
      'X-TC-Timestamp': timestamp,
      'X-TC-Version': version,
      'X-TC-Region': region,
      'X-TC-Language': 'zh-CN',
      'Content-Type': contentType,
      'Authorization': authorization,
    };

    return {"headers": headers, "body": payloadJson};
  }

  static String sha256Hex(String s) {
    var bytes = utf8.encode(s);

    var digest = sha256.convert(bytes);
    return HEX.encode(digest.bytes).toLowerCase();
  }

  static List<int> hmac256(List<int> key, String msgStr) {
    var bytes = utf8.encode(msgStr);

    var hmacSha256 = new Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);

    return digest.bytes;
  }
}
