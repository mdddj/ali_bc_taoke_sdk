import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ali_bc_taoke_sdk/ali_bc_taoke_sdk.dart';

void main() {
  const MethodChannel channel = MethodChannel('ali_bc_taoke_sdk');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await AliBcTaokeSdk.platformVersion, '42');
  });
}
