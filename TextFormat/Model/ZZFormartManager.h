//
//  ZZFormartManager.h
//  TextFormat
//
//  Created by fk on 2017/4/10.
//  Copyright © 2017年 zhouzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZZFormatEditModel;



@interface ZZFormartManager : NSObject

+ (ZZFormartManager *)sharedInstance;

- (void)saveCustomFormartInfo:(ZZFormatEditModel *)editMode;

- (ZZFormatEditModel *)fetchCustomFormartInfo;

@end
