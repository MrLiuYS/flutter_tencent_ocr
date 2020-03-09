/*
 * @Description: 营业执照
 * @Author: MrLiuYS
 * @Date: 2020-03-09 16:25:28
 * @LastEditors: MrLiuYS
 * @LastEditTime: 2020-03-09 16:47:38
 */
import 'dart:convert' show json;

import 'TencentOCRError.dart';

class BizLicenseOCRResponse {
  String address;
  String capital;
  String composingForm;
  String name;
  String period;
  String person;
  String regNum;
  String requestId;
  String type;
  TencentOCRError error;

  BizLicenseOCRResponse.fromParams(
      {this.address,
      this.capital,
      this.composingForm,
      this.name,
      this.period,
      this.person,
      this.regNum,
      this.requestId,
      this.type,
      this.error});

  factory BizLicenseOCRResponse(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? BizLicenseOCRResponse._fromJson(json.decode(jsonStr))
          : BizLicenseOCRResponse._fromJson(jsonStr);

  BizLicenseOCRResponse._fromJson(jsonRes) {
    address = jsonRes['Address'];
    capital = jsonRes['Capital'];
    composingForm = jsonRes['ComposingForm'];
    name = jsonRes['Name'];
    period = jsonRes['Period'];
    person = jsonRes['Person'];
    regNum = jsonRes['RegNum'];
    requestId = jsonRes['RequestId'];
    type = jsonRes['Type'];
    error = jsonRes['Error'] == null ? null : TencentOCRError(jsonRes['Error']);
  }

  @override
  String toString() {
    return '{"Address": ${address != null ? '${json.encode(address)}' : 'null'},"Capital": ${capital != null ? '${json.encode(capital)}' : 'null'},"ComposingForm": ${composingForm != null ? '${json.encode(composingForm)}' : 'null'},"Name": ${name != null ? '${json.encode(name)}' : 'null'},"Period": ${period != null ? '${json.encode(period)}' : 'null'},"Person": ${person != null ? '${json.encode(person)}' : 'null'},"RegNum": ${regNum != null ? '${json.encode(regNum)}' : 'null'},"RequestId": ${requestId != null ? '${json.encode(requestId)}' : 'null'},"Type": ${type != null ? '${json.encode(type)}' : 'null'},"Error": $error}';
  }
}
