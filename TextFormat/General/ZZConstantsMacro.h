//
//  ZZConstantsMacro.h
//  TextFormat
//
//  Created by 粥粥的小笨猪 on 2017/4/3.
//  Copyright © 2017年 zhouzhou. All rights reserved.
//

#ifndef ZZConstantsMacro_h
#define ZZConstantsMacro_h

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)


#define NOTEMPTY_STR(str) (IS_NOEMPTY_STR(str)?str:@"")

#define MIN_Scale 1.0/[UIScreen mainScreen].scale

#endif /* ZZConstantsMacro_h */
