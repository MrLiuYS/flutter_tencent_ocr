/*
 * @Description: 银行卡识别
 * @Author: MrLiuYS
 * @Date: 2020-03-09 16:06:16
 * @LastEditors: MrLiuYS
 * @LastEditTime: 2020-03-10 10:01:25
 */
import 'dart:convert' show json;

import 'TencentOCRError.dart';

class BankCardOCRResponse {
  ///银行信息
  String bankInfo;

  ///卡号
  String cardNo;

  ///唯一请求 ID，每次请求都会返回。定位问题时需要提供该次请求的 RequestId。
  String requestId;

  ///有效期
  String validDate;

  TencentOCRError error;

  BankCardOCRResponse.fromParams(
      {this.bankInfo, this.cardNo, this.requestId, this.validDate, this.error});

  factory BankCardOCRResponse(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? BankCardOCRResponse._fromJson(json.decode(jsonStr))
          : BankCardOCRResponse._fromJson(jsonStr);

  BankCardOCRResponse._fromJson(jsonRes) {
    bankInfo = jsonRes['BankInfo'];
    cardNo = jsonRes['CardNo'];
    requestId = jsonRes['RequestId'];
    validDate = jsonRes['ValidDate'];
    error = jsonRes['Error'] == null ? null : TencentOCRError(jsonRes['Error']);
  }

  @override
  String toString() {
    return '{"BankInfo": ${bankInfo != null ? '${json.encode(bankInfo)}' : 'null'},"CardNo": ${cardNo != null ? '${json.encode(cardNo)}' : 'null'},"RequestId": ${requestId != null ? '${json.encode(requestId)}' : 'null'},"ValidDate": ${validDate != null ? '${json.encode(validDate)}' : 'null'},"Error": $error}';
  }
}
