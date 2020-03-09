/*
 * @Description: 通用的卡卷识别 , 银行卡, 营业执照
 * @Author: MrLiuYS
 * @Date: 2020-03-09 15:58:50
 * @LastEditors: MrLiuYS
 * @LastEditTime: 2020-03-09 16:28:21
 */
import 'dart:convert' show json;

///https://cloud.tencent.com/document/api/866/33524
class GeneralOCRRequest {
  ///公共参数，本接口取值：
  String action;

  ///图片的 Base64 值,图片的 ImageUrl、ImageBase64 必须提供一个，如果都提供，只使用 ImageUrl。
  String imageBase64;

  ///图片的 Url 地址
  String imageUrl;

  GeneralOCRRequest.fromParams({
    this.action = "",
    this.imageBase64 = "",
    this.imageUrl = "",
  });

  factory GeneralOCRRequest(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? GeneralOCRRequest._fromJson(json.decode(jsonStr))
          : GeneralOCRRequest._fromJson(jsonStr);

  GeneralOCRRequest._fromJson(jsonRes) {
    action = jsonRes['Action'] ?? action;
    imageBase64 = jsonRes['ImageBase64'] ?? imageBase64;
    imageUrl = jsonRes['ImageUrl'] ?? imageUrl;
  }

  @override
  String toString() {
    return '{"ImageBase64": ${imageBase64 != null ? '${json.encode(imageBase64)}' : 'null'},"ImageUrl": ${imageUrl != null ? '${json.encode(imageUrl)}' : 'null'}}';
  }
}
