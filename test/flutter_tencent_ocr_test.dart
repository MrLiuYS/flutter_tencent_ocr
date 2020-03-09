import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tencent_ocr/flutter_tencent_ocr.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_tencent_ocr');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  // test('getPlatformVersion', () async {
  //   expect(await FlutterTencentOcr.platformVersion, '42');
  // });
}
