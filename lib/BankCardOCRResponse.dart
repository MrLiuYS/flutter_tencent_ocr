/*
 * @Description: 银行卡识别
 * @Author: MrLiuYS
 * @Date: 2020-03-09 16:06:16
 * @LastEditors: MrLiuYS
 * @LastEditTime: 2020-03-09 16:10:21
 */
import 'dart:convert' show json;

import 'TencentOCRError.dart';

class BankCardOCRResponse {
  String bankInfo;
  String cardNo;
  String requestId;
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
