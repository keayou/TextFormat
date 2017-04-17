//
//  ZZFormatEditModel.m
//  TextFormat
//
//  Created by 粥粥的小笨猪 on 2017/4/3.
//  Copyright © 2017年 zhouzhou. All rights reserved.
//

#import "ZZFormatEditModel.h"

@implementation ZZFormatEditModel

#pragma mark - NSCoding
-(id)initWithCoder:(NSCoder *)decoder {
    
    self.topMargin          = [decoder decodeFloatForKey:@"topMargin"];
//    self.leftMargin         = [decoder decodeFloatForKey:@"leftMargin"];
    self.bottomMargin       = [decoder decodeFloatForKey:@"bottomMargin"];
    self.edgeMargin        = [decoder decodeFloatForKey:@"edgeMargin"];
    self.titleColor         = [decoder decodeObjectForKey:@"titleColor"];
    self.titleFontSize      = [decoder decodeFloatForKey:@"titleFontSize"];
    self.lineMargin         = [decoder decodeFloatForKey:@"lineMargin"];

    
    
    self.topMarginContent       = [decoder decodeFloatForKey:@"topMarginContent"];
//    self.leftMarginContent      = [decoder decodeFloatForKey:@"leftMarginContent"];
    self.bottomMarginContent    = [decoder decodeFloatForKey:@"bottomMarginContent"];
    self.edgeMarginContent     = [decoder decodeFloatForKey:@"edgeMarginContent"];
    self.titleColorContent      = [decoder decodeObjectForKey:@"titleColorContent"];
    self.titleFontSizeContent   = [decoder decodeFloatForKey:@"titleFontSizeContent"];
    self.lineMarginContent      = [decoder decodeFloatForKey:@"lineMarginContent"];

    
    self.bgColor      = [decoder decodeObjectForKey:@"bgColor"];
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    
    [encoder encodeFloat:self.topMargin forKey:@"topMargin"];
//    [encoder encodeFloat:self.leftMargin forKey:@"leftMargin"];
    [encoder encodeFloat:self.bottomMargin forKey:@"bottomMargin"];
    [encoder encodeFloat:self.edgeMargin forKey:@"edgeMargin"];
    [encoder encodeObject:self.titleColor forKey:@"titleColor"];
    [encoder encodeFloat:self.titleFontSize forKey:@"titleFontSize"];
    [encoder encodeFloat:self.lineMargin forKey:@"lineMargin"];

    
    
    [encoder encodeFloat:self.topMarginContent forKey:@"topMarginContent"];
//    [encoder encodeFloat:self.leftMarginContent forKey:@"leftMarginContent"];
    [encoder encodeFloat:self.bottomMarginContent forKey:@"bottomMarginContent"];
    [encoder encodeFloat:self.edgeMarginContent forKey:@"edgeMarginContent"];
    [encoder encodeObject:self.titleColorContent forKey:@"titleColorContent"];
    [encoder encodeFloat:self.titleFontSizeContent forKey:@"titleFontSizeContent"];
    [encoder encodeFloat:self.lineMarginContent forKey:@"lineMarginContent"];

    
    [encoder encodeObject:self.bgColor forKey:@"bgColor"];

}

@end
