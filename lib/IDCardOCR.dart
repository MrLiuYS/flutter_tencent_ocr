/*
 * @Description: 身份证请求体,接收体
 * @Author: MrLiuYS
 * @Date: 2020-03-06 16:54:46
 * @LastEditors: MrLiuYS
 * @LastEditTime: 2020-03-09 14:02:56
 */
import 'dart:convert' show json;

///https://cloud.tencent.com/document/api/866/33524
class IDCardOCRRequest {
  ///公共参数，本接口取值：IDCardOCR
  String action;

  ///FRONT：身份证有照片的一面（人像面），
  ///BACK：身份证有国徽的一面（国徽面），
  ///该参数如果不填，将为您自动判断身份证正反面。
  String cardSide;

  IDCardOCRConfig config;

  ///图片的 Base64 值,图片的 ImageUrl、ImageBase64 必须提供一个，如果都提供，只使用 ImageUrl。
  String imageBase64;

  ///图片的 Url 地址
  String imageUrl;

  IDCardOCRRequest.fromParams({
    this.action = "IDCardOCR",
    this.cardSide = "",
    this.config,
    this.imageBase64 = "",
    this.imageUrl = "",
  });

  factory IDCardOCRRequest(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? IDCardOCRRequest._fromJson(json.decode(jsonStr))
          : IDCardOCRRequest._fromJson(jsonStr);

  IDCardOCRRequest._fromJson(jsonRes) {
    action = jsonRes['Action'] ?? action;
    cardSide = jsonRes['CardSide'] ?? cardSide;
    config = jsonRes['Config'] ?? config;
    imageBase64 = jsonRes['ImageBase64'] ?? imageBase64;
    imageUrl = jsonRes['ImageUrl'] ?? imageUrl;
  }

  @override
  String toString() {
    return '{"ImageUrl":${imageUrl != null ? '${json.encode(imageUrl)}' : 'null'}}';

    return '{"CardSide": ${cardSide != null ? '${json.encode(cardSide)}' : 'null'},"Config": ${config != null ? '${config.toString()}' : 'null'},"ImageBase64": ${imageBase64 != null ? '${json.encode(imageBase64)}' : 'null'},"ImageUrl": ${imageUrl != null ? '${json.encode(imageUrl)}' : 'null'}}';
  }
  Map toJson() {
    return {
      // "CardSide": {cardSide != null ? '${json.encode(cardSide)}' : 'null'},
      // "Config": {config != null ? '${config.toString()}' : 'null'},
      // "ImageBase64": {
      //   imageBase64 != null ? '${json.encode(imageBase64)}' : 'null'
      // },
      "ImageUrl": imageUrl 
    };
  }
}

class IDCardOCRConfig {
  /// BorderCheckWarn，边框和框内遮挡告警
  bool borderCheckWarn;

  /// CopyWarn，复印件告警
  bool copyWarn;

  /// CropIdCard，身份证照片裁剪（去掉证件外多余的边缘、自动矫正拍摄角度）
  bool cropIdCard;

  /// CropPortrait，人像照片裁剪（自动抠取身份证头像区域）
  bool cropPortrait;

  /// DetectPsWarn，PS检测告警
  bool detectPsWarn;

  /// InvalidDateWarn，身份证有效日期不合法告警
  bool invalidDateWarn;

  /// Quality，图片质量分数（评价图片的模糊程度）
  bool quality;

  /// ReshootWarn，翻拍告警
  bool reshootWarn;

  /// TempIdWarn，临时身份证告警
  bool tempIdWarn;

  IDCardOCRConfig.fromParams(
      {this.borderCheckWarn = false,
      this.copyWarn = false,
      this.cropIdCard = false,
      this.cropPortrait = false,
      this.detectPsWarn = false,
      this.invalidDateWarn = false,
      this.quality = false,
      this.reshootWarn = false,
      this.tempIdWarn = false});

