//
//  XHBLanguageUtils.m
//  PodDemo
//
//  Created by HaiBa on 2019/6/20.
//  Copyright © 2019 taquiOS. All rights reserved.
//

#import "XHBLanguageUtils.h"

@implementation XHBLanguageUtils

+ (NSBundle *)hb_languageBundle {
    static NSBundle *languageBundle = nil;
    if (languageBundle == nil) {
        languageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"FastCashLanguage" ofType:@"bundle"]];
    }
    return languageBundle;
}

+ (NSString *)hb_localizedStringForKey:(NSString *)key
{
    return [self hb_localizedStringForKey:key value:nil];
}

+ (NSString *)hb_localizedStringForKey:(NSString *)key value:(NSString *_Nullable)value
{
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        // （iOS获取的语言字符串比较不稳定）目前框架只处理en、zh-Hans、zh-Hant三种情况，其他按照系统默认处理
        
        NSString* preferredLang = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] firstObject];
        
        NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        
        if (![preferredLang isEqualToString:@"yuenan"]) {
            // 强制 改成 英文
            [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"yuenan", nil] forKey:@"AppleLanguages"];
        }
        
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language hasPrefix:@"en"]) {
            language = @"en";
        } else if ([language hasPrefix:@"zh"]) {
            if ([language rangeOfString:@"Hans"].location != NSNotFound) {
                language = @"zh-Hans"; // 简体中文
            } else { // zh-Hant\zh-HK\zh-TW
                language = @"zh-Hant"; // 繁體中文
            }
        } else if ([language hasPrefix:@"yuenan"]) {
            language = @"yuenan";
        }
        else {
            language = @"en";
        }
        
        // 从MJRefresh.bundle中查找资源
        bundle = [NSBundle bundleWithPath:[[XHBLanguageUtils hb_languageBundle] pathForResource:language ofType:@"lproj"]];
        
        if (![preferredLang isEqualToString:@"yuenan"]) {
            //恢复当前语音
            [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
        }
        
    }
    value = [bundle localizedStringForKey:key value:value table:nil];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}

@end
