//
//  FCLanguageUtils.h
//  PodDemo
//
//  Created by HaiBa on 2019/6/20.
//  Copyright © 2019 taquiOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XHBLanguageUtils : NSObject

+ (NSString *)hb_localizedStringForKey:(NSString *)key;

+ (NSString *)hb_localizedStringForKey:(NSString *)key value:(NSString *_Nullable)value;

@end

NS_ASSUME_NONNULL_END
