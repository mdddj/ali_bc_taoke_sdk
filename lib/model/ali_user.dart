import 'dart:convert';
import 'dart:developer';

void tryCatch(Function? f) {
  try {
    f?.call();
  } catch (e, stack) {
    log('$e');
    log('$stack');
  }
}

class FFConvert {
  FFConvert._();
  static T? Function<T extends Object?>(dynamic value) convert =
  <T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return json.decode(value.toString()) as T?;
  };
}

T? asT<T extends Object?>(dynamic value, [T? defaultValue]) {
  if (value is T) {
    return value;
  }
  try {
    if (value != null) {
      final String valueS = value.toString();
      if ('' is T) {
        return valueS as T;
      } else if (0 is T) {
        return int.parse(valueS) as T;
      } else if (0.0 is T) {
        return double.parse(valueS) as T;
      } else if (false is T) {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else {
        return FFConvert.convert<T>(value);
      }
    }
  } catch (e, stackTrace) {
    log('asT<$T>', error: e, stackTrace: stackTrace);
    return defaultValue;
  }

  return defaultValue;
}

class AliUserModel {
  AliUserModel({
    required this.topAccessToken,
    required this.openId,
    required this.openSid,
    required this.nick,
    required this.topAuthCode,
    required this.avatarUrl,
  });

  factory AliUserModel.fromJson(Map<String, dynamic> jsonRes) => AliUserModel(
    topAccessToken: asT<String>(jsonRes['topAccessToken'])!,
    openId: asT<String>(jsonRes['openId'])!,
    openSid: asT<String>(jsonRes['openSid'])!,
    nick: asT<String>(jsonRes['nick'])!,
    topAuthCode: asT<String>(jsonRes['topAuthCode'])!,
    avatarUrl: asT<String>(jsonRes['avatarUrl'])!,
  );

  String topAccessToken;
  String openId;
  String openSid;
  String nick;
  String topAuthCode;
  String avatarUrl;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'topAccessToken': topAccessToken,
    'openId': openId,
    'openSid': openSid,
    'nick': nick,
    'topAuthCode': topAuthCode,
    'avatarUrl': avatarUrl,
  };

  AliUserModel copy() {
    return AliUserModel(
      topAccessToken: topAccessToken,
      openId: openId,
      openSid: openSid,
      nick: nick,
      topAuthCode: topAuthCode,
      avatarUrl: avatarUrl,
    );
  }


}


