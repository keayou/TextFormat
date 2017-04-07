//
//  ZZFormatEditViewController.h
//  TextFormat
//
//  Created by 粥粥的小笨猪 on 2017/4/3.
//  Copyright © 2017年 zhouzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZFormatEditModel.h"


@interface ZZFormatEditViewController : UIViewController

@property (strong, nonatomic) ZZFormatEditModel *editModel;


@property (nonatomic, copy) void(^editCompletedBlock)(ZZFormatEditModel *editModel);

@end
