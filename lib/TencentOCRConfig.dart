import 'dart:convert' show json;

class TencentOCRConfig {
  String algorithm;
  String canonicalHeaders;
  String date;
  String host;
  String service;
  String signedHeaders;
  String timestamp;

  TencentOCRConfig.fromParams(
      {this.algorithm,
      this.canonicalHeaders,
      this.date,
      this.host,
      this.service,
      this.signedHeaders,
      this.timestamp});

  factory TencentOCRConfig(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? TencentOCRConfig._fromJson(json.decode(jsonStr))
          : TencentOCRConfig._fromJson(jsonStr);

  TencentOCRConfig._fromJson(jsonRes) {
    algorithm = jsonRes['algorithm'];
    canonicalHeaders = jsonRes['canonicalHeaders'];
    date = jsonRes['date'];
    host = jsonRes['host'];
    service = jsonRes['service'];
    signedHeaders = jsonRes['signedHeaders'];
    timestamp = jsonRes['timestamp'];
  }

  @override
  String toString() {
    return '{"algorithm": ${algorithm != null ? '${json.encode(algorithm)}' : 'null'},"canonicalHeaders": ${canonicalHeaders != null ? '${json.encode(canonicalHeaders)}' : 'null'},"date": ${date != null ? '${json.encode(date)}' : 'null'},"host": ${host != null ? '${json.encode(host)}' : 'null'},"service": ${service != null ? '${json.encode(service)}' : 'null'},"signedHeaders": ${signedHeaders != null ? '${json.encode(signedHeaders)}' : 'null'},"timestamp": ${timestamp != null ? '${json.encode(timestamp)}' : 'null'}}';
  }
}
