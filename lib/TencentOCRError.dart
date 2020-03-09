import 'dart:convert' show json;

class TencentOCRError {
  String code;
  String message;

  TencentOCRError.fromParams({this.code, this.message});

  factory TencentOCRError(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? TencentOCRError._fromJson(json.decode(jsonStr))
          : TencentOCRError._fromJson(jsonStr);

  TencentOCRError._fromJson(jsonRes) {
    code = jsonRes['Code'];
    message = jsonRes['Message'];
  }

  @override
  String toString() {
    return '{"Code": ${code != null ? '${json.encode(code)}' : 'null'},"Message": ${message != null ? '${json.encode(message)}' : 'null'}}';
  }
}