  factory IDCardOCRConfig(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? IDCardOCRConfig._fromJson(json.decode(jsonStr))
          : IDCardOCRConfig._fromJson(jsonStr);

  IDCardOCRConfig._fromJson(jsonRes) {
    borderCheckWarn = jsonRes['BorderCheckWarn'] ?? false;
    copyWarn = jsonRes['CopyWarn'] ?? false;
    cropIdCard = jsonRes['CropIdCard'] ?? false;
    cropPortrait = jsonRes['CropPortrait'] ?? false;
    detectPsWarn = jsonRes['DetectPsWarn'] ?? false;
    invalidDateWarn = jsonRes['InvalidDateWarn'] ?? false;
    quality = jsonRes['Quality'] ?? false;
    reshootWarn = jsonRes['ReshootWarn'] ?? false;
    tempIdWarn = jsonRes['TempIdWarn'] ?? false;
  }

  @override
  String toString() {
    return '{"BorderCheckWarn": $borderCheckWarn,"CopyWarn": $copyWarn,"CropIdCard": $cropIdCard,"CropPortrait": $cropPortrait,"DetectPsWarn": $detectPsWarn,"InvalidDateWarn": $invalidDateWarn,"Quality": $quality,"ReshootWarn": $reshootWarn,"TempIdWarn": $tempIdWarn}';
  }
}

class IDCardOCRReponse {
  ///姓名（人像面）
  String name;

  ///性别（人像面）
  String sex;

  ///民族（人像面）
  String nation;

  ///出生日期（人像面）
  String birth;

  ///地址（人像面）
  String address;

  ///身份证号（人像面）
  String idNum;

  ///发证机关（国徽面）
  String authority;

  ///证件有效期（国徽面）
  String validDate;

  ///扩展信息，不请求则不返回，具体输入参考示例3和示例4。
  ///IdCard，裁剪后身份证照片的base64编码，请求 CropIdCard 时返回；
  ///Portrait，身份证头像照片的base64编码，请求 CropPortrait 时返回；
  ///QualityValue，图片质量分，请求 Quality 时返回（取值范围：0~100，分数越低越模糊，建议阈值≥50）;
  ///WarnInfos，告警信息，Code 告警码列表和释义：
  ///-9100 身份证有效日期不合法告警，
  ///-9101 身份证边框不完整告警，
  ///-9102 身份证复印件告警，
  ///-9103 身份证翻拍告警，
  ///-9105 身份证框内遮挡告警，
  ///-9104 临时身份证告警，
  ///-9106 身份证 PS 告警。
  String advancedInfo;

  ///唯一请求 ID，每次请求都会返回。定位问题时需要提供该次请求的 RequestId
  String requestId;

  IDCardOCRReponse.fromParams(
      {this.address,
      this.advancedInfo,
      this.authority,
      this.birth,
      this.idNum,
      this.name,
      this.nation,
      this.requestId,
      this.sex,
      this.validDate});

  factory IDCardOCRReponse(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? IDCardOCRReponse._fromJson(json.decode(jsonStr))
          : IDCardOCRReponse._fromJson(jsonStr);

  IDCardOCRReponse._fromJson(jsonRes) {
    address = jsonRes['Address'];
    advancedInfo = jsonRes['AdvancedInfo'];
    authority = jsonRes['Authority'];
    birth = jsonRes['Birth'];
    idNum = jsonRes['IdNum'];
    name = jsonRes['Name'];
    nation = jsonRes['Nation'];
    requestId = jsonRes['RequestId'];
    sex = jsonRes['Sex'];
    validDate = jsonRes['ValidDate'];
  }

  @override
  String toString() {
    return '{"Address": ${address != null ? '${json.encode(address)}' : 'null'},"AdvancedInfo": ${advancedInfo != null ? '${json.encode(advancedInfo)}' : 'null'},"Authority": ${authority != null ? '${json.encode(authority)}' : 'null'},"Birth": ${birth != null ? '${json.encode(birth)}' : 'null'},"IdNum": ${idNum != null ? '${json.encode(idNum)}' : 'null'},"Name": ${name != null ? '${json.encode(name)}' : 'null'},"Nation": ${nation != null ? '${json.encode(nation)}' : 'null'},"RequestId": ${requestId != null ? '${json.encode(requestId)}' : 'null'},"Sex": ${sex != null ? '${json.encode(sex)}' : 'null'},"ValidDate": ${validDate != null ? '${json.encode(validDate)}' : 'null'}}';
  }
}
