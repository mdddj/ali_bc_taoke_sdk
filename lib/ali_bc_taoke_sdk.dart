
import 'dart:async';

import 'package:ali_bc_taoke_sdk/model/ali_user.dart';
import 'package:ali_bc_taoke_sdk/util/alibaichuan_utils.dart';
import 'package:flutter/services.dart';

typedef AliErrorMessage = void Function(String msg);
typedef AliLoginSuccess = void Function(AliUserModel user);

class AliBcTaokeSdk {
  static const MethodChannel _channel = MethodChannel('ali_bc_taoke_sdk');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  // 初始化阿里百川SDK
  static Future<bool> init() async {
    final String isInit = await _channel.invokeMethod("init");
    return isInit == 'YES';
  }

  // 用户登录
 static Future<AliUserModel?> login({AliErrorMessage? errorHandle,AliLoginSuccess? loginSuccessHandle}) async {
    final result = await _channel.invokeMethod('login');
    final mapData = AlibaiChuanUtils().covertToMap(result);
    if(mapData.isSuccess){
      final user = AliUserModel.fromJson(mapData);
      loginSuccessHandle?.call(user);
      return user;
    }
    errorHandle?.call(mapData.errorMessage);
 }
}
