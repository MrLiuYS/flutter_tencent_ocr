/*
 * @Description: 营业执照
 * @Author: MrLiuYS
 * @Date: 2020-03-09 16:25:28
 * @LastEditors: MrLiuYS
 * @LastEditTime: 2020-03-09 16:26:14
 */
import 'dart:convert' show json;

import 'TencentOCRError.dart';

class BizLicenseOCRResponse {
  String Address;
  String Capital;
  String ComposingForm;
  String Name;
  String Period;
  String Person;
  String RegNum;
  String RequestId;
  String Type;
  TencentOCRError Error;

  BizLicenseOCRResponse.fromParams(
      {this.Address,
      this.Capital,
      this.ComposingForm,
      this.Name,
      this.Period,
      this.Person,
      this.RegNum,
      this.RequestId,
      this.Type,
      this.Error});

  factory BizLicenseOCRResponse(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? BizLicenseOCRResponse._fromJson(json.decode(jsonStr))
          : BizLicenseOCRResponse._fromJson(jsonStr);

  BizLicenseOCRResponse._fromJson(jsonRes) {
    Address = jsonRes['Address'];
    Capital = jsonRes['Capital'];
    ComposingForm = jsonRes['ComposingForm'];
    Name = jsonRes['Name'];
    Period = jsonRes['Period'];
    Person = jsonRes['Person'];
    RegNum = jsonRes['RegNum'];
    RequestId = jsonRes['RequestId'];
    Type = jsonRes['Type'];
    Error = jsonRes['Error'] == null ? null : TencentOCRError(jsonRes['Error']);
  }

  @override
  String toString() {
    return '{"Address": ${Address != null ? '${json.encode(Address)}' : 'null'},"Capital": ${Capital != null ? '${json.encode(Capital)}' : 'null'},"ComposingForm": ${ComposingForm != null ? '${json.encode(ComposingForm)}' : 'null'},"Name": ${Name != null ? '${json.encode(Name)}' : 'null'},"Period": ${Period != null ? '${json.encode(Period)}' : 'null'},"Person": ${Person != null ? '${json.encode(Person)}' : 'null'},"RegNum": ${RegNum != null ? '${json.encode(RegNum)}' : 'null'},"RequestId": ${RequestId != null ? '${json.encode(RequestId)}' : 'null'},"Type": ${Type != null ? '${json.encode(Type)}' : 'null'},"Error": $Error}';
  }
}
