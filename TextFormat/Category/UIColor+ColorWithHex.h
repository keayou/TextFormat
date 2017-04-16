//
//  UIColor+WithHex.h
//  sogousearch
//
//  Created by Dragon on 14-6-10.
//  Copyright (c) 2014年 搜狗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorWithHex)

+ (UIColor *)colorWithHex: (NSString *)hexColor;
+ (UIColor *)colorWithHex: (NSString *)hexColor alpha:(CGFloat)alpha;

@end
