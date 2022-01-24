#import "AliBcTaokeSdkPlugin.h"
#import <AlibcTradeUltimateSDK/AlibcTradeUltimateSDK.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>

@implementation AliBcTaokeSdkPlugin
+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel
            methodChannelWithName:@"ali_bc_taoke_sdk"
                  binaryMessenger:[registrar messenger]];
    AliBcTaokeSdkPlugin *instance = [[AliBcTaokeSdkPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if ([@"init" isEqualToString:call.method]) {

        [[AlibcTradeUltimateSDK sharedInstance] asyncInitWithSuccess:^{
            NSLog(@"阿里百川SDK初始化成功");
            result(@"YES");
        }                                                    failure:^(NSError *_Nonnull error) {
            NSLog(@"初始化失败%@", error);
            result([NSString stringWithFormat:@"%@", error.description]);
        }];
        NSLog(@"进来了");
//      result(@"进来了..");
    } else if ([@"login" isEqualToString:call.method]) {
        // 执行登录
        id <AlibcTradeUltimateLoginService> service = [[AlibcTradeUltimateSDK sharedInstance] loginService];
        BOOL res = [service isLogin];
        if (res == YES) {
            // 已经登录了
            AlibcUser *user = [service getUser];
//            NSLog(@"%@", [NSString stringWithFormat:@"已经登录过了,登录成功:头像:%@,昵称:%@,OPENID:%@,SESSIONID:%@",user.avatarUrl,user.nick,user.openId,user.topAccessToken]);
            result([self changeUserToDic:user]);
        } else {
            [service setH5Only:NO];
            [service auth:[self viewControllerWithWindow:nil] success:^(AlibcUser *user) {
//                NSLog(@"%@", [NSString stringWithFormat:@"登录成功:%@",user.description]);
                result([self changeUserToDic:user]);
            }     failure:^(NSError *error) {
                result([NSString stringWithFormat:@"登录失败:%@", error.description]);
            }];
        }
    } else if ([@"open" isEqualToString:call.method]) {
        // 获取打开的链接的URL
        id args = call.arguments;
        NSLog(@"参数:%@", args);
        AlibcTradeSDK *alibcTradeSdk = [AlibcTradeSDK sharedInstance];
        UIViewController *uiViewController = [self viewControllerWithWindow:nil];
        id tradeService = alibcTradeSdk.tradeService;
        AlibcTradeShowParams *alibcTradeShowParams = [[AlibcTradeShowParams alloc] init];
        AlibcTradeTaokeParams *alibcTradeTaokeParams = [[AlibcTradeTaokeParams alloc] init];
        NSMutableDictionary *trackparams = [NSMutableDictionary dictionary];
        [tradeService openByUrl:@"url"
                       identity:@"trade"
                        webView:nil
               parentController:uiViewController
                     showParams:alibcTradeShowParams
                    taoKeParams:alibcTradeTaokeParams
                     trackParam:trackparams
    tradeProcessSuccessCallback:^(AlibcTradeResult *result) {

    }
     tradeProcessFailedCallback:^(NSError *error) {

     }];

    } else {
        result(FlutterMethodNotImplemented);
    }
}

//获取UIViewController，然后可以跳转
- (UIViewController *)viewControllerWithWindow:(UIWindow *)window {
    UIWindow *windowToUse = window;
    if (windowToUse == nil) {
        for (UIWindow *window in [UIApplication sharedApplication].windows) {
            if (window.isKeyWindow) {
                windowToUse = window;
                break;
            }
        }
    }
    UIViewController *topController = windowToUse.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    return topController;
}

//将阿里百川的用户对象转成一个字典
- (NSMutableDictionary *)changeUserToDic:(AlibcUser *)user {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[@"nick"] = user.nick;
    dict[@"avatarUrl"] = user.avatarUrl;
    dict[@"openId"] = user.openId;
    dict[@"openSid"] = user.openSid;
    dict[@"topAccessToken"] = user.topAccessToken;
    dict[@"topAuthCode"] = user.topAuthCode;
    return dict;
}

@end
