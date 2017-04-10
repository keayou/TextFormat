//
//  ZZFormatEditModel.h
//  TextFormat
//
//  Created by 粥粥的小笨猪 on 2017/4/3.
//  Copyright © 2017年 zhouzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZFormatEditModel : NSObject<NSCoding>


@property (nonatomic, assign) CGFloat topMargin;
@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) CGFloat bottomMargin;
@property (nonatomic, assign) CGFloat rightMargin;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) CGFloat titleFontSize;
@property (nonatomic, assign) CGFloat lineMargin;


@property (nonatomic, assign) CGFloat topMarginContent;
@property (nonatomic, assign) CGFloat leftMarginContent;
@property (nonatomic, assign) CGFloat bottomMarginContent;
@property (nonatomic, assign) CGFloat rightMarginContent;
@property (nonatomic, strong) UIColor *titleColorContent;
@property (nonatomic, assign) CGFloat titleFontSizeContent;
@property (nonatomic, assign) CGFloat lineMarginContent;

@property (nonatomic, strong) UIColor *bgColor;



@end
