//
//  NSString+ZZHexColor.m
//  TextFormat
//
//  Created by 粥粥的小笨猪 on 2017/4/16.
//  Copyright © 2017年 zhouzhou. All rights reserved.
//

#import "NSString+ZZHexColor.h"

@implementation NSString (ZZHexColor)

+ (NSString *) hexFromUIColor: (UIColor*) color {
//    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
//        const CGFloat *components = CGColorGetComponents(color.CGColor);
//        color = [UIColor colorWithRed:components[0]
//                                green:components[0]
//                                 blue:components[0]
//                                alpha:components[1]];
//    }
//    
//    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
//        return [NSString stringWithFormat:@"#FFFFFF"];
//    }
//    
//    return [NSString stringWithFormat:@"#XXX", (int)((CGColorGetComponents(color.CGColor))[0]*255.0),
//            (int)((CGColorGetComponents(color.CGColor))[1]*255.0),
//            (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];


    CGFloat r, g, b, a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    int rgb = (int) (r * 255.0f)<<16 | (int) (g * 255.0f)<<8 | (int) (b * 255.0f)<<0;
    return [NSString stringWithFormat:@"%06x", rgb];
}

@end
