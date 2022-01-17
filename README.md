# ali_bc_taoke_sdk

阿里百川,淘宝客专用SDK

## 开始使用

iOS需要按照官方文档,配置APPKEY, 和下载安全图片等信息
(安卓暂未接入)

# API

### 1.初始化SDK

初始化阿里百川SDK

返回值类型:bool类型,true表示成功,false表示初始化失败
```dart
final result = await AliBcTaokeSdk.init(); 
```

### 3.登录
用户进行淘宝登录授权

返回类型`AliUserModel?`
需要判空,里面包含了用户的登录信息
```dart
final result = await AliBcTaokeSdk.login();
```


