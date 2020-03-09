<!--
 * @Description: 
 * @Author: MrLiuYS
 * @Date: 2020-03-05 10:25:14
 * @LastEditors: MrLiuYS
 * @LastEditTime: 2020-03-09 17:16:39
 -->
# flutter_tencent_ocr

## 身份证识别

```
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
```

## 银行卡识别

```
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

```

## 营业执照

```
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
```

## 统一调用的方法

```
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
```

# 运行examle 

在 main.dart 同级目录下新建文件: local_config.dart

```
/// 腾讯OCR生成的秘钥串
const String SecretId = "xxxxxx"; 
const String SecretKey = "xxxxxxx"; 

```
